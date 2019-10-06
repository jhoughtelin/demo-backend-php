# Sample Backend for PHP

This repository contains a sample backend code that demonstrates how to generate a Virgil JWT using the [PHP SDK](https://github.com/VirgilSecurity/virgil-sdk-php)

Do not use this authentication in production. Requests to /virgil-jwt endpoint must be allowed for authenticated users. Use your application authorization strategy.

## Installation

### Prerequisites

* PHP7.2 / PHP7.3
* **virgil_crypto_php** extension

#### Add virgil_crypto_php extension into the server

- [Download](https://github.com/VirgilSecurity/sample-backend-php/releases) *virgil-test.zip*, unzip it and execute on your server [virgil-test.php](/_help/virgil-test.php) file.

- [Download](https://github.com/VirgilSecurity/sample-backend-php/releases) and unzip *%YOUR_OS%_extension.zip* archive according to your server operating system and PHP version.

- Make sure you have access to edit the php.ini file (for example, use *root* for the Linux/Darwin or run *cmd* under administrator for the Windows).
- Copy extensions files to the extensions directory.
    - For the Linux/Darwin:
    ```
     $ path="%PATH_TO_EXTENSIONS_DIR%" && cp virgil_crypto_php.so $path
    ```
    - Or for the Windows:
    ```
     $ set path=%PATH_TO_EXTENSIONS_DIR% && copy virgil_crypto_php.dll %path%
    ```
- Add the extensions in to the php.ini file 
    ```
    $ echo "extension=virgil_crypto_php” >> %PATH_TO_PHP.INI%
    ```
    
- Then, restart your server or php-fpm service!

##### Extension installation example

Our web stack is: *Linux, nginx, php7.2-fpm*

- Execute the [virgil-test.php](/_help/virgil-test.php) to find out your path to the extensions directory and path to the php.ini file:
    <p><img src="https://raw.githubusercontent.com/VirgilSecurity/sample-backend-php/master/_help/s-1.png" width="60%"></p> 

- Then, go to the command line interface (CLI) to specify the paths from the previous step:
    <p><img src="https://raw.githubusercontent.com/VirgilSecurity/sample-backend-php/master/_help/s-2.png" width="60%"></p>

- Reload the page in your browser to see that extensions is loaded (`IS_EXTENSION_LOADED => true`):
    <p><img src="https://raw.githubusercontent.com/VirgilSecurity/sample-backend-php/master/_help/s-3.png" width="60%"></p>
    
### Clone the repository and install dependencies

```
$ git clone https://github.com/VirgilSecurity/sample-backend-php.git .
$ composer install
```

### Get Virgil Credentials

If you don't have an account yet, [sign up for one](https://dashboard.virgilsecurity.com/signup) using your e-mail.

To generate a JWT the following values are required:

| Variable Name                     | Description                    |
|-----------------------------------|--------------------------------|
| APP_KEY                  | Private key of your API key that is used to sign the JWTs. |
| APP_KEY_ID               | ID of your API key. A unique string value that identifies your account in the Virgil Cloud. |
| APP_ID                   | ID of your Virgil Application. |

### Add Virgil Credentials to the .env

- create a `.env` file from the `.env.example` and fill it with your account credentials

## Configure and Run Server

Make sure that `./app/public/` is a public-accessible directory with a `index.php` file. Also, you need to make a front-controller and rewrite all requests to the `index.php` file.

More info on how to configure and run a Apache/nginx/hhvm server can be found [here](https://www.slimframework.com/docs/v3/start/web-servers.html).

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

<p><img src="https://raw.githubusercontent.com/VirgilSecurity/sample-backend-php/master/_help/s-4.png" width="60%"></p>

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

<p><img src="https://raw.githubusercontent.com/VirgilSecurity/sample-backend-php/master/_help/s-5.png" width="60%"></p>

## Virgil JWT Generation
To generate JWT, you need to use the `JwtGenerator` class from the SDK.

```php
$privateKeyStr = $_ENV['APP_KEY'];
$apiKeyData = base64_decode($privateKeyStr);

$crypto = new VirgilCrypto();
$privateKey = $crypto->importPrivateKey($apiKeyData);

$accessTokenSigner = new VirgilAccessTokenSigner();

$appId = $_ENV['APP_ID'];
$apiKeyId = $_ENV['APP_KEY_ID'];
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
