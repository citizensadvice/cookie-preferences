# Citizens Advice Cookie Preferences

A rails engine for managing cookie consent in Citizens Advice websites and applications.

## Usage

This engine can be integrated into host apps and used to manage cookies
based on the consent types of `essential`, `analytics` and `video players`

The engine provides a cookie preferences page, cookie banner, cookie confirmation
banner and cookie management logic.

The engine uses a combination of Rails and JavaScript to manage cookie consent, 
and has fallbacks for users without JavaScript enabled.

## Installation

Add this snippet to your application's Gemfile, updating the tag to the latest published
version of the engine:

```ruby
gem "citizens_advice_cookie_preferences",
    github: "citizensadvice/cookie-preferences",
    tag: "v0.1.0"
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install citizens_advice_cookie_preferences
```

Mount the engine in your routes.rb file, you do not need to include `(/:country)` if your 
host app doesn't support multiple countries:
```ruby
mount CitizensAdviceCookiePreferences::Engine, at: "(/:country)/cookie-preferences"
```

## Local Development

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
