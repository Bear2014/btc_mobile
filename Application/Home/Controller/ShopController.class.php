<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Home\Controller;

class ShopController extends HomeController
{
	public function index($name = NULL, $type = NULL, $deal = NULL, $addtime = NULL, $price = NULL, $ls = 20)
	{	
		if (C('shop_login')) {
			if (!userid()) {
				redirect('/#login');
			}
		}

		if (authgame('shop') != 1) {
			redirect('/');
		}

		$this->assign('prompt_text', D('Text')->get_content('game_shop'));
		if ($name && check($name, 'a')) {
			$where['name'] = array('like', '%' . trim($name) . '%');
		}

		$shop_type_list = D('Shop')->shop_type_list();
		if ($type && $shop_type_list[$type]) {
			$where['type'] = trim($type);
		}

		$this->assign('shop_type_list', $shop_type_list);

		if (empty($deal)) {
		}

		if ($deal) {
			$deal_arr = explode('_', $deal);
			if (($deal_arr[1] == 'asc') || ($deal_arr[1] == 'desc')) {
				$order['deal'] = $deal_arr[1];
			}
			else {
				$order['deal'] = 'desc';
			}
		}

		if (empty($addtime)) {
		}

		if ($addtime) {
			$addtime_arr = explode('_', $addtime);
			if (($addtime_arr[1] == 'asc') || ($addtime_arr[1] == 'desc')) {
				$order['addtime'] = $addtime_arr[1];
			}
			else {
				$order['addtime'] = 'desc';
			}
		}

		if (empty($price)) {
		}

		if ($price) {
			$price_arr = explode('_', $price);
			if (($price_arr[1] == 'asc') || ($price_arr[1] == 'desc')) {
				$order['price'] = $price_arr[1];
			}
			else {
				$order['price'] = 'desc';
			}
		}

		$this->assign('name', $name);
		$this->assign('type', $type);
		$this->assign('deal', $deal);
		$this->assign('addtime', $addtime);
		$this->assign('price', $price);
		$where['status'] = 1;
		$shop = M('Shop');
		$count = $shop->where($where)->count();
		$Page = new \Home\Common\Ext\PageExt($count, $ls);
		$Page->parameter .= 'name=' . $name . '&type=' . $type . '&deal=' . $deal . '&addtime=' . $addtime . '&price=' . $price . '&';
		$show = $Page->show();
		$list = $shop->where($where)->order($order)->limit($Page->firstRow . ',' . $Page->listRows)->select();
		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function view($id)
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('game_shop_view'));

		if (!check($id, 'd')) {
			$this->error('参数错误！');
		}

		$Shop = M('Shop')->where(array('id' => $id))->find();

		if (!$Shop) {
			$this->error('商品错误！');
		}
		else {
			$this->assign('data', $Shop);
			$shop_coin_list = D('Shop')->fangshi($Shop['id']);

			foreach ($shop_coin_list as $k => $v) {
				$coin_list[$k]['name'] = D('Coin')->get_title($k);
				$coin_list[$k]['price'] = Num($v);
			}

			$this->assign('coin_list', $coin_list);
		}

