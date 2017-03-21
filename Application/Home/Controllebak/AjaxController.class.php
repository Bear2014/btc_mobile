<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Home\Controller;

use Common;

class AjaxController extends HomeController
{
	public function getJsonMenu($ajax = 'json')
	{
		$data = (APP_DEBUG ? null : S('getJsonMenu'));

		if (!$data) {
			foreach (C('market') as $k => $v) {
				list($v['xnb']) = explode('_', $v['name']);
				list(, $v['rmb']) = explode('_', $v['name']);
				$data[$k]['name'] = $v['name'];
				$data[$k]['img'] = $v['xnbimg'];
				$data[$k]['title'] = $v['title'];
			}

			S('getJsonMenu', $data);
		}

		if ($ajax) {
			exit(json_encode($data));
		}
		else {
			return $data;
		}
	}

	public function allfinance($ajax = 'json')
	{
		if (!userid()) {
			return false;
		}

		$UserCoin = M('UserCoin')->where(array('userid' => userid()))->find();
		$cny['zj'] = 0;

		foreach (C('coin') as $k => $v) {
			if ($v['name'] == 'cny') {
				$cny['ky'] = $UserCoin[$v['name']] * 1;
				$cny['dj'] = $UserCoin[$v['name'] . 'd'] * 1;
				$cny['zj'] = $cny['zj'] + $cny['ky'] + $cny['dj'];
			}
			else {
				if (C('market')[$v['name'] . '_cny']['new_price']) {
					$jia = C('market')[$v['name'] . '_cny']['new_price'];
				}
				else {
					$jia = 1;
				}

				$cny['zj'] = round($cny['zj'] + (($UserCoin[$v['name']] + $UserCoin[$v['name'] . 'd']) * $jia), 2) * 1;
			}
		}

		$data = round($cny['zj'], 8);
		$data = NumToStr($data);

		if ($ajax) {
			exit(json_encode($data));
		}
		else {
			return $data;
		}
	}

	public function allsum($ajax = 'json')
	{
		$data = (APP_DEBUG ? null : S('allsum'));

		if (!$data) {
			$data = M('TradeLog')->sum('mum');
			S('allsum', $data);
		}

		$data = round($data);
		$data = str_repeat('0', 12 - strlen($data)) . (string) $data;

		if ($ajax) {
			exit(json_encode($data));
		}
		else {
			return $data;
		}
	}

	public function allcoin($ajax = 'json')
	{
		$data = (APP_DEBUG ? null : S('allcoin'));

		if (!$data) {
			foreach (C('market') as $k => $v) {
				$data[$k][0] = $v['title'];
				$data[$k][1] = round($v['new_price'], $v['round']);
				$data[$k][2] = round($v['buy_price'], $v['round']);
				$data[$k][3] = round($v['sell_price'], $v['round']);
				$data[$k][4] = round($v['volume'] * $v['new_price'], 2) * 1;
				$data[$k][5] = '';
				$data[$k][6] = round($v['volume'], 2) * 1;
				$data[$k][7] = round($v['change'], 2);
				$data[$k][8] = $v['name'];
				$data[$k][9] = $v['xnbimg'];
				$data[$k][10] = '';
			}

			S('allcoin', $data);
		}

		if ($ajax) {
			exit(json_encode($data));
		}
		else {
			return $data;
		}
	}

	public function trends($ajax = 'json')
	{
		$data = (APP_DEBUG ? null : S('trends'));

		if (!$data) {
			foreach (C('market') as $k => $v) {
				$tendency = json_decode($v['tendency'], true);
				$data[$k]['data'] = $tendency;
				$data[$k]['yprice'] = $v['new_price'];
			}

			S('trends', $data);
		}

		if ($ajax) {
			exit(json_encode($data));
		}
		else {
			return $data;
		}
	}

	public function getJsonTop($market = NULL, $ajax = 'json')
	{
		$data = (APP_DEBUG ? null : S('getJsonTop' . $market));

		if (!$data) {
			if ($market) {
				list($xnb) = explode('_', $market);
				list(, $rmb) = explode('_', $market);

				foreach (C('market') as $k => $v) {
					list($v['xnb']) = explode('_', $v['name']);
					list(, $v['rmb']) = explode('_', $v['name']);
					$data['list'][$k]['name'] = $v['name'];
					$data['list'][$k]['img'] = $v['xnbimg'];
					$data['list'][$k]['title'] = $v['title'];
					$data['list'][$k]['new_price'] = $v['new_price'];
				}

				$data['info']['img'] = C('market')[$market]['xnbimg'];
				$data['info']['title'] = C('market')[$market]['title'];
				$data['info']['new_price'] = C('market')[$market]['new_price'];
				$data['info']['max_price'] = C('market')[$market]['max_price'];
				$data['info']['min_price'] = C('market')[$market]['min_price'];
				$data['info']['buy_price'] = C('market')[$market]['buy_price'];
				$data['info']['sell_price'] = C('market')[$market]['sell_price'];
				$data['info']['volume'] = C('market')[$market]['volume'];
				$data['info']['change'] = C('market')[$market]['change'];
				S('getJsonTop' . $market, $data);
			}
		}

		if ($ajax) {
			exit(json_encode($data));
		}
		else {
			return $data;
		}
	}

