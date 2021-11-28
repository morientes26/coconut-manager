<?php
declare(strict_types=1);

namespace Tests\Service\Constant;

use App\Model\Constant;
use App\Service\Constant\ConstantServiceImp;
use Tests\TestCase;

class ConstantServiceImpTest extends TestCase
{
    private $constants;
    private $service;

    protected function setUp() : void
    {
        $this->service = new ConstantServiceImp();
        $this->constants = array(
            0 => new Constant(['name'=>'aaa', 'val'=>'123']),
            1 => new Constant(['name'=>'ccc', 'val'=>'456']),
        );
        foreach ($this->constants as $constant) {
            $constant->save();
        }
    }

    protected function tearDown() : void
    {
        Constant::truncate();
    }

    public function testFindAll()
    {
        $result = $this->service->findAll();

        $this->assertTrue($result->contains('aaa'));
        $this->assertTrue($result->contains('ccc'));
    }

    public function testFindByName()
    {
        $this->assertEquals('aaa', $this->service->findOneByName('aaa')->name);
    }

    public function testCreate()
    {
        $this->service->create(['name'=>'xxx', 'val'=>'876']);

        $this->assertEquals('876', Constant::find('xxx')->val);
    }

    public function testUpdate()
    {
        $this->service->update(['name'=>'aaa', 'val'=>'999']);
        $constantFromDb = Constant::find('aaa');

        $this->assertEquals('999', $constantFromDb->val);
    }

    public function testDelete()
    {
        $constantFromDb = Constant::find('aaa');
        $this->assertNotNull($constantFromDb);

        $this->service->deleteByName('aaa');
        $constantFromDb = Constant::find('aaa');
        $this->assertNull($constantFromDb);
    }
}
