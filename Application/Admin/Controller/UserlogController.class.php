<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Admin\Controller;

class UserlogController extends AdminController
{
	private $Model;

	public function __construct()
	{
		parent::__construct();
		$this->Model = M('UserLog');
		$this->Title = '用户日志';
	}

	public function index($name = NULL)
	{
		if ($name) {
			$where['userid'] = M('User')->where(array('username' => $name))->getField('id');
		}

		$count = $this->Model->where($where)->count();
		$Page = new \Think\Page($count, 15);
		$show = $Page->show();
		$list = $this->Model->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();

		foreach ($list as $k => $v) {
			$list[$k]['username'] = M('User')->where(array('id' => $v['userid']))->getField('username');
		}

		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}
}

?>
