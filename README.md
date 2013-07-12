# saddle

Giddyup nerd! Wrangle your SOA.

Saddle makes writing service clients as easy as giving high fives. :hand:

It's a full-featured, generic consumer layer for you to build API client implementations with.

[![Code Climate](https://codeclimate.com/github/mLewisLogic/saddle.png)](https://codeclimate.com/github/mLewisLogic/saddle)

## about

Ok, I love high fives, but what does Saddle do for me?

Saddle is a framework that makes it exceptionally easy to write HTTP API clients. It abstracts away a lot of the repetitive work and lets you focus on your business logic. It also provides a simple middleware interface that makes it easy to extend functionality.

Saddle enables you to create beautifully stable and functionaly API clients, in the fewest lines of code possible.


## features

### client
* Specifying default connection settings for your client makes usage simple
* Automatic call tree construction, based upon module/class namespace
* Easily integrate with logging systems (currently supports statsd & Airbrake)
* Support simple testing of your client

### requests
* Post urlencoded or JSON (handles multipart file posts as well)
* Auto-parse JSON responses
* Strictly enforce request timeouts (client-wide or endpoint specific timeouts)

### error handling
* Automatic retries with exponential backoff
* Turns 4xx and 5xx responses into exceptions
* If desired, silently return default values upon exception


## guide

### concrete example
[saddle-example](https://github.com/mLewisLogic/saddle-example)

### client construction
0. For the sake of cleanliness, pick a namespace that everything related to your client should live in. For this example, we'll use __SaddleExample__
1. Inherit your client class, __SaddleExample::Client__, from __Saddle::Client__
2. Create an _endpoints_ directory at the same level as your client class file
3. Create endpoint classes in the _endpoints_ directory that inherit from __Saddle::TraversalEndpoint__ and are under the __SaddleExample::Endpoints__ namespace module
    1. Give these endpoints methods that call _get_ or _post_ to perform the actual request
    2. Their module/class namespace determines how they are accessed in the client's call tree. For example, the get\_all() in __SaddleExample::Endpoints::Fish::Guppy__ would be accessed by:

        client.fish.guppy.get_all()

    3. If you need REST style endpoints like client.fish('guppy').catch() then check out __Saddle::ResourceEndpoint__ and how it's used in [saddle-example](https://github.com/mLewisLogic/saddle-example/blob/master/lib/endpoints/kitten.rb)

4. Initialize an instance of your client. ex:

        saddle_example_client = SaddleExample::Client.create



## todo
* xml posting/parsing
