<?php
declare(strict_types=1);

namespace App\Application\Actions\Constant;

use Psr\Http\Message\ResponseInterface as Response;
use App\Model\Constant;

class DeleteConstantAction extends ConstantAction
{
    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $name = (string) $this->resolveArg('name');
        $this->logger->info("DeleteConstantAction");
        return $this->respondWithData($this->service->deleteByName($name));
    }
}
