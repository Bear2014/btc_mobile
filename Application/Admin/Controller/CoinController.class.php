<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Admin\Controller;

class CoinController extends AdminController
{
	private $Model;

	public function __construct()
	{
		parent::__construct();
		$this->Model = M('Coin');
		$this->Title = '币种配置';
	}

	public function save()
	{
	}
}

?>
