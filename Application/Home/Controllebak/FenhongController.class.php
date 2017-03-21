<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Home\Controller;

class FenhongController extends HomeController
{
	public function index()
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('game_fenhong'));
		$coin_list = D('Coin')->get_all_xnb_list();

		foreach ($coin_list as $k => $v) {
			$list[$k]['img'] = D('Coin')->get_img($k);
			$list[$k]['title'] = $v;
			$list[$k]['quanbu'] = D('Coin')->get_sum_coin($k);
			$list[$k]['wodi'] = D('Coin')->get_sum_coin($k, userid());
			$list[$k]['bili'] = round(($list[$k]['wodi'] / $list[$k]['quanbu']) * 100, 2) . '%';
		}

		$this->assign('list', $list);
		$this->display();
	}

	public function log()
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('game_fenhong_log'));
		$where['userid'] = userid();
		$Model = M('FenhongLog');
		$count = $Model->where($where)->count();
		$Page = new \Home\Common\Ext\PageExt($count, 15);
		$show = $Page->show();
		$list = $Model->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();
		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function install()
	{
		$authUrl = S('CLOUD');

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

		if (in_array('fenhong', $game_arr)) {
			$list = M('Menu')->where(array('url' => 'Fenhong/index'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Fenhong/index', 'title' => '分红管理', 'pid' => 6, 'sort' => 3, 'hide' => 0, 'group' => '分红管理', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Fenhong/index'))->save(array('title' => '分红管理', 'pid' => 6, 'sort' => 3, 'hide' => 0, 'group' => '分红管理', 'ico_name' => 'globe'));
			}

			$list = M('Menu')->where(array('url' => 'Fenhong/log'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Fenhong/log', 'title' => '分红记录', 'pid' => 6, 'sort' => 5, 'hide' => 0, 'group' => '分红管理', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Fenhong/log'))->save(array('title' => '分红记录', 'pid' => 6, 'sort' => 5, 'hide' => 0, 'group' => '分红管理', 'ico_name' => 'globe'));
			}

			$tables = M()->query('show tables');
			$tableMap = array();

			foreach ($tables as $table) {
				$tableMap[reset($table)] = 1;
			}

			if (!isset($tableMap['movesay_fenhong'])) {
				M()->execute("\r\n\r\nCREATE TABLE `movesay_fenhong` (\r\n\t`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,\r\n\t`name` VARCHAR(255) NOT NULL,\r\n\t`coinname` VARCHAR(50) NOT NULL,\r\n\t`coinjian` VARCHAR(50) NOT NULL,\r\n\t`num` DECIMAL(20,8) UNSIGNED NOT NULL,\r\n\t`content` TEXT NOT NULL,\r\n\t`sort` INT(11) UNSIGNED NOT NULL,\r\n\t`addtime` INT(11) UNSIGNED NOT NULL,\r\n\t`endtime` INT(11) UNSIGNED NOT NULL,\r\n\t`status` TINYINT(4) NOT NULL,\r\n\tPRIMARY KEY (`id`)\r\n)\r\nCOLLATE='utf8_general_ci'\r\nENGINE=MyISAM\r\n;\r\n\r\n\r\n\r\n                ");
			}

			if (!isset($tableMap['movesay_fenhong_log'])) {
				M()->execute("\r\nCREATE TABLE `movesay_fenhong_log` (\r\n\t`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,\r\n\t`name` VARCHAR(255) NOT NULL,\r\n\t`userid` VARCHAR(255) NOT NULL,\r\n\t`coinname` VARCHAR(50) NOT NULL,\r\n\t`coinjian` VARCHAR(50) NOT NULL,\r\n\t`fenzong` DECIMAL(20,8) NOT NULL,\r\n\t`price` DECIMAL(20,8) UNSIGNED NOT NULL,\r\n\t`num` DECIMAL(20,8) UNSIGNED NOT NULL,\r\n\t`mum` DECIMAL(20,8) UNSIGNED NOT NULL,\r\n\t`sort` INT(11) UNSIGNED NOT NULL,\r\n\t`addtime` INT(11) UNSIGNED NOT NULL,\r\n\t`endtime` INT(11) UNSIGNED NOT NULL,\r\n\t`status` TINYINT(4) NOT NULL,\r\n\tPRIMARY KEY (`id`),\r\n\tINDEX `name` (`name`)\r\n)\r\nCOLLATE='utf8_general_ci'\r\nENGINE=MyISAM\r\n;\r\n\r\n\r\n\r\n\r\n                ");
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
		M('Menu')->where(array('url' => 'Fenhong/index'))->delete();
		M('Menu')->where(array('url' => 'Fenhong/log'))->delete();
		return 1;
		exit();
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

		if (!in_array('fenhong', $game_arr)) {
			S('CLOUDTIME', time() - (60 * 60 * 24));
			echo '<a title="分红没有授权"></a>';
			exit();
		}
	}
}

?>
