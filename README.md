# Demo Service

This is a sample Sinatra + Sequel + Sinja microservice template application.

## Requirements

just a bunch of gems specified in a `Gemfile`

## Installation

fairly simple. Demo uses Sqlite3 file database which is created and initialized on start if necessary. So, no worries at all (-;

## Running

There are at least two option. Manually:

```bash
cd demo_service
rackup
```

You can also use docker to containerize our app and run it. To do that first build an image:

```bash
cd demo_service
docker build --force-rm --no-cache -t demo_service:0.0.1 .
```

after some... time our image is ready to use. Now it's time to run it:

```bash
cd demo_service
docker run -d --name demo_service -p9292:9292 demo_service:0.0.1
```

## Usage

If it works we can now try tu add a user:

```bash
curl -X POST \
-H "Accept: application/vnd.api+json" \
-H "Content-Type: application/vnd.api+json" \
-d '{"data":{"type":"users", "attributes":{ "email":"new@email.com", "name": "some new email"}}}' \
http://localhost:9292/users
```

query for all the users:

```bash
curl -X GET \
-H "Accept: application/vnd.api+json" \
-H "Content-Type: application/vnd.api+json" \
http://localhost:9292/users
```

and specific user:

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

Have fun. It's very, very simple application made in minutes to check if and how well Sinatra + Sequel + Sinja performs. For me it's a great combination and definitely worth considering for small code pieces like specialized microservice.

Any comments as well as constructive critics is very welcome.
