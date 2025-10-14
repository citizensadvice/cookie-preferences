# Citizens Advice Cookie Preferences

A rails engine for managing cookie consent in Citizens Advice websites and applications.

## Usage

This engine can be integrated into host apps and used to manage cookies
based on the consent types of `essential`, `analytics` and `video players`

The engine provides a cookie preferences page, cookie banner, cookie confirmation
banner and cookie management logic.

The engine uses a combination of Rails and JavaScript to manage cookie consent,
and has fallbacks for users without JavaScript enabled.

## Getting set up

### Installing the gem

Add this snippet to your application's Gemfile, updating the tag to the latest published
version of the engine:

```ruby
gem "citizens_advice_cookie_preferences",
    github: "citizensadvice/cookie-preferences",
    tag: "v0.2.0"
```

And then execute:

```bash
$ bundle install
```

### Configure /cookie-preferences route

Mount the engine in your routes.rb file. You do not need to include `(/:country)` if your
host app doesn't support multiple countries:

```ruby
mount CitizensAdviceCookiePreferences::Engine, at: "(/:country)/cookie-preferences"
```

### Add helpers

Import the helpers from the gem into application_controller.rb

```ruby
include CitizensAdviceCookiePreferences::Helpers
```

### Add the banner and cookies js to application.html.haml

Add cookie banner to application.html.haml:

```haml
- unless cookies_preference_page?
  = render CitizensAdviceCookiePreferences::CookieBanner.new
```

or to the erb file:

```erb
<% unless cookies_preference_page? %>
  <%= render CitizensAdviceCookiePreferences::CookieBanner.new %>
```

Include cookies javascript in application.html.haml:

```haml
= javascript_include_tag "citizens_advice_cookie_preferences/application", nonce: true
```

or to the erb file:

```erb
<% javascript_include_tag "citizens_advice_cookie_preferences/application", nonce: true %>
```

### Import the engine stylesheets

Add to your main .scss file:

```scss
@import "citizens_advice_cookie_preferences/components/cookie-banner";
@import "citizens_advice_cookie_preferences/components/cookie-preferences";
```

### Add css load path for cookie-preferences stylesheet

In package.json, add the following to your build css script:

```
--load-path=$(bundle show citizens_advice_cookie_preferences)/app/assets/stylesheets
```

### Build js and css

Exact commands will vary according to those defined in your application's package.json.  
Example from energy-apps:

```bash
yarn build && yarn build:css
```

### Update data layer variable

Add a new data layer variable analyticsCookiesAccepted. We use it in GTM to trigger overriding consent mode.

In data_layer.rb (or equivalent file)

```ruby
# e.g. from energy-apps
def default_data_layer_properties
  properties = {
    #data layer properties go here
  }

  if  allow_analytics_cookies?
    properties.merge({ analyticsCookiesAccepted: "True" })
  else
    properties
  end
end
```

### Update analytics configuration

Separate setting data layer from GTM snippet, and only render GTM snippets if user has accepted analytics cookies.  
In the no script tag:

```haml
- if allow_analytics_cookies?
  %noscript
    %iframe{ src: "https://www.googletagmanager.com/ns.html?id=<GTM container id>",
             height: "0", width: "0", style: "display:none;visibility:hidden" }
```

In the head analytics tag:

```haml
%script{ id: "script-data-layer", nonce: content_security_policy_nonce }
  window.dataLayer = window.dataLayer || [];
  - if data_layer_properties.present?
    dataLayer.push(#{data_layer_properties.to_json.html_safe})

- if allow_analytics_cookies?
  %script{ id: "script-google-tag-manager", nonce: content_security_policy_nonce }
    (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
    new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
    j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
    'https://www.googletagmanager.com/gtm.js?id='+i+dl;var n=d.querySelector('[nonce]');
    n&&j.setAttribute('nonce',n.nonce||n.getAttribute('nonce'));f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','<GTM container id>>');
```
