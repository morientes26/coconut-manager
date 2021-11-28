<?php
declare(strict_types=1);

namespace App\Application\Actions\Constant;

use App\Application\Actions\Action;
use App\Domain\Constant\ConstantService;
use Psr\Log\LoggerInterface;

abstract class ConstantAction extends Action
{
    /**
     * @var ConstantService
     */
    protected $service;

    /**
     * @param LoggerInterface $logger
     * @param ConstantService $constantService
     */
    public function __construct(
        LoggerInterface $logger,
        ConstantService $service
    ) {
        parent::__construct($logger);
        $this->service = $service;
    }
}
