<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Admin\Controller;

class AdverController extends AdminController
{
	private $Model;

	public function __construct()
	{
		parent::__construct();
		$this->Model = M('Adver');
		$this->Title = '幻灯片';
		check_server();
	}

	public function index($name = NULL)
	{
		if ($name) {
			$where['name'] = array('like', '%' . $name . '%');
		}

		$count = $this->Model->where($where)->count();
		$Page = new \Think\Page($count, 15);
		$show = $Page->show();
		$list = $this->Model->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();
		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function edit($id = NULL)
	{
		if ($id) {
			$this->data = $this->Model->where(array('id' => trim($id)))->find();
		}
		else {
			$this->data = null;
		}

		$this->display();
	}

	public function save()
	{
		if (APP_DEMO) {
			$this->error('测试站暂时不能修改！');
		}

		$upload = new \Think\Upload();
		$upload->maxSize = 3145728;
		$upload->exts = array('jpg', 'gif', 'png', 'jpeg');
		$upload->rootPath = './Upload/ad/';
		$upload->autoSub = false;
		$info = $upload->upload();

		if ($info) {
			foreach ($info as $k => $v) {
				$_POST[$v['key']] = $v['savename'];
			}
		}

		if ($_POST['id']) {
			$rs = $this->Model->save($_POST);
		}
		else {
			$_POST['adminid'] = session('admin_id');
			$rs = $this->Model->add($_POST);
		}

		if ($rs) {
			$this->success('编辑成功！');
		}
		else {
			$this->error('编辑失败！');
		}
	}

	public function status()
	{
		if (APP_DEMO) {
			$this->error('测试站暂时不能修改！');
		}

		if (IS_POST) {
			$id = array();
			$id = implode(',', $_POST['id']);
		}
		else {
			$id = $_GET['id'];
		}

		if (empty($id)) {
			$this->error('请选择要操作的数据!');
		}

		$where['id'] = array('in', $id);
		$method = $_GET['method'];

		switch (strtolower($method)) {
		case 'forbid':
			$data = array('status' => 0);
			break;

		case 'resume':
			$data = array('status' => 1);
			break;

		case 'delete':
			if ($this->Model->where($where)->delete()) {
				$this->success('操作成功！');
			}
			else {
				$this->error('操作失败！');
			}

			break;

		default:
			$this->error('参数非法');
		}

		if ($this->Model->where($where)->save($data)) {
			$this->success('操作成功！');
		}
		else {
			$this->error('操作失败！');
		}
	}
}

?>
