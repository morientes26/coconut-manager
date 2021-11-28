<?php
declare(strict_types=1);

namespace App\Application\Actions\Constant;

use App\Application\Actions\Action;
use App\Service\Constant\ConstantServiceInterface;
use Psr\Log\LoggerInterface;

abstract class ConstantAction extends Action
{
    /**
     * @var ConstantServiceInterface
     */
    protected $service;

    /**
     * @param LoggerInterface $logger
     * @param ConstantServiceInterface $service
     */
    public function __construct(
        LoggerInterface $logger,
        ConstantServiceInterface $service
    ) {
        parent::__construct($logger);
        $this->service = $service;
    }
}
