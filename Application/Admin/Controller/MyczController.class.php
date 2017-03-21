<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Admin\Controller;

class MyczController extends AdminController
{
	public function status($id, $status, $model)
	{
		$builder = new BuilderList();
		$builder->doSetStatus($model, $id, $status);
	}

	public function config($id = NULL)
	{
		if (!empty($_POST)) {
			if (M('Config')->where(array('id' => 1))->save($_POST)) {
				$this->success('操作成功');
			}
			else {
				$this->error('操作失败');
			}
		}
		else {
			$data['mycz_min'] = C('mycz_min');
			$data['mycz_max'] = C('mycz_max');
			$data['mycz_fee'] = C('mycz_fee');
			$data['mycz_fee_max'] = C('mycz_fee_max');
			$data['mycz_fee_coin'] = C('mycz_fee_coin');
			$data['mycz_text_index'] = C('mycz_text_index');
			$data['mycz_invit_coin'] = C('mycz_invit_coin');
			$data['mycz_invit_1'] = C('mycz_invit_1');
			$data['mycz_invit_2'] = C('mycz_invit_2');
			$data['mycz_invit_3'] = C('mycz_invit_3');
			$builder = new BuilderEdit();
			$builder->title('充值配置');
			$builder->keyText('mycz_min', '最小充值金额', '只能填数字，建议填写10');
			$builder->keyText('mycz_max', '最大充值金额', '只能填数字，建议填写50000');
			$builder->keyEditor('mycz_text_index', '充值提示文字', '充值提示说明文字', U('Mycz/images'));
			$builder->savePostUrl(U('Mycz/config'));
			$builder->data($data);
			$builder->display();
		}
	}

	public function type($p = 1, $r = 15)
	{
		$map = array();
		$data = M('MyczType')->where($map)->page($p, $r)->select();
		$count = M('MyczType')->where($map)->count();
		$parameter['p'] = $p;
		$builder = new BuilderList();
		$builder->title('充值方式');
		$builder->titleList('方式列表', U('Mycz/type'));
		$builder->button('resume', '启 用', U('Mycz/status', array('model' => 'MyczType', 'status' => 1)));
		$builder->button('forbid', '禁 用', U('Mycz/status', array('model' => 'MyczType', 'status' => 0)));
		$builder->keyId();
		$builder->keyText('name', '方式标识');
		$builder->keyText('title', '方式名称');
		$builder->keyText('url', '接口地址');
		$builder->keyText('username', '接口名称');
		$builder->keyText('password', '接口密匙');
		$builder->keyText('extra', '接口其他参数');
		$builder->keyTime('addtime', '添加时间');
		$builder->keyTime('endtime', '编辑时间');
		$builder->keyStatus();
		$builder->keyDoAction('Mycz/edit_type?id=###', '编辑', '操作');
		$builder->data($data);
		$builder->pagination($count, $r, $parameter);
		$builder->display();
	}

	public function edit_type($id = NULL)
	{
		if (!empty($_POST)) {
			if (check($_POST['id'], 'd')) {
				$rs = M('ShopCoin')->save($_POST);
			}
			else {
				$this->error('操作失败1');
			}

			if ($rs) {
				$this->success('操作成功');
			}
			else {
				$this->error('操作失败');
			}
		}
		else {
			if (empty($id)) {
				$this->error('操作失败,参数错误');
			}

			$data = M('MyczType')->where(array('id' => $id))->find();
			$builder = new BuilderEdit();
			$builder->title('充值方式');
			$builder->titleList('充值方式', U('Mycz/type'));
			$builder->keyHidden('id', '方式id');
			$builder->keyReadOnly('id', '方式id', '不能修改');
			$builder->keyReadOnly('name', '方式标识', '不能修改');
			$builder->keyText('title', '接口名称', '前台显示');
			$builder->keyText('url', '接口地址', '不要修改');
			$builder->keyText('username', '接口名称', '一般是用户名或者商户号');
			$builder->keyPass('password', '接口密匙', '一般是用户密码或者密匙');
			$builder->keyText('extra', '其他参数', '特殊充值方式需要使用，没有可以不填');
			$builder->keyText('remark', '备注说明', '备用，其他参数可以不填');
			$builder->savePostUrl(U('Mycz/edit_type'));
			$builder->data($data);
			$builder->display();
		}
	}

