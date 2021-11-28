<?php
declare(strict_types=1);

namespace App\Service\Constant;

use App\Model\Constant;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use App\Application\Exceptions\DomainRecordNotFoundException;

class ConstantService implements ConstantServiceInterface
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
    public function findOneByName(string $name): object
    {
        return $this->findByPrimaryKeyOrFail($name);
    }

    /**
     * {@inheritdoc}
     */
    public function create(array $data)
    {
        Constant::create($data);
    }

    /**
     * {@inheritdoc}
     */
    public function update(array $data)
    {
        $constant = $this->findByPrimaryKeyOrFail($data['name']);
        $constant->update($data);
    }

    /**
     * {@inheritdoc}
     */
    public function deleteByName(string $name)
    {
        //Constant::destroy($name);
        Constant::where('name', $name)->delete();
    }

    private function findByPrimaryKeyOrFail($id)
    {
        try {
            return Constant::findOrFail($id);
        } catch (ModelNotFoundException $e) {
            throw new DomainRecordNotFoundException();
        }
    }
}