	public function getTradelog($market = NULL, $ajax = 'json')
	{
		$data = (APP_DEBUG ? null : S('getTradelog' . $market));

		if (!$data) {
			$tradeLog = M('TradeLog')->where(array('status' => 1, 'market' => $market))->order('id desc')->limit(50)->select();

			if ($tradeLog) {
				foreach ($tradeLog as $k => $v) {
					$data['tradelog'][$k]['addtime'] = date('m-d H:i:s', $v['addtime']);
					$data['tradelog'][$k]['type'] = $v['type'];
					$data['tradelog'][$k]['price'] = $v['price'] * 1;
					$data['tradelog'][$k]['num'] = round($v['num'], 6);
					$data['tradelog'][$k]['mum'] = round($v['mum'], 6);
				}

				S('getTradelog' . $market, $data);
			}
		}

		if ($ajax) {
			exit(json_encode($data));
		}
		else {
			return $data;
		}
	}

	public function getDepth($market = NULL, $trade_moshi = 1, $ajax = 'json')
	{
		if (!C('market')[$market]) {
			return null;
		}

		$data_getDepth = (APP_DEBUG ? null : S('getDepth'));

		if (!$data_getDepth[$market][$trade_moshi]) {
			if ($trade_moshi == 1) {
				$limt = 12;
			}

			if (($trade_moshi == 3) || ($trade_moshi == 4)) {
				$limt = 25;
			}

			$mo = M();

			if ($trade_moshi == 1) {
				$buy = $mo->query('select id,price,sum(num-deal)as nums from movesay_trade where status=0 and type=1 and market =\'' . $market . '\' group by price order by price desc limit ' . $limt . ';');
				$sell = array_reverse($mo->query('select id,price,sum(num-deal)as nums from movesay_trade where status=0 and type=2 and market =\'' . $market . '\' group by price order by price asc limit ' . $limt . ';'));
			}

			if ($trade_moshi == 3) {
				$buy = $mo->query('select id,price,sum(num-deal)as nums from movesay_trade where status=0 and type=1 and market =\'' . $market . '\' group by price order by price desc limit ' . $limt . ';');
				$sell = null;
			}

			if ($trade_moshi == 4) {
				$buy = null;
				$sell = array_reverse($mo->query('select id,price,sum(num-deal)as nums from movesay_trade where status=0 and type=2 and market =\'' . $market . '\' group by price order by price asc limit ' . $limt . ';'));
			}

			if ($buy) {
				foreach ($buy as $k => $v) {
					$data['depth']['buy'][$k] = array(floatval($v['price'] * 1), floatval($v['nums'] * 1));
				}
			}
			else {
				$data['depth']['buy'] = '';
			}

			if ($sell) {
				foreach ($sell as $k => $v) {
					$data['depth']['sell'][$k] = array(floatval($v['price'] * 1), floatval($v['nums'] * 1));
				}
			}
			else {
				$data['depth']['sell'] = '';
			}

			$data_getDepth[$market][$trade_moshi] = $data;
			S('getDepth', $data_getDepth);
		}
		else {
			$data = $data_getDepth[$market][$trade_moshi];
		}

		if ($ajax) {
			exit(json_encode($data));
		}
		else {
			return $data;
		}
	}

	public function getEntrustAndUsercoin($market = NULL, $ajax = 'json')
	{
		if (!userid()) {
			return null;
		}

		if (!C('market')[$market]) {
			return null;
		}

		$result = M()->query('select id,price,num,deal,mum,type,fee,status,addtime from movesay_trade where status=0 and market=\'' . $market . '\' and userid=' . userid() . ' order by id desc limit 10;');

		if ($result) {
			foreach ($result as $k => $v) {
				$data['entrust'][$k]['addtime'] = date('m-d H:i:s', $v['addtime']);
				$data['entrust'][$k]['type'] = $v['type'];
				$data['entrust'][$k]['price'] = $v['price'] * 1;
				$data['entrust'][$k]['num'] = round($v['num'], 6);
				$data['entrust'][$k]['deal'] = round($v['deal'], 6);
				$data['entrust'][$k]['id'] = round($v['id']);
			}
		}
		else {
			$data['entrust'] = null;
		}

		$userCoin = M('UserCoin')->where(array('userid' => userid()))->find();

		if ($userCoin) {
			list($xnb) = explode('_', $market);
			list(, $rmb) = explode('_', $market);
			$data['usercoin']['xnb'] = floatval($userCoin[$xnb]);
			$data['usercoin']['xnbd'] = floatval($userCoin[$xnb . 'd']);
			$data['usercoin']['cny'] = floatval($userCoin[$rmb]);
			$data['usercoin']['cnyd'] = floatval($userCoin[$rmb . 'd']);
		}
		else {
			$data['usercoin'] = null;
		}

		if ($ajax) {
			exit(json_encode($data));
		}
		else {
			return $data;
		}
	}

