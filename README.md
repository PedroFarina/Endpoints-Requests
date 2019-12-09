# Endpoints-Requests
A simplified Swift library to manage gets and posts from servers.

## This framework was built for handling gets and posts from any servers.

### Get:
When in need of a get request all you have to do is one call:

`EndpointsRequests.getRequest` which creates a get request and can do the following:
* Add headers
* Return the answer as:
    * Given by the server
    * A decodable object
* Trigger a completion handler with its answer

### Post:
When in need of a post request all you have to do is one call:

`EndpointsRequests.postRequest` which creates a post requests and can do the following:
* Add headers
* Add params as a:
    * Dictionary with key/value
    * Encodable object
* Return the answer as:
    * Given by the server
    * A decodable object
* Trigger a completion handler with its answer

### Errors
The answers might be errors when:
* An error occurs on the server
* An invalid URL was passed as parameter
* Could not encode object as JSON
