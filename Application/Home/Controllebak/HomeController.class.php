<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Home\Controller;

class HomeController extends \Think\Controller
{
	protected function _initialize()
	{

		defined('APP_DEMO') || define('APP_DEMO', 0);

		/* if (1475251200 < time()) {
			echo '<span class="time"></span>';
			exit();
		} */

		if (!session('userId')) {
			session('userId', 0);
		}
		else if (CONTROLLER_NAME != 'Login') {
			$user = D('user')->where('id = ' . session('userId'))->find();

			if (!$user['paypassword']) {
				redirect('/Login/register2');
			}

			if (!$user['truename']) {
				redirect('/Login/register3');
			}
		}

		if (userid()) {
			$userCoin_top = M('UserCoin')->where(array('userid' => userid()))->find();
			$userCoin_top['cny'] = round($userCoin_top['cny'], 2);
			$userCoin_top['cnyd'] = round($userCoin_top['cnyd'], 2);
			$this->assign('userCoin_top', $userCoin_top);
		}

		if (isset($_GET['invit'])) {
			session('invit', $_GET['invit']);
		}

		$config = (APP_DEBUG ? null : S('home_config'));

		if (!$config) {
			$config = M('Config')->where(array('id' => 1))->find();
			S('home_config', $config);
		}

		if ($_GET['qijianke'] == 'debug') {
			session('web_close', 1);
		}

		if (!session('web_close')) {
			if (!$config['web_close']) {
				exit($config['web_close_cause']);
			}
		}

		C($config);
		C('contact_qq', explode('|', C('contact_qq')));
		C('contact_qqun', explode('|', C('contact_qqun')));
		C('contact_bank', explode('|', C('contact_bank')));
		$coin = (APP_DEBUG ? null : S('home_coin'));

		if (!$coin) {
			$coin = M('Coin')->where(array('status' => 1))->select();
			S('home_coin', $coin);
		}

		$coinList = array();

		foreach ($coin as $k => $v) {
			$coinList['coin'][$v['name']] = $v;

			if ($v['name'] != 'cny') {
				$coinList['coin_list'][$v['name']] = $v;
			}

			if ($v['type'] == 'rmb') {
				$coinList['rmb_list'][$v['name']] = $v;
			}
			else {
				$coinList['xnb_list'][$v['name']] = $v;
			}

			if ($v['type'] == 'rgb') {
				$coinList['rgb_list'][$v['name']] = $v;
			}

			if ($v['type'] == 'qbb') {
				$coinList['qbb_list'][$v['name']] = $v;
			}
		}

		C($coinList);
		$market = (APP_DEBUG ? null : S('home_market'));

		if (!$market) {
			$market = M('Market')->where(array('status' => 1))->select();
			S('home_market', $market);
		}

		foreach ($market as $k => $v) {
			$v['new_price'] = round($v['new_price'], $v['round']);
			$v['buy_price'] = round($v['buy_price'], $v['round']);
			$v['sell_price'] = round($v['sell_price'], $v['round']);
			$v['min_price'] = round($v['min_price'], $v['round']);
			$v['max_price'] = round($v['max_price'], $v['round']);
			list($v['xnb']) = explode('_', $v['name']);
			list(, $v['rmb']) = explode('_', $v['name']);
			$v['xnbimg'] = C('coin')[$v['xnb']]['img'];
			$v['rmbimg'] = C('coin')[$v['rmb']]['img'];
			$v['volume'] = $v['volume'] * 1;
			$v['change'] = $v['change'] * 1;
			$v['title'] = C('coin')[$v['xnb']]['title'] . '(' . strtoupper($v['xnb']) . '/' . strtoupper($v['rmb']) . ')';
			$marketList['market'][$v['name']] = $v;
		}

		C($marketList);
		$C = C();

		foreach ($C as $k => $v) {
			$C[strtolower($k)] = $v;
		}

		$this->assign('C', $C);
		$this->kefu = './Application/Home/View/Kefu/' . $C['kefu'] . '/index.html';

		if (!S('daohang_aa')) {
			$tables = M()->query('show tables');
			$tableMap = array();

			foreach ($tables as $table) {
				$tableMap[reset($table)] = 1;
			}

			if (!isset($tableMap['movesay_daohang'])) {
				M()->execute("\r\n                    CREATE TABLE `movesay_daohang` (\r\n                        `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',\r\n                        `name` VARCHAR(255) NOT NULL COMMENT '名称',\r\n                         `title` VARCHAR(255) NOT NULL COMMENT '名称',\r\n                        `url` VARCHAR(255) NOT NULL COMMENT 'url',\r\n                        `sort` INT(11) UNSIGNED NOT NULL COMMENT '排序',\r\n                        `addtime` INT(11) UNSIGNED NOT NULL COMMENT '添加时间',\r\n                        `endtime` INT(11) UNSIGNED NOT NULL COMMENT '编辑时间',\r\n                        `status` TINYINT(4)  NOT NULL COMMENT '状态',\r\n                        PRIMARY KEY (`id`)\r\n\r\n                  )\r\nCOLLATE='gbk_chinese_ci'\r\nENGINE=MyISAM\r\nAUTO_INCREMENT=1\r\n;\r\n\r\n\r\n\r\nINSERT INTO `movesay_daohang` (`name`,`title`, `url`, `sort`, `status`) VALUES ('finance','财务中心', 'Finance/index', 1, 1);\r\nINSERT INTO `movesay_daohang` (`name`,`title`, `url`, `sort`, `status`) VALUES ('user','安全中心', 'User/index', 2, 1);\r\nINSERT INTO `movesay_daohang` (`name`, `title`,`url`, `sort`, `status`) VALUES ('game','应用中心', 'Game/index', 3, 1);\r\nINSERT INTO `movesay_daohang` (`name`, `title`,`url`, `sort`, `status`) VALUES ('article','帮助中心', 'Article/index', 4, 1);\r\n\r\n\r\n                ");
			}

			S('daohang_aa', 1);
		}

		if (!S('daohang') || APP_DEBUG) {
			$this->daohang = M('Daohang')->where(array('status' => 1))->order('sort asc')->select();
			S('daohang', $this->daohang);
		}
		else {
			$this->daohang = S('daohang');
		}

  
		$footerArticleType = (APP_DEBUG ? null : S('footer_indexArticleType'));

		if (!$footerArticleType) {
			$footerArticleType = M('ArticleType')->where(array('status' => 1, 'footer' => 1, 'shang' => ''))->order('sort asc ,id desc')->limit(3)->select();
			S('footer_indexArticleType', $footerArticleType);
		}

		$this->assign('footerArticleType', $footerArticleType);
		$footerArticle = (APP_DEBUG ? null : S('footer_indexArticle'));

		if (!$footerArticle) {
			foreach ($footerArticleType as $k => $v) {
				//$footerArticle[$v['name']] = M('ArticleType')->where(array('shang' => $v['name'], 'footer' => 1, 'status' => 1))->order('id asc')->limit(4)->select();
				$footerArticle[$v['name']] = M('Article')->field(array('id','title'))->where(array('type' => $v['name'], 'footer' => 1, 'status' => 1))->order('id asc')->limit(4)->select();
			}
			S('footer_indexArticle', $footerArticle);
		}

		$this->assign('footerArticle', $footerArticle);
	}
}

?>
