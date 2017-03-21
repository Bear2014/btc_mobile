<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Admin\Controller;

class UsercoinController extends AdminController
{
	private $Model;

	public function __construct()
	{
		parent::__construct();
		$this->Model = M('UserCoin');
		$this->Title = '用户财产';
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

	public function edit($id = NULL)
	{
		if (empty($id)) {
			$this->data = null;
		}
		else {
			$this->data = $this->Model->where(array('id' => trim($id)))->find();
		}

		$this->display();
	}

	public function save()
	{
		if (APP_DEMO) {
			$this->error('测试站暂时不能修改！');
		}

		if ($this->Model->save($_POST)) {
			$this->success('编辑成功！');
		}
		else {
			$this->error('编辑失败！');
		}
	}

	public function xiangxi($userid = NULL, $coinname = NULL)
	{
		$data['userid'] = $userid;
		$data['username'] = M('User')->where(array('id' => $userid))->getField('username');
		$data['coinname'] = $coinname;
		$data['zhengcheng'] = M('UserCoin')->where(array('userid' => $userid))->getField($coinname);
		$data['dongjie'] = M('UserCoin')->where(array('userid' => $userid))->getField($coinname . 'd');
		$data['zongji'] = $data['zhengcheng'] + $data['dongjie'];
		$data['chongzhicny'] = M('Mycz')->where(array(
	'userid' => $userid,
	'status' => array('neq', '0')
	))->sum('num');
		$data['tixiancny'] = M('Mytx')->where(array('userid' => $userid, 'status' => 1))->sum('num');
		$data['tixiancnyd'] = M('Mytx')->where(array('userid' => $userid, 'status' => 0))->sum('num');

		if ($coinname != 'cny') {
			$data['chongzhi'] = M('Myzr')->where(array(
	'userid' => $userid,
	'status' => array('neq', '0')
	))->sum('num');
			$data['tixian'] = M('Myzc')->where(array('userid' => $userid, 'status' => 1))->sum('num');
		}

		$this->assign('data', $data);
		$this->display();
	}
}

?>
