# Rails Engine demo app
This app:

- Is used in CI to run feature tests against to make sure each part of the cookie preferences engine works together as a whole.
- Acts as a reference implementation showing both how to configure the engine and how to load cookie preferences page & banner.
- Can be ran as a standalone Rails app to experiment with cookie banner component and cookie preferences page.

## Running the demo app
From `/demo` you can run the server with
```shell
bin/dev
```

## Running the cucumber tests
You will need to have an up to date version of Firefox installed.

To run the cucumber tests locally first start the server, then from `/demo` run
```shell
bundle exec cucumber
```
