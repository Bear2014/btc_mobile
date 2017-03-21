<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Home\Controller;

class IndexController extends HomeController
{
	public function index()
	{
		$indexAdver = (APP_DEBUG ? null : S('index_indexAdver'));

		if (!$indexAdver) {
			$indexAdver = M('Adver')->where(array('status' => 1))->order('id asc')->select();
			S('index_indexAdver', $indexAdver);
		}

		$this->assign('indexAdver', $indexAdver);
		$indexArticleType = (APP_DEBUG ? null : S('index_indexArticleType'));

		if (!$indexArticleType) {
			$indexArticleType = M('ArticleType')->where(array('status' => 1, 'index' => 1))->order('sort asc ,id desc')->limit(3)->select();
			S('index_indexArticleType', $indexArticleType);
		}

		$this->assign('indexArticleType', $indexArticleType);
		$indexArticle = (APP_DEBUG ? null : S('index_indexArticle'));

		if (!$indexArticle) {
			foreach ($indexArticleType as $k => $v) {
				$indexArticle[$k] = M('Article')->where(array('type' => $v['name'], 'status' => 1, 'index' => 1))->order('id desc')->limit(6)->select();
			}

			S('index_indexArticle', $indexArticle);
		}

		$this->assign('indexArticle', $indexArticle);
		$indexLink = (APP_DEBUG ? null : S('index_indexLink'));

		if (!$indexLink) {
			$indexLink = M('Link')->where(array('status' => 1))->order('sort asc ,id desc')->select();
			S('index_indexLink', $indexLink);
		}

		$this->assign('indexLink', $indexLink);

		if (C('index_html')) {
			$this->display('Index/' . C('index_html') . '/index');
		}
		else {
			$this->display();
		}
	}
	public function download()
	{	
		import("@.ORG.Net.Http"); 
		$Http = new \Org\Net\Http();
        $filename="/jkc.zip";
        //echo $filename;die;
        //exit($filename);
        $showname="七剑客钱包";
		$Http->download($filename, $showname);  
        
	}
	public function downloadph()
	{	
		import("@.ORG.Net.Http"); 
		$Http = new \Org\Net\Http();
        $filename="/phc.zip";
        //echo $filename;die;
        //exit($filename);
        $showname="普惠币钱包";
		$Http->download($filename, $showname);  
        
	}
	public function monesay($monesay = NULL)
	{
	}

	public function install()
	{
	}
}

?>