	public function index($p = 1, $r = 15, $str_addtime = '', $end_addtime = '', $order = '', $status = '', $type = '', $field = '', $name = '')
	{
		$map = array();
		if ($str_addtime && $end_addtime && (strtotime($str_addtime) != '---') && (addtime(strtotime($end_addtime)) != '---')) {
			$map['addtime'] = array(
	array('egt', strtotime($str_addtime)),
	array('elt', strtotime($end_addtime))
	);
		}

		if (empty($order)) {
			$order = 'id_desc';
		}

		if ($order && (count(explode('_', $order)) == 2)) {
			$order_arr = explode('_', $order);
			$order_set = $order_arr[0] . ' ' . $order_arr[1];
		}

		if (0 < $status) {
			$map['status'] = $status - 1;
		}

		if ($type && D('Mycz')->check_type($type)) {
			$map['type'] = $type;
		}

		if ($field && $name) {
			if ($field == 'username') {
				$map['userid'] = D('User')->get_userid($name);
			}
			else {
				$map[$field] = $name;
			}
		}

		$data = M('Mycz')->where($map)->order($order_set)->page($p, $r)->select();

		foreach ($data as $k => $v) {
			$data[$k]['queren'] = $v['status'] ? 1 : 0;
		}

		$count = M('Mycz')->where($map)->count();
		$parameter['p'] = $p;
		$parameter['str_addtime'] = $str_addtime;
		$parameter['end_addtime'] = $end_addtime;
		$parameter['order'] = $order;
		$parameter['status'] = $status;
		$parameter['type'] = $type;
		$parameter['field'] = $field;
		$parameter['name'] = $name;
		$builder = new BuilderList();
		$builder->title('充值管理');
		$builder->titleList('充值列表', U('Mycz/index'));
		$builder->button('delete', '删 除', U('Mycz/status', array('model' => 'Mycz', 'status' => -1)));
		$builder->setSearchPostUrl(U('Mycz/index'));
		$builder->search('str_addtime', 'time', '开始时间');
		$builder->search('end_addtime', 'time', '结束时间');
		$builder->search('order', 'select', array('id_desc' => 'ID降序', 'id_asc' => 'ID升序', 'num_desc' => '金额降序', 'num_asc' => '金额升序', 'userid_desc' => '用户降序', 'userid_asc' => '用户升序'));
		$builder->search('status', 'select', array('全部状态', '等待付款', '自动到账', '人工到账'));
		$mycz_type_list = D('Mycz')->get_type_list();
		$mycz_type_list[0] = '全部';
		$builder->search('type', 'select', $mycz_type_list);
		$builder->search('field', 'select', array('username' => '用户名', 'tradeno' => '订单号'));
		$builder->search('name', 'text', '请输入查询内容');
		$builder->keyId();
		$builder->keyUserid();
		$builder->keyText('num', '充值金额');
		$builder->keyText('fee', '充值赠送');
		$builder->keyText('coin', '赠送币种');
		$builder->keyText('mum', '到账金额');
		$builder->keyType('type', '充值方式', $mycz_type_list);
		$builder->keyText('tradeno', '充值订单');
		$builder->keyTime('addtime', '充值时间');
		$builder->keyTime('endtime', '到账时间');
		$builder->keyStatus('status', '状态', array('等待付款', '自动到账', '人工到账'));
		$builder->keyDoAction('Mycz/queren?id=###', '确认到账|---|queren', '操作');
		$builder->data($data);
		$builder->pagination($count, $r, $parameter);
		$builder->display();
	}

