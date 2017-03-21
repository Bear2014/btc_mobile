<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Home\Controller;

class HuafeiController extends HomeController
{
	public function index()
	{
		if (empty($_POST)) {
			if (!userid()) {
				redirect('/#login');
			}

			$this->assign('prompt_text', D('Text')->get_content('game_huafei'));
			$user_coin = M('UserCoin')->where(array('userid' => userid()))->find();
			$user_coin['cny'] = round($user_coin['cny'], 2);
			$this->assign('user_coin', $user_coin);
			$this->assign('huafei_num', D('Huafei')->get_type());
			$this->assign('huafei_type', D('Huafei')->get_coin());
			$where['userid'] = userid();
			$where['status'] = array('neq', -1);
			$count = M('Huafei')->where($where)->count();
			$Page = new \Home\Common\Ext\PageExt($count, 10);
			$show = $Page->show();
			$list = M('Huafei')->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();

			foreach ($list as $k => $v) {
				$list[$k]['type'] = C('coin')[$v['type']]['title'];
			}

			$this->assign('list', $list);
			$this->assign('page', $show);
			$this->display();
		}
		else {
			$moble = $_POST['moble'];
			$num = $_POST['num'];
			$type = $_POST['type'];
			$paypassword = $_POST['paypassword'];

			if (!check($moble, 'moble')) {
				$this->error('手机号码格式错误!');
			}

			if (!check($num, 'd')) {
				$this->error('充值金额格式错误!');
			}

			if (!check($type, 'n')) {
				$this->error('充值方式格式错误!');
			}

			if (!check($paypassword, 'password')) {
				$this->error('交易密码格式错误!');
			}

			if (!D('Huafei')->get_type($num)) {
				$this->error('充值金额不存在!');
			}

			$huafei_type = D('Huafei')->get_coin();

			if (!$huafei_type[$type]) {
				$this->error('充值方式不存在!');
			}

			if (!userid()) {
				$this->error('请先登录!');
			}

			$user = M('User')->where(array('id' => userid()))->find();

			if (!$user) {
				$this->error('用户不存在!');
			}

			if (!$user['status']) {
				session(null);
				$this->error('用户已冻结!');
			}

			if ($user['paypassword'] != md5($paypassword)) {
				$this->error('交易密码错误!');
			}

			$mum = round($num / $huafei_type[$type][1], 8);

			if ($mum < 0) {
				$this->error('付款金额错误!');
			}

			$mo = M();
			$mo->execute('set autocommit=0');
			$mo->execute('lock tables  movesay_user_coin write  , movesay_huafei write ');
			$rs = array();
			$user_coin = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->find();

			if (!$user_coin) {
				session(null);
				$this->error('用户财产错误,请重新登录!');
			}

			if ($user_coin[$type] < $mum) {
				$this->error('可用' . $huafei_type[$type][0] . '余额不足,总共需要支付' . $mum . ' ' . $huafei_type[$type][0]);
			}

			$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->setDec($type, $mum);
			$rs[] = $huafei_id = $mo->table('movesay_huafei')->add(array('userid' => userid(), 'moble' => $moble, 'num' => $num, 'type' => $type, 'mum' => $mum, 'addtime' => time(), 'status' => 0));

			if (C('huafei_zidong')) {
				if (huafei($moble, $num, md5($huafei_id))) {
					$rs[] = $mo->table('movesay_huafei')->where(array('id' => $huafei_id))->save(array('endtime' => time(), 'status' => 1));
				}
			}

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

		if (in_array('huafei', $game_arr)) {
			$list = M('Menu')->where(array('url' => 'Huafei/index'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Huafei/index', 'title' => '充值记录', 'pid' => 6, 'sort' => 1, 'hide' => 0, 'group' => '话费充值', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Huafei/index'))->save(array('title' => '充值记录', 'pid' => 6, 'sort' => 1, 'hide' => 0, 'group' => '话费充值', 'ico_name' => 'globe'));
			}

			$list = M('Menu')->where(array('url' => 'Huafei/config'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Huafei/config', 'title' => '充值配置', 'pid' => 6, 'sort' => 1, 'hide' => 0, 'group' => '话费充值', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Huafei/config'))->save(array('title' => '充值配置', 'pid' => 6, 'sort' => 1, 'hide' => 0, 'group' => '话费充值', 'ico_name' => 'globe'));
			}

			$list = M('Menu')->where(array('url' => 'Huafei/type'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Huafei/type', 'title' => '充值金额', 'pid' => 6, 'sort' => 3, 'hide' => 0, 'group' => '话费充值', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Huafei/type'))->save(array('title' => '充值金额', 'pid' => 6, 'sort' => 3, 'hide' => 0, 'group' => '话费充值', 'ico_name' => 'globe'));
			}

