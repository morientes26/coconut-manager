<?php
declare(strict_types=1);

namespace App\Domain\Constant;

use App\Model\Constant;
use Illuminate\Database\Eloquent\Collection;

interface ConstantService
{
    /**
     * @return Constant[]
     */
    public function findAll(): Collection;

    /**
     * @param string $name
     * @return Constant
     */
    public function findOneByName(string $name): object;

    /**
     * @param object $constant
     * @return void
     */
    public function create(array $constant);

    /**
     * @param  array $constant
     * @return void
     */
    public function update(array $constant);

    /**
     * @return void
     */
    public function deleteByName(string $name);
}
