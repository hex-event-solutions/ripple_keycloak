# Ripple Keycloak

![Lint and test](https://github.com/hex-event-solutions/ripple_keycloak/workflows/Lint%20and%20test/badge.svg)

Slim interface focused on groups, roles and users for Keycloak's Admin REST API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ripple_keycloak'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ripple_keycloak

## Usage

The client must be configured before usage

```ruby
RippleKeycloak::Client.configure do |c|
  c.base_url = <keycloak_url>
  c.realm = <keycloak_realm>
  c.client_id = <client_id>
  c.client_secret = <client_secret>
end
```

The supplied client must be of 'confidential' type, and allow service account login.

After configuring, use the supplied interfaces to query, create, update or delete resources in Keycloak.

### Standard methods

The below methods are available on `RippleKeycloak::User`, `RippleKeycloak::Group` and `RippleKeycloak::Role`.

- find(id) - returns the resource with the given id
- find_by(field:, value:) - searches the resource type for an exact match against field and value
- search(value) - searches the resource type for a match in any field
- all - returns all resources
- delete(id) - deletes the resource with the given id

### RippleKeycloak::User

- create(payload) - posts given payload to user create
- add_to_group(user_id, group_id) - adds given user to given group
- remove_from_group(user_id, group_id) - removes given user from given group
- add_role(user_id, role_name) - adds given role to user
- remove_role(user_id, role_name) - removes given role from user

### RippleKeycloak::Group

- create(name:, parent: false) - creates a group with the given name, optionally under the given parent
- add_role(group_id, role_name) - adds given role to group
- remove_role(group_id, role_name) - removes given role from group

### RippleKeycloak::Role

- create(name:) - creates a role with the given name

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hex-event-solutions/ripple_keycloak. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/hex-event-solutions/ripple_keycloak/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RippleKeycloak project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hex-event-solutions/ripple_keycloak/blob/master/CODE_OF_CONDUCT.md).
