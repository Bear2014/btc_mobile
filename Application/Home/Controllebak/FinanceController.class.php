<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Home\Controller;

class FinanceController extends HomeController
{
	public function index()
	{
		if (!userid()) {
			redirect('/#login');
		}

		$CoinList = M('Coin')->where(array('status' => 1))->select();
		$UserCoin = M('UserCoin')->where(array('userid' => userid()))->find();
		$Market = M('Market')->where(array('status' => 1))->select();

		foreach ($Market as $k => $v) {
			$Market[$v['name']] = $v;
		}

		$cny['zj'] = 0;

		foreach ($CoinList as $k => $v) {
			if ($v['name'] == 'cny') {
				$cny['ky'] = round($UserCoin[$v['name']], 2) * 1;
				$cny['dj'] = round($UserCoin[$v['name'] . 'd'], 2) * 1;
				$cny['zj'] = $cny['zj'] + $cny['ky'] + $cny['dj'];
			}
			else {
				if ($Market[$v['name'] . '_cny']['new_price']) {
					$jia = $Market[$v['name'] . '_cny']['new_price'];
				}
				else {
					$jia = 1;
				}

				$coinList[$v['name']] = array('name' => $v['name'], 'img' => $v['img'], 'title' => $v['title'] . '(' . strtoupper($v['name']) . ')', 'xnb' => round($UserCoin[$v['name']], 6) * 1, 'xnbd' => round($UserCoin[$v['name'] . 'd'], 6) * 1, 'xnbz' => round($UserCoin[$v['name']] + $UserCoin[$v['name'] . 'd'], 6), 'jia' => $jia * 1, 'zhehe' => round(($UserCoin[$v['name']] + $UserCoin[$v['name'] . 'd']) * $jia, 2));
				$cny['zj'] = round($cny['zj'] + (($UserCoin[$v['name']] + $UserCoin[$v['name'] . 'd']) * $jia), 2) * 1;
			}
		}

		$this->assign('cny', $cny);
		$this->assign('coinList', $coinList);
		$this->assign('prompt_text', D('Text')->get_content('finance_index'));
		$this->display();
	}

