<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Admin\Controller;

class ToolsController extends AdminController
{
	public function index()
	{
		$this->checkUpdata();
		$size = $this->getDirSize('./Runtime/');
		$this->assign('cacheSize', round($size / pow(1024, $i = floor(log($size, 1024))), 2));
		$this->display();
	}

	public function delcahe()
	{
		$size = $this->getDirSize('./Runtime/');
		$this->assign('cacheSize', round($size / pow(1024, $i = floor(log($size, 1024))), 2));
		$this->display();
	}

	protected function getDirSize($dir)
	{
		$sizeResult = '';
		$handle = opendir($dir);

		while (false !== ($FolderOrFile = readdir($handle))) {
			if (($FolderOrFile != '.') && ($FolderOrFile != '..')) {
				if (is_dir($dir . '/' . $FolderOrFile)) {
					$sizeResult += $this->getDirSize($dir . '/' . $FolderOrFile);
				}
				else {
					$sizeResult += filesize($dir . '/' . $FolderOrFile);
				}
			}
		}

		closedir($handle);
		return $sizeResult;
	}

	public function delcache()
	{
		$dirs = array('./Runtime/');
		@mkdir('Runtime', 511, true);

		foreach ($dirs as $value) {
			$this->rmdirr($value);
		}

		@mkdir('Runtime', 511, true);
		S(null);//清空所有缓存
		$this->success('系统缓存清除成功！');
	}

	public function invoke()
	{
		$dirs = array('./Runtime/');
		@mkdir('Runtime', 511, true);

		foreach ($dirs as $value) {
			$this->rmdirr($value);
		}

		@mkdir('Runtime', 511, true);
	}

	protected function rmdirr($dirname)
	{
		if (!file_exists($dirname)) {
			return false;
		}

		if (is_file($dirname) || is_link($dirname)) {
			return unlink($dirname);
		}

		$dir = dir($dirname);

		if ($dir) {
			while (false !== ($entry = $dir->read())) {
				if (($entry == '.') || ($entry == '..')) {
					continue;
				}

				$this->rmdirr($dirname . DIRECTORY_SEPARATOR . $entry);
			}
		}

		$dir->close();
		return rmdir($dirname);
	}

	public function dataExport()
	{
		redirect('/Admin/Tools/database?type=export');
	}

	public function dataImport()
	{
		redirect('/Admin/Tools/database?type=import');
	}

	public function database($type = NULL)
	{
		switch ($type) {
		case 'import':
			$path = realpath(DATABASE_PATH);
			$flag = \FilesystemIterator::KEY_AS_FILENAME;
			$glob = new \FilesystemIterator($path, $flag);
			$list = array();

			foreach ($glob as $name => $file) {
				if (preg_match('/^\\d{8,8}-\\d{6,6}-\\d+\\.sql(?:\\.gz)?$/', $name)) {
					$name = sscanf($name, '%4s%2s%2s-%2s%2s%2s-%d');
					$date = $name[0] . '-' . $name[1] . '-' . $name[2];
					$time = $name[3] . ':' . $name[4] . ':' . $name[5];
					$part = $name[6];

					if (isset($list[$date . ' ' . $time])) {
						$info = $list[$date . ' ' . $time];
						$info['part'] = max($info['part'], $part);
						$info['size'] = $info['size'] + $file->getSize();
					}
					else {
						$info['part'] = $part;
						$info['size'] = $file->getSize();
					}

					$extension = strtoupper(pathinfo($file->getFilename(), PATHINFO_EXTENSION));
					$info['compress'] = $extension === 'SQL' ? '-' : $extension;
					$info['time'] = strtotime($date . ' ' . $time);
					$list[$date . ' ' . $time] = $info;
				}
			}

			$title = L('_DATA_REDUCTION_');
			break;

		case 'export':
			$Db = \Think\Db::getInstance();
			$list = $Db->query('SHOW TABLE STATUS');
			$list = array_map('array_change_key_case', $list);
			$title = '数据备份';
			break;

		default:
			$this->error('参数错误！');
		}

		$this->assign('meta_title', $title);
		$this->assign('list', $list);
		$this->display($type);
	}

