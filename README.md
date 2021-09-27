# Mongoid::Bulk::Import

 This gem adds an `bulk_insert` method to mongoid classes for bulk inserting data with validations support.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongoid-bulk-import'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid-bulk-import

## Usage

### Sample a single document

```ruby

class MyModel
  include Mongoid::Document
  field :name
end

MyModel.bulk_insert({ name: "Jack" })
```

### Sample multiple documents

```ruby

class MyModel
  include Mongoid::Document
  field :name
end

MyModel.bulk_insert([{ name: "Jack" }, { name: "Matt" }])
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mongoid-bulk-import. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mongoid::Bulk::Import project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/mongoid-bulk-import/blob/master/CODE_OF_CONDUCT.md).