	public function mycz($status = NULL)
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('finance_mycz'));
		$myczType = M('MyczType')->where(array('status' => 1))->select();

		foreach ($myczType as $k => $v) {
			$myczTypeList[$v['name']] = $v['title'];
		}

		$this->assign('myczTypeList', $myczTypeList);
		$user_coin = M('UserCoin')->where(array('userid' => userid()))->find();
		$user_coin['cny'] = round($user_coin['cny'], 2);
		$user_coin['cnyd'] = round($user_coin['cnyd'], 2);
		$this->assign('user_coin', $user_coin);
		if (($status == 1) || ($status == 2) || ($status == 3) || ($status == 4)) {
			$where['status'] = $status - 1;
		}

		$this->assign('status', $status);
		$where['userid'] = userid();
		$count = M('Mycz')->where($where)->count();
		$Page = new \Home\Common\Ext\PageExt($count, 15);
		$show = $Page->show();
		$list = M('Mycz')->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();

		foreach ($list as $k => $v) {
			$list[$k]['type'] = M('MyczType')->where(array('name' => $v['type']))->getField('title');
			$list[$k]['num'] = Num($v['num']) ? Num($v['num']) : '';
			$list[$k]['mum'] = Num($v['mum']) ? Num($v['mum']) : '';
		}

		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function myczHuikuan($id = NULL)
	{
		if (!userid()) {
			$this->error('请先登录！');
		}

		if (!check($id, 'd')) {
			$this->error('参数错误！');
		}

		$mycz = M('Mycz')->where(array('id' => $id))->find();

		if (!$mycz) {
			$this->error('充值订单不存在！');
		}

		if ($mycz['userid'] != userid()) {
			$this->error('非法操作！');
		}

		if ($mycz['status'] != 0) {
			$this->error('订单已经处理过！');
		}

		$rs = M('Mycz')->where(array('id' => $id))->save(array('status' => 3));

		if ($rs) {
			$this->success('操作成功');
		}
		else {
			$this->error('操作失败！');
		}
	}

	public function myczChakan($id = NULL)
	{
		if (!userid()) {
			$this->error('请先登录！');
		}

		if (!check($id, 'd')) {
			$this->error('参数错误！');
		}

		$mycz = M('Mycz')->where(array('id' => $id))->find();

		if (!$mycz) {
			$this->error('充值订单不存在！');
		}

		if ($mycz['userid'] != userid()) {
			$this->error('非法操作！');
		}

		if ($mycz['status'] != 0) {
			$this->error('订单已经处理过！');
		}

		$rs = M('Mycz')->where(array('id' => $id))->save(array('status' => 3));

		if ($rs) {
			$this->success('', array('id' => $id));
		}
		else {
			$this->error('操作失败！');
		}
	}

	public function myczUp($type, $num)
	{
		if (!userid()) {
			$this->error('请先登录！');
		}

		if (!check($type, 'n')) {
			$this->error('充值方式格式错误！');
		}

		if (!check($num, 'cny')) {
			$this->error('充值金额格式错误！');
		}

		$myczType = M('MyczType')->where(array('name' => $type))->find();

		if (!$myczType) {
			$this->error('充值方式不存在！');
		}

		if ($myczType['status'] != 1) {
			$this->error('充值方式没有开通！');
		}

		$mycz_min = ($myczType['min'] ? $myczType['min'] : 1);
		$mycz_max = ($myczType['max'] ? $myczType['max'] : 100000);

		if ($num < $mycz_min) {
			$this->error('充值金额不能小于' . $mycz_min . '元！');
		}

		if ($mycz_max < $num) {
			$this->error('充值金额不能大于' . $mycz_max . '元！');
		}

		for (; ; ) {
			$tradeno = tradeno();

			if (!M('Mycz')->where(array('tradeno' => $tradeno))->find()) {
				break;
			}
		}

		$mycz = M('Mycz')->add(array('userid' => userid(), 'num' => $num, 'type' => $type, 'tradeno' => $tradeno, 'addtime' => time(), 'status' => 0));

		if ($mycz) {
			$this->success('充值订单创建成功！', array('id' => $mycz));
		}
		else {
			$this->error('提现订单创建失败！');
		}
	}

	public function mytx($status = NULL)
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('finance_mytx'));
		$moble = M('User')->where(array('id' => userid()))->getField('moble');

		if ($moble) {
			$moble = substr_replace($moble, '****', 3, 4);
		}
		else {
			$this->error('请先认证手机！');
		}

		$this->assign('moble', $moble);
		$user_coin = M('UserCoin')->where(array('userid' => userid()))->find();
		$user_coin['cny'] = round($user_coin['cny'], 2);
		$user_coin['cnyd'] = round($user_coin['cnyd'], 2);
		$this->assign('user_coin', $user_coin);
		$userBankList = M('UserBank')->where(array('userid' => userid(), 'status' => 1))->order('id desc')->select();
		$this->assign('userBankList', $userBankList);
		if (($status == 1) || ($status == 2) || ($status == 3) || ($status == 4)) {
			$where['status'] = $status - 1;
		}

		$this->assign('status', $status);
		$where['userid'] = userid();
		$count = M('Mytx')->where($where)->count();
		$Page = new \Home\Common\Ext\PageExt($count, 15);
		$show = $Page->show();
		$list = M('Mytx')->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();

		foreach ($list as $k => $v) {
			$list[$k]['num'] = Num($v['num']) ? Num($v['num']) : '';
			$list[$k]['fee'] = Num($v['fee']) ? Num($v['fee']) : '';
			$list[$k]['mum'] = Num($v['mum']) ? Num($v['mum']) : '';
		}

		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function mytxUp($moble_verify, $num, $paypassword, $type)
	{
		if (!userid()) {
			$this->error('请先登录！');
		}

		if (!check($moble_verify, 'd')) {
			$this->error('短信验证码格式错误！');
		}

		if (!check($num, 'd')) {
			$this->error('提现金额格式错误！');
		}

		if (!check($paypassword, 'password')) {
			$this->error('交易密码格式错误！');
		}

		if (!check($type, 'd')) {
			$this->error('提现方式格式错误！');
		}

		if ($moble_verify != session('mytx_verify')) {
			$this->error('短信验证码错误！');
		}

		$userCoin = M('UserCoin')->where(array('userid' => userid()))->find();

		if ($userCoin['cny'] < $num) {
			$this->error('可用人民币余额不足！');
		}

		$user = M('User')->where(array('id' => userid()))->find();

		if (md5($paypassword) != $user['paypassword']) {
			$this->error('交易密码错误！');
		}

		$userBank = M('UserBank')->where(array('id' => $type))->find();

		if (!$userBank) {
			$this->error('提现地址错误！');
		}

		$mytx_min = (C('mytx_min') ? C('mytx_min') : 1);
		$mytx_max = (C('mytx_max') ? C('mytx_max') : 1000000);
		$mytx_bei = C('mytx_bei');
		$mytx_fee = C('mytx_fee');

		if ($num < $mytx_min) {
			$this->error('每次提现金额不能小于' . $mytx_min . '元！');
		}

		if ($mytx_max < $num) {
			$this->error('每次提现金额不能大于' . $mytx_max . '元！');
		}

		if ($mytx_bei) {
			if (($num % $mytx_bei) != 0) {
				$this->error('每次提现金额必须是' . $mytx_bei . '的整倍数！');
			}
		}

		$fee = round(($num / 100) * $mytx_fee, 2);
		$mum = round(($num / 100) * (100 - $mytx_fee), 2);
		$mo = M();
		$mo->execute('set autocommit=0');
		$mo->execute('lock tables movesay_mytx write , movesay_user_coin write ,movesay_finance write');
		$rs = array();
		$finance = $mo->table('movesay_finance')->where(array('userid' => userid()))->order('id desc')->find();
		$finance_num_user_coin = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->find();
		$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->setDec('cny', $num);
		$rs[] = $finance_nameid = $mo->table('movesay_mytx')->add(array('userid' => userid(), 'num' => $num, 'fee' => $fee, 'mum' => $mum, 'name' => $userBank['name'], 'truename' => $user['truename'], 'bank' => $userBank['bank'], 'bankprov' => $userBank['bankprov'], 'bankcity' => $userBank['bankcity'], 'bankaddr' => $userBank['bankaddr'], 'bankcard' => $userBank['bankcard'], 'addtime' => time(), 'status' => 0));
		$finance_mum_user_coin = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->find();
		$finance_hash = md5(userid() . $finance_num_user_coin['cny'] . $finance_num_user_coin['cnyd'] . $mum . $finance_mum_user_coin['cny'] . $finance_mum_user_coin['cnyd'] . MSCODE . 'auth.movesay.com');
		$finance_num = $finance_num_user_coin['cny'] + $finance_num_user_coin['cnyd'];

		if ($finance['mum'] < $finance_num) {
			$finance_status = (1 < ($finance_num - $finance['mum']) ? 0 : 1);
		}
		else {
			$finance_status = (1 < ($finance['mum'] - $finance_num) ? 0 : 1);
		}

		$rs[] = $mo->table('movesay_finance')->add(array('userid' => userid(), 'coinname' => 'cny', 'num_a' => $finance_num_user_coin['cny'], 'num_b' => $finance_num_user_coin['cnyd'], 'num' => $finance_num_user_coin['cny'] + $finance_num_user_coin['cnyd'], 'fee' => $num, 'type' => 2, 'name' => 'mytx', 'nameid' => $finance_nameid, 'remark' => '人民币提现-申请提现', 'mum_a' => $finance_mum_user_coin['cny'], 'mum_b' => $finance_mum_user_coin['cnyd'], 'mum' => $finance_mum_user_coin['cny'] + $finance_mum_user_coin['cnyd'], 'move' => $finance_hash, 'addtime' => time(), 'status' => $finance_status));

		if (check_arr($rs)) {
			session('mytx_verify', null);
			$mo->execute('commit');
			$mo->execute('unlock tables');
			$this->success('提现订单创建成功！');
		}
		else {
			$mo->execute('rollback');
			$this->error('提现订单创建失败！');
		}
	}

	public function mytxChexiao($id)
	{
		if (!userid()) {
			$this->error('请先登录！');
		}

		if (!check($id, 'd')) {
			$this->error('参数错误！');
		}

		$mytx = M('Mytx')->where(array('id' => $id))->find();

		if (!$mytx) {
			$this->error('提现订单不存在！');
		}

		if ($mytx['userid'] != userid()) {
			$this->error('非法操作！');
		}

		if ($mytx['status'] != 0) {
			$this->error('订单不能撤销！');
		}

		$mo = M();
		$mo->execute('set autocommit=0');
		$mo->execute('lock tables movesay_user_coin write,movesay_mytx write,movesay_finance write');
		$rs = array();
		$finance = $mo->table('movesay_finance')->where(array('userid' => $mytx['userid']))->order('id desc')->find();
		$finance_num_user_coin = $mo->table('movesay_user_coin')->where(array('userid' => $mytx['userid']))->find();
		$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => $mytx['userid']))->setInc('cny', $mytx['num']);
		$rs[] = $mo->table('movesay_mytx')->where(array('id' => $mytx['id']))->setField('status', 2);
		$finance_mum_user_coin = $mo->table('movesay_user_coin')->where(array('userid' => $mytx['userid']))->find();
		$finance_hash = md5($mytx['userid'] . $finance_num_user_coin['cny'] . $finance_num_user_coin['cnyd'] . $mytx['num'] . $finance_mum_user_coin['cny'] . $finance_mum_user_coin['cnyd'] . MSCODE . 'auth.movesay.com');
		$finance_num = $finance_num_user_coin['cny'] + $finance_num_user_coin['cnyd'];

		if ($finance['mum'] < $finance_num) {
			$finance_status = (1 < ($finance_num - $finance['mum']) ? 0 : 1);
		}
		else {
			$finance_status = (1 < ($finance['mum'] - $finance_num) ? 0 : 1);
		}

		$rs[] = $mo->table('movesay_finance')->add(array('userid' => $mytx['userid'], 'coinname' => 'cny', 'num_a' => $finance_num_user_coin['cny'], 'num_b' => $finance_num_user_coin['cnyd'], 'num' => $finance_num_user_coin['cny'] + $finance_num_user_coin['cnyd'], 'fee' => $mytx['num'], 'type' => 1, 'name' => 'mytx', 'nameid' => $mytx['id'], 'remark' => '人民币提现-撤销提现', 'mum_a' => $finance_mum_user_coin['cny'], 'mum_b' => $finance_mum_user_coin['cnyd'], 'mum' => $finance_mum_user_coin['cny'] + $finance_mum_user_coin['cnyd'], 'move' => $finance_hash, 'addtime' => time(), 'status' => $finance_status));

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

	public function myzr($coin = NULL)
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('finance_myzr'));

		if (C('coin')[$coin]) {
			$coin = trim($coin);
		}
		else {
			$coin = C('xnb_mr');
		}

		$this->assign('xnb', $coin);
		$Coin = M('Coin')->where(array(
	'status' => 1,
	'name'   => array('neq', 'cny')
	))->select();

		foreach ($Coin as $k => $v) {
			$coin_list[$v['name']] = $v;
		}

		$this->assign('coin_list', $coin_list);
		$user_coin = M('UserCoin')->where(array('userid' => userid()))->find();
		$user_coin[$coin] = round($user_coin[$coin], 6);
		$this->assign('user_coin', $user_coin);
		$Coin = M('Coin')->where(array('name' => $coin))->find();
		$this->assign('zr_jz', $Coin['zr_jz']);

		if (!$Coin['zr_jz']) {
			$qianbao = '当前币种禁止转入！';
		}
		else {
			$qbdz = $coin . 'b';

			if (!$user_coin[$qbdz]) {
				if ($Coin['type'] == 'rgb') {
					$qianbao = md5(username() . $coin);
					$rs = M('UserCoin')->where(array('userid' => userid()))->save(array($qbdz => $qianbao));

					if (!$rs) {
						$this->error('生成钱包地址出错！');
					}
				}

				if ($Coin['type'] == 'qbb') {
					$dj_username = $Coin['dj_yh'];
					$dj_password = $Coin['dj_mm'];
					$dj_address = $Coin['dj_zj'];
					$dj_port = $Coin['dj_dk'];
					$CoinClient = CoinClient($dj_username, $dj_password, $dj_address, $dj_port, 5, array(), 1);
					$json = $CoinClient->getinfo();
					if (!isset($json['version']) || !$json['version']) {
						$this->error('钱包链接失败！');
					}

					$qianbao_addr = $CoinClient->getaddressesbyaccount(username());

					if (!is_array($qianbao_addr)) {
						$qianbao_ad = $CoinClient->getnewaddress(username());

						if (!$qianbao_ad) {
							$this->error('生成钱包地址出错1！');
						}
						else {
							$qianbao = $qianbao_ad;
						}
					}
					else {
						$qianbao = $qianbao_addr[0];
					}

					if (!$qianbao) {
						$this->error('生成钱包地址出错2！');
					}

					$rs = M('UserCoin')->where(array('userid' => userid()))->save(array($qbdz => $qianbao));

					if (!$rs) {
						$this->error('钱包地址添加出错3！');
					}
				}
			}
			else {
				$qianbao = $user_coin[$coin . 'b'];
			}
		}

		$this->assign('qianbao', $qianbao);
		$where['userid'] = userid();
		$where['coinname'] = $coin;
		$Moble = M('Myzr');
		$count = $Moble->where($where)->count();
		$Page = new \Home\Common\Ext\PageExt($count, 10);
		$show = $Page->show();
		$list = $Moble->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();
		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function myzc($coin = NULL)
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('finance_myzc'));

		if (C('coin')[$coin]) {
			$coin = trim($coin);
		}
		else {
			$coin = C('xnb_mr');
		}

		$this->assign('xnb', $coin);
		$Coin = M('Coin')->where(array(
	'status' => 1,
	'name'   => array('neq', 'cny')
	))->select();

		foreach ($Coin as $k => $v) {
			$coin_list[$v['name']] = $v;
		}

		$this->assign('coin_list', $coin_list);
		$user_coin = M('UserCoin')->where(array('userid' => userid()))->find();
		$user_coin[$coin] = round($user_coin[$coin], 6);
		$this->assign('user_coin', $user_coin);

		if (!$coin_list[$coin]['zc_jz']) {
			$this->assign('zc_jz', '当前币种禁止转出！');
		}
		else {
			$userQianbaoList = M('UserQianbao')->where(array('userid' => userid(), 'status' => 1, 'coinname' => $coin))->order('id desc')->select();
			$this->assign('userQianbaoList', $userQianbaoList);
			$moble = M('User')->where(array('id' => userid()))->getField('moble');

			if ($moble) {
				$moble = substr_replace($moble, '****', 3, 4);
			}
			else {
				redirect(U('Home/User/moble'));
				exit();
			}

			$this->assign('moble', $moble);
		}

		$where['userid'] = userid();
		$where['coinname'] = $coin;
		$Moble = M('Myzc');
		$count = $Moble->where($where)->count();
		$Page = new \Home\Common\Ext\PageExt($count, 10);
		$show = $Page->show();
		$list = $Moble->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();
		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function upmyzc($coin, $num, $addr, $paypassword, $moble_verify)
	{
		if (!userid()) {
			$this->error('您没有登录请先登录！');
		}

		if (!check($moble_verify, 'd')) {
			$this->error('短信验证码格式错误！');
		}

		if ($moble_verify != session('myzc_verify')) {
			$this->error('短信验证码错误！');
		}

		$num = abs($num);

		if (!check($num, 'currency')) {
			$this->error('数量格式错误！');
		}

		if (!check($addr, 'dw')) {
			$this->error('钱包地址格式错误！');
		}

		if (!check($paypassword, 'password')) {
			$this->error('交易密码格式错误！');
		}

		if (!check($coin, 'n')) {
			$this->error('币种格式错误！');
		}

		if (!C('coin')[$coin]) {
			$this->error('币种错误！');
		}

		$Coin = M('Coin')->where(array('name' => $coin))->find();

		if (!$Coin) {
			$this->error('币种错误！');
		}

		$myzc_min = ($Coin['zc_min'] ? abs($Coin['zc_min']) : 0.0001);
		$myzc_max = ($Coin['zc_max'] ? abs($Coin['zc_max']) : 10000000);

		if ($num < $myzc_min) {
			$this->error('转出数量超过系统最小限制！');
		}

		if ($myzc_max < $num) {
			$this->error('转出数量超过系统最大限制！');
		}

		$user = M('User')->where(array('id' => userid()))->find();

		if (md5($paypassword) != $user['paypassword']) {
			$this->error('交易密码错误！');
		}

		$user_coin = M('UserCoin')->where(array('userid' => userid()))->find();

		if ($user_coin[$coin] < $num) {
			$this->error('可用余额不足');
		}

		$qbdz = $coin . 'b';
		$fee_user = M('UserCoin')->where(array($qbdz => $Coin['zc_user']))->find();

		if ($fee_user) {
			debug('手续费地址: ' . $Coin['zc_user'] . ' 存在,有手续费');
			$fee = round(($num / 100) * $Coin['zc_fee'], 8);
			$mum = round($num - $fee, 8);

			if ($mum < 0) {
				$this->error('转出手续费错误！');
			}

			if ($fee < 0) {
				$this->error('转出手续费设置错误！');
			}
		}
		else {
			debug('手续费地址: ' . $Coin['zc_user'] . ' 不存在,无手续费');
			$fee = 0;
			$mum = $num;
		}

		if ($Coin['type'] == 'rgb') {
			debug($Coin, '开始认购币转出');
			$peer = M('UserCoin')->where(array($qbdz => $addr))->find();

			if (!$peer) {
				$this->error('转出认购币地址不存在！');
			}

			$mo = M();
			$mo->execute('set autocommit=0');
			$mo->execute('lock tables  movesay_user_coin write  , movesay_myzc write  , movesay_myzr write , movesay_myzc_fee write');
			$rs = array();
			$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->setDec($coin, $num);
			$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => $peer['userid']))->setInc($coin, $mum);

			if ($fee) {
				if ($mo->table('movesay_user_coin')->where(array($qbdz => $Coin['zc_user']))->find()) {
					$rs[] = $mo->table('movesay_user_coin')->where(array($qbdz => $Coin['zc_user']))->setInc($coin, $fee);
					debug(array('msg' => '转出收取手续费' . $fee), 'fee');
				}
				else {
					$rs[] = $mo->table('movesay_user_coin')->add(array($qbdz => $Coin['zc_user'], $coin => $fee));
					debug(array('msg' => '转出收取手续费' . $fee), 'fee');
				}
			}

			$rs[] = $mo->table('movesay_myzc')->add(array('userid' => userid(), 'username' => $addr, 'coinname' => $coin, 'txid' => md5($addr . $user_coin[$coin . 'b'] . time()), 'num' => $num, 'fee' => $fee, 'mum' => $mum, 'addtime' => time(), 'status' => 1));
			$rs[] = $mo->table('movesay_myzr')->add(array('userid' => $peer['userid'], 'username' => $user_coin[$coin . 'b'], 'coinname' => $coin, 'txid' => md5($user_coin[$coin . 'b'] . $addr . time()), 'num' => $num, 'fee' => $fee, 'mum' => $mum, 'addtime' => time(), 'status' => 1));

			if ($fee_user) {
				$rs[] = $mo->table('movesay_myzc_fee')->add(array('userid' => $fee_user['userid'], 'username' => $Coin['zc_user'], 'coinname' => $coin, 'txid' => md5($user_coin[$coin . 'b'] . $Coin['zc_user'] . time()), 'num' => $num, 'fee' => $fee, 'type' => 1, 'mum' => $mum, 'addtime' => time(), 'status' => 1));
			}

			if (check_arr($rs)) {
				$mo->execute('commit');
				$mo->execute('unlock tables');
				session('myzc_verify', null);
				$this->success('转账成功！');
			}
			else {
				$mo->execute('rollback');
				$this->error('转账失败!');
			}
		}

		if ($Coin['type'] == 'qbb') {
			$mo = M();

			if ($mo->table('movesay_user_coin')->where(array($qbdz => $addr))->find()) {
				$peer = M('UserCoin')->where(array($qbdz => $addr))->find();

				if (!$peer) {
					$this->error('转出地址不存在！');
				}

				$mo = M();
				$mo->execute('set autocommit=0');
				$mo->execute('lock tables  movesay_user_coin write  , movesay_myzc write  , movesay_myzr write , movesay_myzc_fee write');
				$rs = array();
				$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->setDec($coin, $num);
				$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => $peer['userid']))->setInc($coin, $mum);

				if ($fee) {
					if ($mo->table('movesay_user_coin')->where(array($qbdz => $Coin['zc_user']))->find()) {
						$rs[] = $mo->table('movesay_user_coin')->where(array($qbdz => $Coin['zc_user']))->setInc($coin, $fee);
					}
					else {
						$rs[] = $mo->table('movesay_user_coin')->add(array($qbdz => $Coin['zc_user'], $coin => $fee));
					}
				}

				$rs[] = $mo->table('movesay_myzc')->add(array('userid' => userid(), 'username' => $addr, 'coinname' => $coin, 'txid' => md5($addr . $user_coin[$coin . 'b'] . time()), 'num' => $num, 'fee' => $fee, 'mum' => $mum, 'addtime' => time(), 'status' => 1));
				$rs[] = $mo->table('movesay_myzr')->add(array('userid' => $peer['userid'], 'username' => $user_coin[$coin . 'b'], 'coinname' => $coin, 'txid' => md5($user_coin[$coin . 'b'] . $addr . time()), 'num' => $num, 'fee' => $fee, 'mum' => $mum, 'addtime' => time(), 'status' => 1));

				if ($fee_user) {
					$rs[] = $mo->table('movesay_myzc_fee')->add(array('userid' => $fee_user['userid'], 'username' => $Coin['zc_user'], 'coinname' => $coin, 'txid' => md5($user_coin[$coin . 'b'] . $Coin['zc_user'] . time()), 'num' => $num, 'fee' => $fee, 'type' => 1, 'mum' => $mum, 'addtime' => time(), 'status' => 1));
				}

				if (check_arr($rs)) {
					$mo->execute('commit');
					$mo->execute('unlock tables');
					session('myzc_verify', null);
					$this->success('转账成功！');
				}
				else {
					$mo->execute('rollback');
					$this->error('转账失败!');
				}
			}
			else {
				$dj_username = $Coin['dj_yh'];
				$dj_password = $Coin['dj_mm'];
				$dj_address = $Coin['dj_zj'];
				$dj_port = $Coin['dj_dk'];
				$CoinClient = CoinClient($dj_username, $dj_password, $dj_address, $dj_port, 5, array(), 1);
				$json = $CoinClient->getinfo();
				if (!isset($json['version']) || !$json['version']) {
					$this->error('钱包链接失败！');
				}

				$valid_res = $CoinClient->validateaddress($addr);

				if (!$valid_res['isvalid']) {
					$this->error($addr . '不是一个有效的钱包地址！');
				}

				$auto_status = ($Coin['zc_zd'] && ($num < $Coin['zc_zd']) ? 1 : 0);

				if ($json['balance'] < $num) {
					$this->error('钱包余额不足');
				}

				$mo = M();
				$mo->execute('set autocommit=0');
				$mo->execute('lock tables  movesay_user_coin write  , movesay_myzc write ,movesay_myzr write, movesay_myzc_fee write');
				$rs = array();
				$rs[] = $r = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->setDec($coin, $num);
				$rs[] = $aid = $mo->table('movesay_myzc')->add(array('userid' => userid(), 'username' => $addr, 'coinname' => $coin, 'num' => $num, 'fee' => $fee, 'mum' => $mum, 'addtime' => time(), 'status' => $auto_status));
				if ($fee && $auto_status) {
					$rs[] = $mo->table('movesay_myzc_fee')->add(array('userid' => $fee_user['userid'], 'username' => $Coin['zc_user'], 'coinname' => $coin, 'num' => $num, 'fee' => $fee, 'mum' => $mum, 'type' => 2, 'addtime' => time(), 'status' => 1));

					if ($mo->table('movesay_user_coin')->where(array($qbdz => $Coin['zc_user']))->find()) {
						$rs[] = $r = $mo->table('movesay_user_coin')->where(array($qbdz => $Coin['zc_user']))->setInc($coin, $fee);
						debug(array('res' => $r, 'lastsql' => $mo->table('movesay_user_coin')->getLastSql()), '新增费用');
					}
					else {
						$rs[] = $r = $mo->table('movesay_user_coin')->add(array($qbdz => $Coin['zc_user'], $coin => $fee));
					}
				}

				if (check_arr($rs)) {
					if ($auto_status) {
						$mo->execute('commit');
						$mo->execute('unlock tables');
						$sendrs = $CoinClient->sendtoaddress($addr, floatval($mum));

						if ($sendrs) {
							$flag = 1;
							$arr = json_decode($sendrs, true);
							if (isset($arr['status']) && ($arr['status'] == 0)) {
								$flag = 0;
							}
						}
						else {
							$flag = 0;
						}

						if (!$flag) {
							$this->error('钱包服务器转出币失败,请手动转出');
						}
						else {
							$this->success('转出成功!');
						}
					}

					if ($auto_status) {
						$mo->execute('commit');
						$mo->execute('unlock tables');
						session('myzc_verify', null);
						$this->success('转出成功!');
					}
					else {
						$mo->execute('commit');
						$mo->execute('unlock tables');
						session('myzc_verify', null);
						$this->success('转出申请成功,请等待审核！');
					}
				}
				else {
					$mo->execute('rollback');
					$this->error('转出失败!');
				}
			}
		}
	}

	public function mywt($market = NULL, $type = NULL, $status = NULL)
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('finance_mywt'));
		check_server();
		$Coin = M('Coin')->where(array('status' => 1))->select();

		foreach ($Coin as $k => $v) {
			$coin_list[$v['name']] = $v;
		}

		$this->assign('coin_list', $coin_list);
		$Market = M('Market')->where(array('status' => 1))->select();

		foreach ($Market as $k => $v) {
			list($v['xnb']) = explode('_', $v['name']);
			list(, $v['rmb']) = explode('_', $v['name']);
			$market_list[$v['name']] = $v;
		}

		$this->assign('market_list', $market_list);

		if (!$market_list[$market]) {
			$market = $Market[0]['name'];
		}

		$where['market'] = $market;
		if (($type == 1) || ($type == 2)) {
			$where['type'] = $type;
		}

		if (($status == 1) || ($status == 2) || ($status == 3)) {
			$where['status'] = $status - 1;
		}

		$where['userid'] = userid();
		$this->assign('market', $market);
		$this->assign('type', $type);
		$this->assign('status', $status);
		$Moble = M('Trade');
		$count = $Moble->where($where)->count();
		$Page = new \Home\Common\Ext\PageExt($count, 15);
		$Page->parameter .= 'type=' . $type . '&status=' . $status . '&market=' . $market . '&';
		$show = $Page->show();
		$list = $Moble->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();

		foreach ($list as $k => $v) {
			$list[$k]['num'] = $v['num'] * 1;
			$list[$k]['price'] = $v['price'] * 1;
			$list[$k]['deal'] = $v['deal'] * 1;
		}

		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function mycj($market = NULL, $type = NULL)
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('finance_mycj'));
		check_server();
		$Coin = M('Coin')->where(array('status' => 1))->select();

		foreach ($Coin as $k => $v) {
			$coin_list[$v['name']] = $v;
		}

		$this->assign('coin_list', $coin_list);
		$Market = M('Market')->where(array('status' => 1))->select();

		foreach ($Market as $k => $v) {
			list($v['xnb']) = explode('_', $v['name']);
			list(, $v['rmb']) = explode('_', $v['name']);
			$market_list[$v['name']] = $v;
		}

		$this->assign('market_list', $market_list);

		if (!$market_list[$market]) {
			$market = $Market[0]['name'];
		}

		if ($type == 1) {
			$where = 'userid=' . userid() . ' && market=\'' . $market . '\'';
		}
		else if ($type == 2) {
			$where = 'peerid=' . userid() . ' && market=\'' . $market . '\'';
		}
		else {
			$where = '((userid=' . userid() . ') || (peerid=' . userid() . ')) && market=\'' . $market . '\'';
		}

		$this->assign('market', $market);
		$this->assign('type', $type);
		$this->assign('userid', userid());
		$Moble = M('TradeLog');
		$count = $Moble->where($where)->count();
		$Page = new \Home\Common\Ext\PageExt($count, 15);
		$Page->parameter .= 'type=' . $type . '&market=' . $market . '&';
		$show = $Page->show();
		$list = $Moble->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();

		foreach ($list as $k => $v) {
			$list[$k]['num'] = $v['num'] * 1;
			$list[$k]['price'] = $v['price'] * 1;
			$list[$k]['mum'] = $v['mum'] * 1;
			$list[$k]['fee_buy'] = $v['fee_buy'] * 1;
			$list[$k]['fee_sell'] = $v['fee_sell'] * 1;
		}

		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function mytj()
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('finance_mytj'));
		check_server();
		$user = M('User')->where(array('id' => userid()))->find();

		if (!$user['invit']) {
			for (; ; ) {
				$tradeno = tradenoa();

				if (!M('User')->where(array('invit' => $tradeno))->find()) {
					break;
				}
			}

			M('User')->where(array('id' => userid()))->save(array('invit' => $tradeno));
			$user = M('User')->where(array('id' => userid()))->find();
		}

		$this->assign('user', $user);
		$this->display();
	}

	public function mywd()
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('finance_mywd'));
		check_server();
		$where['invit_1'] = userid();
		$Model = M('User');
		$count = $Model->where($where)->count();
		$Page = new \Home\Common\Ext\PageExt($count, 10);
		$show = $Page->show();
		$list = $Model->where($where)->order('id asc')->field('id,username,moble,addtime,invit_1')->limit($Page->firstRow . ',' . $Page->listRows)->select();

		foreach ($list as $k => $v) {
			$list[$k]['invits'] = M('User')->where(array('invit_1' => $v['id']))->order('id asc')->field('id,username,moble,addtime,invit_1')->select();
			$list[$k]['invitss'] = count($list[$k]['invits']);

			foreach ($list[$k]['invits'] as $kk => $vv) {
				$list[$k]['invits'][$kk]['invits'] = M('User')->where(array('invit_1' => $vv['id']))->order('id asc')->field('id,username,moble,addtime,invit_1')->select();
				$list[$k]['invits'][$kk]['invitss'] = count($list[$k]['invits'][$kk]['invits']);
			}
		}

		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function myjp()
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('finance_myjp'));
		check_server();
		$where['userid'] = userid();
		$Model = M('Invit');
		$count = $Model->where($where)->count();
		$Page = new \Home\Common\Ext\PageExt($count, 10);
		$show = $Page->show();
		$list = $Model->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();

		foreach ($list as $k => $v) {
			$list[$k]['invit'] = M('User')->where(array('id' => $v['invit']))->getField('username');
		}

		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function install()
	{
		if (!S(MODULE_NAME . CONTROLLER_NAME . 'check')) {
			$Config_DbFields = M('MyczType')->getDbFields();

			if (!in_array('truename', $Config_DbFields)) {
				M()->execute('ALTER TABLE `movesay_mycz_type` ADD COLUMN `truename` VARCHAR(200) DEFAULT \'\' NOT NULL   COMMENT \'名称\' AFTER `id`;');
			}

			if (!in_array('kaihu', $Config_DbFields)) {
				M()->execute('ALTER TABLE `movesay_mycz_type` ADD COLUMN `kaihu` VARCHAR(200) DEFAULT \'\' NOT NULL   COMMENT \'名称\' AFTER `id`;');
			}

			if (!in_array('img', $Config_DbFields)) {
				M()->execute('ALTER TABLE `movesay_mycz_type` ADD COLUMN `img` VARCHAR(200) DEFAULT \'\' NOT NULL   COMMENT \'名称\' AFTER `id`;');
			}

			if (!in_array('min', $Config_DbFields)) {
				M()->execute('ALTER TABLE `movesay_mycz_type` ADD COLUMN `min` VARCHAR(200) DEFAULT \'\' NOT NULL   COMMENT \'名称\' AFTER `id`;');
			}

			if (!in_array('max', $Config_DbFields)) {
				M()->execute('ALTER TABLE `movesay_mycz_type` ADD COLUMN `max` VARCHAR(200) DEFAULT \'\' NOT NULL   COMMENT \'名称\' AFTER `id`;');
			}

			if (!in_array('username', $Config_DbFields)) {
				M()->execute('ALTER TABLE `movesay_mycz_type` ADD COLUMN `username` VARCHAR(200) DEFAULT \'\' NOT NULL   COMMENT \'名称\' AFTER `id`;');
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/index',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Finance/index', 'title' => '财务明细', 'pid' => 4, 'sort' => 1, 'hide' => 0, 'group' => '财务', 'ico_name' => 'th-list'));
			}
			else {
				M('Menu')->where(array(
	'url' => 'Finance/index',
	'pid' => array('neq', 0)
	))->save(array('title' => '财务明细', 'pid' => 4, 'sort' => 1, 'hide' => 0, 'group' => '财务', 'ico_name' => 'th-list'));
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/mycz',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Finance/mycz', 'title' => '人民币充值', 'pid' => 4, 'sort' => 2, 'hide' => 0, 'group' => '财务', 'ico_name' => 'th-list'));
			}
			else {
				M('Menu')->where(array(
	'url' => 'Finance/mycz',
	'pid' => array('neq', 0)
	))->save(array('title' => '人民币充值', 'pid' => 4, 'sort' => 2, 'hide' => 0, 'group' => '财务', 'ico_name' => 'th-list'));
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/myczType',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Finance/myczType', 'title' => '人民币充值方式', 'pid' => 4, 'sort' => 3, 'hide' => 0, 'group' => '财务', 'ico_name' => 'th-list'));
			}
			else {
				M('Menu')->where(array(
	'url' => 'Finance/myczType',
	'pid' => array('neq', 0)
	))->save(array('title' => '人民币充值方式', 'pid' => 4, 'sort' => 3, 'hide' => 0, 'group' => '财务', 'ico_name' => 'th-list'));
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/mytx',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Finance/mytx', 'title' => '人民币提现', 'pid' => 4, 'sort' => 4, 'hide' => 0, 'group' => '财务', 'ico_name' => 'th-list'));
			}
			else {
				M('Menu')->where(array(
	'url' => 'Finance/mytx',
	'pid' => array('neq', 0)
	))->save(array('title' => '人民币提现', 'pid' => 4, 'sort' => 4, 'hide' => 0, 'group' => '财务', 'ico_name' => 'th-list'));
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/mytxConfig',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Finance/mytxConfig', 'title' => '人民币提现配置', 'pid' => 4, 'sort' => 5, 'hide' => 0, 'group' => '财务', 'ico_name' => 'th-list'));
			}
			else {
				M('Menu')->where(array(
	'url' => 'Finance/mytxConfig',
	'pid' => array('neq', 0)
	))->save(array('title' => '人民币提现配置', 'pid' => 4, 'sort' => 5, 'hide' => 0, 'group' => '财务', 'ico_name' => 'th-list'));
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/myzr',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Finance/myzr', 'title' => '虚拟币转入', 'pid' => 4, 'sort' => 6, 'hide' => 0, 'group' => '财务', 'ico_name' => 'th-list'));
			}
			else {
				M('Menu')->where(array(
	'url' => 'Finance/myzr',
	'pid' => array('neq', 0)
	))->save(array('title' => '虚拟币转入', 'pid' => 4, 'sort' => 6, 'hide' => 0, 'group' => '财务', 'ico_name' => 'th-list'));
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/myzc',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Finance/myzc', 'title' => '虚拟币转出', 'pid' => 4, 'sort' => 7, 'hide' => 0, 'group' => '财务', 'ico_name' => 'th-list'));
			}
			else {
				M('Menu')->where(array(
	'url' => 'Finance/myzc',
	'pid' => array('neq', 0)
	))->save(array('title' => '虚拟币转出', 'pid' => 4, 'sort' => 7, 'hide' => 0, 'group' => '财务', 'ico_name' => 'th-list'));
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/myczStatus',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else {
				$pid = M('Menu')->where(array(
	'url' => 'Finance/mycz',
	'pid' => array('neq', 0)
	))->getField('id');

				if (!$list) {
					M('Menu')->add(array('url' => 'Finance/myczStatus', 'title' => '修改状态', 'pid' => $pid, 'sort' => 100, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
				else {
					M('Menu')->where(array(
	'url' => 'Finance/myczStatus',
	'pid' => array('neq', 0)
	))->save(array('title' => '修改状态', 'pid' => $pid, 'sort' => 100, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/myczQueren',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else {
				$pid = M('Menu')->where(array(
	'url' => 'Finance/mycz',
	'pid' => array('neq', 0)
	))->getField('id');

				if (!$list) {
					M('Menu')->add(array('url' => 'Finance/myczQueren', 'title' => '确认到账', 'pid' => $pid, 'sort' => 100, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
				else {
					M('Menu')->where(array(
	'url' => 'Finance/myczQueren',
	'pid' => array('neq', 0)
	))->save(array('title' => '确认到账', 'pid' => $pid, 'sort' => 100, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/myczTypeEdit',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else {
				$pid = M('Menu')->where(array(
	'url' => 'Finance/myczType',
	'pid' => array('neq', 0)
	))->getField('id');

				if (!$list) {
					M('Menu')->add(array('url' => 'Finance/myczTypeEdit', 'title' => '编辑添加', 'pid' => $pid, 'sort' => 1, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
				else {
					M('Menu')->where(array(
	'url' => 'Finance/myczTypeEdit',
	'pid' => array('neq', 0)
	))->save(array('title' => '编辑添加', 'pid' => $pid, 'sort' => 1, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/myczTypeStatus',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else {
				$pid = M('Menu')->where(array(
	'url' => 'Finance/myczType',
	'pid' => array('neq', 0)
	))->getField('id');

				if (!$list) {
					M('Menu')->add(array('url' => 'Finance/myczTypeStatus', 'title' => '状态修改', 'pid' => $pid, 'sort' => 2, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
				else {
					M('Menu')->where(array(
	'url' => 'Finance/myczTypeStatus',
	'pid' => array('neq', 0)
	))->save(array('title' => '状态修改', 'pid' => $pid, 'sort' => 2, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/myczTypeImage',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else {
				$pid = M('Menu')->where(array(
	'url' => 'Finance/myczType',
	'pid' => array('neq', 0)
	))->getField('id');

				if (!$list) {
					M('Menu')->add(array('url' => 'Finance/myczTypeImage', 'title' => '上传图片', 'pid' => $pid, 'sort' => 2, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
				else {
					M('Menu')->where(array(
	'url' => 'Finance/myczTypeImage',
	'pid' => array('neq', 0)
	))->save(array('title' => '上传图片', 'pid' => $pid, 'sort' => 2, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/mytxStatus',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else {
				$pid = M('Menu')->where(array(
	'url' => 'Finance/mytx',
	'pid' => array('neq', 0)
	))->getField('id');

				if (!$list) {
					M('Menu')->add(array('url' => 'Finance/mytxStatus', 'title' => '修改状态', 'pid' => $pid, 'sort' => 2, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
				else {
					M('Menu')->where(array(
	'url' => 'Finance/mytxStatus',
	'pid' => array('neq', 0)
	))->save(array('title' => '修改状态', 'pid' => $pid, 'sort' => 2, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/mytxExcel',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else {
				$pid = M('Menu')->where(array(
	'url' => 'Finance/mytx',
	'pid' => array('neq', 0)
	))->getField('id');

				if (!$list) {
					M('Menu')->add(array('url' => 'Finance/mytxExcel', 'title' => '导出选中', 'pid' => $pid, 'sort' => 3, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
				else {
					M('Menu')->where(array(
	'url' => 'Finance/mytxExcel',
	'pid' => array('neq', 0)
	))->save(array('title' => '导出选中', 'pid' => $pid, 'sort' => 3, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/mytxChuli',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else {
				$pid = M('Menu')->where(array(
	'url' => 'Finance/mytx',
	'pid' => array('neq', 0)
	))->getField('id');

				if (!$list) {
					M('Menu')->add(array('url' => 'Finance/mytxChuli', 'title' => '正在处理', 'pid' => $pid, 'sort' => 4, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
				else {
					M('Menu')->where(array(
	'url' => 'Finance/mytxChuli',
	'pid' => array('neq', 0)
	))->save(array('title' => '正在处理', 'pid' => $pid, 'sort' => 4, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/mytxChexiao',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else {
				$pid = M('Menu')->where(array(
	'url' => 'Finance/mytx',
	'pid' => array('neq', 0)
	))->getField('id');

				if (!$list) {
					M('Menu')->add(array('url' => 'Finance/mytxChexiao', 'title' => '撤销提现', 'pid' => $pid, 'sort' => 5, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
				else {
					M('Menu')->where(array(
	'url' => 'Finance/mytxChexiao',
	'pid' => array('neq', 0)
	))->save(array('title' => '撤销提现', 'pid' => $pid, 'sort' => 5, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/mytxQueren',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else {
				$pid = M('Menu')->where(array(
	'url' => 'Finance/mytx',
	'pid' => array('neq', 0)
	))->getField('id');

				if (!$list) {
					M('Menu')->add(array('url' => 'Finance/mytxQueren', 'title' => '确认提现', 'pid' => $pid, 'sort' => 6, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
				else {
					M('Menu')->where(array(
	'url' => 'Finance/mytxQueren',
	'pid' => array('neq', 0)
	))->save(array('title' => '确认提现', 'pid' => $pid, 'sort' => 6, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
			}

			$list = M('Menu')->where(array(
	'url' => 'Finance/myzcQueren',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else {
				$pid = M('Menu')->where(array(
	'url' => 'Finance/myzc',
	'pid' => array('neq', 0)
	))->getField('id');

				if (!$list) {
					M('Menu')->add(array('url' => 'Finance/myzcQueren', 'title' => '确认转出', 'pid' => $pid, 'sort' => 6, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
				else {
					M('Menu')->where(array(
	'url' => 'Finance/myzcQueren',
	'pid' => array('neq', 0)
	))->save(array('title' => '确认转出', 'pid' => $pid, 'sort' => 6, 'hide' => 1, 'group' => '财务', 'ico_name' => 'home'));
				}
			}

			if (M('Menu')->where(array('url' => 'Mycz/index'))->delete()) {
				M('AuthRule')->where(array('status' => 1))->delete();
			}

			if (M('Menu')->where(array('url' => 'Mycztype/index'))->delete()) {
				M('AuthRule')->where(array('status' => 1))->delete();
			}

			if (M('Menu')->where(array('url' => 'Mycz/type'))->delete()) {
				M('AuthRule')->where(array('status' => 1))->delete();
			}

			if (M('Menu')->where(array('url' => 'Mycz/invit'))->delete()) {
				M('AuthRule')->where(array('status' => 1))->delete();
			}

			if (M('Menu')->where(array('url' => 'Mycz/config'))->delete()) {
				M('AuthRule')->where(array('status' => 1))->delete();
			}

			if (M('Menu')->where(array('url' => 'Mytx/index'))->delete()) {
				M('AuthRule')->where(array('status' => 1))->delete();
			}

			if (M('Menu')->where(array('url' => 'Config/mytx'))->delete()) {
				M('AuthRule')->where(array('status' => 1))->delete();
			}

			if (M('Menu')->where(array('url' => 'Myzc/index'))->delete()) {
				M('AuthRule')->where(array('status' => 1))->delete();
			}

			if (M('Menu')->where(array('url' => 'Myzr/index'))->delete()) {
				M('AuthRule')->where(array('status' => 1))->delete();
			}

			if (M('Menu')->where(array('url' => 'Config/mycz'))->delete()) {
				M('AuthRule')->where(array('status' => 1))->delete();
			}

			S(MODULE_NAME . CONTROLLER_NAME . 'check', 1);
		}
	}

	public function check()
	{
		if ((S('CLOUDTIME') + (60 * 60)) < time()) {
			S('CLOUD', null);
			S('CLOUD_IP', null);
			S('CLOUD_HOME', null);
			S('CLOUD_DAOQI', null);
			S('CLOUD_GAME', null);
			S('CLOUDTIME', time());
		}

		$CLOUD = S('CLOUD');
		$CLOUD_IP = S('CLOUD_IP');
		$CLOUD_HOME = S('CLOUD_HOME');
		$CLOUD_DAOQI = S('CLOUD_DAOQI');
		$CLOUD_GAME = S('CLOUD_GAME');

		if (!$CLOUD) {
			foreach (C('__CLOUD__') as $k => $v) {
				if (getUrl($v . '/Auth/text') == 1) {
					$CLOUD = $v;
					break;
				}
			}

			if (!$CLOUD) {
				S('CLOUDTIME', time() - (60 * 60 * 24));
				echo '<a title="授权服务器连失败"></a>';
				exit();
			}
			else {
				S('CLOUD', $CLOUD);
			}
		}

		if (!$CLOUD_DAOQI) {
			$CLOUD_DAOQI = getUrl($CLOUD . '/Auth/daoqi?mscode=' . MSCODE);

			if ($CLOUD_DAOQI) {
				S('CLOUD_DAOQI', $CLOUD_DAOQI);
			}
			else {
				S('CLOUDTIME', time() - (60 * 60 * 24));
				echo '<a title="获取授权到期时间失败"></a>';
				exit();
			}
		}

		if (strtotime($CLOUD_DAOQI) < time()) {
			S('CLOUDTIME', time() - (60 * 60 * 24));
			echo '<a title="授权已到期"></a>';
			exit();
		}

		if (!$CLOUD_IP) {
			$CLOUD_IP = getUrl($CLOUD . '/Auth/ip?mscode=' . MSCODE);

			if (!$CLOUD_IP) {
				S('CLOUD_IP', 1);
			}
			else {
				S('CLOUD_IP', $CLOUD_IP);
			}
		}

		if ($CLOUD_IP && ($CLOUD_IP != 1)) {
			$ip_arr = explode('|', $CLOUD_IP);

			if ('/' == DIRECTORY_SEPARATOR) {
				$ip_a = $_SERVER['SERVER_ADDR'];
			}
			else {
				$ip_a = @gethostbyname($_SERVER['SERVER_NAME']);
			}

			if (!$ip_a) {
				S('CLOUDTIME', time() - (60 * 60 * 24));
				echo '<a title="获取本地ip失败"></a>';
				exit();
			}

			if (!in_array($ip_a, $ip_arr)) {
				S('CLOUDTIME', time() - (60 * 60 * 24));
				echo '<a title="匹配授权ip失败"></a>';
				exit();
			}
		}

		if (!$CLOUD_HOME) {
			$CLOUD_HOME = getUrl($CLOUD . '/Auth/home?mscode=' . MSCODE);

			if (!$CLOUD_HOME) {
				S('CLOUD_HOME', 1);
			}
			else {
				S('CLOUD_HOME', $CLOUD_HOME);
			}
		}

		if ($CLOUD_HOME && ($CLOUD_HOME != 1)) {
			$home_arr = explode('|', $CLOUD_HOME);
			$home_a = $_SERVER['SERVER_NAME'];

			if (!$home_a) {
				$home_a = $_SERVER['HTTP_HOST'];
			}

			if (!$home_a) {
				S('CLOUDTIME', time() - (60 * 60 * 24));
				echo '<a title="获取本地域名失败"></a>';
				exit();
			}

			if (!in_array($home_a, $home_arr)) {
				S('CLOUDTIME', time() - (60 * 60 * 24));
				echo '<a title="匹配授权域名失败"></a>';
				exit();
			}
		}
	}
}

?>
