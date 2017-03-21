<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Admin\Controller;

class IssuelogController extends AdminController
{
	private $Model;

	public function __construct()
	{
		parent::__construct();
		$this->Model = M('IssueLog');
		$this->Title = '认购记录';
	}

	public function index($name = NULL)
	{
		if ($name && check($name, 'username')) {
			$where['userid'] = M('User')->where(array('username' => $name))->getField('id');
		}
		else {
			$where = array();
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
