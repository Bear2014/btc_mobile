<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Admin\Controller;

class HuafeiController extends AdminController
{
	public function index($name = NULL)
	{
		$this->checkUpdata();
		$where = array();
		if ($name && ($userid = D('User')->get_userid($name))) {
			$where['userid'] = $userid;
		}

		$where['status'] = array('neq', -1);
		$count = M('Huafei')->where($where)->count();
		$Page = new \Think\Page($count, 15);
		$show = $Page->show();
		$list = M('Huafei')->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();

		foreach ($list as $k => $v) {
			$list[$k]['username'] = D('User')->get_username($v['userid']);
			$list[$k]['mum'] = Num($v['mum']);
			$list[$k]['addtime'] = addtime($v['addtime']);
			$list[$k]['endtime'] = addtime($v['endtime']);
		}

		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function delete($id = NULL)
	{
		if (D('Huafei')->setStatus($id, 'delete')) {
			$this->success('操作成功！');
		}
		else {
			$this->error('操作失败！');
		}
	}

	public function repeal($id = NULL)
	{
		$huafei = M('Huafei')->where(array('id' => $id))->find();

		if (!$huafei) {
			$this->error('不存在！');
		}

		if ($huafei['status'] != 0) {
			$this->error('已经处理过！');
		}

		$mo = M();
		$mo->execute('set autocommit=0');
		$mo->execute('lock tables  movesay_user_coin write  , movesay_huafei write ');
		$rs = array();
		$user_coin = $mo->table('movesay_user_coin')->where(array('userid' => $huafei['userid']))->find();

		if (!$user_coin) {
			session(null);
			$this->error('用户财产错误!');
		}

		$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => $huafei['userid']))->setInc($huafei['type'], $huafei['mum']);
		$rs[] = $mo->table('movesay_huafei')->where(array('id' => $id))->save(array('endtime' => time(), 'status' => 2));

		if (check_arr($rs)) {
			$mo->execute('commit');
			$mo->execute('unlock tables');
			$this->success('操作成功！');
		}
		else {
			$mo->execute('rollback');
			$this->error('操作失败!');
		}
	}

	public function resume($id = NULL)
	{
		if (empty($id)) {
			$this->error('参数错误！');
		}

		$huafei = M('Huafei')->where(array('id' => $id))->find();

		if (!$huafei) {
			$this->error('数据错误！');
		}

		if (huafei($huafei['moble'], $huafei['num'], md5($huafei['id']))) {
			if (D('Huafei')->setStatus($id, 'resume')) {
				$this->success('操作成功！');
			}
			else {
				$this->error('操作失败！');
			}
		}
		else {
			$this->error('第三方付款失败!');
		}
	}

	public function config()
	{
		$Config_DbFields = M('Config')->getDbFields();

		if (!in_array('huafei_appkey', $Config_DbFields)) {
			M()->execute('ALTER TABLE `movesay_config` ADD COLUMN `huafei_appkey` VARCHAR(200) DEFAULT \'\' NOT NULL   COMMENT \'名称\' AFTER `id`;');
		}

		if (!in_array('huafei_openid', $Config_DbFields)) {
			M()->execute('ALTER TABLE `movesay_config` ADD COLUMN `huafei_openid` VARCHAR(200) DEFAULT \'\' NOT NULL   COMMENT \'名称\' AFTER `id`;');
		}

		if (!in_array('huafei_zidong', $Config_DbFields)) {
			M()->execute('ALTER TABLE `movesay_config` ADD COLUMN `huafei_zidong` VARCHAR(200) DEFAULT \'\' NOT NULL   COMMENT \'名称\' AFTER `id`;');
		}

		if (empty($_POST)) {
			$this->display();
		}
		else if (M('Config')->where(array('id' => 1))->save($_POST)) {
			$this->success('修改成功！');
		}
		else {
			$this->error('修改失败');
		}
	}

	public function type()
	{
		$where = array();
		$where['status'] = array('neq', -1);
		$count = M('HuafeiType')->where($where)->count();
		$Page = new \Think\Page($count, 15);
		$show = $Page->show();
		$list = M('HuafeiType')->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();
		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function forbidType($id = NULL)
	{
		if (D('Huafei')->setStatus($id, 'forbid', 'HuafeiType')) {
			$this->success('操作成功！');
		}
		else {
			$this->error('操作失败！');
		}
	}

	public function resumeType($id = NULL)
	{
		if (D('Huafei')->setStatus($id, 'resume', 'HuafeiType')) {
			$this->success('操作成功！');
		}
		else {
			$this->error('操作失败！');
		}
	}

	public function coin()
	{
		$where = array();
		$where['status'] = array('neq', -1);
		$count = M('HuafeiCoin')->where($where)->count();
		$Page = new \Think\Page($count, 15);
		$show = $Page->show();
		$list = M('HuafeiCoin')->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();
		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function forbidCoin($id = NULL)
	{
		if (D('Huafei')->setStatus($id, 'forbid', 'HuafeiCoin')) {
			$this->success('操作成功！');
		}
		else {
			$this->error('操作失败！');
		}
	}

	public function resumeCoin($id = NULL)
	{
		if (D('Huafei')->setStatus($id, 'resume', 'HuafeiCoin')) {
			$this->success('操作成功！');
		}
		else {
			$this->error('操作失败！');
		}
	}

	public function deleteCoin($id = NULL)
	{
		if (D('Huafei')->setStatus($id, 'del', 'HuafeiCoin')) {
			$this->success('操作成功！');
		}
		else {
			$this->error('操作失败！');
		}
	}

	public function editCoin($id = NULL)
	{
		if (empty($_POST)) {
			if ($id) {
				$this->data = M('HuafeiCoin')->where(array('id' => trim($id)))->find();
			}
			else {
				$this->data = null;
			}

			$this->display();
		}
		else {
			if (!C('coin')[$_POST['coinname']]) {
				$this->error('币种错误！');
			}

			if ($_POST['id']) {
				$rs = M('HuafeiCoin')->save($_POST);
			}
			else {
				if ($id = M('HuafeiCoin')->where(array('coinname' => $_POST['coinname']))->find()) {
					$this->error('币种存在！');
				}

				$rs = M('HuafeiCoin')->add($_POST);
			}

			if ($rs) {
				$this->success('操作成功！');
			}
			else {
				$this->error('操作失败！');
			}
		}
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

		if (!in_array('huafei', $game_arr)) {
			S('CLOUDTIME', time() - (60 * 60 * 2));
			echo '<a title="话费没有授权"></a>';
			exit();
		}
	}

	public function checkUpdata()
	{
	}
}

?>
