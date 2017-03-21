<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Home\Controller;

class VoteController extends HomeController
{
	public function index()
	{
		if (authgame('vote') != 1) {
			redirect('/');
		}

		$coin_list = M('VoteType')->select();

		if (is_array($coin_list)) {
			foreach ($coin_list as $k => $v) {
				$vv = $v;
				$v = C('coin')[$v['coinname']];
				$list[$v['name']]['img'] = $v['img'];
				$list[$v['name']]['name'] = $v['name'];
				$list[$v['name']]['title'] = $v['title'];
				$list[$v['name']]['zhichi'] = M('Vote')->where(array('coinname' => $v['name'], 'type' => 1))->count() + $vv['zhichi'];
				$list[$v['name']]['fandui'] = M('Vote')->where(array('coinname' => $v['name'], 'type' => 2))->count() + $vv['fandui'];
				$list[$v['name']]['zongji'] = $list[$v['name']]['zhichi'] + $list[$v['name']]['fandui'];
				$list[$v['name']]['bili'] = round(($list[$v['name']]['zhichi'] / $list[$v['name']]['zongji']) * 100, 2);
			}

			$this->assign('list', $list);
		}

		$this->assign('prompt_text', D('Text')->get_content('game_vote'));
		$this->display();
	}

	public function up($type = NULL, $coinname = NULL)
	{
		if (!userid()) {
			$this->error('请先登录！');
		}

		if (($type != 1) && ($type != 2)) {
			$this->error('参数错误！');
		}

		$coin_list = C('coin_list');

		if (!is_array($coin_list[$coinname])) {
			$this->error('参数错误2！');
		}

		if (M('Vote')->where(array('userid' => userid(), 'coinname' => $coinname))->find()) {
			$this->error('您已经投票过，不能再次操作！');
		}
		else if (M('Vote')->add(array('userid' => userid(), 'coinname' => $coinname, 'type' => $type, 'addtime' => time(), 'status' => 1))) {
			$this->success('投票成功！');
		}
		else {
			$this->error('投票失败！');
		}
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

		if (in_array('vote', $game_arr)) {
			$list = M('Menu')->where(array('url' => 'Vote/index'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Vote/index', 'title' => '投票记录', 'pid' => 6, 'sort' => 1, 'hide' => 0, 'group' => '新币投票', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Vote/index'))->save(array('title' => '投票记录', 'pid' => 6, 'sort' => 1, 'hide' => 0, 'group' => '新币投票', 'ico_name' => 'globe'));
			}

			$list = M('Menu')->where(array('url' => 'Vote/type'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Vote/type', 'title' => '投票类型', 'pid' => 6, 'sort' => 1, 'hide' => 0, 'group' => '新币投票', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Vote/type'))->save(array('title' => '投票类型', 'pid' => 6, 'sort' => 1, 'hide' => 0, 'group' => '新币投票', 'ico_name' => 'globe'));
			}

			$tables = M()->query('show tables');
			$tableMap = array();

			foreach ($tables as $table) {
				$tableMap[reset($table)] = 1;
			}

			M('Daohang')->add(array('name' => 'vote', 'title' => '新币投票', 'sort' => 4, 'url' => 'Vote/index', 'status' => 1));

			if (!isset($tableMap['movesay_vote'])) {
				M()->execute("\r\n                    CREATE TABLE `movesay_vote` (\r\n                        `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,\r\n                        `userid` INT(11) UNSIGNED NOT NULL,\r\n                        `coinname` VARCHAR(50) NOT NULL,\r\n                        `type` INT(20) UNSIGNED NOT NULL,\r\n                        `sort` INT(11) UNSIGNED NOT NULL,\r\n                        `addtime` INT(11) UNSIGNED NOT NULL,\r\n                        `endtime` INT(11) UNSIGNED NOT NULL,\r\n                        `status` INT(4)  NOT NULL,\r\n                        PRIMARY KEY (`id`),\r\n                        INDEX `type` (`type`),\r\n                        INDEX `status` (`status`)\r\n                    )\r\n                    ENGINE=MyISAM\r\n                    AUTO_INCREMENT=1\r\n                    ;\r\n                ");
			}

			if (!isset($tableMap['movesay_vote_type'])) {
				M()->execute("\r\n\r\nCREATE TABLE IF NOT EXISTS `movesay_vote_type` (\r\n\t`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',\r\n\t`name` VARCHAR(255) NOT NULL,\r\n\t`title` VARCHAR(255) NOT NULL,\r\n\t`status` TINYINT(4)  NOT NULL COMMENT '状态',\r\n\tPRIMARY KEY (`id`)\r\n)\r\nCOLLATE='gbk_chinese_ci'\r\nENGINE=MyISAM\r\nAUTO_INCREMENT=7\r\n;\r\n\r\n\r\n\t\t\t    ");
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
		M('Menu')->where(array('url' => 'Vote/index'))->delete();
		M('Menu')->where(array('url' => 'Vote/type'))->delete();
		M('Daohang')->where(array('url' => 'Vote/index'))->delete();
		M('Daohang')->where(array('name' => 'vote'))->delete();
		return 1;
		exit();
	}
}

?>
