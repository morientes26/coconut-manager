<?php
declare(strict_types=1);

use App\Application\Settings\Settings;
use App\Application\Settings\SettingsInterface;
use DI\ContainerBuilder;
use Monolog\Logger;

return function (ContainerBuilder $containerBuilder) {
    $dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . "/..");
    $dotenv->load();

    // Global Settings Object
    $containerBuilder->addDefinitions([
        SettingsInterface::class => function () {
            return new Settings([
                'displayErrorDetails' => true, // Should be set to false in production
                'logError'            => false,
                'logErrorDetails'     => false,
                'logger' => [
                    'name' => 'slim-app',
                    'path' => isset($_ENV['docker']) ? 'php://stdout' : __DIR__ . '/../logs/app.log',
                    'level' => Logger::DEBUG,
                ],
                'db' => [
                    'driver' => isset($_ENV['DB_DRIVER']) ? $_ENV['DB_DRIVER'] : 'mysql',
                    'host' => isset($_ENV['DB_HOST']) ? $_ENV['DB_HOST'] : '127.0.0.1',
                    'database' => isset($_ENV['DB_NAME']) ? $_ENV['DB_NAME'] : 'coconu24_testing',
                    'username' => isset($_ENV['DB_USERNAME']) ? $_ENV['DB_USERNAME'] : 'coconut',
                    'password' => isset($_ENV['DB_PASSWORD']) ? $_ENV['DB_PASSWORD'] : 'coconut',
                    'charset'   => 'utf8',
                    'collation' => 'utf8_unicode_ci',
                    'prefix'    => '',
                ]
            ]);
        }
    ]);
};
