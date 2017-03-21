<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Home\Controller;

class QueueController extends HomeController
{
	public function index()
	{
		foreach (C('market') as $k => $v) {
		}

		foreach (C('coin_list') as $k => $v) {
		}
	}

	public function checkYichang()
	{
		$mo = M();
		$mo->execute('set autocommit=0');
		$mo->execute('lock tables movesay_trade write');
		$Trade = M('Trade')->where('deal > num')->order('id desc')->find();

		if ($Trade) {
			if ($Trade['status'] == 0) {
				$mo->table('movesay_trade')->where(array('id' => $Trade['id']))->save(array('deal' => Num($Trade['num']), 'status' => 1));
			}
			else {
				$mo->table('movesay_trade')->where(array('id' => $Trade['id']))->save(array('deal' => Num($Trade['num'])));
			}

			$mo->execute('commit');
			$mo->execute('unlock tables');
		}
		else {
			$mo->execute('rollback');
			$mo->execute('unlock tables');
		}
	}

	public function checkDapan()
	{
		foreach (C('market') as $k => $v) {
			A('Trade')->matchingTrade($v['name']);
		}
	}

	public function checkUsercoin()
	{
		foreach (C('coin') as $k => $v) {
		}
	}

	public function yichang()
	{
		foreach (C('market') as $k => $v) {
			$this->setMarket($v['name']);
		}

		foreach (C('coin_list') as $k => $v) {
			$this->setcoin($v['name']);
		}

		$this->chack_dongjie_coin();
	}

	public function move_yichang()
	{
	}

	public function move_dongjie()
	{
		$max_userid = S('queue_max_userid');

		if (!$max_userid) {
			$max_userid = M('User')->max('id');
			S('queue_max_userid', $max_userid);
		}

		$zuihou_userid = S('queue_zuihou_userid');

		if (!$zuihou_userid) {
			$zuihou_userid = M('User')->min('id');
		}

		for ($x = 0; $x <= 30; $x++) {
			if ($max_userid < ($zuihou_userid + $x)) {
				S('queue_zuihou_userid', null);
				S('queue_max_userid', null);
				break;
			}
			else {
				S('queue_zuihou_userid', $zuihou_userid + $x + 1);
			}

			$user = M('UserCoin')->where(array('userid' => $zuihou_userid + $x))->find();

			if (is_array($user)) {
				foreach (C('coin_list') as $k => $v) {
					if (0 < $user[$v['name'] . 'd']) {
						$mo = M();
						$mo->execute('set autocommit=0');
						$mo->execute('lock tables movesay_user_coin write  , movesay_trade write ');
						$rs = array();
						$rs = M('Trade')->where(array(
	'market' => array('like', $v['name'] . '%'),
	'status' => 0,
	'userid' => $user['userid']
	))->find();

						if (!$rs) {
							M('UserCoin')->where(array('userid' => $user['userid']))->setField($v['name'] . 'd', 0);
							$mo->execute('commit');
							$mo->execute('unlock tables');
						}
						else {
							$mo->execute('rollback');
							$mo->execute('unlock tables');
						}
					}
				}
			}
		}
	}

	public function chack_dongjie_coin()
	{
		$max_userid = S('queue_max_userid');

		if (!$max_userid) {
			$max_userid = M('User')->max('id');
			S('queue_max_userid', $max_userid);
		}

		$zuihou_userid = S('queue_zuihou_userid');

		if (!$zuihou_userid) {
			$zuihou_userid = M('User')->min('id');
		}

		for ($x = 0; $x <= 30; $x++) {
			if ($max_userid < ($zuihou_userid + $x)) {
				S('queue_zuihou_userid', null);
				S('queue_max_userid', null);
				break;
			}
			else {
				S('queue_zuihou_userid', $zuihou_userid + $x + 1);
			}

			$user = M('UserCoin')->where(array('userid' => $zuihou_userid + $x))->find();

			if (is_array($user)) {
				foreach (C('coin_list') as $k => $v) {
					if (0 < $user[$v['name'] . 'd']) {
						$mo = M();
						$mo->execute('set autocommit=0');
						$mo->execute('lock tables movesay_user_coin write  , movesay_trade write ');
						$rs = array();
						$rs = M('Trade')->where(array(
	'market' => array('like', $v['name'] . '%'),
	'status' => 0,
	'userid' => $user['userid']
	))->find();

						if (!$rs) {
							M('UserCoin')->where(array('userid' => $user['userid']))->setField($v['name'] . 'd', 0);
						}
					}
				}
			}
		}
	}

