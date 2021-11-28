<?php
declare(strict_types=1);

namespace App\Application\Actions\Constant;

use Psr\Http\Message\ResponseInterface as Response;
use App\Model\Constant;

class ViewConstantAction extends ConstantAction
{
    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $name = (string) $this->resolveArg('name');
        $this->logger->info("Constant of name=`${name}` was viewed.");
        $constant = $this->service->findOneByName($name);
        return $this->respondWithData($constant);
    }
}
