<?php
declare(strict_types=1);

use DI\Container;
use App\Application\Settings\SettingsInterface;
use Illuminate\Database\Capsule\Manager as Capsule;

return function (SettingsInterface $settings) {
    $capsule = new Capsule;
    $capsule->addConnection($settings->get('db'));
    $capsule->setAsGlobal();
    $capsule->bootEloquent();
};
