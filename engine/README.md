# Citizens Advice Cookie Preferences

A rails engine for managing cookie consent in Citizens Advice websites and applications.

## Local Development

## Prerequisites

Running the project locally requires a few dependencies.

### Ruby

The minimum Ruby version we require is ruby-3.3.1. We include a `.ruby-version` file in the root of the project so if you are using a version manager like [rvm](https://rvm.io/) it should pick this up.

`rbenv` has known issues during setup, and running rspec, so it is best to avoid `rbenv` and use `rvm` instead.

### Node

Node v16 is required.

### Yarn

This project uses yarn to manage npm packages. Check if you have yarn installed by running

```
yarn --version
```

If not, it will be installed by the setup script below.

There is some guidance on [updating packages with yarn](../docs/general/yarn.md).

Alternatively, you can install it by following the [instructions in the yarn docs](https://classic.yarnpkg.com/lang/en/docs/install/#mac-stable).

## Initial setup

Run `bundle install && yarn install` directly.

You may need to run `nvm install` if you are running into front end asset compilation errors, they are likely due to differences in node version.

#### Run the app locally

To test the app locally without it being mounted in a host app you need to navigate to the demo app within the repo and
run that app to load a website and test functionality.

## Testing

The majority of the testing is held within the demo app, however there are some rspec tests which can be run using
`bundle exec rspec`

## Changing cookies

When people add, delete or change the purpose of cookies used on our host apps we need to update our cookie mapping
to ensure the use of cookies remains compliant and functional.

This can be done in the [`version.rb` file](engine/lib/citizens_advice_cookie_preferences/version.rb) which contains a
list of cookies and their purpose. In this mapping you can add, delete or change the purpose of the cookies as needed.

Once you have amended the list you must make sure to increment the `COOKIE_CURRENT_VERSION` and the `VERSION`. This will
allow you to create a new release which will bump the cookie version and the gem version - therefore allowing the host
apps to update their implementation and retrigger consent from users with the new cookie set up. You should inform all
the teams of the `cookie-preferences` version bump so they can update it in their Gemfiles and remain compliant.

## Creating a release

To create a new release, once you have update the version number you should go to `releases` on the right hand side of the
code window on Github, and click `Draft a new release`. From here you can click `select tag` and create a new tag with a
version number matching the one you just incremented to in the `version.rb` file.

From here check your changelog has all the relevant changes to that release, and if not add them in, and then publish the
release. This will then allow host apps to bump to match this new latest version.
