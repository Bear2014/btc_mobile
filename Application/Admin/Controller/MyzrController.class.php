<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Admin\Controller;

class MyzrController extends AdminController
{
	private $Model;

	public function __construct()
	{
		parent::__construct();
		$this->Model = M('Myzr');
		$this->Title = '虚拟币转入';
	}

	public function index($name = NULL, $coin = NULL)
	{
		if (check($name, 'username')) {
			$userid = M('User')->where(array('username' => trim($name)))->getField('id');

			if (0 < $userid) {
				$where['userid'] = $userid;
			}
		}

		if ($coin) {
			$where['coinname'] = trim($coin);
		}

		$count = $this->Model->where($where)->count();
		$Page = new \Think\Page($count, 15);
		$show = $Page->show();
		$list = $this->Model->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();

		foreach ($list as $k => $v) {
			$list[$k]['usernamea'] = M('User')->where(array('id' => $v['userid']))->getField('username');
		}

		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}
}

?>