	public function queren()
	{
		$id = $_GET['id'];

		if (empty($id)) {
			$this->error('请选择要操作的数据!');
		}

		$mycz = M('Mycz')->where(array('id' => $id))->find();

		if ($mycz['status'] != 0) {
			$this->error('已经处理，禁止再次操作！');
		}

		$mo = M();
		$mo->execute('set autocommit=0');
		$mo->execute('lock tables movesay_user_coin write,movesay_mycz write,movesay_finance write');
		$rs = array();
		$finance = $mo->table('movesay_finance')->where(array('userid' => $mycz['userid']))->order('id desc')->find();
		$finance_num_user_coin = $mo->table('movesay_user_coin')->where(array('userid' => $mycz['userid']))->find();
		$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => $mycz['userid']))->setInc('cny', $mycz['num']);
		$rs[] = $mo->table('movesay_mycz')->where(array('id' => $mycz['id']))->setField('status', 2);
		$finance_mum_user_coin = $mo->table('movesay_user_coin')->where(array('userid' => $mycz['userid']))->find();
		$finance_hash = md5($mycz['userid'] . $finance_num_user_coin['cny'] . $finance_num_user_coin['cnyd'] . $mycz['num'] . $finance_mum_user_coin['cny'] . $finance_mum_user_coin['cnyd'] . MSCODE . 'auth.movesay.com');
		$finance_num = $finance_num_user_coin['cny'] + $finance_num_user_coin['cnyd'];

		if ($finance['mum'] < $finance_num) {
			$finance_status = (1 < ($finance_num - $finance['mum']) ? 0 : 1);
		}
		else {
			$finance_status = (1 < ($finance['mum'] - $finance_num) ? 0 : 1);
		}

		$rs[] = $mo->table('movesay_finance')->add(array('userid' => $mycz['userid'], 'coinname' => 'cny', 'num_a' => $finance_num_user_coin['cny'], 'num_b' => $finance_num_user_coin['cnyd'], 'num' => $finance_num_user_coin['cny'] + $finance_num_user_coin['cnyd'], 'fee' => $mycz['num'], 'type' => 1, 'name' => 'mycz', 'nameid' => $mycz['id'], 'remark' => '人民币充值-人工到账', 'mum_a' => $finance_mum_user_coin['cny'], 'mum_b' => $finance_mum_user_coin['cnyd'], 'mum' => $finance_mum_user_coin['cny'] + $finance_mum_user_coin['cnyd'], 'move' => $finance_hash, 'addtime' => time(), 'status' => $finance_status));

		if (check_arr($rs)) {
			$mo->execute('commit');
			$mo->execute('unlock tables');
			$this->success('操作成功！');
		}
		else {
			$mo->execute('rollback');
			$this->error('操作失败！');
		}
	}

	public function invit($p = 1, $r = 15, $str_addtime = '', $end_addtime = '', $order = '', $status = '', $type = '', $field = '', $name = '')
	{
		$map = array();
		if ($str_addtime && $end_addtime && (strtotime($str_addtime) != '---') && (addtime(strtotime($end_addtime)) != '---')) {
			$map['addtime'] = array(
	array('egt', strtotime($str_addtime)),
	array('elt', strtotime($end_addtime))
	);
		}

		if ($order && (count(explode('_', $order)) == 2)) {
			$order_arr = explode('_', $order);
			$order_set = $order_arr[0] . ' ' . $order_arr[1];
		}

		if (0 < $status) {
			$map['status'] = $status - 1;
		}
		else {
			$map['status'] = array('egt', 0);
		}

		if ($type && M('Mycz')->check_type($type)) {
			$map['type'] = $type;
		}

		if ($field && $name) {
			if ($field == 'username') {
				$map['userid'] = D('User')->get_userid($name);
			}
			else if ($field == 'inuvtname') {
				$map['invitid'] = D('User')->get_userid($name);
			}
			else {
				$map[$field] = $name;
			}
		}

		$data = M('MyczInvit')->where($map)->order($order_set)->page($p, $r)->select();

		foreach ($data as $k => $v) {
			$data[$k]['queren'] = $v['status'] ? 1 : 0;
		}

		$count = M('MyczInvit')->where($map)->count();
		$parameter['p'] = $p;
		$parameter['str_addtime'] = $str_addtime;
		$parameter['end_addtime'] = $end_addtime;
		$parameter['order'] = $order;
		$parameter['status'] = $status;
		$parameter['type'] = $type;
		$parameter['field'] = $field;
		$parameter['name'] = $name;
		$builder = new BuilderList();
		$builder->title('充值赠送');
		$builder->titleList('赠送列表', U('Mycz/invit'));
		$builder->setSearchPostUrl(U('Mycz/invit'));
		$builder->search('str_addtime', 'time', '开始时间');
		$builder->search('end_addtime', 'time', '结束时间');
		$builder->search('order', 'select', array('id_desc' => 'ID降序', 'id_asc' => 'ID升序', 'num_desc' => '金额降序', 'num_asc' => '金额升序', 'userid_desc' => '用户降序', 'userid_asc' => '用户升序'));
		$builder->search('field', 'select', array('username' => '用户名', 'inuvtname' => '推荐人'));
		$builder->search('name', 'text', '请输入查询内容');
		$builder->keyId();
		$builder->keyUserid();
		$builder->keyInvitid();
		$builder->keyText('num', '充值金额');
		$builder->keyText('fee', '赠送金额');
		$builder->keyText('coinname', '赠送币种');
		$builder->keyText('mum', '到账金额');
		$builder->keyText('remark', '赠送备注');
		$builder->keyTime('addtime', '充值时间');
		$builder->keyTime('endtime', '到账时间');
		$builder->data($data);
		$builder->pagination($count, $r, $parameter);
		$builder->display();
	}

	public function images()
	{
		$baseUrl = str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME']));
		$upload = new Upload();
		$upload->maxSize = 3145728;
		$upload->exts = array('jpg', 'gif', 'png', 'jpeg');
		$upload->rootPath = UPLOAD_PATH . 'mycz/';
		$upload->autoSub = false;
		$info = $upload->upload();

		if ($info) {
			if (!is_array($info['imgFile'])) {
				$info['imgFile'] = $info['file'];
			}

			$data = array('url' => str_replace('./', '/', $upload->rootPath) . $info['imgFile']['savename'], 'error' => 0);
			exit(json_encode($data));
		}
		else {
			$error['error'] = 1;
			$error['message'] = $upload->getError();
			exit(json_encode($error));
		}
	}
}

?>
