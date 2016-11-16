# Types of architecture relative to:


* ## Structure

* ## Shared memory

* ## Messaging

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

 	
