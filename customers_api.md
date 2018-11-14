# Compology Customers and Locations Read/Write API

The Compology Customers and Locations Read/Write API allows you to query
and create data about your customers and their service locations.

The API is based on REST principles, making it conform to industry-standard
approaches, and making it easy to implement and test clients. You can use
**curl** to test URLs and you can use any programming language to interact
with the API.

Use cases of this API include (but are not limited to):

 * Getting a list of customers
 * Getting a list of service locations for a specific customer
 * Adding a service location
 * Deleting a service location
 
## Terminology

For the purposes of this API `compology customer id` and `compology location id`
refer to Compology's internal identifiers for specific entities.  The terms
`external customer id`, `externalCustomerId`, `external location id`, and
`externalLocationId` refer to the API user's identifiers for specific entities.


## Overview

Base URL: `https://customers-api.compology.com/v1/`


## API Reference

### REST Resource: Customer

#### GET `/customers`
Return a list of customers ordered by the date they were created.
The list is paginated, with 100 records per page.

#### Parameters
 * `page` optional
 
#### Request example
```
curl -v -H "Authorization: Bearer $TOKEN" "https://customers-api.compology.com/v1/customers?page=0"
```


#### GET `/customers/e/<external customer id>`

#### Parameters
None.

#### Request example
```
curl -v -H "Authorization: Bearer $TOKEN" "https://customers-api.compology.com/v1/customers/e/kljlkj"
```

#### Response example
```
...
< HTTP/1.1 200 OK
< Date: Thu, 18 Oct 2018 17:47:15 GMT
< Content-Type: application/json; charset=utf-8
< Content-Length: 366
...
{"id":"f5e77ca3-357a-4100-9796-5c3ae850a837","externalCrmId":"kljlkj","organizationId":"compologyinc","name":"Aplace in Santa Cruz","createdAt":"2018-07-24T21:40:03.482Z","updatedAt":"2018-07-24T21:40:03.482Z","billingStreet":"","billingCity":"","billingState":"","billingZip":"","contactFullName":"","contactPhone":"","email":"","isActive":true,"billingCountry":""}
```

#### POST `/customers`

#### Parameters
 * `name` required
 * `externalCustomerId` required
   * must be unique
 * `billingStreet` optional
 * `billingCity` optional
 * `billingState` optional
 * `billingPostcode` optional
 * `contactEmail` optional
 * `contactFullName` optional
 * `contactPhone` optional
 
#### Request example
```
curl -v -X POST -H "Authorization: Bearer $TOKEN" "https://customers-api.compology.com/v1/customers/" -d name=foo -d externalCustomerId=ABC098 -d "billingStreet=123 Bar St" -d "contactFullName=John Doe"
```

#### Response example

**NOTE:** 201, with `location` header set to the URL that includes the `compology customer id`
```
< HTTP/1.1 201 Created
< Date: Thu, 18 Oct 2018 17:51:13 GMT
< Content-Type: application/json; charset=utf-8
< Content-Length: 251
< Connection: keep-alive
< Strict-Transport-Security: max-age=31536000
< X-Content-Type-Options: nosniff
< X-Frame-Options: DENY
< X-XSS-Protection: 1; mode=block
< Vary: X-HTTP-Method-Override, Accept-Encoding
< Location: /v1/customers/fbb31d2e-ccc2-40c0-a314-1ca113a29ec1
...
{"name":"foo","organizationId":"compologyinc","billingStreet":"123 Bar St","externalCrmId":"ABC098","contactFullName":"John Doe","updatedAt":"2018-10-18T17:51:13.481Z","createdAt":"2018-10-18T17:51:13.481Z","id":"fbb31d2e-ccc2-40c0-a314-1ca113a29ec1"}
```

#### PUT `/customers/`
This endpoint can also be used to "undelete" a previously-deleted customer.

#### Parameters
 * `name` required
 * `externalCustomerId` required
   * must be unique
 * `billingStreet` optional
 * `billingCity` optional
 * `billingState` optional
 * `billingZip` optional
 * `contactEmail` optional
 * `contactFullName` optional
 * `contactPhone` optional

#### Request example
```
curl -v -X PUT -H "Authorization: Bearer $TOKEN" "https://customers-api.compology.com/v1/customers/" -d externalCustomerId=ABC098 -d name=foo -d "contactFullName=John W. Doe"
```