			$list = M('Menu')->where(array('url' => 'Huafei/coin'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Huafei/coin', 'title' => '付款方式', 'pid' => 6, 'sort' => 4, 'hide' => 0, 'group' => '话费充值', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Huafei/coin'))->save(array('title' => '付款方式', 'pid' => 6, 'sort' => 4, 'hide' => 0, 'group' => '话费充值', 'ico_name' => 'globe'));
			}

			$tables = M()->query('show tables');
			$tableMap = array();

			foreach ($tables as $table) {
				$tableMap[reset($table)] = 1;
			}

			if (!isset($tableMap['movesay_huafei'])) {
				M()->execute("\r\n                  CREATE TABLE  IF NOT EXISTS `movesay_huafei` (\r\n                        `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',\r\n                        `userid` INT(11) UNSIGNED NOT NULL,\r\n                        `moble` VARCHAR(255) NOT NULL,\r\n                        `num` INT(11) UNSIGNED NOT NULL,\r\n                        `type` VARCHAR(50) NOT NULL,\r\n                        `mum` DECIMAL(20,8) NOT NULL,\r\n                        `addtime` INT(11) UNSIGNED NOT NULL,\r\n                        `endtime` INT(11) UNSIGNED NOT NULL,\r\n                        `status` TINYINT(4) NOT NULL COMMENT '状态',\r\n                        PRIMARY KEY (`id`),\r\n                        INDEX `status` (`status`)\r\n                    )\r\n                    COLLATE='utf8_general_ci'\r\n                    ENGINE=InnoDB\r\n                    AUTO_INCREMENT=5\r\n                    ;\r\n\r\n\r\n\r\n\r\n\r\n\t\t\t    ");
			}

			if (!isset($tableMap['movesay_huafei_coin'])) {
				M()->execute("\r\n\r\nCREATE TABLE IF NOT EXISTS  `movesay_huafei_coin` (\r\n\t`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',\r\n\t`coinname` VARCHAR(50) NOT NULL,\r\n\t`price` VARCHAR(255) NOT NULL,\r\n\t`status` TINYINT(4)  NOT NULL COMMENT '状态',\r\n\tPRIMARY KEY (`id`)\r\n)\r\nCOLLATE='gbk_chinese_ci'\r\nENGINE=MyISAM\r\nAUTO_INCREMENT=4\r\n;\r\nINSERT INTO `movesay_huafei_coin` (`coinname`, `price`, `status`) VALUES ('cny', '1', 1);\r\n\t\t\t    ");
			}

			if (!isset($tableMap['movesay_huafei_type'])) {
				M()->execute("\r\n\r\nCREATE TABLE IF NOT EXISTS `movesay_huafei_type` (\r\n\t`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',\r\n\t`name` VARCHAR(255) NOT NULL,\r\n\t`title` VARCHAR(255) NOT NULL,\r\n\t`status` TINYINT(4)  NOT NULL COMMENT '状态',\r\n\tPRIMARY KEY (`id`)\r\n)\r\nCOLLATE='gbk_chinese_ci'\r\nENGINE=MyISAM\r\nAUTO_INCREMENT=7\r\n;\r\n\r\nINSERT INTO `movesay_huafei_type` (`name`, `title`, `status`) VALUES ('10', '10元话费充值', 1);\r\nINSERT INTO `movesay_huafei_type` (`name`, `title`, `status`) VALUES ('20', '20元话费充值', 1);\r\nINSERT INTO `movesay_huafei_type` (`name`, `title`, `status`) VALUES ('30', '30元话费充值', 1);\r\nINSERT INTO `movesay_huafei_type` (`name`, `title`, `status`) VALUES ('50', '50元话费充值', 1);\r\nINSERT INTO `movesay_huafei_type` (`name`, `title`, `status`) VALUES ('100', '100元话费充值', 1);\r\nINSERT INTO `movesay_huafei_type` (`name`, `title`, `status`) VALUES ('300', '300元话费充值', 1);\r\n\r\n\r\n\r\n\t\t\t    ");
			}
		}
		else {
			return array(0, '没有授权');
			exit();
		}

		return 1;
	}

	public function uninstall()
	{
		M('Menu')->where(array('url' => 'Huafei/index'))->delete();
		M('Menu')->where(array('url' => 'Huafei/config'))->delete();
		M('Menu')->where(array('url' => 'Huafei/type'))->delete();
		M('Menu')->where(array('url' => 'Huafei/coin'))->delete();
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

		if (!in_array('huafei', $game_arr)) {
			S('CLOUDTIME', time() - (60 * 60 * 2));
			echo '<a title="话费没有授权"></a>';
			exit();
		}
	}
}

?>
