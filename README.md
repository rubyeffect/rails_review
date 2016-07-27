# Rails Review

Rails Review gem checks your rails applications against style guides present at [Rails Style Guide Repository](https://github.com/bbatsov/rails-style-guide) and reports the code snippets where the style guide is not met.

## Installation

Add this line to your application's Gemfile in the development group:

```ruby
gem 'rails_review'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_review

## Usage

Run the following rake task to start the rails style guide checks on your application.

    $ rake rails_review:start

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

1. Fork it ( https://github.com/rubyeffect/rails_review/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Note

In the current version, 17 [Rails Style Guide](https://github.com/bbatsov/rails-style-guide) points are being checked. Further checks would be added in future commits.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## About RubyEffect

![RubyEffect](http://blog.rubyeffect.com/wp-content/uploads/2015/05/cropped-re_original_logo.png)

RubyEffect builds intuitive, live and elegant software that solves real world problems. We love open source and it's community.

Liked this gem? You may also like the articles we post on our [blog](http://blog.rubyeffect.com). Please do check

We would love to work on your ideas and see them grow. Say hello @ http://rubyeffect.com/contact