	public function move()
	{
		M('Trade')->where(array('status' => '-1'))->setField('status', 1);

		foreach (C('market') as $k => $v) {
			$this->setMarket($v['name']);
		}

		foreach (C('coin_list') as $k => $v) {
			$this->setcoin($v['name']);
		}
	}

	public function setMarket($market = NULL)
	{
		if (!$market) {
			return null;
		}

		$market_json = M('Market_json')->where(array('name' => $market))->order('id desc')->find();

		if ($market_json) {
			$addtime = $market_json['addtime'] + 60;
		}
		else {
			$addtime = M('TradeLog')->where(array('market' => $market))->order('addtime asc')->find()['addtime'];
		}

		$t = $addtime;
		$start = mktime(0, 0, 0, date('m', $t), date('d', $t), date('Y', $t));
		$end = mktime(23, 59, 59, date('m', $t), date('d', $t), date('Y', $t));
		$trade_num = M('TradeLog')->where(array(
	'market'  => $market,
	'addtime' => array(
		array('egt', $start),
		array('elt', $end)
		)
	))->sum('num');

		if ($trade_num) {
			$trade_mum = M('TradeLog')->where(array(
	'market'  => $market,
	'addtime' => array(
		array('egt', $start),
		array('elt', $end)
		)
	))->sum('mum');
			$trade_fee_buy = M('TradeLog')->where(array(
	'market'  => $market,
	'addtime' => array(
		array('egt', $start),
		array('elt', $end)
		)
	))->sum('fee_buy');
			$trade_fee_sell = M('TradeLog')->where(array(
	'market'  => $market,
	'addtime' => array(
		array('egt', $start),
		array('elt', $end)
		)
	))->sum('fee_sell');
			$d = array($trade_num, $trade_mum, $trade_fee_buy, $trade_fee_sell);

			if (M('Market_json')->where(array('name' => $market, 'addtime' => $end))->find()) {
				M('Market_json')->where(array('name' => $market, 'addtime' => $end))->save(array('data' => json_encode($d)));
			}
			else {
				M('Market_json')->add(array('name' => $market, 'data' => json_encode($d), 'addtime' => $end));
			}
		}
		else {
			$d = null;

			if (M('Market_json')->where(array('name' => $market, 'data' => ''))->find()) {
				M('Market_json')->where(array('name' => $market, 'data' => ''))->save(array('addtime' => $end));
			}
			else {
				M('Market_json')->add(array('name' => $market, 'data' => '', 'addtime' => $end));
			}
		}
	}

