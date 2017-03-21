<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Admin\Controller;

class MyzcController extends AdminController
{
	private $Model;

	public function __construct()
	{
		parent::__construct();
		$this->Model = M('Myzc');
		$this->Title = '虚拟币转出';
	}

	public function index($name = NULL, $coin = NULL)
	{
		if ($name) {
			$userid = M('User')->where(array('username' => $name))->getField('id');

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

	public function queren($id = NULL)
	{
		if (APP_DEMO) {
			$this->error('测试站暂时不能修改！');
		}

		$myzc = $this->Model->where(array('id' => trim($id)))->find();

		if (!$myzc) {
			$this->error('转出错误！');
		}

		if ($myzc['status']) {
			$this->error('已经处理过！');
		}

		$username = M('User')->where(array('id' => $myzc['userid']))->getField('username');
		$coin = $myzc['coinname'];
		$dj_username = C('coin')[$coin]['dj_yh'];
		$dj_password = C('coin')[$coin]['dj_mm'];
		$dj_address = C('coin')[$coin]['dj_zj'];
		$dj_port = C('coin')[$coin]['dj_dk'];
		$CoinClient = CoinClient($dj_username, $dj_password, $dj_address, $dj_port, 5, array(), 1);
		$json = $CoinClient->getinfo();
		if (!isset($json['version']) || !$json['version']) {
			$this->error('钱包链接失败！');
		}

		$Coin = M('Coin')->where(array('name' => $myzc['coinname']))->find();
		$fee_user = M('UserCoin')->where(array($coin . 'b' => $Coin['zc_user']))->find();
		$user_coin = M('UserCoin')->where(array('userid' => $myzc['userid']))->find();
		$zhannei = M('UserCoin')->where(array($coin . 'b' => $myzc['username']))->find();
		$mo = M();
		$mo->execute('set autocommit=0');
		$mo->execute('lock tables  movesay_user_coin write  , movesay_myzc write  , movesay_myzr write , movesay_myzc_fee write');
		$rs = array();

		if ($zhannei) {
			$rs[] = $mo->table('movesay_myzr')->add(array('userid' => $zhannei['userid'], 'username' => $myzc['username'], 'coinname' => $coin, 'txid' => md5($myzc['username'] . $user_coin[$coin . 'b'] . time()), 'num' => $myzc['num'], 'fee' => $myzc['fee'], 'mum' => $myzc['mum'], 'addtime' => time(), 'status' => 1));
			$rs[] = $r = $mo->table('movesay_user_coin')->where(array('userid' => $zhannei['userid']))->setInc($coin, $myzc['mum']);
		}

		if (!$fee_user['userid']) {
			$fee_user['userid'] = 0;
		}

		if (0 < $myzc['fee']) {
			$rs[] = $mo->table('movesay_myzc_fee')->add(array('userid' => $fee_user['userid'], 'username' => $Coin['zc_user'], 'coinname' => $coin, 'num' => $myzc['num'], 'fee' => $myzc['fee'], 'mum' => $myzc['mum'], 'type' => 2, 'addtime' => time(), 'status' => 1));

			if ($mo->table('movesay_user_coin')->where(array($coin . 'b' => $Coin['zc_user']))->find()) {
				$rs[] = $mo->table('movesay_user_coin')->where(array($coin . 'b' => $Coin['zc_user']))->setInc($coin, $myzc['fee']);
				debug(array('lastsql' => $mo->table('movesay_user_coin')->getLastSql()), '新增费用');
			}
			else {
				$rs[] = $mo->table('movesay_user_coin')->add(array($coin . 'b' => $Coin['zc_user'], $coin => $myzc['fee']));
			}
		}

		$rs[] = $this->Model->where(array('id' => trim($id)))->save(array('status' => 1));

		if (check_arr($rs)) {
			$sendrs = $CoinClient->sendtoaddress($myzc['username'], (double) $myzc['mum']);

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

			if ($flag) {
				$mo->execute('commit');
				$mo->execute('unlock tables');
				$this->success('转账成功！');
			}
			else {
				$mo->execute('rollback');
				$mo->execute('unlock tables');
				$this->error('钱包服务器转出币失败!');
			}
		}
		else {
			$mo->execute('rollback');
			$mo->execute('unlock tables');
			$this->error('转出失败!' . implode('|', $rs) . $myzc['fee']);
		}
	}
}

?>
