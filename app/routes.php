<?php
declare(strict_types=1);

use App\Application\Actions\User\ListUsersAction;
use App\Application\Actions\User\ViewUserAction;
use App\Application\Actions\Constant\ViewConstantAction;
use App\Application\Actions\Constant\ListConstantAction;
use App\Application\Actions\Constant\CreateConstantAction;
use App\Application\Actions\Constant\UpdateConstantAction;
use App\Application\Actions\Constant\DeleteConstantAction;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\App;
use Slim\Interfaces\RouteCollectorProxyInterface as Group;
use Illuminate\Database\Capsule\Manager as Manager;
use App\Model\Constant;

return function (App $app) {
    $app->options('/{routes:.*}', function (Request $request, Response $response) {
        // CORS Pre-Flight OPTIONS Request Handler
        return $response;
    });

    $app->get('/', function (Request $request, Response $response) {
        $response->getBody()->write('API version 0.0.0');
        return $response;
    });

    $app->group('/constants', function (Group $group) {
        $group->get('', ListConstantAction::class);
        $group->post('', CreateConstantAction::class);
        $group->get('/{name}', ViewConstantAction::class);
        $group->put('/{name}', UpdateConstantAction::class);
        $group->delete('/{name}', DeleteConstantAction::class);
    });
};