	public function optimize($tables = NULL)
	{
		if ($tables) {
			$Db = \Think\Db::getInstance();

			if (is_array($tables)) {
				$tables = implode('`,`', $tables);
				$list = $Db->query('OPTIMIZE TABLE `' . $tables . '`');

				if ($list) {
					$this->success('数据表优化完成！');
				}
				else {
					$this->error('数据表优化出错请重试！');
				}
			}
			else {
				$list = $Db->query('OPTIMIZE TABLE `' . $tables . '`');

				if ($list) {
					$this->success('数据表\'' . $tables . '\'优化完成！');
				}
				else {
					$this->error('数据表\'' . $tables . '\'优化出错请重试！');
				}
			}
		}
		else {
			$this->error('请指定要优化的表！');
		}
	}

	public function repair($tables = NULL)
	{
		if ($tables) {
			$Db = \Think\Db::getInstance();

			if (is_array($tables)) {
				$tables = implode('`,`', $tables);
				$list = $Db->query('REPAIR TABLE `' . $tables . '`');

				if ($list) {
					$this->success('数据表修复完成！');
				}
				else {
					$this->error('数据表修复出错请重试！');
				}
			}
			else {
				$list = $Db->query('REPAIR TABLE `' . $tables . '`');

				if ($list) {
					$this->success('数据表\'' . $tables . '\'修复完成！');
				}
				else {
					$this->error('数据表\'' . $tables . '\'修复出错请重试！');
				}
			}
		}
		else {
			$this->error('请指定要修复的表！');
		}
	}

	public function del($time = 0)
	{
		if (APP_DEMO) {
			$this->error('测试站暂时不能修改！');
		}

		if ($time) {
			$name = date('Ymd-His', $time) . '-*.sql*';
			$path = realpath(DATABASE_PATH) . DIRECTORY_SEPARATOR . $name;
			array_map('unlink', glob($path));

			if (count(glob($path))) {
				$this->success('备份文件删除失败，请检查权限！');
			}
			else {
				$this->success('备份文件删除成功！');
			}
		}
		else {
			$this->error('参数错误！');
		}
	}

	public function export($tables = NULL, $id = NULL, $start = NULL)
	{
		if (APP_DEMO) {
			$this->error('测试站暂时不能修改！');
		}

		if (C('web_close')) {
			$this->error('请先关闭网站再备份数据库！');
		}

		if (IS_POST && !empty($tables) && is_array($tables)) {
			$config = array('path' => realpath(DATABASE_PATH) . DIRECTORY_SEPARATOR, 'part' => 20971520, 'compress' => 1, 'level' => 9);
			$lock = $config['path'] . 'backup.lock';

			if (is_file($lock)) {
				$this->error('检测到有一个备份任务正在执行，请稍后再试！');
			}
			else {
				file_put_contents($lock, NOW_TIME);
			}

			is_writeable($config['path']) || $this->error('备份目录不存在或不可写，请检查后重试！');
			session('backup_config', $config);
			$file = array('name' => date('Ymd-His', NOW_TIME), 'part' => 1);
			session('backup_file', $file);
			session('backup_tables', $tables);
			$Database = new \OT\Database($file, $config);

			if (false !== $Database->create()) {
				$tab = array('id' => 0, 'start' => 0);
				$this->success('初始化成功！', '', array('tables' => $tables, 'tab' => $tab));
			}
			else {
				$this->error('初始化失败，备份文件创建失败！');
			}
		}
		else {
			if (IS_GET && is_numeric($id) && is_numeric($start)) {
				$tables = session('backup_tables');
				$Database = new \OT\Database(session('backup_file'), session('backup_config'));
				$start = $Database->backup($tables[$id], $start);

				if (false === $start) {
					$this->error('备份出错！');
				}
				else if (0 === $start) {
					if (isset($tables[++$id])) {
						$tab = array('id' => $id, 'start' => 0);
						$this->success('备份完成！', '', array('tab' => $tab));
					}
					else {
						unlink(session('backup_config.path') . 'backup.lock');
						session('backup_tables', null);
						session('backup_file', null);
						session('backup_config', null);
						$this->success('备份完成！');
					}
				}
				else {
					$tab = array('id' => $id, 'start' => $start[0]);
					$rate = floor(100 * ($start[0] / $start[1]));
					$this->success('正在备份...(' . $rate . '%)', '', array('tab' => $tab));
				}
			}
			else {
				$this->error('参数错误！');
			}
		}
	}

