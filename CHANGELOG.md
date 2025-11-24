## v0.4.1

#### _Nov. 24, 2025_

- Added more resilient handling of cookie preferences setting when the value becomes malformed.
 
## v0.4.0

#### _Nov. 13, 2025_

- Updated cookie banner text

## v0.3.1

#### _Oct. 28, 2025_

- Fix for malformed `ReturnUrl` raising exceptions

## v0.3.0

#### _Oct. 16, 2025_

**Breaking change**
- add LOCAL_RETURN_HOST env var. This allows configuring return url for local development and feature tests.
Any feature tests which check that the cookie banner has the correct "Choose cookies" link need to be updated to use the new env var in their GitHub workflow configuration.

## v0.2.0

#### _Oct. 14, 2025_

**New**
- adding return url when visiting the cookie preferences page from the cookie banner

## v0.1.0

#### _Sep. 16, 2025_

- Add linting, automated testing and auditing
- Create cookie banner
- Create cookie preferences page
- Handle cookie consent state using `cookie_preference_set` and `cookie_preference`
- Tie cookie consent versioning to `cookie_preference_set` to allow management of cookies as they change
- Create cookie preference helpers for use in host apps
- Add no JS versions of both the banner and the page
- Add success message to cookie preference page
- Create logic to delete cookies on change of cookie version, or on withdrawal of consent
- Country specific routing for preference page and banner links
- Welsh banner and preference page
- Prevent attempted deletion of malformed cookies as this causes an error
