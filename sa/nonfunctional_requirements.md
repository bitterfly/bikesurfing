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

## Availability
The maximum downtime of the system should be less than 10 minutes and that should happen less than 2 times per month.
This could have negative effect on usability. But if the user is nicely informed, 10 minutes are not that much of a time to wait.   

## Robustness
A city should not be dependant on other cities. If one of the cities is unreachable the othe should be able to continue working.
There should be no interopereability on city level. A city does not know and care of other cities existance.
That will make the system as a whole more reliable and reusable but some overhead is added in term of maintainability.

## Efficiency
When havin many requests per second the response takes longer.
*Compromise:* Focus is on stability, a request should not take more than 200ms with 5k requests per second. Code should be written in a scalale way so vertical scaling could take care of higher load.

## Maintainability
That is very important as the project is open source and new developers should be able to get to know the project on their own.
Writing testable code as well as tests for it is a must, as that will make it easier to modify it. Reusability of the code also helps making it more meintainable.
Interopereability would make it harder to test and modify the code base and therefore make it less meintainable, so separation of conserns is prefered.

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
    - Separate modules for UI, API, data management, integration with services
    - Clean and documented code (document every entity)
5. have short response time
    - < 200ms response time (excluding network latency)