	public function getChat($ajax = 'json')
	{
		$chat = (APP_DEBUG ? null : S('getChat'));

		if (!$chat) {
			$chat = M('Chat')->where(array('status' => 1))->order('id desc')->limit(500)->select();
			S('getChat', $chat);
		}

		asort($chat);

		if ($chat) {
			foreach ($chat as $k => $v) {
				$data[] = array((int) $v['id'], $v['username'], $v['content']);
			}
		}
		else {
			$data = '';
		}

		if ($ajax) {
			exit(json_encode($data));
		}
		else {
			return $data;
		}
	}

	public function upChat($content)
	{
		if (!userid()) {
			$this->error('请先登录...');
		}

		$content = msubstr($content, 0, 20, 'utf-8', false);

		if (!$content) {
			$this->error('请先输入内容');
		}

		if (time() < (session('chat' . userid()) + 10)) {
			$this->error('不能发送过快');
		}

		$id = M('Chat')->add(array('userid' => userid(), 'username' => username(), 'content' => $content, 'addtime' => time(), 'status' => 1));

		if ($id) {
			S('getChat', null);
			session('chat' . userid(), time());
			$this->success($id);
		}
		else {
			$this->error('发送失败');
		}
	}

	public function upcomment($msgaaa, $s1, $s2, $s3, $xnb)
	{
		if (empty($msgaaa)) {
			$this->error('提交内容错误');
		}

		if (!check($s1, 'd')) {
			$this->error('技术评分错误');
		}

		if (!check($s2, 'd')) {
			$this->error('应用评分错误');
		}

		if (!check($s3, 'd')) {
			$this->error('前景评分错误');
		}

		if (!userid()) {
			$this->error('请先登录！');
		}

		if (M('CoinComment')->where(array(
	'userid'   => userid(),
	'coinname' => $xnb,
	'addtime'  => array('gt', time() - 60)
	))->find()) {
			$this->error('请不要频繁提交！');
		}

		if (M('Coin')->where(array('name' => $xnb))->save(array(
	'tp_zs' => array('exp', 'tp_zs+1'),
	'tp_js' => array('exp', 'tp_js+' . $s1),
	'tp_yy' => array('exp', 'tp_yy+' . $s2),
	'tp_qj' => array('exp', 'tp_qj+' . $s3)
	))) {
			if (M('CoinComment')->add(array('userid' => userid(), 'coinname' => $xnb, 'content' => $msgaaa, 'addtime' => time(), 'status' => 1))) {
				$this->success('提交成功');
			}
			else {
				$this->error('提交失败！');
			}
		}
		else {
			$this->error('提交失败！');
		}
	}

	public function subcomment($id, $type)
	{
		if ($type != 1) {
			if ($type != 2) {
				if ($type != 3) {
					$this->error('参数错误！');
				}
				else {
					$type = 'xcd';
				}
			}
			else {
				$type = 'tzy';
			}
		}
		else {
			$type = 'cjz';
		}

		if (!check($id, 'd')) {
			$this->error('参数错误1');
		}

		if (!userid()) {
			$this->error('请先登录！');
		}

		if (S('subcomment' . userid() . $id)) {
			$this->error('请不要频繁提交！');
		}

		if (M('CoinComment')->where(array('id' => $id))->setInc($type, 1)) {
			S('subcomment' . userid() . $id, 1);
			$this->success('提交成功');
		}
		else {
			$this->error('提交失败！');
		}
	}
	
	public function translate($src = '')
	{
	    //当前环境为中文，则不进行翻译
	    if(constant('LANG_SET') == 'zh-cn'){
	        exit($src);
	    }
	        
	    $data = (APP_DEBUG ? null : S('en.'.$src));
	
	    if (!$data) {
	        $data = \Common\Ext\Translate::exec($src);
	        S('en.'.$src, $data);
	    }
	
	    exit($data);
	}
}

?>
