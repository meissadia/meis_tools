# MeisTools

Bundling some patterns for reuse in my Ruby projects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'meis_tools'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install meis_tools

## Usage

### Mixins  
```ruby
class CoolKids
  include Meis::[mixin_name]   
end  
```

#### Mixin List
- Cli  
- Files  
- Output::Text  
- Storage  

### Classes  
#### Readme Generator
```ruby
  options_hash = {
    :file = 'path/to/file.md',
    :change_log = 'path/to/changelog.md',
    :out_file = 'README.md'
  }
  readmer  = Meis::Output::Readme.new(options_hash)  
  readmer.run! # Inject dynamic content and output README.md file
```  
#### Text Report Generator

```ruby
  reporter = Meis::Output::Reporter.new(options_hash)  
```

## Development  

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/meissadia/meis_tools.
