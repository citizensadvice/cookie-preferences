# 3. Cookie version resetting

Date: 2026-08-04

## Status

Accepted

## Context

We have several apps that use the cookie preferences gem. When we launch new versions of the gem, it is possible to have time between the app launches.
This means that if a user visits an app (e.g public-website) that has the new gem version, then navigates to an app that uses the old gem version (e.g forms) and navigates back,
the cookie banner is re-displayed and the cookies are reset. What happens behind the scenes is:

1. User goes to an updated product (e.g public-website) and accepts the cookies - this sets the cookie_preference_set to the lasest version (e.g 2)
2. User navigates to a page that uses a different app (e.g forms) - cookies[:cookie_preference_set] is 2 from the previous page visit and COOKIE_CURRENT_VERSION is 1. They don't match so we reset the cookies and that means we also show the banner again on the next page visit.
3. User navigates to a page within public-website - cookies[:cookie_preference_set] is now 1 from the forms page visit, COOKIE_CURRENT_VERSION is 2. They don't match so we reset the cookies and that means we also show the banner again on the next page visit.

We need to minimise the impact of version updates across the apps and the times the user sees the banner unnecessarily.

## Options

### Option 1: Only reset the cookies if the version is older than the current

This involves a little bit of additional implementation as we need to release an interim upgrade to the cookies preferences gem to make the apps backwards compatible.
In practice, if we apply this to the example from the context it would mean that:

1. User goes to an updated product (e.g public-website) and accepts the cookies - this sets the cookie_preference_set to the lasest version (e.g 2)
2. User navigates to a page that uses a different app (e.g forms) - cookies[:cookie_preference_set] is 2 from the previous page visit and COOKIE_CURRENT_VERSION is 1. We don't reset the cookies or show the banner again.
3. User navigates to a page within public-website - cookies[:cookie_preference_set] is still 2, COOKIE_CURRENT_VERSION is 2. We don't delete the cookies or show the banner again.

If we do it the other way round and start from an app that has an older version to an app that has a newer one, we would want to reset the cookies to get the latest updates.
It will make it easier to do future releases as we won't have to think about in what order to update the apps.

### Option 2: Accept it as a breaking change and coordinate everything to be released in quick succession

We have to make sure we do this every time we update the COOKIE_CURRENT_VERSION across the apps which adds to the cognitive load and processes we need to follow.

## Decision

We are going to proceed with option 1 - even though it requires additional code, it's quite minimal.
It would make the launch process more robust without relying on manually syncronising the deployments.
