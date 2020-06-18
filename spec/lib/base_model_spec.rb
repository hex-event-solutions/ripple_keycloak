# frozen_string_literal: true

RSpec.describe RippleKeycloak::BaseModel do
  include_context 'models'

  let(:client) { instance_double(RippleKeycloak::Client) }
  let(:model) { described_class }

  let(:url) { 'some_url' }
  let(:body) { { one: 'one', two: 'two' } }
  let(:object_type) { 'users' }

  let(:query_model) do
    described_class.tap do |m|
      m.object_type object_type
    end
  end

  before do
    allow(RippleKeycloak::Client).to receive(:new).and_return(client)
  end

  describe 'get' do
    before { allow(client).to receive(:get) }

    it 'forwards get to the client' do
      model.get(url)
      expect(client).to have_received(:get).with(url)
    end
  end

  describe 'post' do
    before { allow(client).to receive(:post) }

    it 'forwards get to the client' do
      model.post(url, body)
      expect(client).to have_received(:post).with(url, body)
    end
  end

  describe 'object_type' do
    before { model.object_type object_type }

    it 'sets the instance variable' do
      expect(model.instance_variable_get(:@object_type)).to eq object_type
    end
  end

  describe 'search' do
    before { allow(client).to receive(:get) }

    it 'calls search on client' do
      query_model.search('query')
      expect(client).to have_received(:get).with("#{object_type}?search=query")
    end
  end

  describe 'all' do
    before { allow(client).to receive(:get) }

    let(:first) { 5 }
    let(:first_q) { "first=#{first}&" }
    let(:max) { 10 }
    let(:max_q) { "max=#{max}" }
    let(:base_url) { "#{object_type}?" }

    context 'with no parameters' do
      it 'calls get on client' do
        query_model.all
        expect(client).to have_received(:get).with(base_url)
      end
    end

    context 'with first' do
      it 'calls get on client' do
        query_model.all(first: first)
        expect(client).to have_received(:get).with("#{base_url}#{first_q}")
      end
    end

    context 'with max' do
      it 'calls get on client' do
        query_model.all(max: max)
        expect(client).to have_received(:get).with("#{base_url}#{max_q}")
      end
    end

    context 'with first and max' do
      it 'calls get on client' do
        query_model.all(first: first, max: max)
        expect(client).to have_received(:get).with("#{base_url}#{first_q}#{max_q}")
      end
    end
  end

  describe 'find' do
    before { allow(client).to receive(:get) }

    it 'calls get on client' do
      query_model.find(user_id)
      expect(client).to have_received(:get).with("#{object_type}/#{user_id}")
    end
  end

  describe 'find_by' do
    let(:field) { :firstName }
    let(:value) { 'Info' }
    let(:response) { double(HTTParty::Response, parsed_response: response_body) }

    before do
      allow(client).to receive(:get).and_return(response)
    end

    context 'when there are no results returned' do
      let(:response_body) { [] }

      it 'raises an error' do
        expect { query_model.find_by(field: field, value: value) }.to raise_errorRippleKeycloak::NotFoundError
      end
    end

    context 'when there is one exact result returned' do
      let(:response_body) { single_exact_user }

      it 'does not raise an error' do
        expect { query_model.find_by(field: field, value: value) }.not_to raise_error
      end
    end

    context 'when there is one non-exact result returned' do
      let(:response_body) { single_nonexact_user }

      it 'raises an error' do
        expect { query_model.find_by(field: field, value: value) }.to raise_errorRippleKeycloak::NotFoundError
      end
    end

    context 'when there are multiple results returned' do
      let(:response_body) { users }

      it 'does not raise an error' do
        expect { query_model.find_by(field: field, value: value) }.not_to raise_error
      end
    end
  end

  describe 'delete' do
    before { allow(client).to receive(:delete) }

    it 'calls delete on client' do
      query_model.delete(user_id)
      expect(client).to have_received(:delete).with("#{object_type}/#{user_id}")
    end
  end
end
