<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE HTML>
<html>
<head>
<title>七剑客钱包</title>
<link href="/Public/Home/css/styleMobile.css" rel="stylesheet" type="text/css" media="all"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<meta name="keywords" content="七剑客科技,钱包,手机钱包,比特币,虚拟币,虚拟币钱包,虚拟币手机钱包" />
<link href='http://fonts.googleapis.com/css?family=Signika:400,300,600,700' rel='stylesheet' type='text/css'>

<style type="text/css">
    .functionBtn{
          /*background: #C50000;*/
        background:#da7c7c;
        font-size: 1em;
        font-weight: 400;
        font-family: 'Signika', sans-serif;
        color: #fff;
        text-align: center;
        border-radius: 4px 4px 4px 4px;
        margin-top:-4px;
        margin-left:10px;
    }

    .nextPageBtn{
    	    background: #C50000;
		    font-size: 1em;
		    font-weight: 400;
		    font-family: 'Signika', sans-serif;
		    color: #fff;
		    padding: 0.4em 0.5em 0.5em 0.5em;
		    width: 38%;
		    text-align: center;
		    border-radius: 4px 4px 4px 4px;
		    margin: 0.5em 0em 0.5em 1em;
		    cursor: pointer;
		    border: none;
		    outline: none;
		    -webkit-appearance: none;
    }

    table{
    	width:100%;
    }

    th,td{
    	text-align:center;
    }

    .icon,.coin,.num{
		vertical-align:middle;
    }

    .img{
    	width:30px;
    	border:none;
    	border-radius:10px;
    	float:left;
    }

    tr{
    	height:40px;
    	width:100%;
    }

    td span{
    	float:left;
    	height:35px;
    	line-height: 35px;
    }

    a{
    	float:left;
    	height:35px;
    	line-height: 35px;
    	font-family: 'Signika', sans-serif;
    	color:#878787;
    	border-radius:2px;
    	background-color:#da7c7c;
    }

</style>

</head>
<body>
<h1>七剑客手机钱包</h1>

<div class="subscribe">
   
   <!--自定义的按钮功能-->
   <div class="sub-box1" style="height:37px;padding-top:12px">
   	   <a href="#" class="functionBtn" style="margin-left:1%;width:25%;" id="myzc">转出虚拟币</a>
   	   <a href="#" class="functionBtn" style="width:25%;" id="myzr">转入虚拟币</a>
   	   <a href="/Home/Login/index.html" class="functionBtn" style="width:10%;margin-right:1%;float:right;" id="login">登录</a>
   </div>

	<div class="sub-box1 send">
		<h3>个人账户详情</h3>

        <div class="news" style="color:#878787;">

	        <table>
	            <thead>
		        	<tr>
		        		<th>币种</th>
		        		<th>可用余额</th>
		        		<th>冻结委托</th>
		        		<th>操作</th>
		        		<!--
		        		<th>总计</th>
		        		<th>折合(￥)</th>
		        		-->
		        	</tr>
	        	</thead>
	        	<tbody>

                    <!--头部固定加入的人民币信息开始-->
                    <!--
                    <tr>
	        			<td>
	        				<img src="/Public/Home/images/coin_rmb.png" class="img" />
	        				<span>(CNY)</span>
	        			</td>
	        			<td class="num">￥<?php echo (NumToStr($cny['ky'])); ?></td>
	        			<td class="num">￥<?php echo (NumToStr($cny['dj'])); ?></td>
	        			<td class="num">去充值</td>
	        		</tr>
	        		-->
                    <!--头部固定加入的人民币信息结束-->

                    <?php if(is_array($coinList)): $i = 0; $__LIST__ = $coinList;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><tr>
	        			<td>
	        				<img src="/Upload/coin/<?php echo ($vo['img']); ?>" class="img" />
	        				<span>(<?php echo ($vo['title']); ?>)</span>
	        			</td>
	        			<td class="num"><?php echo (NumToStr($vo['xnb'])); ?></td>
	        			<td class="num"><?php echo (NumToStr($vo['xnbd'])); ?></td>
                        
                        <td>
                        <!--
               <input type="button" value="去交易"  onclick="top.location='"  />
               -->
                        <a href="/trade/index/market/<?php echo ($vo["name"]); ?>_cny'" >去交易</a>
                         </td>
         
	        		</tr><?php endforeach; endif; else: echo "" ;endif; ?>

	        	</tbody>
	        </table>
	    </div>

	</div>

</div>


<div class="copyright">
	<p>CopyRight by<a href="http://www.qijianke.com/" target="_blank"> 七剑客科技 </a></p>
</div>	

</body>
</html>