		$goods_list = D('Shop')->get_goods(userid());
		$this->assign('goods_list', $goods_list);
		$this->display();
	}

	public function log($ls = 15)
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('game_shop_log'));
		$where['status'] = array('egt', 0);
		$where['userid'] = userid();
		$ShopLog = M('ShopLog');
		$count = $ShopLog->where($where)->count();
		$Page = new \Home\Common\Ext\PageExt($count, $ls);
		$show = $Page->show();
		$list = $ShopLog->where($where)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();
		$this->assign('list', $list);
		$this->assign('page', $show);
		$this->display();
	}

	public function address()
	{
		if (!userid()) {
			redirect('/#login');
		}

		$ShopAddr = M('ShopAddr')->where(array('userid' => userid()))->find();
		$this->assign('ShopAddr', $ShopAddr);
		$this->display();
	}

	public function shopaddr()
	{
		exit();

		if (!userid()) {
			redirect('/#login');
		}

		$this->display();
	}

	public function buyShop($id, $num, $paypassword, $type, $goods)
	{
		if (!userid()) {
			$this->error('请先登录！');
		}

		if (!check($id, 'd')) {
			$this->error('参数错误！');
		}

		if (!check($num, 'd')) {
			$this->error('购买数量格式错误！');
		}

		if (!check($goods, 'd')) {
			$this->error('收货地址格式错误！');
		}

		if (!check($paypassword, 'password')) {
			$this->error('交易密码格式错误！');
		}

		if (!check($type, 'w')) {
			$this->error('付款方式格式错误！');
		}

		$User = M('User')->where(array('id' => userid()))->find();

		if (!$User['paypassword']) {
			$this->error('交易密码非法！');
		}

		if (md5($paypassword) != $User['paypassword']) {
			$this->error('交易密码错误！');
		}

		$Shop = M('Shop')->where(array('id' => $id))->find();

		if (!$Shop) {
			$this->error('商品错误！');
		}

		$my_goods = M('UserGoods')->where(array('id' => $goods))->find();

		if (!$my_goods) {
			$this->error('收货地址错误！');
		}

		if ($my_goods['userid'] != userid()) {
			$this->error('收货地址非法！');
		}

		if (!$Shop['status']) {
			$this->error('当前商品没有上架！');
		}

		if ($Shop['num'] <= $Shop['deal']) {
			$this->error('当前商品已经卖完！');
		}

		$shop_min = 1;
		$shop_max = 100000000;

		if ($num < $shop_min) {
			$this->error('购买数量超过系统最小限制！');
		}

		if ($shop_max < $num) {
			$this->error('购买数量超过系统最大限制！');
		}

		if (($Shop['num'] - $Shop['deal']) < $num) {
			$this->error('购买数量超过当前剩余量！');
		}

		if ($type != 'cny') {
			$coin_price = D('Market')->get_new_price($type . '_cny');

			if (!$coin_price) {
				$this->error('当前币种价格错误！');
			}
		}
		else {
			$coin_price = 1;
		}

		$mum = round($Shop['price'] * $num, 8);

		if (!$mum) {
			$this->error('购买总额错误');
		}

		$xuyao = round($mum / $coin_price, 8);

		if (!$xuyao) {
			$this->error('付款总额错误');
		}

		$usercoin = M('UserCoin')->where(array('userid' => userid()))->getField($type);

		if ($usercoin < $xuyao) {
			$this->error('可用' . C('coin')[$type]['title'] . '余额不足,总共需要支付' . $xuyao . ' ' . C('coin')[$type]['title']);
		}

		$mo = M();
		$mo->execute('set autocommit=0');
		$mo->execute('lock tables movesay_user_coin write,movesay_shop write,movesay_shop_log write');
		$rs = array();
		$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->setDec($type, $xuyao);
		$rs[] = $mo->table('movesay_shop')->where(array('id' => $Shop['id']))->save(array(
	'deal' => array('exp', 'deal+' . $num),
	'num'  => array('exp', 'num-' . $num)
	));

		if (($Shop['num'] - $num) <= 0) {
			$rs[] = $mo->table('movesay_shop')->where(array('id' => $Shop['id']))->save(array('status' => 0));
		}

		$rs[] = $mo->table('movesay_shop_log')->add(array('userid' => userid(), 'shopid' => $Shop['id'], 'price' => $Shop['price'], 'coinname' => $type, 'xuyao' => $xuyao, 'num' => $num, 'mum' => $mum, 'addr' => $my_goods['truename'] . '|' . $my_goods['moble'] . '|' . $my_goods['addr'], 'addtime' => time(), 'status' => 0));

		if (check_arr($rs)) {
			$mo->execute('commit');
			$mo->execute('unlock tables');
			$this->success('购买成功！');
		}
		else {
			$mo->execute('rollback');
			$this->error('购买失败！');
		}
	}

	public function shouhuo($id = NULL)
	{
		if (!check($id, 'd')) {
			$this->error('参数错误！');
		}

		$shoplog = M('ShopLog')->where(array('id' => $id))->find();

		if (!$shoplog) {
			$this->error('操作失败1！');
		}

		if ($shoplog['userid'] != userid()) {
			$this->error('非法操作！');
		}

		$rs = M('ShopLog')->where(array('id' => $id))->save(array('status' => 1));

		if ($rs) {
			$this->success('操作成功！');
		}
		else {
			$this->error('操作失败！');
		}
	}

	public function setaddress($truename, $moble, $name)
	{
		if (!userid()) {
			redirect('/#login');
		}

		if (!check($truename, 'truename')) {
			$this->error('收货人姓名格式错误');
		}

		if (!check($moble, 'moble')) {
			$this->error('收货人电话格式错误');
		}

		if (!check($name, 'a')) {
			$this->error('收货地址格式错误');
		}

		$ShopAddr = M('ShopAddr')->where(array('userid' => userid()))->find();

		if ($ShopAddr) {
			$rs = M('ShopAddr')->where(array('userid' => userid()))->save(array('truename' => $truename, 'moble' => $moble, 'name' => $name));
		}
		else {
			$rs = M('ShopAddr')->add(array('userid' => userid(), 'truename' => $truename, 'moble' => $moble, 'name' => $name));
		}

		if ($rs) {
			$this->success('提交成功');
		}
		else {
			$this->error('提交失败');
		}
	}

	public function goods()
	{
		if (!userid()) {
			redirect('/#login');
		}

		$this->assign('prompt_text', D('Text')->get_content('game_shop_goods'));
		$userGoodsList = M('UserGoods')->where(array('userid' => userid(), 'status' => 1))->order('id desc')->select();

		foreach ($userGoodsList as $k => $v) {
			$userGoodsList[$k]['moble'] = substr_replace($v['moble'], '****', 3, 4);
			$userGoodsList[$k]['idcard'] = substr_replace($v['idcard'], '********', 6, 8);
		}

		$this->assign('userGoodsList', $userGoodsList);
		$this->display();
	}

	public function upgoods($name, $truename, $idcard, $moble, $addr, $paypassword)
	{
		if (!userid()) {
			redirect('/#login');
		}

		if (!check($name, 'a')) {
			$this->error('备注名称格式错误！');
		}

		if (!check($truename, 'truename')) {
			$this->error('联系姓名格式错误！');
		}

		if (!check($idcard, 'idcard')) {
			$this->error('身份证号格式错误！');
		}

		if (!check($moble, 'moble')) {
			$this->error('联系电话格式错误！');
		}

		if (!check($addr, 'a')) {
			$this->error('联系地址格式错误！');
		}

		$user_paypassword = M('User')->where(array('id' => userid()))->getField('paypassword');

		if (md5($paypassword) != $user_paypassword) {
			$this->error('交易密码错误！');
		}

		$userGoods = M('UserGoods')->where(array('userid' => userid()))->select();

		foreach ($userGoods as $k => $v) {
			if ($v['name'] == $name) {
				$this->error('请不要使用相同的地址标识！');
			}
		}

		if (10 <= count($userGoods)) {
			$this->error('每个人最多只能添加10个地址！');
		}

		if (M('UserGoods')->add(array('userid' => userid(), 'name' => $name, 'addr' => $addr, 'idcard' => $idcard, 'truename' => $truename, 'moble' => $moble, 'addtime' => time(), 'status' => 1))) {
			$this->success('添加成功！');
		}
		else {
			$this->error('添加失败！');
		}
	}

	public function delgoods($id, $paypassword)
	{
		if (!userid()) {
			redirect('/#login');
		}

		if (!check($paypassword, 'password')) {
			$this->error('交易密码格式错误！');
		}

		if (!check($id, 'd')) {
			$this->error('参数错误！');
		}

		$user_paypassword = M('User')->where(array('id' => userid()))->getField('paypassword');

		if (md5($paypassword) != $user_paypassword) {
			$this->error('交易密码错误！');
		}

		if (!M('UserGoods')->where(array('userid' => userid(), 'id' => $id))->find()) {
			$this->error('非法访问！');
		}
		else if (M('UserGoods')->where(array('userid' => userid(), 'id' => $id))->delete()) {
			$this->success('删除成功！');
		}
		else {
			$this->error('删除失败！');
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

		if (in_array('shop', $game_arr)) {
			$list = M('Menu')->where(array('url' => 'Shop/index'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Shop/index', 'title' => '商品管理', 'pid' => 6, 'sort' => 1, 'hide' => 0, 'group' => '商城管理', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Shop/index'))->save(array('title' => '商品管理', 'pid' => 6, 'sort' => 1, 'hide' => 0, 'group' => '商城管理', 'ico_name' => 'globe'));
			}

			$list = M('Menu')->where(array('url' => 'Shop/config'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Shop/config', 'title' => '商城配置', 'pid' => 6, 'sort' => 2, 'hide' => 0, 'group' => '商城管理', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Shop/config'))->save(array('title' => '商城配置', 'pid' => 6, 'sort' => 2, 'hide' => 0, 'group' => '商城管理', 'ico_name' => 'globe'));
			}

			$list = M('Menu')->where(array('url' => 'Shop/type'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Shop/type', 'title' => '商品类型', 'pid' => 6, 'sort' => 3, 'hide' => 0, 'group' => '商城管理', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Shop/type'))->save(array('title' => '商品类型', 'pid' => 6, 'sort' => 3, 'hide' => 0, 'group' => '商城管理', 'ico_name' => 'globe'));
			}

			$list = M('Menu')->where(array('url' => 'Shop/coin'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Shop/coin', 'title' => '付款方式', 'pid' => 6, 'sort' => 4, 'hide' => 0, 'group' => '商城管理', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Shop/coin'))->save(array('title' => '付款方式', 'pid' => 6, 'sort' => 4, 'hide' => 0, 'group' => '商城管理', 'ico_name' => 'globe'));
			}

			$list = M('Menu')->where(array('url' => 'Shop/log'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Shop/log', 'title' => '购物记录', 'pid' => 6, 'sort' => 5, 'hide' => 0, 'group' => '商城管理', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Shop/log'))->save(array('title' => '购物记录', 'pid' => 6, 'sort' => 5, 'hide' => 0, 'group' => '商城管理', 'ico_name' => 'globe'));
			}

			$list = M('Menu')->where(array('url' => 'Shop/goods'))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Shop/goods', 'title' => '收货地址', 'pid' => 6, 'sort' => 6, 'hide' => 0, 'group' => '商城管理', 'ico_name' => 'globe'));
			}
			else {
				M('Menu')->where(array('url' => 'Shop/goods'))->save(array('title' => '收货地址', 'pid' => 6, 'sort' => 6, 'hide' => 0, 'group' => '商城管理', 'ico_name' => 'globe'));
			}

			M('Daohang')->add(array('name' => 'shop', 'title' => '云购商城', 'sort' => 3, 'url' => 'Shop/index', 'status' => 1));
			$tables = M()->query('show tables');
			$tableMap = array();

			foreach ($tables as $table) {
				$tableMap[reset($table)] = 1;
			}

			if (!isset($tableMap['movesay_shop'])) {
				M()->execute("\r\n                    CREATE TABLE `movesay_shop` (\r\n                        `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',\r\n                        `name` VARCHAR(255) NOT NULL COMMENT '商品名称',\r\n                        `img` VARCHAR(255) NOT NULL COMMENT '商品logo',\r\n                        `type` VARCHAR(255) NOT NULL COMMENT '商品类型',\r\n                        `price` DECIMAL(20,2) UNSIGNED NOT NULL COMMENT '商品价格',\r\n                        `market_price` DECIMAL(20,2) UNSIGNED NOT NULL COMMENT '市场价',\r\n                        `num` INT(11) UNSIGNED NOT NULL COMMENT '库存数量',\r\n                        `deal` INT(11) UNSIGNED NOT NULL COMMENT '总销量',\r\n                        `content` TEXT NOT NULL COMMENT '商品介绍',\r\n                        `sort` INT(11) UNSIGNED NOT NULL COMMENT '商品排序',\r\n                        `addtime` INT(11) UNSIGNED NOT NULL COMMENT '添加时间',\r\n                        `endtime` INT(11) UNSIGNED NOT NULL COMMENT '编辑时间',\r\n                        `status` TINYINT(4)  NOT NULL COMMENT '状态',\r\n                        PRIMARY KEY (`id`),\r\n                        INDEX `name` (`name`),\r\n                        INDEX `status` (`status`),\r\n                        INDEX `deal` (`deal`),\r\n                        INDEX `price` (`price`)\r\n                    )\r\n                    COMMENT='商城商品表'\r\n                    COLLATE='utf8_general_ci'\r\n                    ENGINE=InnoDB\r\n                    AUTO_INCREMENT=1\r\n                    ;\r\n                ");
			}

			if (!isset($tableMap['movesay_shop_log'])) {
				M()->execute("\r\n                        CREATE TABLE `movesay_shop_log` (\r\n                            `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',\r\n                            `userid` INT(11) UNSIGNED NOT NULL COMMENT '用户id',\r\n                            `shopid` INT(11) UNSIGNED NOT NULL COMMENT '商品id',\r\n                            `price` DECIMAL(20,2) UNSIGNED NOT NULL COMMENT '商品价格',\r\n                            `coinname` VARCHAR(50) NOT NULL COMMENT '付款币种',\r\n                            `num` INT(11) UNSIGNED NOT NULL COMMENT '购买数量',\r\n                            `mum` DECIMAL(20,2) UNSIGNED NOT NULL COMMENT '总金额',\r\n                            `xuyao` DECIMAL(20,2) UNSIGNED NOT NULL COMMENT '总金额',\r\n                            `addr` VARCHAR(50) NOT NULL COMMENT '收货地址',\r\n                            `sort` INT(11) UNSIGNED NOT NULL COMMENT '排序',\r\n                            `addtime` INT(11) UNSIGNED NOT NULL COMMENT '添加时间',\r\n                            `endtime` INT(11) UNSIGNED NOT NULL COMMENT '编辑时间',\r\n                            `status` TINYINT(4)  NOT NULL COMMENT '状态',\r\n                            PRIMARY KEY (`id`),\r\n                            INDEX `userid` (`userid`),\r\n                            INDEX `status` (`status`)\r\n                        )\r\n                        COMMENT='购物记录表'\r\n                        COLLATE='utf8_general_ci'\r\n                        ENGINE=InnoDB\r\n                        AUTO_INCREMENT=1\r\n                        ;\r\n                ");
			}

			if (!isset($tableMap['movesay_shop_type'])) {
				M()->execute("\r\n                    CREATE TABLE `movesay_shop_type` (\r\n                        `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',\r\n                        `name` VARCHAR(200) NOT NULL COMMENT '类型名称',\r\n                        `title` VARCHAR(200) NOT NULL COMMENT '类型标题',\r\n                        `remark` VARCHAR(200) NOT NULL COMMENT '类型备注',\r\n                        `sort` INT(11) UNSIGNED NOT NULL COMMENT '排序',\r\n                        `addtime` INT(11) UNSIGNED NOT NULL COMMENT '添加时间',\r\n                        `endtime` INT(11) UNSIGNED NOT NULL COMMENT '编辑时间',\r\n                        `status` INT(4)  NOT NULL COMMENT '状态',\r\n                        PRIMARY KEY (`id`),\r\n                        INDEX `name` (`name`),\r\n                        INDEX `status` (`status`)\r\n                    )\r\n                    COMMENT='商品分类表'\r\n                    COLLATE='utf8_general_ci'\r\n                    ENGINE=InnoDB\r\n                    AUTO_INCREMENT=1\r\n                    ;\r\n                ");
			}

			if (!isset($tableMap['movesay_shop_coin'])) {
				M()->execute("\r\n                        CREATE TABLE `movesay_shop_coin` (\r\n                            `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',\r\n                            `shopid` INT(11) UNSIGNED NOT NULL COMMENT '商品id',\r\n                            `cny` VARCHAR(50) NOT NULL COMMENT '人民币',\r\n                            PRIMARY KEY (`id`),\r\n                            INDEX `shopid` (`shopid`)\r\n                        )\r\n                        COMMENT='商品付款方式表'\r\n                        COLLATE='utf8_general_ci'\r\n                        ENGINE=InnoDB\r\n                        AUTO_INCREMENT=1\r\n                        ;\r\n                ");
			}
		}
		else {
			return 0;
			exit();
		}

		return 1;
	}

	public function uninstall()
	{
		M('Menu')->where(array('url' => 'Shop/config'))->delete();
		M('Menu')->where(array('url' => 'Shop/index'))->delete();
		M('Menu')->where(array('url' => 'Shop/type'))->delete();
		M('Menu')->where(array('url' => 'Shop/coin'))->delete();
		M('Menu')->where(array('url' => 'Shop/log'))->delete();
		M('Menu')->where(array('url' => 'Shop/goods'))->delete();
		M('Daohang')->where(array('url' => 'Shop/index'))->delete();
		M('Daohang')->where(array('name' => 'shop'))->delete();
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

		if (!in_array('shop', $game_arr)) {
			S('CLOUDTIME', time() - (60 * 60 * 2));
			echo '<a title="商城没有授权"></a>';
			exit();
		}
	}
}

?>
