# ruby-whois-api

A simple web service for [the Ruby WHOIS gem](https://github.com/weppos/whois)

## Usage

`git clone` this repo and install the necessary gems. Then `touch` api-keys.txt in the repo root. Open with your favorite text editor. Valid API keys should each live on their own line in this file.

Request the service with the API key as follows

`curl -H "Whois-Api-Key: vsdAxe2dajkSf3sjkFSDF34sa" http://my-whois-endpoint.com/google.com`

API responds in JSON

`status`: 200 for successful request, 400 for error
`data`: JSON based on parser from [the Ruby WHOIS gem](https://github.com/weppos/whois)
`error`: Error message (if an error is encountered)


