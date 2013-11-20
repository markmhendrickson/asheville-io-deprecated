## asheville.io

This is an [Asheville](https://github.com/asheville) external service
for powering the Asheville Dashboard.

It contains both the frontend JavaScript application as well as the
API for said application.

The Asheville dashboard is the main interaction point for a user and Asheville,
and provides them access to settings, sync status and authentication configuration
(including OAuth flows) for various [storages](https://github.com/asheville/spec/blob/master/storage.md)
and [sources](https://github.com/asheville/spec/blob/master/sources.md).

This API exposes a JSON API intended for the dashboard JavaScript application.

It talks to various other Asheville services to populate data and modify
information, such as the [accounts](https://github.com/asheville/accounts)
API.

## Hacking on asheville-io

Download and install [Vagrant](http://vagrantup.com)
and [VirtualBox](https://www.virtualbox.org/)

## API

### Table of Contents

- [Storages](#storages) contains methods for accessing and configuring
a "storage" for a user.
- [Sources](#storages) contains methods for accessing and configuring
a "source" for a user.
- [Session](#session) contains authentication endpoints for the application,
as well as details for a specific user.
- [Storage Surveys](#storage-surveys) contains authentication endpoints for the application

This is documentation for an early API. It is very much a work-in-progress
and may change or break at any time.

### Storages

A storage is a connected service that is used to store
data collected from sources.

#### Retrieve all storages

**URL**: `/v1/storages`

**METHOD**: `GET`

##### Example

`GET /v1/storages`

```json
{
    "storages": [{
        "id": "6f447ed6-15b5-4e3b-b301-ddc0d07f409b",
        "type": "dropbox",
        "name": "Dropbox",
        "connected": true,
        "sizes": {
            "total": 5000000000,
            "available": 2000000000,
            "occupied": 1250000000,
            "other": 1750000000
        },
        "last_completed_sync": null
    }]
}
```

### Sources

A source is a connected service that is used to pull in information,
such as Facebook or Twitter.

#### Retrieve all sources

**URL**: `/v1/sources`

**METHOD**: `GET`

##### Example

`GET /v1/sources`

```json
{
    "sources": [{
        "id": "6f447ed6-15b5-4e3b-b301-ddc0d07f409b",
        "type": "facebook",
        "name": "Facebook",
        "connected": true,
        "sizes": {
            "total": 5000000000,
            "available": 2000000000,
            "occupied": 1250000000,
            "other": 1750000000
        },
        "total_items_synced": null,
        "total_items_available": null,
        "last_completed_sync": null,
        "content_types": {
            {
                "id": "6f447ed6-15b5-4e3b-b301-ddc0d07f409b",
                "name": "Photos",
                "enabled": true
            }
        },
    }
    }]
}
```

### Session

Exposes authentication and user information.

#### Retrieve Session

Returns a users current session

**URL**: `/v1/session`

**METHOD**: `GET`

##### Example

`GET /v1/session`

Returns:

```json
{
    "email": "example@example.org",
    "name": "Saul Goodman",
    "id": "6f447ed6-15b5-4e3b-b301-ddc0d07f409b"
}
```

### Storage Survey

Recieves a survey result for what storages people want.

#### Recieve Survey

**URL**: `/v1/storage_survey`

**METHOD**: `POST`

##### Example

`POST /v1/storage_survey`

Returns:

```json
{
    "success": true,
}
```
