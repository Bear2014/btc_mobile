<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Common\Model;

class CategoryModel extends \Think\Model
{
	protected $_validate = array(
		array('name', 'require', '标识不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
		array('name', '', '标识已经存在', self::VALUE_VALIDATE, 'unique', self::MODEL_BOTH),
		array('title', 'require', '名称不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
		array('meta_title', '1,50', '网页标题不能超过50个字符', self::VALUE_VALIDATE, 'length', self::MODEL_BOTH),
		array('keywords', '1,255', '网页关键字不能超过255个字符', self::VALUE_VALIDATE, 'length', self::MODEL_BOTH),
		array('meta_title', '1,255', '网页描述不能超过255个字符', self::VALUE_VALIDATE, 'length', self::MODEL_BOTH)
		);
	protected $_auto = array(
		array('model', 'arr2str', self::MODEL_BOTH, 'function'),
		array('model', NULL, self::MODEL_BOTH, 'ignore'),
		array('type', 'arr2str', self::MODEL_BOTH, 'function'),
		array('type', NULL, self::MODEL_BOTH, 'ignore'),
		array('reply_model', 'arr2str', self::MODEL_BOTH, 'function'),
		array('reply_model', NULL, self::MODEL_BOTH, 'ignore'),
		array('extend', 'json_encode', self::MODEL_BOTH, 'function'),
		array('extend', NULL, self::MODEL_BOTH, 'ignore'),
		array('create_time', NOW_TIME, self::MODEL_INSERT),
		array('update_time', NOW_TIME, self::MODEL_BOTH),
		array('status', '1', self::MODEL_BOTH),
		);

	public function info($id, $field = true)
	{
		$map = array();

		if (is_numeric($id)) {
			$map['id'] = $id;
		}
		else {
			$map['name'] = $id;
		}

		return $this->field($field)->where($map)->find();
	}

	public function getTree($id = 0, $field = true)
	{
		if ($id) {
			$info = $this->info($id);
			$id = $info['id'];
		}

		$map = array(
			'status' => array('gt', -1)
			);
		$list = $this->field($field)->where($map)->order('sort')->select();
		$list = list_to_tree($list, $pk = 'id', $pid = 'pid', $child = '_', $root = $id);

		if (isset($info)) {
			$info['_'] = $list;
		}
		else {
			$info = $list;
		}

		return $info;
	}

	public function getSameLevel($id, $field = true)
	{
		$info = $this->info($id, 'pid');
		$map = array('pid' => $info['pid'], 'status' => 1);
		return $this->field($field)->where($map)->order('sort')->select();
	}

	public function update()
	{
		$data = $this->create();

		if (!$data) {
			return false;
		}

		if (empty($data['id'])) {
			$res = $this->add();
		}
		else {
			$res = $this->save();
		}

		S('sys_category_list', null);
		action_log('update_category', 'category', $data['id'] ? $data['id'] : $res, UID);
		return $res;
	}

	protected function _after_find(&$data, $options)
	{
		if (!empty($data['model'])) {
			$data['model'] = explode(',', $data['model']);
		}

		if (!empty($data['type'])) {
			$data['type'] = explode(',', $data['type']);
		}

		if (!empty($data['reply_model'])) {
			$data['reply_model'] = explode(',', $data['reply_model']);
		}

		if (!empty($data['reply_type'])) {
			$data['reply_type'] = explode(',', $data['reply_type']);
		}

		if (!empty($data['extend'])) {
			$data['extend'] = json_decode($data['extend'], true);
		}
	}
}

?>
