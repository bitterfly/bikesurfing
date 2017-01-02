# Functional requirements

After consulting with owner's requirements, reviewing the current state of the web service and envisioning our ideas we have come up with the following functional requirements. We have devised a system that divides requirements based on type of user and relative priority.

### Types of users

Every requirement has its own unique identification code, e.g. `FR305`. The letters are an abbreviation for `Functional Requirement`. They are followed by a 3 digit code identifier. The first digit in the number represents the type of user the requirement is for. The following digits make up the requirement's number which increases by a factor of 5 so it's easier to make additions to the list without having to reorder it or put something out of place.

##### These are the types of users and their respective digits in the functional requirements:

1. Guest
2. User
2.1. Bike renter
2.2. Bike lender
3. City admin
4. Sysadmin

### Requirement priority

We will be using the [MoSCoW](https://en.wikipedia.org/wiki/MoSCoW_method) method as a prioritizing technique for the functional requirements.

> The term MoSCoW itself is an acronym derived from the first letter of each of four prioritization categories (_Must have, Should have, Could have,_ and _Would like but won't get_), with the interstitial os added simply to make the word pronounceable. ~Wikipedia

## Guest functional requirements
These activities can be performed by all visitors. Registering or logging in on the site is not mandatory.

- ?FR105 - Viewing the News Bulletin

A list of news, sorted by date and time, will be displayed on the right side of the webpage. It will show the news' title, publisher and the time of publishing.

<!-- TODO: FIX numbers -->
<!-- TODO: Add description to FR and users -->

- FR110 - Choose city (front page)
- FR105 - Choose similar websites (front page)
- FR105 - Terms and Conditions page
- ?FR105 - Donate + Bitcoin wallet (fp + city page)
- FR105 - Sign up (fp + cp)
    - FR110 - Create account
    - ?FR110 - Sign up with facebook/couchsurfing
- FR105 - Log in (fp + cp)
- FR105 - Review the blog
- FR105 - View bikes
    - FR110 - View graphic calendar
    - FR110 - Search bikes
- FR105 - View bike locations
- FR105 - Read FAQ
- FR105 - Browse bike lenders
- FR105 - Use social media links
- FR105 - View press snippets (fp)
- FR105 - View city guide


## User functional requirements
### Bike renter

- FR110 - Rent a bike
- FR110 - Receive e-mail alerts
- FR110 - Edit personal profile
- FR110 - Access to other user's profiles
- FR110 - Access to forum page
- FR110 - Leave a note for future bike renters (bike page)
- FR110 - Apply for page translator
- FR110 - Become bike lender (fp)

### Bike lender

- FR110 - Approve/Decline rent requests
- ?FR110 - Add blog post
- ?FR110 - Edit rent requests
- FR110 - Add bikes to system

## City admin functional requirements

- FR110 - Customise city page
- FR110 - Add blog post !! unless in bike lender
- FR110 - Edit rent requests !! unless in bike lender
- FR110 - Approve bike lenders
- FR110 - Delete bike lenders
- FR110 - Set up bike stations

## Sysadmin functional requirements

- FR110 - Add/Remove city admins
- FR110 - Detele BikeSurfer account
- FR110 - Review BikeSurfer
- FR110 - Real time statistics (total profiles, total days "surfed")