	public function setcoin($coinname = NULL)
	{
		if (!$coinname) {
			return null;
		}

		if (C('coin')[$coinname]['type'] == 'qbb') {
			$dj_username = C('coin')[$coinname]['dj_yh'];
			$dj_password = C('coin')[$coinname]['dj_mm'];
			$dj_address = C('coin')[$coinname]['dj_zj'];
			$dj_port = C('coin')[$coinname]['dj_dk'];
			$CoinClient = CoinClient($dj_username, $dj_password, $dj_address, $dj_port, 5, array(), 1);
			$json = $CoinClient->getinfo();
			if (!isset($json['version']) || !$json['version']) {
				return null;
			}

			$data['trance_mum'] = $json['balance'];
		}
		else {
			$data['trance_mum'] = 0;
		}

		$market_json = M('CoinJson')->where(array('name' => $coinname))->order('id desc')->find();

		if ($market_json) {
			$addtime = $market_json['addtime'] + 60;
		}
		else {
			$addtime = M('Myzr')->where(array('name' => $coinname))->order('id asc')->find()['addtime'];
		}

		$t = $addtime;
		$start = mktime(0, 0, 0, date('m', $t), date('d', $t), date('Y', $t));
		$end = mktime(23, 59, 59, date('m', $t), date('d', $t), date('Y', $t));

		if ($addtime) {
			if ((time() + (60 * 60 * 24)) < $addtime) {
				return null;
			}

			$trade_num = M('UserCoin')->where(array(
	'addtime' => array(
		array('egt', $start),
		array('elt', $end)
		)
	))->sum($coinname);
			$trade_mum = M('UserCoin')->where(array(
	'addtime' => array(
		array('egt', $start),
		array('elt', $end)
		)
	))->sum($coinname . 'd');
			$aa = $trade_num + $trade_mum;

			if (C($coinname)['type'] == 'qbb') {
				$bb = $json['balance'];
			}
			else {
				$bb = 0;
			}

			$trade_fee_buy = M('Myzr')->where(array(
	'name'    => $coinname,
	'addtime' => array(
		array('egt', $start),
		array('elt', $end)
		)
	))->sum('fee');
			$trade_fee_sell = M('Myzc')->where(array(
	'name'    => $coinname,
	'addtime' => array(
		array('egt', $start),
		array('elt', $end)
		)
	))->sum('fee');
			$d = array($aa, $bb, $trade_fee_buy, $trade_fee_sell);

			if (M('CoinJson')->where(array('name' => $coinname, 'addtime' => $end))->find()) {
				M('CoinJson')->where(array('name' => $coinname, 'addtime' => $end))->save(array('data' => json_encode($d)));
			}
			else {
				M('CoinJson')->add(array('name' => $coinname, 'data' => json_encode($d), 'addtime' => $end));
			}
		}
	}

	public function paicuo()
	{
		foreach (C('market') as $k => $v) {
		}
	}

	public function houprice()
	{
		foreach (C('market') as $k => $v) {
			if (!$v['hou_price'] || (date('H', time()) == '00')) {
				$t = time();
				$start = mktime(0, 0, 0, date('m', $t), date('d', $t), date('Y', $t));
				$hou_price = M('TradeLog')->where(array(
	'market'  => $v['name'],
	'addtime' => array('lt', $start)
	))->order('id desc')->getField('price');

				if (!$hou_price) {
					$hou_price = M('TradeLog')->where(array('market' => $v['name']))->order('id asc')->getField('price');
				}

				M('Market')->where(array('name' => $v['name']))->setField('hou_price', $hou_price);
				S('home_market', null);
			}
		}
	}

