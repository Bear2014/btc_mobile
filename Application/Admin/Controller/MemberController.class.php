<?php 
namespace Admin\Controller;
class MemberController extends AdminController
{
	public function index(){
		$list=M('level_config')->select();
		$this->assign('list',$list);
		$this->display();
	}
	public function edit(){
		$parame=I('post.');
		for ($i=1; $i < 9; $i++) { 
			/*验证*/
			if($parame['scale_'.$i]<0){
				$this->error('提现手续费(比例)不能小于0！');	
			}
			if($parame['scale_'.$i]>100){
				$this->error('提现手续费(比例)不能大于100！');	
			}
			if(!is_numeric($parame['scale_'.$i])){
				$this->error('提现手续费(比例)只能是数字！');	
			}
			if($parame['quota_'.$i]<0){
				$this->error('最大配额不能小于0！');	
			}
			if(!preg_match("/^\d*$/",$parame['quota_'.$i])){
				$this->error('最大配额只能填写数字(整数)！');	
			}
			if ($parame['quota_'.$i]>999999999) {
				$this->error('最大配额不能超过999999999！');	
			}
			/*操作数据*/
			if ($parame['level_name_'.$i]) {
				$data['level_name']=$parame['level_name_'.$i];
			}
			if ($parame['people_num_'.$i]) {
				$data['people_num']=$parame['people_num_'.$i];
			}
			if ($parame['c_money_'.$i]) {
				$data['c_money']=$parame['c_money_'.$i];
			}
			if ($parame['quota_'.$i]) {
				$data['quota']=$parame['quota_'.$i];
			}
			if ($parame['quota_price_'.$i]) {
				$data['quota_price']=$parame['quota_price_'.$i];
			}
			if ($parame['scale_'.$i]) {
				$data['scale']=$parame['scale_'.$i];
			}

				$result=M('level_config')->where('id='.$i)->data($data)->save();
				unset($data);
				if ($result!== false) {
					
				}else{
					$this->error('修改失败！');
				}
				
			
		}
		$this->success('修改成功！');
		
		
	}
}
?>