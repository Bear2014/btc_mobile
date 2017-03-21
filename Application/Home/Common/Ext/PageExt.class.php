<?php

namespace Home\Common\Ext;

use Think\Page;
/**
 * @author huangyq
 * @desc 前端对应分页类(重写show方法，支持中英文)
 */
class PageExt extends Page{
    
    // 英文对应配置
    protected $configEn = array('header'=>'record','prev'=>'prev','next'=>'next','first'=>'first','last'=>'last','theme'=>' %totalRow% %header% %nowPage%/%totalPage% page %upPage% %downPage% %first%  %prePage%  %linkPage%  %nextPage% %end%');
    
    public function setConfig($name,$value) {
        if(isset($this->config[$name])) {
            $this->config[$name] = $value;
            $this->configEn[$name] = $value;
        }
    }
    
    /**
     * 分页显示输出
     * @access public
     */
    public function show() {
        if(0 == $this->totalRows) return '';
        $conf = (LANG_SET == 'zh-cn' ? $this -> config : $this -> configEn);
        $p              =   $this->varPage;
        $nowCoolPage    =   ceil($this->nowPage/$this->rollPage);
    
        // 分析分页参数
        if($this->url){
            $depr       =   C('URL_PATHINFO_DEPR');
            $url        =   rtrim(U('/'.$this->url,'',false),$depr).$depr.'__PAGE__';
        }else{
            if($this->parameter && is_string($this->parameter)) {
                parse_str($this->parameter,$parameter);
            }elseif(is_array($this->parameter)){
                $parameter      =   $this->parameter;
            }elseif(empty($this->parameter)){
                unset($_GET[C('VAR_URL_PARAMS')]);
                $var =  !empty($_POST)?$_POST:$_GET;
                if(empty($var)) {
                    $parameter  =   array();
                }else{
                    $parameter  =   $var;
                }
            }
            $parameter[$p]  =   '__PAGE__';
            $url            =   U('',$parameter);
        }
        //上下翻页字符串
        $upRow          =   $this->nowPage-1;
        $downRow        =   $this->nowPage+1;
        if ($upRow>0){
            $upPage     =   "<a href='".str_replace('__PAGE__',$upRow,$url)."'>".$conf['prev']."</a>";
        }else{
            $upPage     =   '';
        }
    
        if ($downRow <= $this->totalPages){
            $downPage   =   "<a href='".str_replace('__PAGE__',$downRow,$url)."'>".$conf['next']."</a>";
        }else{
            $downPage   =   '';
        }
        // << < > >>
        if($nowCoolPage == 1){
            $theFirst   =   '';
            $prePage    =   '';
        }else{
            $preRow     =   $this->nowPage-$this->rollPage;
            $prePage    =   "<a href='".str_replace('__PAGE__',$preRow,$url)."' >".get_lang_text('上', 'prev&nbsp;').$this->rollPage.get_lang_text('页', '&nbsp;page')."</a>";
            $theFirst   =   "<a href='".str_replace('__PAGE__',1,$url)."' >".$conf['first']."</a>";
        }
        if($nowCoolPage == $this->coolPages){
            $nextPage   =   '';
            $theEnd     =   '';
        }else{
            $nextRow    =   $this->nowPage+$this->rollPage;
            $theEndRow  =   $this->totalPages;
            $nextPage   =   "<a href='".str_replace('__PAGE__',$nextRow,$url)."' >".get_lang_text('下', 'next&nbsp;').$this->rollPage.get_lang_text('页', '&nbsp;page')."</a>";
            $theEnd     =   "<a href='".str_replace('__PAGE__',$theEndRow,$url)."' >".$conf['last']."</a>";
        }
        // 1 2 3 4 5
        $linkPage = "";
        for($i=1;$i<=$this->rollPage;$i++){
            $page       =   ($nowCoolPage-1)*$this->rollPage+$i;
            if($page!=$this->nowPage){
                if($page<=$this->totalPages){
                    $linkPage .= "<a href='".str_replace('__PAGE__',$page,$url)."'>".$page."</a>";
                }else{
                    break;
                }
            }else{
                if($this->totalPages != 1){
                    $linkPage .= "<span class='current'>".$page."</span>";
                }
            }
        }
        $pageStr     =   str_replace(
            array('%header%','%nowPage%','%totalRow%','%totalPage%','%upPage%','%downPage%','%first%','%prePage%','%linkPage%','%nextPage%','%end%'),
            array($conf['header'],$this->nowPage,$this->totalRows,$this->totalPages,$upPage,$downPage,$theFirst,$prePage,$linkPage,$nextPage,$theEnd),$conf['theme']);
        return $pageStr;
    }
}