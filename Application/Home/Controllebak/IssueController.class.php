<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Home\Controller;

class IssueController extends HomeController
{
	public function index()
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('game_issue'));
		$where['status'] = array('egt', 0);
		$Model = M('Issue');
		$count = $Model->where($where)->count();
		$Page = new \Home\Common\Ext\PageExt($count, 5);
		$show = $Page->show();
		$list = $Model->where($where)->order('addtime desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();

		foreach ($list as $k => $v) {
			$list[$k]['img'] = M('Coin')->where(array('name' => $v['coinname']))->getField('img');
			$list[$k]['bili'] = round(($v['deal'] / $v['num']) * 100, 2);
		}

		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function buy($id = 1)
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('game_issue_buy'));

		if (!check($id, 'd')) {
			$this->error('参数错误！');
		}

		$Issue = M('Issue')->where(array('id' => $id))->find();
		$Issue['bili'] = round(($Issue['deal'] / $Issue['num']) * 100, 2);

		$user_coin = M('UserCoin')->where(array('userid' => userid()))->find();
		$this->assign('user_coin', $user_coin[$Issue['buycoin']]);

		if (!$Issue) {
			$this->error('认购错误！');
		}

		$Issue['img'] = M('Coin')->where(array('name' => $Issue['coinname']))->getField('img');
		$this->assign('issue', $Issue);
		$this->display();
	}

	public function log($ls = 15)
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('game_issue_log'));
		$where['status'] = array('egt', 0);
		$where['userid'] = userid();
		$IssueLog = M('IssueLog');
		$count = $IssueLog->where($where)->count();
		$Page = new \Home\Common\Ext\PageExt($count, $ls);
		$show = $Page->show();
		$list = $IssueLog->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();

		foreach ($list as $k => $v) {
			$list[$k]['shen'] = round((($v['ci'] - $v['unlock']) * $v['num']) / $v['ci'], 6);
		}

		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function upbuy($id, $num, $paypassword)
	{
		if (!userid()) {
			redirect('/#login');
		}

		if (!check($id, 'd')) {
			$this->error('参数错误！');
		}

		if (!check($num, 'd')) {
			$this->error('认购数量格式错误！');
		}

		if (!check($paypassword, 'password')) {
			$this->error('交易密码格式错误！');
		}

		$User = M('User')->where(array('id' => userid()))->find();

		if (!$User['paypassword']) {
			$this->error('交易密码非法！');
		}

		if (md5($paypassword) != $User['paypassword']) {
			$this->error('交易密码错误！');
		}

		$Issue = M('Issue')->where(array('id' => $id))->find();

		if (!$Issue) {
			$this->error('认购错误！');
		}

		if (time() < strtotime($Issue['time'])) {
			$this->error('当前认购还未开始！');
		}

		if (!$Issue['status']) {
			$this->error('当前认购已经结束！');
		}

		$issue_min = ($Issue['min'] ? $Issue['min'] : 9.9999999999999995E-7);
		$issue_max = ($Issue['max'] ? $Issue['max'] : 100000000);

		if ($num < $issue_min) {
			$this->error('单次认购数量不得少于系统设置' . $issue_min . '个');
		}

		if ($issue_max < $num) {
			$this->error('单次认购数量不得大于系统设置' . $issue_max . '个');
		}

		if (($Issue['num'] - $Issue['deal']) < $num) {
			$this->error('认购数量超过当前剩余量！');
		}

		$mum = round($Issue['price'] * $num, 6);

		if (!$mum) {
			$this->error('认购总额错误');
		}

		$buycoin = M('UserCoin')->where(array('userid' => userid()))->getField($Issue['buycoin']);

		if ($buycoin < $mum) {
			$this->error('可用' . C('coin')[$Issue['buycoin']]['title'] . '余额不足');
		}

		$issueLog = M('IssueLog')->where(array('userid' => userid(), 'coinname' => $Issue['coinname']))->sum('num');

		if ($Issue['limit'] < ($issueLog + $num)) {
			$this->error('认购总数量超过最大限制' . $Issue['limit']);
		}

		if ($Issue['ci']) {
			$jd_num = round($num / $Issue['ci'], 6);
		}
		else {
			$jd_num = $num;
		}

		if (!$jd_num) {
			$this->error('认购解冻数量错误');
		}

		$mo = M();
		$mo->execute('set autocommit=0');
		$mo->execute('lock tables movesay_invit write ,  movesay_user_coin write  , movesay_issue write  , movesay_issue_log  write ,movesay_finance write');
		$rs = array();
		$finance = $mo->table('movesay_finance')->where(array('userid' => userid()))->order('id desc')->find();
		$finance_num_user_coin = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->find();
		$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->setDec($Issue['buycoin'], $mum);
		$rs[] = $finance_nameid = $mo->table('movesay_issue_log')->add(array('userid' => userid(), 'coinname' => $Issue['coinname'], 'buycoin' => $Issue['buycoin'], 'name' => $Issue['name'], 'price' => $Issue['price'], 'num' => $num, 'mum' => $mum, 'ci' => $Issue['ci'], 'jian' => $Issue['jian'], 'unlock' => 1, 'addtime' => time(), 'endtime' => time(), 'status' => $Issue['ci'] == 1 ? 1 : 0));
		$finance_mum_user_coin = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->find();
		$finance_hash = md5(userid() . $finance_num_user_coin['cny'] . $finance_num_user_coin['cnyd'] . $mum . $finance_mum_user_coin['cny'] . $finance_mum_user_coin['cnyd'] . MSCODE . 'auth.movesay.com');
		$rs[] = $mo->table('movesay_finance')->add(array('userid' => userid(), 'coinname' => 'cny', 'num_a' => $finance_num_user_coin['cny'], 'num_b' => $finance_num_user_coin['cnyd'], 'num' => $finance_num_user_coin['cny'] + $finance_num_user_coin['cnyd'], 'fee' => $num, 'type' => 2, 'name' => 'issue', 'nameid' => $finance_nameid, 'remark' => '认购中心-立即认购', 'mum_a' => $finance_mum_user_coin['cny'], 'mum_b' => $finance_mum_user_coin['cnyd'], 'mum' => $finance_mum_user_coin['cny'] + $finance_mum_user_coin['cnyd'], 'move' => $finance_hash, 'addtime' => time(), 'status' => $finance['mum'] != ($finance_num_user_coin['cny'] + $finance_num_user_coin['cnyd']) ? 0 : 1));
		$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->setInc($Issue['coinname'], $jd_num);
		$rs[] = $mo->table('movesay_issue')->where(array('id' => $id))->setInc('deal', $num);

		if ($Issue['num'] <= $Issue['deal']) {
			$rs[] = $mo->table('movesay_issue')->where(array('id' => $id))->setField('status', 0);
		}

		if ($User['invit_1'] && $Issue['invit_1']) {
			$invit_num_1 = round(($mum / 100) * $Issue['invit_1'], 6);

			if ($invit_num_1) {
				$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => $User['invit_1']))->setInc($Issue['invit_coin'], $invit_num_1);
				$rs[] = $mo->table('movesay_invit')->add(array('userid' => $User['invit_1'], 'invit' => userid(), 'name' => $Issue['name'], 'type' => '一代认购赠送', 'num' => $num, 'mum' => $mum, 'fee' => $invit_num_1, 'addtime' => time(), 'status' => 1));
			}
		}

		if ($User['invit_2'] && $Issue['invit_2']) {
			$invit_num_2 = round(($mum / 100) * $Issue['invit_2'], 6);

			if ($invit_num_2) {
				$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => $User['invit_2']))->setInc($Issue['invit_coin'], $invit_num_2);
				$rs[] = $mo->table('movesay_invit')->add(array('userid' => $User['invit_2'], 'invit' => userid(), 'name' => $Issue['name'], 'type' => '二代认购赠送', 'num' => $num, 'mum' => $mum, 'fee' => $invit_num_2, 'addtime' => time(), 'status' => 1));
			}
		}

		if ($User['invit_3'] && $Issue['invit_3']) {
			$invit_num_3 = round(($mum / 100) * $Issue['invit_3'], 6);

			if ($invit_num_3) {
				$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => $User['invit_3']))->setInc($Issue['invit_coin'], $invit_num_3);
				$rs[] = $mo->table('movesay_invit')->add(array('userid' => $User['invit_3'], 'invit' => userid(), 'name' => $Issue['name'], 'type' => '三代认购赠送', 'num' => $num, 'mum' => $mum, 'fee' => $invit_num_3, 'addtime' => time(), 'status' => 1));
			}
		}

		if (check_arr($rs)) {
			$mo->execute('commit');
			$mo->execute('unlock tables');
			$this->success('购买成功！');
		}
		else {
			$mo->execute('rollback');
			$this->error('购买失败!');
		}
	}

	public function unlock($id)
	{
		if (!userid()) {
			redirect('/#login');
		}

		if (!check($id, 'd')) {
			$this->error('请选择解冻项！');
		}

		$IssueLog = M('IssueLog')->where(array('id' => $id))->find();

		if (!$IssueLog) {
			$this->error('参数错误！');
		}

		if ($IssueLog['status']) {
			$this->error('当前解冻已完成！');
		}

		if ($IssueLog['ci'] <= $IssueLog['unlock']) {
			$this->error('非法访问！');
		}

		$tm = $IssueLog['endtime'] + (60 * 60 * $IssueLog['jian']);

		if (time() < $tm) {
			$this->error('解冻时间还没有到,请在<br>【' . addtime($tm) . '】<br>之后再次操作');
		}

		if ($IssueLog['userid'] != userid()) {
			$this->error('非法访问');
		}

		$jd_num = round($IssueLog['num'] / $IssueLog['ci'], 6);
		$mo = M();
		$mo->execute('set autocommit=0');
		$mo->execute('lock tables movesay_user_coin write  , movesay_issue_log write ');
		$rs = array();
		$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->setInc($IssueLog['coinname'], $jd_num);
		$rs[] = $mo->table('movesay_issue_log')->where(array('id' => $IssueLog['id']))->save(array('unlock' => $IssueLog['unlock'] + 1, 'endtime' => time()));

		if ($IssueLog['ci'] <= $IssueLog['unlock'] + 1) {
			$rs[] = $mo->table('movesay_issue_log')->where(array('id' => $IssueLog['id']))->save(array('status' => 1));
		}

		if (check_arr($rs)) {
			$mo->execute('commit');
			$mo->execute('unlock tables');
			$this->success('解冻成功！');
		}
		else {
			$mo->execute('rollback');
			$this->error('解冻失败！');
		}
	}

	public function install()
	{
		$authUrl = S('CLOUD');

		if (!$authUrl) {
			if (getUrl($authUrl . '/Auth/text') != 1) {
				$cloudUrl = C('__CLOUD__');

				foreach ($cloudUrl as $k => $v) {
					if (getUrl($v . '/Auth/text') == 1) {
						$authUrl = $v;
						S('CLOUD', $v);
						break;
					}
				}
			}
		}

		if (!$authUrl) {
			return array(0, '网络不通');
			exit();
		}

		$game = getUrl($authUrl . '/Auth/game?mscode=' . MSCODE);

		if (!$game) {
			return array(0, '没有开通');
			exit();
		}

		$game_arr = explode('|', $game);

		if (in_array('issue', $game_arr)) {
			$list = M('Menu')->where(array('url' => 'Issue/index'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Issue/index', 'title' => '认购管理', 'pid' => 6, 'sort' => 1, 'hide' => 0, 'group' => '认购管理', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Issue/index'))->save(array('title' => '认购管理', 'pid' => 6, 'sort' => 1, 'hide' => 0, 'group' => '认购管理', 'ico_name' => 'globe'));
			}

			$list = M('Menu')->where(array('url' => 'Issue/log'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Issue/log', 'title' => '认购记录', 'pid' => 6, 'sort' => 1, 'hide' => 0, 'group' => '认购管理', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Issue/log'))->save(array('title' => '认购记录', 'pid' => 6, 'sort' => 1, 'hide' => 0, 'group' => '认购管理', 'ico_name' => 'globe'));
			}

			M('Menu')->where(array('url' => 'Issue/config'))->delete();
		}
		else {
			return array(0, '没有授权');
			exit();
		}

		return 1;
	}

	public function uninstall()
	{
		M('Menu')->where(array('url' => 'Issue/index'))->delete();
		M('Menu')->where(array('url' => 'Issue/log'))->delete();
		M('Menu')->where(array('url' => 'Issuelog/index'))->delete();
		return 1;
		exit();
	}

	public function checkAuth()
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

		if (!$CLOUD_GAME) {
			$CLOUD_GAME = getUrl($CLOUD . '/Auth/game?mscode=' . MSCODE);

			if (!$CLOUD_GAME) {
				S('CLOUDTIME', time() - (60 * 60 * 24));
				echo '<a title="授权应用不存在"></a>';
				exit();
			}
			else {
				S('CLOUD_GAME', $CLOUD_GAME);
			}
		}

		$game_arr = explode('|', $CLOUD_GAME);

		if (!in_array('issue', $game_arr)) {
			S('CLOUDTIME', time() - (60 * 60 * 2));
			echo '<a title="认购没有授权"></a>';
			exit();
		}
	}
}

?>
