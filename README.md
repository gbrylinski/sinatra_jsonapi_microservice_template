# Demo Service

This is a sample Sinatra + Sequel + Sinja microservice template application. It's been built to verify feasibility and easiness of such.

It works and it's fast. Rails fast, not Go fast, I'm aware of that.

## Requirements

just a bunch of gems specified in a `Gemfile`

Documentation for gems for lazy ones:

- [Sinatra](http://www.sinatrarb.com/)
- [Sequel](http://sequel.jeremyevans.net/)
- [Sinja](https://github.com/mwpastore/sinja)

## Installation

fairly simple. Demo uses Sqlite3 file database which is created and initialized on start if necessary. So, no worries at all (-;

## Running

There are at least two option. Manually:

```bash
cd demo_service
bundle # install necessary gems
rackup # start da app
```

You can also use docker to containerize our app and run it. To do that first build an image:

```bash
cd demo_service
docker build --force-rm --no-cache -t demo_service:0.0.1 .
```

after few (hundred) seconds our image is ready to use. Now it's time to run it:

```bash
cd demo_service
docker run -d --name demo_service -p9292:9292 demo_service:0.0.1
```

## Usage

There is a chance it's working so we could now try to add new user. Please notice we have to use a JSONAPI format:

```bash
curl -X POST \
-H "Accept: application/vnd.api+json" \
-H "Content-Type: application/vnd.api+json" \
-d '{"data":{"type":"users", "attributes":{ "email":"new@email.com", "name": "some new email"}}}' \
http://localhost:9292/users
```

let's query for all the users:

```bash
curl -X GET \
-H "Accept: application/vnd.api+json" \
-H "Content-Type: application/vnd.api+json" \
http://localhost:9292/users
```

and for particularly interesting one:

```bash
curl -X GET \
-H "Accept: application/vnd.api+json" \
-H "Content-Type: application/vnd.api+json" \
http://localhost:9292/users/1
```

you should get a JSONAPI format response, similar to this:

```json
{
  "data": {
    "type": "users",
    "id": "46",
    "attributes": {
      "id": 46,
      "name": "some new email",
      "email": "new@email.com"
    },
    "links": {
      "self": "/users/46"
    }
  },
  "jsonapi": {
    "version": "1.0"
  },
  "included": [

  ]
}
```

## Final thoughts

Have fun. It's very, very simple application made in minutes to check if and how well Sinatra + Sequel + Sinja performs.

For me it's a great combination and definitely worth considering for small code pieces like specialized microservice. Sinatra is amazing, every Rubyist knows that, right? Sinja seems to be very powerful and makes API implementation very easy.

Any comments as well as constructive critics is very welcome.
