# 1. Cookie version tracking

Date: 2025-09-10

## Status

Proposed

## Context

Currently, we have two SCSS files and two JavaScript files (compiled into a single application.js file) in the cookie preferences engine.

We include them as part of the engine, and they are updated when the engine is updated in a host app.

Our current process for handling SCSS and JS assets is:

### SCSS

Import the SCSS into an existing SCSS file of a host app. E.g:

```
@import 'citizens_advice_cookie_preferences/components/cookie-banner';
```

We also need to include the stylesheets path in our build-css in package.json:

```
--load-path=$(bundle show citizens_advice_cookie_preferences)/app/assets/stylesheets
```

### Javascript

We need to build the JavaScript in the engine every time we make a change to a JavaScript file.
We then include the build file in our host app layouts:

```
= javascript_include_tag "citizens_advice_cookie_preferences/application", nonce: true
```

and add it to manifest.js

```
//= link citizens_advice_cookie_preferences/application.js
```

## Options

### Option 1: continue using the current process

Pros:

- We have already implemented and tested with this approach in our host apps
- There is a low number of SCSS and JS files to maintain, and we might not update them often
- We only need to update the engine version in the Gemfile of the host apps

Cons:

- There can be differences in the SCSS/JS implementation depending on the version of the host app and its assets pipeline
- We need to build the JS every time we want to update the app
- We need to remember to add the JS tag into any layouts that use cookies

### Option 2: create a new npm package

Pros:

- The npm release process already exists at Citizens Advice - we can use our design system knowledge to implement
- We can include the SCSS and JS in the host apps the same way that we include the design system ones, which makes our code more consistent
- Simplifies JS inclusion - we would be able to add the `init` functions directly in the host apps' packs JS files instead of having to add the script to the layouts

Cons:

- Different release process - we would have to release the package via npm. This would add complexity to the release process as we need run two releases - one for the npm package and one for the Rails engine
- We need to remember to update the gem and the npm package at the same time in the host apps. The process will be manual. We can't rely on dependabot in those cases
- There will be additional work to restructure the way that the file paths are set up. We also need to consider what the roll-out process would be - there needs to be a period of time when both npm package and current structure work. This will add to development complexity and tidy up tasks

## Decision

TBD
