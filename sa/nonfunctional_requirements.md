# Nonfunctional requirements
The system attributes we'are going to consider are availability, efficiency, flexibility, integrity,
interopereability, maintainability, reliability, reusability, robustness, testability, usability

# Discusion
The goals of the project is to provide:
- good looking and easy to use product with all the necessary functionality
- maintainable, extensible and documented code so developers could easily join the team
- good level of security as some kind of personal document is needed to identify yourself.

With regard to that the system attributes we need to consider are:
* usability
* availability
* robustness
* efficiency
* maintainability
* reusability

## Usability
Supporting multiple browsers and resolutions will make it harder to maintain the code as well as making it harder to modify it as well as it will slow down consiredably the development process.
*Compromise:* The focus is on supporting the *newest versions* of browsers that we expect te target group is most likely to use: Google Chrome, Opera, Mozilla Firefox, Microsoft Internet Explorer, Tor Browser. 

Have sleek and good looking user interface is imortant but that could have effect on performance.
*Compromise* Interface should be intuitive but eye candy could be sacrificed in name of performance.

    - NFR3 - Display well on 4,5-5,5', 7-9', 13-15' and bigger than 17' displays.
    - NFR4 - Support the newest versions of the following browsers: Google Chrome, Opera, Mozilla Firefox, Microsoft Internet Explorer, Tor Browser
    - NFR7 - Four out of five users shall be able to book a bike within 5 minutes after waching the wellcome video.
    - NFR8 - Novice users shall find and book a bike in 10 minutes.
    - NFR9 - Instalation of additional software is not requred.
    - NFR15 - The user should be able te revert booking a bike up to 24 hours before the time of picking it up.

## Availability
The maximum downtime of the system should be less than 10 minutes and that should happen less than 2 times per month.
This could have negative effect on usability. But if the user is nicely informed, 10 minutes are not that much of a time to wait.   

    - NFR20 - Each city downtime should be less than 10 minutes long, less than 3 times per year.

## Robustness
A city should not be dependant on other cities. If one of the cities is unreachable the othe should be able to continue working.
There should be no interopereability on city level. A city does not know and care of other cities existance.
That will make the system as a whole more reliable and reusable but some overhead is added in term of maintainability.
    
    - NFR30 - Installation of a new version shall leave all database contents and all personal settings unchanged.
    - NFR31 - Adding new city should not affect other cities.
    - NFR32 - If a city is unreachable, that does not affect user actions on other cities.

## Efficiency
When havin many requests per second the response takes longer.
*Compromise:* Focus is on stability, a request should not take more than 200ms with 5k requests per second. Code should be written in a scalale way so vertical scaling could take care of higher load.
    
    - NFR50 - Acceptale responce time for each user request is 300 ms.
    - NFR51 - User should register with 5 clicks or less.
    - NFR52 - User should be able to book a bike with 10 clicks or less.

## Maintainability
That is very important as the project is open source and new developers should be able to get to know the project on their own.
Writing testable code as well as tests for it is a must, as that will make it easier to modify it. Reusability of the code also helps making it more meintainable.
Interopereability would make it harder to test and modify the code base and therefore make it less meintainable, so separation of conserns is prefered.
    
    - NFR65 - The cyclomatic complexity of code must not exceed 6.
    - NFR66 - No method in any object may exceed 20 lines of code.
    - NFR70 - The delivered system shall include unit tests that ensure 99% branch coverage.
    - NFR71 - The code should follow the ruby style guide.

## Reusability
Having separation of conserns and exposing CRUD APIs makes code much more reusable and meintainable. Reliability could be affected negatively though.

# Conclusion
We want the system to:

1. be easy and intuitive to use
    - The user should be able to work with the system without any additional training.
    - The user should be able to easily revert their actions
2. be easily accessible
    - No need to install extra software or plugins
    - Work on most up to date browsers
    - Display well on displays of any size
3. be secure and scalable
    - Use only encrypted communication between clients and servers
    - Store passwords in a sensible way (e.g. let a tested library do it for us)
    - Easily add new cities without any configuration changes to the current ones
    - Be stable with 5k requests per second
    - Be stable for 100k users and 500k listings in the database
4. be easy to maintain, modify and extend
    - Separate modules for UI, API, data management and integration with services
    - Clean and documented code (document every entity)
5. have short response time
    - < 200ms response time (excluding network latency)
