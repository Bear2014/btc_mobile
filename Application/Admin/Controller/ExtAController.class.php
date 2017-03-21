<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Admin\Controller;

class ExtAController extends AdminController
{
	public function index()
	{
		redirect('/Admin/Cloud/update');
		$this->display();
	}
}

?>