	public function qianbao()
	{
		$coinList = M('Coin')->where(array('status' => 1))->select();

		foreach ($coinList as $k => $v) {
			if ($v['type'] != 'qbb') {
				continue;
			}

			$coin = $v['name'];

			if (!$coin) {
				echo 'MM';
				continue;
			}

			$dj_username = C('coin')[$coin]['dj_yh'];
			$dj_password = C('coin')[$coin]['dj_mm'];
			$dj_address = C('coin')[$coin]['dj_zj'];
			$dj_port = C('coin')[$coin]['dj_dk'];
			echo 'start ' . $coin . "\n";
			$CoinClient = CoinClient($dj_username, $dj_password, $dj_address, $dj_port, 5, array(), 1);
			$json = $CoinClient->getinfo();
			if (!isset($json['version']) || !$json['version']) {
				echo '###ERR#####***** ' . $coin . " connect fail***** ####ERR####>\n";
				continue;
			}

			echo 'Cmplx ' . $coin . ' start,connect ' . (empty($CoinClient) ? 'fail' : 'ok') . " :\n";
			$listtransactions = $CoinClient->listtransactions('*', 100, 0);
			echo 'listtransactions:' . count($listtransactions) . "\n";
			krsort($listtransactions);

			foreach ($listtransactions as $trans) {
				if (!$trans['account']) {
					echo "empty account continue\n";
					continue;
				}

				if (!($user = M('User')->where(array('username' => $trans['account']))->find())) {
					echo "no account find continue\n";
					continue;
				}

				if (M('Myzr')->where(array('txid' => $trans['txid'], 'status' => '1'))->find()) {
					echo "txid had found continue\n";
					continue;
				}

				echo "all check ok \n";

				if ($trans['category'] == 'receive') {
					print_r($trans);
					echo "start receive do:\n";
					$sfee = 0;
					$true_amount = $trans['amount'];

					if (C('coin')[$coin]['zr_zs']) {
						$song = round(($trans['amount'] / 100) * C('coin')[$coin]['zr_zs'], 8);

						if ($song) {
							$sfee = $song;
							$trans['amount'] = $trans['amount'] + $song;
						}
					}

					if ($trans['confirmations'] < C('coin')[$coin]['zr_dz']) {
						echo $trans['account'] . ' confirmations ' . $trans['confirmations'] . ' not elengh ' . C('coin')[$coin]['zr_dz'] . " continue \n";
						echo "confirmations <  c_zr_dz continue\n";

						if ($res = M('myzr')->where(array('txid' => $trans['txid']))->find()) {
							M('myzr')->save(array('id' => $res['id'], 'addtime' => time(), 'status' => intval($trans['confirmations'] - C('coin')[$coin]['zr_dz'])));
						}
						else {
							M('myzr')->add(array('userid' => $user['id'], 'username' => $trans['address'], 'coinname' => $coin, 'fee' => $sfee, 'txid' => $trans['txid'], 'num' => $true_amount, 'mum' => $trans['amount'], 'addtime' => time(), 'status' => intval($trans['confirmations'] - C('coin')[$coin]['zr_dz'])));
						}

						continue;
					}
					else {
						echo "confirmations full\n";
					}

					$mo = M();
					$mo->execute('set autocommit=0');
					$mo->execute('lock tables  movesay_user_coin write , movesay_myzr  write ');
					$rs = array();
					$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => $user['id']))->setInc($coin, $trans['amount']);

					if ($res = $mo->table('movesay_myzr')->where(array('txid' => $trans['txid']))->find()) {
						echo 'movesay_myzr find and set status 1';
						$rs[] = $mo->table('movesay_myzr')->save(array('id' => $res['id'], 'addtime' => time(), 'status' => 1));
					}
					else {
						echo "movesay_myzr not find and add a new movesay_myzr\n";
						$rs[] = $mo->table('movesay_myzr')->add(array('userid' => $user['id'], 'username' => $trans['address'], 'coinname' => $coin, 'fee' => $sfee, 'txid' => $trans['txid'], 'num' => $true_amount, 'mum' => $trans['amount'], 'addtime' => time(), 'status' => 1));
					}

					if (check_arr($rs)) {
						$mo->execute('commit');
						echo $trans['amount'] . ' receive ok ' . $coin . ' ' . $trans['amount'];
						$mo->execute('unlock tables');
						echo "commit ok\n";
					}
					else {
						echo $trans['amount'] . 'receive fail ' . $coin . ' ' . $trans['amount'];
						echo var_export($rs, true);
						$mo->execute('rollback');
						$mo->execute('unlock tables');
						print_r($rs);
						echo "rollback ok\n";
					}
				}
			}

