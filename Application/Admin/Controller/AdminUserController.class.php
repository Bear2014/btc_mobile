<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Admin\Controller;

class AdminUserController extends AdminController
{
	public function index()
	{
		$this->field = '';
		$this->name = '';
		$this->status = '';
		$where = array();
		$parameter = array();
		$rows = 15;
		$input = I('get.');

		if ($input['status']) {
			$this->status = $input['status'];
			$where['status'] = $input['status'];
			$parameter['status'] = $input['status'];
		}

		if ($input['name'] && $input['field']) {
			$this->name = $input['name'];
			$this->field = $input['field'];
			$where[$input['field']] = $input['name'];
			$parameter['name'] = $input['name'];
			$parameter['field'] = $input['field'];
		}

		$count = M('Admin')->where($where)->count();
		$Page = new \Think\Page($count, 15, $parameter);
		$show = $Page->show();
		$list = M('Admin')->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();
		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function add()
	{
		if (IS_POST) {
			if (APP_DEMO) {
				$this->error('测试站暂时不能修改！');
			}

			$input = I('post.');

			if (!check($input['username'], 'username')) {
				$this->error('用户名格式错误！');
			}

			if (!check($input['nickname'], 'A')) {
				$this->error('昵称格式错误！');
			}

			if (!check($input['password'], 'password')) {
				$this->error('登录密码格式错误！');
			}

			if (!check($input['moble'], 'moble')) {
				$this->error('手机号码格式错误！');
			}

			if (!check($input['email'], 'email')) {
				$this->error('邮箱格式错误！');
			}

			$input['status'] = 1;
			$input['addtime'] = time();
			$input['updatetime'] = time();
			$input['password'] = md5($input['password']);

			if (M('Admin')->add($input)) {
				$this->success('添加成功！', U('AdminUser/index'));
			}
			else {
				$this->error('添加失败！');
			}
		}
		else {
			$this->display();
		}
	}

	public function detail()
	{
		if (empty($_GET['id'])) {
			redirect(U('AdminUser/index'));
		}
		else {
			$this->data = M('Admin')->where(array('id' => trim($_GET['id'])))->find();
		}

		$this->display();
	}

	public function edit()
	{
		if (IS_POST) {
			if (APP_DEMO) {
				$this->error('测试站暂时不能修改！');
			}

			$input = I('post.');

			if ($input['password']) {
				$input['password'] = md5($input['password']);
			}
			else {
				unset($input['password']);
			}

			$input['updatetime'] = time();

			if (M('Admin')->save($input)) {
				$this->success('编辑成功！');
			}
			else {
				$this->error('编辑失败！');
			}
		}
		else {
			if (empty($_GET['id'])) {
				$this->data = null;
			}
			else {
				$this->data = M('Admin')->where(array('id' => trim($_GET['id'])))->find();
			}

			$this->display();
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
			if (M('Admin')->where($where)->delete()) {
				$this->success('操作成功！');
			}
			else {
				$this->error('操作失败！');
			}

			break;

		default:
			$this->error('参数非法');
		}

		if (M('Admin')->where($where)->save($data)) {
			$this->success('操作成功！');
		}
		else {
			$this->error('操作失败！');
		}
	}
}

?>