	public function import($time = 0, $part = NULL, $start = NULL)
	{
		if (APP_DEMO) {
			$this->error('测试站暂时不能修改！');
		}

		if (C('web_close')) {
			$this->error('请先关闭网站再还原数据库！');
		}

		if (is_numeric($time) && is_null($part) && is_null($start)) {
			$name = date('Ymd-His', $time) . '-*.sql*';
			$path = realpath(DATABASE_PATH) . DIRECTORY_SEPARATOR . $name;
			$files = glob($path);
			$list = array();

			foreach ($files as $name) {
				$basename = basename($name);
				$match = sscanf($basename, '%4s%2s%2s-%2s%2s%2s-%d');
				$gz = preg_match('/^\\d{8,8}-\\d{6,6}-\\d+\\.sql.gz$/', $basename);
				$list[$match[6]] = array($match[6], $name, $gz);
			}

			ksort($list);
			$last = end($list);

			if (count($list) === $last[0]) {
				session('backup_list', $list);
				$this->success('初始化完成！', '', array('part' => 1, 'start' => 0));
			}
			else {
				$this->error('备份文件可能已经损坏，请检查！');
			}
		}
		else {
			if (is_numeric($part) && is_numeric($start)) {
				$list = session('backup_list');
				$db = new \OT\Database($list[$part], array('path' => realpath(DATABASE_PATH) . DIRECTORY_SEPARATOR, 'compress' => 1, 'level' => 9));
				$start = $db->import($start);

				if (false === $start) {
					$this->error('还原数据出错！');
				}
				else if (0 === $start) {
					if (isset($list[++$part])) {
						$data = array('part' => $part, 'start' => 0);
						$this->success('正在还原...#' . $part, '', $data);
					}
					else {
						session('backup_list', null);
						$this->success('还原完成！');
					}
				}
				else {
					$data = array('part' => $part, 'start' => $start[0]);

					if ($start[1]) {
						$rate = floor(100 * ($start[0] / $start[1]));
						$this->success('正在还原...#' . $part . ' (' . $rate . '%)', '', $data);
					}
					else {
						$data['gz'] = 1;
						$this->success('正在还原...#' . $part, '', $data);
					}
				}
			}
			else {
				$this->error('参数错误！');
			}
		}
	}

	public function excel($tables = NULL)
	{
		if ($tables) {
			if (APP_DEMO) {
				$this->error('测试站暂时不能修改！');
			}

			$mo = M();
			$mo->execute('set autocommit=0');
			$mo->execute('lock tables ' . $tables . ' write');
			$rs = $mo->table($tables)->select();
			$zd = $mo->table($tables)->getDbFields();

			if ($rs) {
				$mo->execute('commit');
				$mo->execute('unlock tables');
			}
			else {
				$mo->execute('rollback');
			}

			$xlsName = $tables;
			$xls = array();

			foreach ($zd as $k => $v) {
				$xls[$k][0] = $v;
				$xls[$k][1] = $v;
			}

			$this->exportExcel($xlsName, $xls, $rs);
		}
		else {
			$this->error('请指定要导出的表！');
		}
	}

