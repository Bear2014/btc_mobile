<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Admin\Controller;

class MycztypeController extends AdminController
{
	private $Model;

	public function __construct()
	{
		parent::__construct();
		$this->Model = M('MyczType');
	}

	public function indexa($p = 1, $r = 15)
	{
		$map = array();

		if (empty($order)) {
			$order = 'id_desc';
		}

		$order_arr = explode('_', $order);

		if (count($order_arr) != 2) {
			$order = 'id_desc';
			$order_arr = explode('_', $order);
		}

		$order_set = $order_arr[0] . ' ' . $order_arr[1];

		if (empty($status)) {
			$map['status'] = array('egt', 0);
		}

		if (($status == 1) || ($status == 2) || ($status == 3)) {
			$map['status'] = $status - 1;
		}

		$data = $this->Model->where($map)->order($order_set)->page($p, $r)->select();
		$count = $this->Model->where($map)->count();
		$parameter['p'] = $p;
		$builder = new BuilderList();
		$builder->title('充值类型');
		$builder->titleList('类型列表', U('Mycztype/index'));
		$builder->button('resume', '启 用', U('Mycztype/status', array('model' => 'MyczType', 'status' => 1)));
		$builder->button('forbid', '禁 用', U('Mycztype/status', array('model' => 'MyczType', 'status' => 0)));
		$builder->keyId();
		$builder->keyText('title', '接口名称');
		$builder->keyText('username', '接口账户');
		$builder->keyText('password', '接口KEY');
		$builder->keyText('url', '接口地址');
		$builder->keyImage('img', '接口图片');
		$builder->keyText('remark', '接口备注');
		$builder->keyText('sort', '接口排序');
		$builder->keyStatus('status', '状态', array('禁用', '启用'));
		$builder->keyDoAction('Mycz/queren?id=###', '编辑');
		$builder->data($data);
		$builder->pagination($count, $r, $parameter);
		$builder->display();
	}

	public function index()
	{
		$where = array();
		$count = $this->Model->where($where)->count();
		$Page = new \Think\Page($count, 15);
		$show = $Page->show();
		$list = $this->Model->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();
		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function status()
	{
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
