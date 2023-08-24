# Compology Containers API

The Compology API allows you to query data about your containers.

The API is based on REST principles, making it conform to industry-standard
approaches, and making it easy to implement and test clients. You can use
**curl** to test URLs and you can use any programming language to interact
with the API.

Use cases of this API include (but are not limited to):

 * Getting a list of containers
 * Getting a list of containers for a specific customer

## Overview

## Version 1 (v1) (Base URL: `https://containers-api.compology.com/v1/`)

## API Reference

### REST Resource: Customers

#### GET `/customers/<compology customer id>/containers`
Return a list of containers located at the specified customer's location(s).
The list is paginated, with 100 records per page.

#### Parameters
 * `page` optional

#### Request example
```bash
export BASE=https://containers-api.compology.com/v1
export TOKEN=<your auth token>
curl -H 'Accept: application/json' -H "Authorization: Bearer ${TOKEN}" ${BASE}/customers/ABC/containers?page=0
```

#### Response example
```json
[
  {
    "id":"COMPOLOGYINC_04",
    "containerType":"roll off",
    "contentType":"refuse",
    "cubicYards":20,
    "description":"20-02",
    "externalId":"1ST4P4WFx6",
    "hasAccuratePosition":true,
    "lastClassifiedCameraBlocked":null,
    "lastGpsIsAccurate":true,
    "lastImageTimestamp":"2018-04-18T18:07:41.129Z",
    "lastImageUrl":"https://images.compology.com/1/raw_device_data/7ea64852-0215-4541-8a87-c4ea56f64734",
    "level":5,
    "location":{
      "id":null,
      "description":null,
      "externalId":null,
      "street":null,
      "city":null,
      "state":null,
      "zip":null
    },
    "locationUpdatedAt":"2018-04-19T01:02:44.207Z",
    "latitude":38.8977,
    "longitude":-77.0365,
    "maybeLastEmptiedAt":"2017-06-16T22:55:58.527Z",
    "pendingClassification":true,
    "positionAccuracy":3,
    "technicianAssigned":true,
    "updatedAt":"2018-10-18T05:17:08.359Z"
  },
  ...
]
```

### REST Resource: Containers

#### GET `/containers`
#### Parameters
 * `page` optional

#### Request example
```bash
export BASE=https://containers-api.compology.com/v1
export TOKEN=<your auth token>
curl -H 'Accept: application/json' -H "Authorization: Bearer ${TOKEN}" ${BASE}/containers
```

#### Response example
```json
[
  {
    "id":"COMPOLOGYINC_04",
    "containerType":"roll off",
    "contentType":"refuse",
    "cubicYards":20,
    "description":"20-02",
    "externalId":"1ST4P4WFJNA6",
    "hasAccuratePosition":true,
    "lastClassifiedCameraBlocked":null,
    "lastGpsIsAccurate":true,
    "lastImageTimestamp":"2018-04-18T18:07:41.129Z",
    "lastImageUrl":"https://images.compology.com/1/raw_device_data/7ea64852-0215-4541-8a87-c4ea56f64734",
    "level":5,
    "location":{
      "id":"96ece541-dd64-437f-a869-15e205e81111",
      "description":"Sanford Shop",
      "externalId":"SPRING001",
      "street":"123 Fake St",
      "city":"Springfield",
      "state":null,
      "zip":null
    },
    "locationUpdatedAt":"2018-04-19T01:02:44.207Z",
    "latitude":38.89,
    "longitude":-77.03,
    "maybeLastEmptiedAt":"2017-06-16T22:55:58.527Z",
    "pendingClassification":true,
    "positionAccuracy":3,
    "technicianAssigned":true,
    "updatedAt":"2018-10-18T05:17:08.359Z"
  },
  ...
]
```

** Version 2 (v2) (Base URL: `https://containers-api.compology.com/v2/`)

#### POST `/bulk_update`

  #### Paramaters
   * `containers` required ( a list of the containers to update)
    The types for container is as follows. In addition to the dumpsterId it must have
    at least one field to update and each field must be a valid input for a dumpster 
    in the user's organization
   * `dumpsterId` required
   * `description` optional
   * `cubicYards` optional
   * `containerType` optional
   * `contentType` optional
  
  #### Request Example
  ```json
    {
     "containers": [
        {
           "dumpsterId":"ROADRUNNERRECYCLING_00001",
           "description":"TEST",
           "cubicYards":42,
           "containerType":"roll off",
           "contentType":"recycle"
        }
     ]
    }
  ```
  
  #### Response Example
  ```json
  {
      "params": {
          "containers": [
              {
                  "dumpsterId": "ROADRUNNERRECYCLING_00001",
                  "description": "TEST",
                  "cubicYards": 42,
                  "containerType": "roll off",
                  "contentType": "recycle"
              }
          ]
      }
  }
  ```
  #### Notes
  * Will only update containers within the organization provided in the bearer token.
    * Requesting containers that do not exist or containers outside the organization will result in an erorr   
  * Set content-type: 'application/json'



## Authentication
API access will be supported only via HTTPS.

Users of this API will receive a JWT token. When a client makes a request to the API, this token shall be included in the `Authorization` header.

The header shall be formatted thusly: `Bearer <your token>`.

## Rate limiting
Excessive requests to this API will be denied via rate limiting.

## Error handling

### 200s
Successes will be HTTP responses with status codes between 200-299.

### 400s
Client errors will be indicated by HTTP responses with status codes between 400-499.

This level of error will be accompanied by an HTTP body containing JSON data with descriptive information about the error.

### 500s
Server-side or network errors will be indicated by HTTP responses with status codes between 500-599.