#### Response example
```
< HTTP/1.1 200 OK
...
{"id":"fbb31d2e-ccc2-40c0-a314-1ca113a29ec1","externalCrmId":"ABC098","organizationId":"compologyinc","name":"foo","createdAt":"2018-10-18T17:51:13.481Z","updatedAt":"2018-10-18T17:57:36.860Z","contactFullName":"John W. Doe","isActive":true,"billingCountry":null}
```

#### PUT `/customers/e/<external customer id>`
This endpoint can also be used to "undelete" a previously-deleted customer.
#### Parameters
 * `name` required
 * `externalCustomerId` required
   * must be unique
 * `billingStreet` optional
 * `billingCity` optional
 * `billingState` optional
 * `billingZip` optional
 * `contactEmail` optional
 * `contactFullName` optional
 * `contactPhone` optional

#### Request example
```
curl -v -X PUT -H "Authorization: Bearer $TOKEN" "https://customers-api.compology.com/v1/customers/e/ABC098" -d name=foo -d "contactFullName=John X. Doe"
```

#### Response example
```
< HTTP/1.1 200 OK
...
{"id":"fbb31d2e-ccc2-40c0-a314-1ca113a29ec1","externalCrmId":"ABC098","organizationId":"compologyinc","name":"foo","createdAt":"2018-10-18T17:51:13.481Z","updatedAt":"2018-10-18T17:55:04.466Z","contactFullName":"John X. Doe","isActive":true,"billingCountry":null}
```


#### DELETE `/customers/e/<external customer id>`

#### Parameters
None.

#### Request example
```
curl -v -X DELETE -H "Authorization: Bearer $TOKEN" "https://customers-api.compology.com/v1/customers/e/ABC098"
```

#### Response example
```
< HTTP/1.1 200 OK
...
{"id":"fbb31d2e-ccc2-40c0-a314-1ca113a29ec1","externalCrmId":"ABC098","organizationId":"compologyinc","name":"foo","createdAt":"2018-10-18T17:51:13.481Z","updatedAt":"2018-10-18T17:59:49.077Z","billingStreet":"123 Bar St","billingCity":null,"billingState":null,"billingZip":null,"contactFullName":"John W. Doe","contactPhone":null,"email":null,"isActive":false,"billingCountry":null}

```

### REST Resource: Location

#### GET `/locations`
Return a list of service locations ordered by the date they were created.
The list is paginated, with 100 records per page.
#### Parameters
 * `page` optional

#### GET `/locations/e/<external location id>`
#### Parameters
None.

#### POST `/locations`
#### Parameters
 * `externalCustomerId` required
   * must be an existing customer's external id
 * `externalLocationId` required
   * must be unique
 * `lat` optional
   * must be a valid latitude
 * `lon` optional
   * must be a valid longitude
 * `radius` optional
   * must be between 30 and 999
 * `description` optional
 * `street` optional
 * `city` optional
 * `state` optional
 * `zip` optional
 * `contactEmail` optional
 * `contactFullName` optional
 * `contactPhone` optional

#### PUT `/locations/`
This endpoint can also be used to "undelete" a previously-deleted location.
#### Parameters
 * `externalLocationId` required
   * must be unique
 * `externalCustomerId` required
 * `description` optional
 * `street` optional
 * `city` optional
 * `state` optional
 * `zip` optional
 * `contactEmail` optional
 * `contactFullName` optional
 * `contactPhone` optional
 * `lat` optional
   * must be a valid latitude
   * ignored if Compology has automatically adjusted the position
 * `lon` optional
   * must be a valid longitude
   * ignored if Compology has automatically adjusted the position

#### PUT `/locations/e/<external location id>`
This endpoint can also be used to "undelete" a previously-deleted location.
#### Parameters
 * `externalLocationId` required
   * must be unique
 * `externalCustomerId` required
 * `description` optional
 * `street` optional
 * `city` optional
 * `state` optional
 * `zip` optional
 * `contactEmail` optional
 * `contactFullName` optional
 * `contactPhone` optional
 * `lat` optional
   * must be a valid latitude
   * ignored if Compology has automatically adjusted the position
 * `lon` optional
   * must be a valid longitude
   * ignored if Compology has automatically adjusted the position

#### DELETE `/locations/e/<external location id>`
#### Parameters
None.

## Authentication
API access will be supported only via HTTPS.

Users of this API will receive a JWT token. When a client makes a request to the API, this token shall be included in the `Authorization` header.

The header shall be formatted thusly: `Bearer <your token>`.
```bash
export TOKEN=eyJ0ABC...XYZ
curl -v -H "Authorization: Bearer $TOKEN" "https://customers-api.compology.com/v1/locations"
```


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
