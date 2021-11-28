<?php
declare(strict_types=1);

namespace App\Infrastructure\Persistence\Constant;

use App\Model\Constant;
use App\Domain\User\UserNotFoundException;
use App\Domain\Constant\ConstantService;
use Illuminate\Database\Eloquent\Collection;

class ConstantServiceImp implements ConstantService
{
    /**
     * @var Constant[]
     */
    private $constants;

    /**
     * ConstantServiceImp constructor.
     *
     * @param array|null $users
     */
    public function __construct(array $constants = null)
    {

    }

    /**
     * {@inheritdoc}
     */
    public function findAll(): Collection
    {
        return Constant::all();
    }

    /**
     * {@inheritdoc}
     */
    public function findByName(string $name): object
    {
        return Constant::findOrFail($name);
    }

    /**
     * {@inheritdoc}
     */
    public function save(array $data)
    {
        Constant::create($data);
    }

    /**
     * {@inheritdoc}
     */
    public function update(array $data)
    {
        $constant = Constant::findOrFail($data['name'])->update($data);
    }

    /**
     * {@inheritdoc}
     */
    public function deleteByName(string $name)
    {
        //Constant::destroy($name);
        Constant::where('name', $name)->delete();
    }
}
