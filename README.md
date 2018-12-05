# Sample backend for PHP

This repository contains a sample backend code that demonstrates how to generate a Virgil JWT using PHP.

## Installation

### Requirements

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

### Virgil Credentials and .env file

If you don't have an account yet, [sign up for one](https://dashboard.virgilsecurity.com/signup) using your e-mail.

To generate a JWT the following values are required:

| Variable Name                     | Description                    |
|-----------------------------------|--------------------------------|
| API_PRIVATE_KEY                   | Private key of your API key that is used to sign the JWTs. |
| API_KEY_ID                        | ID of your API key. A unique string value that identifies your account in the Virgil Cloud. |
| APP_ID                            | ID of your Virgil Application. |

Create a `.env` file from `.env.example` and fill it with your credentials

## Endpoints

### /authenticate

* Method: POST
* Request body: `{"identity": {string}}`
* Response: `{"token": {string}}` or `{"error-message": {string}}`

### /virgil-jwt

* Method: GET
* Request: `header: {"Authorization": "Bearer {string}"}`
* Response: `{"token": {string}}` or `{"error-message": {string}}`

## Configure and Run Server

Make sure that `./app/public/` is a public-accessible directory with a `index.php` file. Also, you need to make a 
front-controller and rewrite all requests to the `index.php` file.

More info on how to configure and run a
Apache/nginx/hhvm server can be found [here](https://www.slimframework.com/docs/v3/start/web-servers.html).


## License

This library is released under the [3-clause BSD License](LICENSE.md).

## Support
Our developer support team is here to help you. Find out more information on our [Help Center](https://help.virgilsecurity.com/).

You can find us on [Twitter](https://twitter.com/VirgilSecurity) or send us email support@VirgilSecurity.com.

Also, get extra help from our support team on [Slack](https://virgilsecurity.slack.com/join/shared_invite/enQtMjg4MDE4ODM3ODA4LTc2OWQwOTQ3YjNhNTQ0ZjJiZDc2NjkzYjYxNTI0YzhmNTY2ZDliMGJjYWQ5YmZiOGU5ZWEzNmJiMWZhYWVmYTM).
