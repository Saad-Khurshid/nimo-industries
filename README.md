# Nimo Industries Crypto Price API

Nimo Industries initial assessment microservices architecture for crypto APIs with CICD.

## API Endpoints

### 1. Email Crypto Price

This endpoint sends the current price of a specified cryptocurrency to a given email address.

#### Endpoint: `GET /email-crypto-price`

#### Query Parameters

- `coin`: The name of the cryptocurrency (e.g., `bitcoin`).
- `toEmail`: The email address to which the crypto price will be sent.

#### Example Request

https://n22kdaewb3.execute-api.us-east-2.amazonaws.com/dev/email-crypto-price?coin=bitcoin&toEmail=saadkhurshid@rocketmail.com


### 2. Crypto Search History

This endpoint retrieves the history of cryptocurrency price searches for a given email address, returning 10 items at a time in a most recent first manner. The `LastEvaluatedKey` parameter can be used to paginate through the search history.

#### Endpoint: `GET /crypto-search-history`

#### Query Parameters

- `email`: The email address for which the search history is requested.
- `LastEvaluatedKey`: The key to retrieve the next set of items in the search history. This can be `null` for the first request.

#### Example Request

https://n22kdaewb3.execute-api.us-east-2.amazonaws.com/dev/crypto-search-history?email=saadkhurshid@rocketmail.com&LastEvaluatedKey=null


## Pagination

For the Crypto Search History endpoint, if there are more than 10 items in the search history, the response will include a `LastEvaluatedKey` value. Use this value in the subsequent request to retrieve the next set of items. If the `LastEvaluatedKey` is `null`, it indicates that there are no more items to retrieve.