			if ($trans['category'] == 'send') {
				echo "start send do:\n";

				if (3 <= $trans['confirmations']) {
					$myzc = M('Myzc')->where(array('txid' => $trans['txid']))->find();

					if ($myzc) {
						if ($myzc['status'] == 0) {
							M('Myzc')->where(array('txid' => $trans['txid']))->save(array('status' => 1));
							echo $trans['amount'] . '成功转出' . $coin . ' 币确定';
						}
					}
				}
			}
		}
	}

	public function syn_qianbao()
	{
	}

	public function tendency()
	{
		foreach (C('market') as $k => $v) {
			echo '----计算趋势----' . $v['name'] . '------------';
			$tendency_time = 4;
			$t = time();
			$tendency_str = $t - (24 * 60 * 60 * 3);

			for ($x = 0; $x <= 18; $x++) {
				$na = $tendency_str + (60 * 60 * $tendency_time * $x);
				$nb = $tendency_str + (60 * 60 * $tendency_time * ($x + 1));
				$b = M('TradeLog')->where('addtime >=' . $na . ' and addtime <' . $nb . ' and market =\'' . $v['name'] . '\'')->max('price');

				if (!$b) {
					$b = 0;
				}

				$rs[] = array($na, $b);
			}

			M('Market')->where(array('name' => $v['name']))->setField('tendency', json_encode($rs));
			unset($rs);
			echo '计算成功!';
			echo "\n";
		}

		echo '趋势计算0k ' . "\n";
	}

	public function chart()
	{
		foreach (C('market') as $k => $v) {
			$this->setTradeJson($v['name']);
		}

		echo '计算行情0k ' . "\n";
	}

	public function setTradeJson($market)
	{
		$timearr = array(1, 3, 5, 10, 15, 30, 60, 120, 240, 360, 720, 1440, 10080);

		foreach ($timearr as $k => $v) {
			$tradeJson = M('TradeJson')->where(array('market' => $market, 'type' => $v))->order('id desc')->find();

			if ($tradeJson) {
				$addtime = $tradeJson['addtime'];
			}
			else {
				$addtime = M('TradeLog')->where(array('market' => $market))->order('id asc')->getField('addtime');
			}

			if ($addtime) {
				$youtradelog = M('TradeLog')->where('addtime >=' . $addtime . '  and market =\'' . $market . '\'')->sum('num');
			}

			if ($youtradelog) {
				if ($v == 1) {
					$start_time = $addtime;
				}
				else {
					$start_time = mktime(date('H', $addtime), floor(date('i', $addtime) / $v) * $v, 0, date('m', $addtime), date('d', $addtime), date('Y', $addtime));
				}

				for ($x = 0; $x <= 20; $x++) {
					$na = $start_time + (60 * $v * $x);
					$nb = $start_time + (60 * $v * ($x + 1));

					if (time() < $na) {
						break;
					}

					$sum = M('TradeLog')->where('addtime >=' . $na . ' and addtime <' . $nb . ' and market =\'' . $market . '\'')->sum('num');

					if ($sum) {
						$sta = M('TradeLog')->where('addtime >=' . $na . ' and addtime <' . $nb . ' and market =\'' . $market . '\'')->order('id asc')->getField('price');
						$max = M('TradeLog')->where('addtime >=' . $na . ' and addtime <' . $nb . ' and market =\'' . $market . '\'')->max('price');
						$min = M('TradeLog')->where('addtime >=' . $na . ' and addtime <' . $nb . ' and market =\'' . $market . '\'')->min('price');
						$end = M('TradeLog')->where('addtime >=' . $na . ' and addtime <' . $nb . ' and market =\'' . $market . '\'')->order('id desc')->getField('price');
						$d = array($na, $sum, $sta, $max, $min, $end);

						if (M('TradeJson')->where(array('market' => $market, 'addtime' => $na, 'type' => $v))->find()) {
							M('TradeJson')->where(array('market' => $market, 'addtime' => $na, 'type' => $v))->save(array('data' => json_encode($d)));
						}
						else {
							$aa = M('TradeJson')->add(array('market' => $market, 'data' => json_encode($d), 'addtime' => $na, 'type' => $v));
							M('TradeJson')->execute('commit');
							M('TradeJson')->where(array('market' => $market, 'data' => '', 'type' => $v))->delete();
							M('TradeJson')->execute('commit');
						}
					}
					else {
						M('TradeJson')->add(array('market' => $market, 'data' => '', 'addtime' => $na, 'type' => $v));
						M('TradeJson')->execute('commit');
					}
				}
			}
		}

		return '计算成功!';
	}

	public function upTrade($market = NULL)
	{
		$userid = rand(86345, 86355);
		$type = rand(1, 2);

		if (!$market) {
			$market = C('market_mr');
		}
/* [31m * TODO SEPARATE[0m */
/* [31m * TODO SEPARATE[0m */

		$min_price = round(C('market')[$market]['buy_min'] * 100000000);
		$max_price = round(C('market')[$market]['buy_max'] * 100000000);
		$price = round(rand($min_price, $max_price) / 100000000, C('market')[$market]['round']);
		$max_num = round((C('market')[$market]['trade_max'] / C('market')[$market]['buy_max']) * 10000, 4);
		$min_num = round((1 / C('market')[$market]['buy_max']) * 10000, 4);
		$num = round(rand($min_num, $max_num) / 10000, C('market')[$market]['round']);

		if (!$price) {
			return '交易价格格式错误';
		}

		if (!check($num, 'double')) {
			return '交易数量格式错误';
		}

		if (($type != 1) && ($type != 2)) {
			return '交易类型格式错误';
		}

		if (!C('market')[$market]) {
			return '交易市场错误';
		}
		else {
			list($xnb) = explode('_', $market);
			list(, $rmb) = explode('_', $market);
		}

		if (!C('market')[$market]['trade']) {
			return '当前市场禁止交易';
		}
/* [31m * TODO SEPARATE[0m */

		$price = round(floatval($price), C('market')[$market]['round']);

		if (!$price) {
			return '交易价格错误';
		}

		$num = round(trim($num), 8 - C('market')[$market]['round']);

		if (!check($num, 'double')) {
			return '交易数量错误';
		}

		if ($type == 1) {
			$min_price = (C('market')[$market]['buy_min'] ? C('market')[$market]['buy_min'] : 1.0E-8);
			$max_price = (C('market')[$market]['buy_max'] ? C('market')[$market]['buy_max'] : 10000000);
		}
		else if ($type == 2) {
			$min_price = (C('market')[$market]['sell_min'] ? C('market')[$market]['sell_min'] : 1.0E-8);
			$max_price = (C('market')[$market]['sell_max'] ? C('market')[$market]['sell_max'] : 10000000);
		}
		else {
			return '交易类型错误';
		}

		if ($max_price < $price) {
			return '交易价格超过最大限制！';
		}

		if ($price < $min_price) {
			return '交易价格超过最小限制！';
		}

		$hou_price = C('market')[$market]['hou_price'];

		if ($hou_price) {
		}

		$user_coin = M('UserCoin')->where(array('userid' => $userid))->find();

		if ($type == 1) {
			$trade_fee = C('market')[$market]['fee_buy'];

			if ($trade_fee) {
				$fee = round((($num * $price) / 100) * $trade_fee, 8);
				$mum = round((($num * $price) / 100) * (100 + $trade_fee), 8);
			}
			else {
				$fee = 0;
				$mum = round($num * $price, 8);
			}

			if ($user_coin[$rmb] < $mum) {
				return C('coin')[$rmb]['title'] . '余额不足！';
			}
		}
		else if ($type == 2) {
			$trade_fee = C('market')[$market]['fee_sell'];

			if ($trade_fee) {
				$fee = round((($num * $price) / 100) * $trade_fee, 8);
				$mum = round((($num * $price) / 100) * (100 - $trade_fee), 8);
			}
			else {
				$fee = 0;
				$mum = round($num * $price, 8);
			}

			if ($user_coin[$xnb] < $num) {
				return C('coin')[$xnb]['title'] . '余额不足2！';
			}
		}
		else {
			return '交易类型错误';
		}

		if (C('coin')[$xnb]['fee_bili']) {
			if ($type == 2) {
				$bili_user = round($user_coin[$xnb] + $user_coin[$xnb . 'd'], 8);

				if ($bili_user) {
					$bili_keyi = round(($bili_user / 100) * C('coin')[$xnb]['fee_bili'], 8);

					if ($bili_keyi) {
						$bili_zheng = M()->query('select id,price,sum(num-deal)as nums from movesay_trade where userid=' . userid() . ' and status=0 and type=2 and market like \'%' . $xnb . '%\' ;');

						if (!$bili_zheng[0]['nums']) {
							$bili_zheng[0]['nums'] = 0;
						}

						$bili_kegua = $bili_keyi - $bili_zheng[0]['nums'];

						if ($bili_kegua < 0) {
							$bili_kegua = 0;
						}

						if ($bili_kegua < $num) {
							return '您的挂单总数量超过系统限制，您当前持有' . C('coin')[$xnb]['title'] . $bili_user . '个，已经挂单' . $bili_zheng[0]['nums'] . '个，还可以挂单' . $bili_kegua . '个';
						}
					}
					else {
						return '可交易量错误';
					}
				}
			}
		}

		if (C('market')[$market]['trade_min']) {
			if ($mum < C('market')[$market]['trade_min']) {
				return '交易总额不能小于' . C('market')[$market]['trade_min'];
			}
		}

		if (C('market')[$market]['trade_max']) {
			if (C('market')[$market]['trade_max'] < $mum) {
				return '交易总额不能大于' . C('market')[$market]['trade_max'];
			}
		}

		if (!$rmb) {
			return '数据错误1';
		}

		if (!$xnb) {
			return '数据错误2';
		}

		if (!$market) {
			return '数据错误3';
		}

		if (!$price) {
			return '数据错误4';
		}

		if (!$num) {
			return '数据错误5';
		}

		if (!$mum) {
			return '数据错误6';
		}

		if (!$type) {
			return '数据错误7';
		}

		$mo = M();
		$mo->execute('set autocommit=0');
		$mo->execute('lock tables movesay_trade write ,movesay_user_coin write,movesay_finance write');
		$rs = array();

		if ($type == 1) {
			$finance = $mo->table('movesay_finance')->where(array('userid' => userid()))->order('id desc')->find();
			$finance_num_user_coin = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->find();
			$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => $userid))->setDec($rmb, $mum);
			$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => $userid))->setInc($rmb . 'd', $mum);
			$rs[] = $finance_nameid = $mo->table('movesay_trade')->add(array('userid' => $userid, 'market' => $market, 'price' => $price, 'num' => $num, 'mum' => $mum, 'fee' => $fee, 'type' => 1, 'addtime' => time(), 'status' => 0));
			$finance_mum_user_coin = $mo->table('movesay_user_coin')->where(array('userid' => userid()))->find();
			$finance_hash = md5(userid() . $finance_num_user_coin['cny'] . $finance_num_user_coin['cnyd'] . $mum . $finance_mum_user_coin['cny'] . $finance_mum_user_coin['cnyd'] . MSCODE . 'auth.movesay.com');
			$finance_num = $finance_num_user_coin['cny'] + $finance_num_user_coin['cnyd'];

			if ($finance['mum'] < $finance_num) {
				$finance_status = (1 < ($finance_num - $finance['mum']) ? 0 : 1);
			}
			else {
				$finance_status = (1 < ($finance['mum'] - $finance_num) ? 0 : 1);
			}

			$rs[] = $mo->table('movesay_finance')->add(array('userid' => userid(), 'coinname' => 'cny', 'num_a' => $finance_num_user_coin['cny'], 'num_b' => $finance_num_user_coin['cnyd'], 'num' => $finance_num_user_coin['cny'] + $finance_num_user_coin['cnyd'], 'fee' => $mum, 'type' => 2, 'name' => 'trade', 'nameid' => $finance_nameid, 'remark' => '交易中心-委托买入-市场' . $market, 'mum_a' => $finance_mum_user_coin['cny'], 'mum_b' => $finance_mum_user_coin['cnyd'], 'mum' => $finance_mum_user_coin['cny'] + $finance_mum_user_coin['cnyd'], 'move' => $finance_hash, 'addtime' => time(), 'status' => $finance_status));
		}
		else if ($type == 2) {
			$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => $userid))->setDec($xnb, $num);
			$rs[] = $mo->table('movesay_user_coin')->where(array('userid' => $userid))->setInc($xnb . 'd', $num);
			$rs[] = $mo->table('movesay_trade')->add(array('userid' => $userid, 'market' => $market, 'price' => $price, 'num' => $num, 'mum' => $mum, 'fee' => $fee, 'type' => 2, 'addtime' => time(), 'status' => 0));
		}
		else {
			$mo->execute('rollback');
			$mo->execute('unlock tables');
			return '交易类型错误';
		}

		if (check_arr($rs)) {
			$mo->execute('commit');
			$mo->execute('unlock tables');
			A('Trade')->matchingTrade($market);
			return '交易成功！';
		}
		else {
			$mo->execute('rollback');
			$mo->execute('unlock tables');
			return '交易失败！';
		}
	}
}

?>
