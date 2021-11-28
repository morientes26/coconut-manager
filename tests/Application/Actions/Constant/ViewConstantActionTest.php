<?php
declare(strict_types=1);

namespace Tests\Application\Actions\Constant;

use App\Application\Actions\ActionError;
use App\Application\Actions\ActionPayload;
use App\Application\Handlers\HttpErrorHandler;
use App\Model\Constant;
use App\Domain\Constant\ConstantService;
use DI\Container;
use Slim\Middleware\ErrorMiddleware;
use App\Domain\DomainException\DomainRecordNotFoundException;
use Tests\TestCase;

class ViewConstantActionTest extends TestCase
{
    public function testAction()
    {
        $app = $this->getAppInstance();

        /** @var Container $container */
        $container = $app->getContainer();

        $constant = new Constant(['abc', '123']);

        $constantServiceProphecy = $this->prophesize(ConstantService::class);
        $constantServiceProphecy
            ->findOneByName('abc')
            ->willReturn($constant)
            ->shouldBeCalledOnce();

        $container->set(ConstantService::class, $constantServiceProphecy->reveal());

        $request = $this->createRequest('GET', 'constants/abc');
        $response = $app->handle($request);

        $payload = (string) $response->getBody();
        $expectedPayload = new ActionPayload(200, $constant);
        $serializedPayload = json_encode($expectedPayload, JSON_PRETTY_PRINT);

        $this->assertEquals($serializedPayload, $payload);
    }

    public function testActionThrowsConstantNotFoundException()
    {
        $app = $this->getAppInstance();

        $callableResolver = $app->getCallableResolver();
        $responseFactory = $app->getResponseFactory();

        $errorHandler = new HttpErrorHandler($callableResolver, $responseFactory);
        $errorMiddleware = new ErrorMiddleware($callableResolver, $responseFactory, true, false, false);
        $errorMiddleware->setDefaultErrorHandler($errorHandler);

        $app->add($errorMiddleware);

        /** @var Container $container */
        $container = $app->getContainer();

        $constantServiceProphecy = $this->prophesize(ConstantService::class);
        $constantServiceProphecy
            ->findOneByName('notexists')
            ->willThrow(new DomainRecordNotFoundException())
            ->shouldBeCalledOnce();

        $container->set(ConstantService::class, $constantServiceProphecy->reveal());

        $request = $this->createRequest('GET', '/constants/notexists');
        $response = $app->handle($request);

        $payload = (string) $response->getBody();
        $expectedError = new ActionError(ActionError::RESOURCE_NOT_FOUND, '');
        $expectedPayload = new ActionPayload(404, null, $expectedError);
        $serializedPayload = json_encode($expectedPayload, JSON_PRETTY_PRINT);

        $this->assertEquals($serializedPayload, $payload);
    }
}
