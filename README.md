# RaceResult

Provides a Ruby API for communicating with Race Result timing systems.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'raceresult'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install raceresult

## Usage

```ruby
require 'raceresult'

decoder = RaceResult::Decoder.new('192.168.153.254', port: 3601)

if decoder.has_power?
  puts decoder.current_time
end

decoder.start_timing!

decoder.passings.each do |p|
  puts "#{p.detected_at}: #{p.chip_code}"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/WhyEee/raceresult.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
