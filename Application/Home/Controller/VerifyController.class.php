<?php
//dezend by http://www.yunlu99.com/ QQ:270656184
namespace Home\Controller;

class VerifyController extends HomeController
{
	public function __construct()
	{
		parent::__construct();
	}

	public function code()
	{
		$config['useNoise'] = false;
		$config['length'] = 4;
		$config['codeSet'] = '0123456789';
		$verify = new \Think\Verify($config);
		$verify->entry(1);
	}

	public function real($moble, $verify)
	{
		if (!userid()) {
			redirect('/#login');
		}

		if (!check_verify(strtoupper($verify))) {
			$this->error('图形验证码错误!');
		}

		if (!check($moble, 'moble')) {
			$this->error('手机号码格式错误！');
		}

		if (M('User')->where(array('moble' => $moble))->find()) {
			$this->error('手机号码已存在！');
		}

		$code = rand(111111, 999999);
		session('real_verify', $code);
		$content = '您正在进行手机操作，您的验证码是' . $code;

		if (send_moble($moble, $content)) {
			$this->success('短信验证码已发送到你的手机，请查收');
		}
		else {
			$this->error('短信验证码发送失败，请重新点击发送');
		}
	}

	public function mytx()
	{
		if (!userid()) {
			$this->error('请先登录');
		}

		$moble = M('User')->where(array('id' => userid()))->getField('moble');

		if (!$moble) {
			$this->error('你的手机没有认证');
		}

		$code = rand(111111, 999999);
		session('mytx_verify', $code);
		$content = '您正在进行申请提现操作，您的验证码是' . $code;

		if (send_moble($moble, $content)) {
			$this->success('短信验证码已发送到你的手机，请查收');
		}
		else {
			$this->error('短信验证码发送失败，请重新点击发送');
		}
	}

	public function sendMobileCode()
	{
		if (IS_POST) {
			$input = I('post.');

			if (!check_verify(strtoupper($input['verify']))) {
				$this->error('图形验证码错误!', 'mobile_verify');
			}

			if (!check($input['mobile'], 'moble')) {
				$this->error('手机号码格式错误！', 'mobile');
			}

			if (M('User')->where(array('moble' => $input['mobile']))->find()) {
				$this->error('手机号码已存在！');
			}

			if ((session('mobile#mobile') == $input['mobile']) && (time() < (session('mobile#real_verify#time') + 600))) {
				$code = session('mobile#real_verify');
				session('mobile#real_verify', $code);
			}
			else {
				$code = rand(111111, 999999);
				session('mobile#real_verify#time', time());
				session('mobile#mobile', $input['mobile']);
				session('mobile#real_verify', $code);
			}

			$content = '您正在进行手机操作，您的验证码是' . $code;

			if (1) {
				$this->success('短信验证码已发送到你的手机，请查收' . $code);
			}
			else {
				$this->error('短信验证码发送失败，请重新点击发送');
			}
		}
		else {
			$this->error('非法访问！');
		}
	}

	public function sendEmailCode()
	{
		if (IS_POST) {
			$input = I('post.');

			if (!check_verify(strtoupper($input['verify']))) {
				$this->error('图形验证码错误!');
			}

			if (!check($input['email'], 'email')) {
				$this->error('邮箱格式错误！');
			}

			if (M('User')->where(array('email' => $input['email']))->find()) {
				$this->error('邮箱已存在！');
			}

			if ((session('email#email') == $input['email']) && (time() < (session('email#real_verify#time') + 600))) {
				$code = session('email#real_verify');
				session('email#real_verify', $code);
			}
			else {
				$code = rand(111111, 999999);
				session('email#real_verify#time', time());
				session('email#email', $input['email']);
				session('email#real_verify', $code);
			}

			$content = '您正在进行邮箱注册操作，您的验证码是' . $code;

			if (1) {
				$this->success('邮箱验证码已发送到你的邮箱，请前往查收' . $content);
			}
			else {
				$this->error('邮箱验证码发送失败，请重新点击发送');
			}
		}
		else {
			$this->error('非法访问！');
		}
	}

	public function findpwd()
	{
		if (IS_POST) {
			$input = I('post.');

			if (!check_verify(strtoupper($input['verify']))) {
				$this->error('图形验证码错误!');
			}

			if (!check($input['username'], 'username')) {
				$this->error('用户名格式错误！');
			}

			if (!check($input['moble'], 'moble')) {
				$this->error('手机号码格式错误！');
			}

			$user = M('User')->where(array('username' => $input['username']))->find();

			if (!$user) {
				$this->error('用户名不存在！');
			}

			if ($user['moble'] != $input['moble']) {
				$this->error('用户名或手机号码错误！');
			}

			$code = rand(111111, 999999);
			session('findpwd_verify', $code);
			$content = '您正在进行找回登录密码操作，您的验证码是' . $code;

			if (send_moble($input['moble'], $content)) {
				$this->success('短信验证码已发送到你的手机，请查收');
			}
			else {
				$this->error('短信验证码发送失败，请重新点击发送');
			}
		}
	}

	public function findpaypwd()
	{
		$input = I('post.');

		if (!check_verify(strtoupper($input['verify']))) {
			$this->error('图形验证码错误!');
		}

		if (!check($input['username'], 'username')) {
			$this->error('用户名格式错误！');
		}

		if (!check($input['moble'], 'moble')) {
			$this->error('手机号码格式错误！');
		}

		$user = M('User')->where(array('username' => $input['username']))->find();

		if (!$user) {
			$this->error('用户名不存在！');
		}

		if ($user['moble'] != $input['moble']) {
			$this->error('用户名或手机号码错误！');
		}

		$code = rand(111111, 999999);
		session('findpaypwd_verify', $code);
		$content = '您正在进行找回交易密码操作，您的验证码是' . $code;

		if (send_moble($input['moble'], $content)) {
			$this->success('短信验证码已发送到你的手机，请查收');
		}
		else {
			$this->error('短信验证码发送失败，请重新点击发送');
		}
	}

	public function myzc()
	{
		if (!userid()) {
			$this->error('您没有登录请先登录!');
		}

		$moble = M('User')->where(array('id' => userid()))->getField('moble');

		if (!$moble) {
			$this->error('你的手机没有认证');
		}

		$code = rand(111111, 999999);
		session('myzc_verify', $code);
		$content = '您正在进行申请转出操作，您的验证码是' . $code;

		if (send_moble($moble, $content)) {
			$this->success('短信验证码已发送到你的手机，请查收');
		}
		else {
			$this->error('短信验证码发送失败，请重新点击发送');
		}
	}
}

?>
