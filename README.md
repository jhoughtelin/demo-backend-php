# Sample Backend for PHP

This repository contains a sample backend code that demonstrates how to generate a Virgil JWT using the [PHP SDK](https://github.com/VirgilSecurity/virgil-sdk-php)

Do not use this authentication in production. Requests to /virgil-jwt endpoint must be allowed for authenticated users. Use your application authorization strategy.

## Installation

### Prerequisites

* PHP 5.6 and newer
* virgil_crypto_php extension

#### Add virgil_crypto_php extension before install this sample backend:

* [Download virgil_crypto_{latest version} archive from the CDN](https://cdn.virgilsecurity.com/virgil-crypto/php/) 
according to 
your server operating system and PHP version
* Place virgil_crypto_php.so* file from the archive into the directory with extensions
* Add string *extension=virgil_crypto_php.so* to the php.ini file
* Restart your web-service (apache or nginx): *sudo service {apache2 / nginx} restart*

##### Tips:

* PHP version: *phpversion() / php --version*
* OS Version: *PHP_OS*
* php.ini and extensions directory: *phpinfo() / php -i / php-config --extension_dir*

### Clone the repository and make composer update

```
$ git clone https://github.com/VirgilSecurity/sample-backend-php.git
$ composer update
```

### Get Virgil Credentials

If you don't have an account yet, [sign up for one](https://dashboard.virgilsecurity.com/signup) using your e-mail.

To generate a JWT the following values are required:

| Variable Name                     | Description                    |
|-----------------------------------|--------------------------------|
| API_PRIVATE_KEY                  | Private key of your API key that is used to sign the JWTs. |
| API_KEY_ID               | ID of your API key. A unique string value that identifies your account in the Virgil Cloud. |
| APP_ID                   | ID of your Virgil Application. |

### Add Virgil Credentials to .env

- open the project folder
- create a `.env` file
- fill it with your account credentials (take a look at the `.env.example` file to find out how to setup your own `.env` file)
- save the `.env` file

## Configure and Run Server

Make sure that `./app/public/` is a public-accessible directory with a `index.php` file. Also, you need to make a 
front-controller and rewrite all requests to the `index.php` file.

More info on how to configure and run a
Apache/nginx/hhvm server can be found [here](https://www.slimframework.com/docs/v3/start/web-servers.html).

## Specification

### /authenticate endpoint
This endpoint is an example of users authentication. It takes user `identity` and responds with unique token.

```http
POST https://<server_name>/authenticate HTTP/1.1
Content-type: application/json;

{
    "identity": "string"
}

Response:

{
    "authToken": "string"
}
```

### /virgil-jwt endpoint
This endpoint checks whether a user is authorized by an authorization header. It takes user's `authToken`, finds related user identity and generates a `virgilToken` (which is [JSON Web Token](https://jwt.io/)) with this `identity` in a payload. Use this token to make authorized api calls to Virgil Cloud.

```http
GET https://<server_name>/virgil-jwt HTTP/1.1
Content-type: application/json;
Authorization: Bearer <authToken>

Response:

{
    "virgilToken": "string"
}
```

## Virgil JWT Generation
To generate JWT, you need to use the `JwtGenerator` class from the SDK.

```php
    $privateKeyStr = $_ENV['API_PRIVATE_KEY'];
    $apiKeyData = base64_decode($privateKeyStr);

    $crypto = new VirgilCrypto();
    $privateKey = $crypto->importPrivateKey($apiKeyData);

    $accessTokenSigner = new VirgilAccessTokenSigner();

    $appId = $_ENV['APP_ID'];
    $apiKeyId = $_ENV['API_KEY_ID'];
    $ttl = 3600;

    $jwtGenerator = new JwtGenerator($privateKey, $apiKeyId, $accessTokenSigner, $appId, $ttl);

    $token = $jwtGenerator->generateToken($identity);

    $jwt = $token->__toString();

```
Then you need to provide an HTTP endpoint which will return the JWT with the user's identity as a JSON.

For more details take a look at the [JWTGenerator.php](app/core/JWTGenerator.php) file.

## License

This library is released under the [3-clause BSD License](LICENSE.md).

## Support
Our developer support team is here to help you. Find out more information on our [Help Center](https://help.virgilsecurity.com/).

You can find us on [Twitter](https://twitter.com/VirgilSecurity) or send us email support@VirgilSecurity.com.

Also, get extra help from our support team on [Slack](https://virgilsecurity.com/join-community).
