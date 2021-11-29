<?php
declare(strict_types=1);

use App\Service\Constant\ConstantService;
use App\Service\Constant\ConstantServiceInterface;
use DI\ContainerBuilder;

return function (ContainerBuilder $containerBuilder) {

    $containerBuilder->addDefinitions([
        ConstantServiceInterface::class => \DI\autowire(ConstantService::class),
    ]);
};