	public function exportExcel($expTitle, $expCellName, $expTableData)
	{
		import('Org.Util.PHPExcel');
		import('Org.Util.PHPExcel.Writer.Excel5');
		import('Org.Util.PHPExcel.IOFactory.php');
		$xlsTitle = iconv('utf-8', 'gb2312', $expTitle);
		$fileName = $_SESSION['loginAccount'] . date('_YmdHis');
		$cellNum = count($expCellName);
		$dataNum = count($expTableData);
		$objPHPExcel = new \PHPExcel();
		$cellName = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AL', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ');
		$objPHPExcel->getActiveSheet(0)->mergeCells('A1:' . $cellName[$cellNum - 1] . '1');
		$objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', $expTitle . '  Export time:' . date('Y-m-d H:i:s'));

		for ($i = 0; $i < $cellNum; $i++) {
			$objPHPExcel->setActiveSheetIndex(0)->setCellValue($cellName[$i] . '2', $expCellName[$i][1]);
		}

		for ($i = 0; $i < $dataNum; $i++) {
			for ($j = 0; $j < $cellNum; $j++) {
				$objPHPExcel->getActiveSheet(0)->setCellValue($cellName[$j] . ($i + 3), $expTableData[$i][$expCellName[$j][0]]);
			}
		}

		ob_end_clean();
		header('pragma:public');
		header('Content-type:application/vnd.ms-excel;charset=utf-8;name="' . $xlsTitle . '.xls"');
		header('Content-Disposition:attachment;filename=' . $fileName . '.xls');
		$objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
		$objWriter->save('php://output');
		exit();
	}

	public function importExecl($file)
	{
		import('Org.Util.PHPExcel');
		import('Org.Util.PHPExcel.Writer.Excel5');
		import('Org.Util.PHPExcel.IOFactory.php');

		if (!file_exists($file)) {
			return array('error' => 0, 'message' => 'file not found!');
		}

		$objReader = PHPExcel_IOFactory::createReader('Excel5');

		try {
			$PHPReader = $objReader->load($file);
		}
		catch (Exception $e) {
		}

		if (!isset($PHPReader)) {
			return array('error' => 0, 'message' => 'read error!');
		}

		$allWorksheets = $PHPReader->getAllSheets();
		$i = 0;

		foreach ($allWorksheets as $objWorksheet) {
			$sheetname = $objWorksheet->getTitle();
			$allRow = $objWorksheet->getHighestRow();
			$highestColumn = $objWorksheet->getHighestColumn();
			$allColumn = PHPExcel_Cell::columnIndexFromString($highestColumn);
			$array[$i]['Title'] = $sheetname;
			$array[$i]['Cols'] = $allColumn;
			$array[$i]['Rows'] = $allRow;
			$arr = array();
			$isMergeCell = array();

			foreach ($objWorksheet->getMergeCells() as $cells) {
				foreach (PHPExcel_Cell::extractAllCellReferencesInRange($cells) as $cellReference) {
					$isMergeCell[$cellReference] = true;
				}
			}

			for ($currentRow = 1; $currentRow <= $allRow; $currentRow++) {
				$row = array();

				for ($currentColumn = 0; $currentColumn < $allColumn; $currentColumn++) {
					$cell = $objWorksheet->getCellByColumnAndRow($currentColumn, $currentRow);
					$afCol = PHPExcel_Cell::stringFromColumnIndex($currentColumn + 1);
					$bfCol = PHPExcel_Cell::stringFromColumnIndex($currentColumn - 1);
					$col = PHPExcel_Cell::stringFromColumnIndex($currentColumn);
					$address = $col . $currentRow;
					$value = $objWorksheet->getCell($address)->getValue();

					if (substr($value, 0, 1) == '=') {
						return array('error' => 0, 'message' => 'can not use the formula!');
						exit();
					}

					if ($cell->getDataType() == PHPExcel_Cell_DataType::TYPE_NUMERIC) {
						$cellstyleformat = $cell->getParent()->getStyle($cell->getCoordinate())->getNumberFormat();
						$formatcode = $cellstyleformat->getFormatCode();

						if (preg_match('/^([$[A-Z]*-[0-9A-F]*])*[hmsdy]/i', $formatcode)) {
							$value = gmdate('Y-m-d', PHPExcel_Shared_Date::ExcelToPHP($value));
						}
						else {
							$value = PHPExcel_Style_NumberFormat::toFormattedString($value, $formatcode);
						}
					}

					if ($isMergeCell[$col . $currentRow] && $isMergeCell[$afCol . $currentRow] && !empty($value)) {
						$temp = $value;
					}
					else {
						if ($isMergeCell[$col . $currentRow] && $isMergeCell[$col . ($currentRow - 1)] && empty($value)) {
							$value = $arr[$currentRow - 1][$currentColumn];
						}
						else {
							if ($isMergeCell[$col . $currentRow] && $isMergeCell[$bfCol . $currentRow] && empty($value)) {
								$value = '';
							}
						}
					}

					$row[$currentColumn] = $value;
				}

				$arr[$currentRow] = $row;
			}

			$array[$i]['Content'] = $arr;
			$i++;
		}

		spl_autoload_register(array('Think', 'autoload'));
		unset($objWorksheet);
		unset($PHPReader);
		unset($PHPExcel);
		unlink($file);
		return array('error' => 1, 'data' => $array);
	}

	public function xiazai()
	{
		if (APP_DEMO) {
			$this->error('测试站暂时不能修改！');
		}

		if (!check($_GET['file'], 'dw', '-.')) {
			$this->error('失败！');
		}

		DownloadFile(DATABASE_PATH . $_GET['file']);
		exit();
	}

	public function queue()
	{
		$file_path = DATABASE_PATH . '/check_queue.json';
		$time = time();
		$timeArr = array();

		if (file_exists($file_path)) {
			$timeArr = file_get_contents($file_path);
			$timeArr = json_decode($timeArr, true);
		}

		$str = '';

		foreach ($timeArr as $key => $val) {
			if ($key == 0) {
				$val = '上一次执行:' . addtime($val);
			}

			if ($key == 1) {
				$val = '上二次执行:' . addtime($val);
			}

			if ($key == 2) {
				$val = '上三次执行:' . addtime($val);
			}

			$str .= $val . ' ';
		}

		$status = '';
		$count = count($timeArr);

		if (3 <= $count) {
			$_t1 = $timeArr[2] - $timeArr[1];
			$_t2 = $timeArr[1] - $timeArr[0];

			if (60 < abs($timeArr[0] - time())) {
				$status = '<span class="btn btn-warning">队列停止运行</span>';
			}

			if ((50 < abs($_t1)) && (50 < abs($_t2))) {
				$status = '<span class="btn">队列运行正常</span>';
			}
			else {
				$status = '<span class="btn btn-warning">队列时间异常,请稍后再试</span>';
			}
		}
		else {
			$msg = '';

			if ($count == 0) {
				$msg = '队列还未开始运行,请1分钟后刷新';
			}

			if ($count == 1) {
				$msg = '队列运行一次请再等待2分钟检查';
			}

			if ($count == 2) {
				$msg = '队列运行两次请再等待1分钟检查';
			}

			$status = '<span class="btn btn-warning">' . $msg . '</span>';
		}

		$this->assign('status', $status);
		$this->assign('str', $str);
		$this->display();
		return NULL;
	}

	public function qianbao($id = NULL)
	{
		$s_key = md5('ToolsQianbao');
		$qb_list = S($s_key);

		if (!$qb_list) {
			$qb_list = M('Coin')->where(array('type' => 'qbb'))->select();
			S($s_key, $qb_list);
		}

		if ($id === null) {
			S($s_key, null);
			$this->assign('list_len', count($qb_list));
			$this->display();
			exit();
		}

		if ($id == -1) {
			$dirs = array('./Runtime/');
			@mkdir('Runtime', 511, true);

			foreach ($dirs as $value) {
				$this->rmdirr($value);
			}

			@mkdir('Runtime', 511, true);
			echo json_encode(array('status' => 1, 'info' => '缓存清除成功'));
			exit();
		}

		$update_str = '&nbsp;&nbsp;&nbsp;<a href="' . U('Coin/edit', array('id' => $qb_list[$id]['id'])) . '" color="green" target="_black">立即前往修改<a>';

		if (isset($qb_list[$id])) {
			if ($qb_list[$id]['status']) {
				if ($qb_list[$id]['zr_dz'] <= 0) {
					echo json_encode(array('status' => -2, 'info' => $qb_list[$id]['title'] . '钱包确认次数不能为空' . $update_str));
					exit();
				}

				if ($qb_list[$id]['zc_zd'] <= 10) {
					echo json_encode(array('status' => -2, 'info' => $qb_list[$id]['title'] . '钱包自动转出限额太小,建议10个以上' . $update_str));
					exit();
				}

				$CoinClient = CoinClient($qb_list[$id]['dj_yh'], $qb_list[$id]['dj_mm'], $qb_list[$id]['dj_zj'], $qb_list[$id]['dj_dk'], 3, array(), 1);
				$json = $CoinClient->getinfo();

				if ($json) {
					if ($tmp = json_decode($json, true)) {
						$json = $tmp;
					}
				}

				if (!isset($json['version']) || !$json['version']) {
					echo json_encode(array('status' => -2, 'info' => $qb_list[$id]['title'] . '服务器返回错误:' . $json['data'] . $update_str));
					exit();
				}
				else {
					echo json_encode(array('status' => 1, 'info' => $qb_list[$id]['title'] . '运行正常'));
					exit();
				}
			}
			else {
				echo json_encode(array('status' => -1, 'info' => $qb_list[$id]['title'] . '已经禁用,不用检查'));
			}
		}
		else {
			echo json_encode(array('status' => 100, 'info' => '全部检查完毕'));
			exit();
		}
	}

	public function jiancha($id = NULL)
	{
		if ($id === null) {
			$this->display();
			exit();
		}

		if ($id == -1) {
			$dirs = array('./Runtime/');
			@mkdir('Runtime', 511, true);

			foreach ($dirs as $value) {
			}

			@mkdir('Runtime', 511, true);
			echo json_encode(array('status' => 1, 'info' => '缓存清除成功'));
			exit();
		}

		if ((0 <= $id) && ($id <= 19)) {
			$dirfile = check_dirfile();
			echo json_encode(array('status' => $dirfile[$id][2] == 'ok' ? 1 : -2, 'info' => $dirfile[$id][3] . $dirfile[$id][1]));
			exit();
		}

		if (19 < $id) {
			echo json_encode(array('status' => 100, 'info' => '检查完成'));
			exit();
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
	}

	public function checkUpdata()
	{
		if (!S(MODULE_NAME . CONTROLLER_NAME . 'checkUpdata')) {
			$list = M('Menu')->where(array(
	'url' => 'Tools/index',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Tools/index', 'title' => '清理缓存', 'pid' => 9, 'sort' => 1, 'hide' => 0, 'group' => '工具', 'ico_name' => 'wrench'));
			}
			else {
				M('Menu')->where(array(
	'url' => 'Tools/index',
	'pid' => array('neq', 0)
	))->save(array('title' => '清理缓存', 'pid' => 9, 'sort' => 1, 'hide' => 0, 'group' => '工具', 'ico_name' => 'wrench'));
			}

			$list = M('Menu')->where(array(
	'url' => 'Tools/dataExport',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Tools/dataExport', 'title' => '备份数据库', 'pid' => 9, 'sort' => 2, 'hide' => 0, 'group' => '工具', 'ico_name' => 'wrench'));
			}
			else {
				M('Menu')->where(array(
	'url' => 'Tools/dataExport',
	'pid' => array('neq', 0)
	))->save(array('title' => '备份数据库', 'pid' => 9, 'sort' => 2, 'hide' => 0, 'group' => '工具', 'ico_name' => 'wrench'));
			}

			$list = M('Menu')->where(array(
	'url' => 'Tools/dataImport',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Tools/dataImport', 'title' => '还原数据库', 'pid' => 9, 'sort' => 2, 'hide' => 0, 'group' => '工具', 'ico_name' => 'wrench'));
			}
			else {
				M('Menu')->where(array(
	'url' => 'Tools/dataImport',
	'pid' => array('neq', 0)
	))->save(array('title' => '还原数据库', 'pid' => 9, 'sort' => 2, 'hide' => 0, 'group' => '工具', 'ico_name' => 'wrench'));
			}

			$list = M('Menu')->where(array(
	'url' => 'Tools/queue',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Tools/queue', 'title' => '服务器队列', 'pid' => 9, 'sort' => 3, 'hide' => 0, 'group' => '工具', 'ico_name' => 'wrench'));
			}
			else {
				M('Menu')->where(array(
	'url' => 'Tools/queue',
	'pid' => array('neq', 0)
	))->save(array('title' => '服务器队列', 'pid' => 9, 'sort' => 3, 'hide' => 0, 'group' => '工具', 'ico_name' => 'wrench'));
			}

			$list = M('Menu')->where(array(
	'url' => 'Tools/qianbao',
	'pid' => array('neq', 0)
	))->select();

			if ($list[1]) {
				M('Menu')->where(array('id' => $list[1]['id']))->delete();
			}
			else if (!$list) {
				M('Menu')->add(array('url' => 'Tools/qianbao', 'title' => '钱包检查', 'pid' => 9, 'sort' => 3, 'hide' => 0, 'group' => '工具', 'ico_name' => 'wrench'));
			}
			else {
				M('Menu')->where(array(
	'url' => 'Tools/qianbao',
	'pid' => array('neq', 0)
	))->save(array('title' => '钱包检查', 'pid' => 9, 'sort' => 3, 'hide' => 0, 'group' => '工具', 'ico_name' => 'wrench'));
			}

			if (M('Menu')->where(array('url' => 'Tools/delcahe'))->delete()) {
				M('AuthRule')->where(array('status' => 1))->delete();
			}

			if (M('Menu')->where(array('url' => 'Tools/database?type=export'))->delete()) {
				M('AuthRule')->where(array('status' => 1))->delete();
			}

			if (M('Menu')->where(array('url' => 'Tools/database?type=import'))->delete()) {
				M('AuthRule')->where(array('status' => 1))->delete();
			}

			$DbFields = M('VersionGame')->getDbFields();

			if (!in_array('class', $DbFields)) {
				M()->execute('ALTER TABLE `movesay_version_game` ADD COLUMN `class` VARCHAR(200) DEFAULT \'\' NOT NULL   COMMENT \'\' AFTER `title`;');
			}

			if (!in_array('shuoming', $DbFields)) {
				M()->execute('ALTER TABLE `movesay_version_game` ADD COLUMN `shuoming` VARCHAR(200) DEFAULT \'\' NOT NULL   COMMENT \'\' AFTER `title`;');
			}

			if (!in_array('gongsi', $DbFields)) {
				M()->execute('ALTER TABLE `movesay_version_game` ADD COLUMN `gongsi` VARCHAR(200) DEFAULT \'\' NOT NULL   COMMENT \'\' AFTER `title`;');
			}

			S(MODULE_NAME . CONTROLLER_NAME . 'checkUpdata', 1);
		}
	}
}

?>
