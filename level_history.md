# Compology Level History API

**VERSION 1 (v1) FOR RELEASE**


## Overview

Base URL: `https://api.compology.com/v1/`

## API Reference

### REST Resource: Level History

#### GET `/reports/level_history.csv`

The level history report contains a single record for each level reading
performed by a Compology sensor. In addition to level information, the report
also includes additional information about the sensor reading and the container
to assist in data analysis.

#### Parameters

 * `api_key` required. See below
 * `organization_id` required. Contact support@compology.com for your organization’s identifier.
 * `start_at` required. The start of the report formatted as an ISO-8601 timestamp.
 * `end_at` required. The end of the report formatted as an ISO-8601 timestamp. This must be less than 32 days after the `start_at` value.

#### Response Type

Successful responses will always have a Content-Type of text/csv; charset=utf-8.

#### Response fields

| Name | Type      | Description | Example |
|------|-----------|-------------|---------|
| organization_id         | string    | Your organization’s identifier. This will match the organization_id value specified in the request. | compologyinc |
| occurred_at             | timestamp | The ISO-8601 timestamp of when this event occurred and data was captured. | 2017-11-01T01:58:59.615Z |
| customer_id             | string    | If the container was assigned to a customer when this event occurred, the unique identifier for the customer (typically an internal reference or billing id). | 30003 |
| customer_name           | string    | If the container was assigned to a customer when this event occurred, the name of the customer. | Blue Bottle Coffee |
| service_location_id     | string    | If the container was assigned to a service location when this event occurred, the unique identifier for the service location (typically an internal reference or billing id). | 461 |
| service_location_name   | string    | If the container was assigned to a service location when this event occurred, the name of the service location. | Ferry Building |
| container_id            | string    | The unique Compology identifier for the container. This identifier uniquely identifies the physical box. | AA4M1L41R9TD |
| container_name          | string    | The current name of the container (typically painted on the container). While duplicates are rare, this is not guaranteed to be unique. | 3-5201 |
| container_content_type  | string    | The designated content type of the container. | refuse |
| container_cubic_yards   | string    | The branded size of the container, in cubic yards. | 3 |
| level                   | integer   | If present, the level of content within the container at this event as a percentage, inclusive, between 0 and 100. This value may update for recent events as Compology has more time to classify data but should be relatively static 6 hours after the occurred_at timestamp. | 35 |
| was_emptied             | boolean   | If present, indicates whether the container was emptied prior to this event. This field is only supported for front-load containers. This value may update for recent events as Compology has more time to classify data but should be relatively static 12 hours after the occurred_at timestamp. | t |
| empty_occurred_at       | timestamp | If present (when was_emptied is t), the ISO-8601 timestamp representing Compology’s best guess at when the bin was emptied. This value may update for recent events as Compology has more time to classify data but should be relatively static 12 hours after the occurred_at timestamp. | 2017-11-01T01:31:42.982Z |
| latitude                | float     | If present, the latitude of the container at this event in decimal degrees. | 37.771777 |
| longitude               | float     | If present, the longitude of the container at this event in decimal degrees. | -122.407368 |
| position_accuracy       | float     | If present, the expected margin of error of the latitude/longitude values in meters. | 9.3 |
| image_url               | string    | If present, the url of the image taken at this event. | https://images.compology.com/1/raw_device_data/3a22fd3f-e793-4cf7-bcf9-be8e789d8a8b |


#### Example

```bash
export BASE_URL=https://api.compology.com/v1/
export API_KEY=<your api key>
export ORG_ID=<your organization id>
curl -o level_history.csv $BASE_URL/reports/level_history.csv?api_key=$API_KEY&organization_id=$ORG_ID&start_at=2017-11-01T00:00:00&end_at=2017-11-30T00:00:00
```

## Authentication

All requests to the API must include a secret API key (contact
support@compology.com for more information on how to acquire your secret key).
This key must be included in all requests as a query parameter with the key api_key.

All requests must be made over HTTPS, this API does not listen for requests over plain HTTP.

Your secret API key should not be shared in any publicly accessible places, client-side code, etc.

## Error handling

The API uses standard HTTP response codes to indicate the success or failure of a request. In general, 2XX responses indicate success, 4XX responses indicate an error with the request which must be corrected before retrying, and 5XX responses indicate a temporary issue with the API which may be retried in the future.

## Versioning

Major version numbers are defined in the API by using a URL path prefix.
These versions will be incremented when backwards incompatible changes are made to the API (for example, the removal of a response field). We expect these changes to be extremely infrequent and will work with API users to transition to new versions when changes are necessary.

Backwards compatible changes will not result in this version being incremented. The addition of new fields in responses is considered a backwards compatible change and users should anticipate the potential addition of new fields in responses.

## Data Types

CSV Responses

While there is no standardized CSV file format, Compology responses generally try to follow RFC 4180 with empty values generally indicating a null value. Boolean values are represented as either t or f and timestamp values are represented using their ISO-8601 value.

## Rate Limits

In general, we do not recommend requesting data from this endpoint more frequently than once per hour. Requests to this endpoint in excess of once per minute may result in temporary API key deactivation.

