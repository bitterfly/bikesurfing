# Types of architecture relative to:


* ## Structure
Mainly, we have a component based. We'll have several separate servers, processing logically connected requests - e.g. we have a separate independent component servering as a Town's structure with its full functionality of renting and lending bikes.
	Our structure is also layered since we have several user roles. Those actors work on different levels of abstraction which enables changes to be made on one layer without affecting the others. The roles vary between the lowest - the guest user and the highest being the whole platform administrator.

#### Why don't we use other types of structures?
- We don't use pipes and filters because we have independent elements, which could not be chained in a pipeline. 
- The whole idea of our project is to be scalable, so we must have separation of both components and users, so we can not use any type of monolothic application.

* ## Shared memory
Bikesurfing is a platform for managing data such as images, locations, maps and trip events. We are strongly data-centric and rely on open-source database managing systems for communication between components, instead of messaging.
#### Why don't we use other types of memory sharing?
- We can't use blackboard or rule-based architectures, because we rely on user interaction and the only place we could implement AI is the search engine and the bike recommendation section. 

* ## Messaging
Since we are building a data-centric application, the messaging between components is handled by database systems.

* ## Adaptive systems

* ## Distributed systems
Relative to the distribution of the system, we're going to use __client–server architecture__ type. And to be more precise - [three-tier architecture](https://en.wikipedia.org/wiki/Multitier_architecture) - where the presentation logic, business logic and data access are separated.

#### Why don't we use other types of distributed systems?
- Other kinds of n-tier architecure

  Because the frond end should be easily changable, we can't have a strong connection between the presentation and business logic. On the contrary, we must create an API with which any type of client could connect through jsons. 

- [Shared nothing architecture](https://en.wikipedia.org/wiki/Shared_nothing_architecture)
	
    We don't have logical modules which are self-sufficient in order to have this kind of architecture. Even if we could separate them, not having a single connection point is unusable in this kind of application.
    
 - [Space-based architecture](https://en.wikipedia.org/wiki/Space-based_architecture)
  
 	Well, again we have the idea of building the application out of a set of self-sufficient units, which is very scalable, but in our case the logical components can't be divided into separate independant units. We may use parts of this kind of architecture when implementing the communication with Twitter and other platforms, but as for the main part of the application it can't be applied.

  - [Peer-to-peer](https://en.wikipedia.org/wiki/Peer-to-peer)

 	There is no use to use peer-to-peer, because the whole project's idea is to create a platform for bikesurfing. We should have a centralised server which processes the requests, before having any direct communication between users.