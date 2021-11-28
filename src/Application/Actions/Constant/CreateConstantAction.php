<?php
declare(strict_types=1);

namespace App\Application\Actions\Constant;

use Psr\Http\Message\ResponseInterface as Response;
use App\Model\Constant;

class CreateConstantAction extends ConstantAction
{
    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $this->logger->info("CreateConstantAction");
        $payload = $this->request->getBody()->getContents();
        $this->logger->debug('payload : ' . $payload);
        $payloadArray = json_decode($payload, true);
        return $this->respondWithData($this->service->save($payloadArray));
    }
}
