<?php

$extension = 'virgil_crypto_php';

$result = [
    'EXTENSION' => $extension,
    'IS_EXTENSION_LOADED' => extension_loaded($extension),
    'OS' => PHP_OS,
    'PHP' => PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION,
    'PATH_TO_EXTENSIONS_DIR' => PHP_EXTENSION_DIR,
    'PATH_TO_PHP.INI' => php_ini_loaded_file(),
];

var_dump($result);
exit();