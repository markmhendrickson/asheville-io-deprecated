## accounts.asheville

This is an [Asheville](https://github.com/asheville) internal
service for the management of user accounts.

Given proper authentication, it exposes an HTTP/JSON API for:

- Retrieving information about an Asheville user, such as authentication
tokens for their connected networks and storage systems
- Adding authentication tokens
- Deleting a user from Asheville

## Security

Initially, this API will be exposed on a local network only, requiring
the use of a VPN to be connected to by other Asheville services.

Additionally, an authentication token must be used to connect to the
service.

The authentication token is sent in the header in an `X-Asheville-Auth`
field, i.e:

```
GET: "accounts.asheville/v1/user/6f447ed6-15b5-4e3b-b301-ddc0d07f409b.json HTTP/1.1"
HOST: "accounts.asheville"
X-Asheville-Auth: "foobar-token"
```

## Hacking on asheville-accounts

TODO Vagrant Guide.

## API

### Table of Contents

- [User](#user) contains methods for manipulating individual Asheville users
- [Admin](#admin) exposes various admin statistics about the Asheville userbase

This is documentation for an early API. It is very much a work-in-progress
and may change or break at any time.

### User

A user represents an invidiual that has signed up and connected at least
one storage account with Asheville.

#### Retrieve a User

**URL**: `/v1/user/<uuid>.json`

**METHOD**: `GET`

**ARGS**:

- `user_id` (required): A unique identifier representing the users
Asheville ID. This should be a 36 character UUID as specified in [RFC 4122](http://tools.ietf.org/html/rfc4122.html),
or, more realistically, generated using Python's built-in `uuid.uuid4()`

##### Example

`GET /v1/user/6f447ed6-15b5-4e3b-b301-ddc0d07f409b.json`

```json
{
    "id": "6f447ed6-15b5-4e3b-b301-ddc0d07f409b",
    "identity": {
        "name": "Jack Pearkes",
        "email": "jackpearkes@gmail.com"
    },
    "storages": [{
        "type": "dropbox",
        "authentication_type": "credential_pair",
        "access_key": "foo",
        "access_secret": "bar",
        "state": "paused",
        "settings": {
            "arbitrary": "key value settings"
        }
    }],
    "sources": [{
        "type": "facebook",
        "authentication_type": "credential_pair",
        "access_key": "foo",
        "access_secret": "bar",
        "state": "bad_authentication",
        "settings": {
            "arbitrary": "key value settings"
        },
        "content_types": [
            "photos": true,
            "checkins": false,
            "facebook_specific_thing": true
        ]
    }],
    "created_at": "2013-10-05 10:33:22",
    "updated_at": "2013-10-05 10:33:22"
}
```

#### Create a User

Creates a user with the given credentials.

**URL**: `/v1/user`

**METHOD**: `POST`

**REQUEST BODY** (json):

- `identity` (optional): Identity meta data for the user
    - `name`: The users full name
    - `email`: The users email address
- `storages` (optional): An array of storage objects
    - `type` (required): The type of storage backend, i.e `dropbox`
    - `authentication_type` (required): The method of authentication, i.e `credential_pair`
    - `access_key` (required for `credential_pair` type): The key or ID on the service for the user
    - `access_secret` (required for `credential_pair` type): The secret or password associated with the key for the user on the service
    - `state` (optional): The current state of the storage backend, i.e `active` or `bad_authentication`
    - `settings` (optional): Any arbitrary service-specific settings. Any valid JSON can be passed into this key.
- `sources` (optional): An array of source objects
    - `type` (required): The type of storage backend, i.e `facebook`
    - `authentication_type` (required): The method of authentication, i.e `credential_pair`
    - `access_key` (required for `credential_pair` type): The key or ID on the service for the user
    - `access_secret` (required for `credential_pair` type): The secret or password associated with the key for the user on the service
    - `state` (optional): The current state of the storage backend, i.e `active` or `bad_authentication`
    - `settings` (optional): Any arbitrary service-specific settings. Any valid JSON can be passed into this key.
    - `content_types` (optional): An array of boolean key-value pairs representing what the Asheville service should sync for the user

##### Example

`POST /v1/user`

Payload:

```json
{
    "identity": {
        "email": "jackpearkes@gmail.com"
    }
}
```

Returns:

```json
{
    "id": "6f447ed6-15b5-4e3b-b301-ddc0d07f409b",
    "identity": {
        "email": "jackpearkes@gmail.com",
        "name": null
    }
    "storages": [],
    "sources": [],
    "created_at": "2013-10-05 10:33:22",
    "updated_at" "2013-10-05 10:33:22"
}
```

### Admin

Admin exposes various statistics about the Asheville user accounts.

#### Retrieve Stats

Creates a user with the given credentials.

**URL**: `/v1/user`

**METHOD**: `POST`

**PARAMS**:



