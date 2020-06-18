# frozen_string_literal: true

RSpec.shared_context 'models' do
  let(:user_id) { 'a9733fff-13c0-400f-9bb1-6f9da47d4bfb' }
  let(:user) do
    {
      "id": 'a9733fff-13c0-400f-9bb1-6f9da47d4bfb',
      "createdTimestamp": 1_592_324_987_557,
      "username": 'info@hexes.co.uk',
      "enabled": true,
      "totp": false,
      "emailVerified": false,
      "firstName": 'Info',
      "lastName": 'Hexes',
      "email": 'info@hexes.co.uk',
      "attributes": {
        "phone": [
          '01234 567890'
        ]
      },
      "disableableCredentialTypes": [],
      "requiredActions": [
        'UPDATE_PASSWORD'
      ],
      "notBefore": 0,
      "access": {
        "manageGroupMembership": true,
        "view": true,
        "mapRoles": true,
        "impersonate": false,
        "manage": true
      }
    }
  end
  let(:users) do
    [
      {
        "id": 'a9733fff-13c0-400f-9bb1-6f9da47d4bfb',
        "createdTimestamp": 1_592_324_987_557,
        "username": 'info@hexes.co.uk',
        "enabled": true,
        "totp": false,
        "emailVerified": false,
        "firstName": 'Info',
        "lastName": 'Hexes',
        "email": 'info@hexes.co.uk',
        "attributes": {
          "phone": [
            '01234 567890'
          ]
        },
        "disableableCredentialTypes": [],
        "requiredActions": [
          'UPDATE_PASSWORD'
        ],
        "notBefore": 0,
        "access": {
          "manageGroupMembership": true,
          "view": true,
          "mapRoles": true,
          "impersonate": false,
          "manage": true
        }
      },
      {
        "id": 'a9733fff-13c0-400f-9bb1-6f9da47d4bfb',
        "createdTimestamp": 1_592_324_987_557,
        "username": 'info2@hexes.co.uk',
        "enabled": true,
        "totp": false,
        "emailVerified": false,
        "firstName": 'Info2',
        "lastName": 'Hexes',
        "email": 'info2@hexes.co.uk',
        "attributes": {
          "phone": [
            '01234 567891'
          ]
        },
        "disableableCredentialTypes": [],
        "requiredActions": [
          'UPDATE_PASSWORD'
        ],
        "notBefore": 0,
        "access": {
          "manageGroupMembership": true,
          "view": true,
          "mapRoles": true,
          "impersonate": false,
          "manage": true
        }
      }
    ]
  end
  let(:single_nonexact_user) do
    [
      {
        "id": 'a9733fff-13c0-400f-9bb1-6f9da47d4bfb',
        "username": 'info@hexes.co.uk',
        "firstName": 'Infowithextras',
        "lastName": 'Hexes',
        "email": 'info@hexes.co.uk',
        "attributes": {
          "phone": [
            '01234 567890'
          ]
        }
      }
    ]
  end
  let(:single_exact_user) do
    [
      {
        "id": 'a9733fff-13c0-400f-9bb1-6f9da47d4bfb',
        "username": 'info@hexes.co.uk',
        "firstName": 'Info',
        "lastName": 'Hexes',
        "email": 'info@hexes.co.uk',
        "attributes": {
          "phone": [
            '01234 567890'
          ]
        }
      }
    ]
  end

  let(:group_id) { '4ac79394-684d-435d-b8dc-fb984e8c3020' }
  let(:group) do
    {
      "id": '4ac79394-684d-435d-b8dc-fb984e8c3020',
      "name": 'test_group1',
      "path": '/test_group1',
      "subGroups": []
    }
  end
  let(:groups) do
    [
      {
        "id": 'dae1b507-9e83-4e94-84f3-e9a14a5b2337',
        "name": 'test_group',
        "path": '/test_group',
        "subGroups": [
          {
            "id": '696dbd4d-9730-4e8e-9894-ccb8e830c316',
            "name": 'test_group_child',
            "path": '/test_group/test_group_child',
            "subGroups": []
          }
        ]
      },
      {
        "id": '4ac79394-684d-435d-b8dc-fb984e8c3020',
        "name": 'test_group1',
        "path": '/test_group1',
        "subGroups": []
      }
    ]
  end

  let(:role_id) { '2d6e2c36-d5e5-4632-b087-19775e376d56' }
  let(:role) do
    {
      "id": '2d6e2c36-d5e5-4632-b087-19775e376d56',
      "name": 'asset_type#create',
      "composite": false,
      "clientRole": false,
      "containerId": 'ripple'
    }
  end
  let(:roles) do
    [
      {
        "id": '33500724-396d-425b-8e0c-3020b40106f6',
        "name": 'asset#update',
        "composite": false,
        "clientRole": false,
        "containerId": 'ripple'
      },
      {
        "id": '2d6e2c36-d5e5-4632-b087-19775e376d56',
        "name": 'asset_type#create',
        "composite": false,
        "clientRole": false,
        "containerId": 'ripple'
      }
    ]
  end
end
