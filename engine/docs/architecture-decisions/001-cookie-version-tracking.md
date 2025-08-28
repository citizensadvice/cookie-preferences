# 1. Cookie version tracking

Date: 2025-08-12

## Status

Accepted

## Context

We need to track the version of our cookies so that if a cookie is added or removed we can update the version. This will ensure that the banner is rendered to users again for them to set their preferences following the change; and means we remain cookie compliant.

## Options

### Option 1: Cookie preferences engine is the source of truth for the version number

Pros:

- All information related to cookie preferences is contained within one codebase
- It doesn't require additional dev work beyond what we've already allocated to it

Cons:

- Once we update the version number and release a new version of the cookie preferences gem we will need to update all the other apps that use the engine e.g. public-website, energy-apps. This will mean that there is going to be gap where users visiting different parts will have different version numbers and they could potentially be shown the banner/asked to consent multiple times
- There will need to be pull requests approved and merged across multiple repos which will require dev input and time when new there's a new cookie version to release. We will need to ensure that this work is included in whatever process is implemented to manage cookies so that dev time can be allocated. We'll also need to agree on a reasonable timeframe for all the codebases that rely on this engine to be updated within

### Option 2: Move the version number out of the engine e.g. public-website

Pros:

- When the version number is updated a user accessing any part of the site will be able to update their consent, and will only need to do once
- No additional dev time required beyond updating the version number and deploying public-website

Cons:

- This will require move dev time to implement which will affect the timeline currently in place for hitting the 30th Sept deadline
- Information related to the cookies will be split across different places, increasing the mental load required by the developers maintaining cookies and public-website to understand how they interact, and what changes are required in which repo

### Option 3: Convert the cookies engine to a deployable Rails app

Pros:

- When the version number is updated a user accessing any part of the site will be able to update their consent, and will only need to do once
- All information related to cookie preferences is contained within one codebase
- This approach follows our existing code/project design and implementation

Cons:

- A much bigger piece of work that would include more dev time, especially when it comes to setting up the initial infrastructure required as we know that this is time intensive. It would be unlikely that we would be able to implement this by the deadline

## Decision

We are going to proceed with option 1 for the following reasons:

- We have a hard deadline and this can be done within the timeframe
- All the cookies code will live in one codebase, making it easier for devs to maintain
- This will be v1 of version tracking, we can always iterate on it once the initial deadline has been met
- It is safer if all host apps have to update the engine gem version as they will go through their own build pipelines which will reduce the chances of cookies being broken across various parts of the site
- At present all the host apps are within control of the Content Platform & Non-advice Teams
- We will ensure that we create a process for rolling out updates to the cookie version. This will reduce the time in which there may be different versions across the site
