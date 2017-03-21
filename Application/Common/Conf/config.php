<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
return array(
	'DB_TYPE'              => DB_TYPE,
	'DB_HOST'              => DB_HOST,
	'DB_NAME'              => DB_NAME,
	'DB_USER'              => DB_USER,
	'DB_PWD'               => DB_PWD,
	'DB_PORT'              => DB_PORT,
	'DB_PREFIX'            => 'movesay_',
	'ACTION_SUFFIX'        => '',
	'MULTI_MODULE'         => true,
	'MODULE_DENY_LIST'     => array('Common', 'Runtime'),
	'MODULE_ALLOW_LIST'    => array('Home', 'Admin', 'Mapi'),
	'DEFAULT_MODULE'       => 'Home',
	'URL_CASE_INSENSITIVE' => false,
	'URL_MODEL'            => 2,
	'URL_HTML_SUFFIX'      => 'html',
	'UPDATE_PATH'          => './Database/Update/',
	'CLOUD_PATH'           => './Database/Cloud/',
	'__CLOUD__'            => array('http://os.qijianke.com', 'http://auth.qijianke.com', 'http://101.201.199.224'),
    'LANG_SWITCH_ON' => true, // 开启语言包功能
    'LANG_AUTO_DETECT' => true, // 自动侦测语言 开启多语言功能后有效
    'LANG_LIST' => 'zh-cn,en-us', //必须写可允许的语言列表
    'VAR_LANGUAGE' => 'l', // 默认语言切换变量
    //'SHOW_PAGE_TRACE'   => true
    
	);

?>
