<?php
declare(strict_types=1);

namespace App\Application\Actions\Constant;

use Psr\Http\Message\ResponseInterface as Response;
use App\Model\Constant;

class UpdateConstantAction extends ConstantAction
{
    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $name = (string) $this->resolveArg('name');
        $this->logger->info("UpdateConstantAction");

        $payload = (string) $this->request->getBody();
        $this->logger->debug('payload : ' . $payload);
        $payloadArray = json_decode($payload, true);

        return $this->respondWithData($this->service->update($payloadArray));
    }
}
