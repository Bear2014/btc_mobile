/*
SQLyog Ultimate v11.24 (32 bit)
MySQL - 5.5.40 : Database - okmoney
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `movesay_admin` */

DROP TABLE IF EXISTS `movesay_admin`;

CREATE TABLE `movesay_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(200) NOT NULL DEFAULT '',
  `username` char(16) NOT NULL,
  `nickname` varchar(50) NOT NULL DEFAULT '',
  `moble` varchar(50) NOT NULL DEFAULT '',
  `password` char(32) NOT NULL,
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `last_login_time` int(11) unsigned NOT NULL DEFAULT '0',
  `last_login_ip` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='管理员表';

/*Data for the table `movesay_admin` */

insert  into `movesay_admin`(`id`,`email`,`username`,`nickname`,`moble`,`password`,`sort`,`addtime`,`last_login_time`,`last_login_ip`,`endtime`,`status`) values (1,'','admin123','','','0192023a7bbd73250516f069df18b500',0,0,0,0,0,1);

/*Table structure for table `movesay_adver` */

DROP TABLE IF EXISTS `movesay_adver`;

CREATE TABLE `movesay_adver` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `img` varchar(250) NOT NULL DEFAULT '',
  `type` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='广告图片表';

/*Data for the table `movesay_adver` */

insert  into `movesay_adver`(`id`,`name`,`url`,`img`,`type`,`sort`,`addtime`,`endtime`,`status`) values (15,'最专业的交易平台','','5775e5ad38f6d.jpg','',0,0,0,1),(3,'幻灯片','','5779eee87de1e.jpg','index',0,1446829556,0,1),(16,'图','','57bc2defebd9e.png','',0,1471881600,1471881600,1);

/*Table structure for table `movesay_article` */

DROP TABLE IF EXISTS `movesay_article`;

CREATE TABLE `movesay_article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `index` varchar(200) NOT NULL DEFAULT '' COMMENT ' ',
  `footer` varchar(200) NOT NULL DEFAULT '' COMMENT ' ',
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` text,
  `adminid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(255) NOT NULL DEFAULT '',
  `hits` int(11) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `type` (`type`),
  KEY `adminid` (`adminid`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='系统文章表';

/*Data for the table `movesay_article` */

insert  into `movesay_article`(`id`,`index`,`footer`,`title`,`content`,`adminid`,`type`,`hits`,`sort`,`addtime`,`endtime`,`status`) values (1,'1','1','帮助中心','<p>\r\n	<span style=\"font-size:16px;\">2016年6月11日正式上线</span>\r\n</p>\r\n<p>\r\n	<br />\r\n</p>',1,'aboutus',0,0,1462921317,1470844800,1),(2,'','','法律声明','<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>',1,'aboutus',0,0,1447196754,0,1),(3,'','','用户协议','',1,'aboutus',0,0,1447196832,0,1),(4,'','','资质证明','',1,'aboutus',0,0,1447196898,0,1),(5,'','','联系我们','',1,'aboutus',0,0,1447197626,0,1),(6,'','','关于我们','',1,'aboutus',0,0,1441733195,0,1),(8,'','','新人必看--登录注册详细说明','',1,'help',0,0,0,0,1),(9,'','','新人必看--平台交易详细说明','',1,'help',0,0,1447197238,0,1),(10,'','','新人必看--自助充值详细说明','目前支持支付宝充值 &nbsp;充值成功后立即到账&nbsp;',1,'help',0,0,1447197283,0,1),(11,'','','新人必看--申请提现详细说明','关于提现说明 每次提现收取1%手续费 &nbsp;需要完成实名认证',1,'help',0,0,1447197343,0,1),(12,'','','新人必看--修改密码详细说明','即将公布',1,'help',0,0,1447197369,0,1),(13,'','','新人必看--实名认证详细说明','',1,'help',0,0,1447196898,0,1),(21,'','','这里是最新公告','',1,'notice',0,0,1452514770,0,1),(26,'','','新人必看--应用中心详细说明','',1,'help',0,0,1447196898,0,1),(27,'','','这是帮助中心文章','',1,'help',0,0,1452514759,0,1),(30,'','','这是行业资讯文章','',1,'news',0,0,1452514748,0,1),(32,'','','这里是最新公告','',1,'notice',0,0,1452514770,0,1),(49,'','','这里是最新公告','',1,'notice',0,0,1452514770,0,1),(50,'','','2016年6月16日提现到账公告','',1,'news',0,0,1447196898,0,1),(64,'1','1','法特币即将上线','法特币即将上线',1,'notice',0,0,1447196898,1475510400,1),(65,'0','0','区块链上的分布式物联网','<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	想象一下你的洗衣机，当洗涤剂不够时可以自动联系供应商，并进行自助下订单购物，进行自我维护，从外部资源处下载新的洗衣程序，根据电价的变化周期来安排最经济的洗衣计划表，还能和它的传感器互动来决定最优化的洗衣环境；再想象一辆汽车，实时联网，可以智能的选择最合适的零件和服务；还有这样的制造厂，它们的机械在没有人工干预的情况下，知道自己的哪个部位什么时候需要修理。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	以上的这些场景，在物联网（the Internet of Things IoT）的帮助下将会成为现实。事实上，那些曾不适应电脑的的产业已经被数十亿计的连接互联网的物联网设备改变；还没有被改变的产业，最终将在这样的浪潮中被迫跟上这种步伐。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	<img src=\"http://7xqy72.com1.z0.glb.clouddn.com/public/resources/pic/news/2016/06/30/c0h1pzUyRV_IoT.jpg\" style=\"height:auto;\" />\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	未来的可能性是无限的，特别是当物联网和其它技术结合所产生的力量，比如和机器学习结合。然而，数十亿的智能设备之间想要产生互动，或者和它们的拥有者互动，那么就会出现一些大问题。当现存的支持物联网通信的模型无法应对这样的挑战时，相关的技术公司和一些研究人员希望通过区块链技术来解决它们，这个技术就是大名鼎鼎的<a name=\"tuilink_a_5dfe53e3dre3\" href=\"http://www.tuiunion.com/tuilink/redirect/8/?domain=www.btckan.com\" target=\"_black\">比特币</a>背后的基石。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	<strong>中心化模型的问题</strong>\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	当前的物联网生态依赖于中心化系统，中介通信模型，也就是我们熟知的服务器/客户端（server/client）模型。拥有巨大计算能力和存储空间的云服务器与被标记和验证的设备相连。设备间的只通过互联网连接，即使它们只相隔几英尺。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	这种模型在通用的计算设备连接中运行了几十年，它还会存在于小规模的物联网网络中，正如我们现在所看到的那些。然而在未来逐渐增长为大规模的物联网生态上，这种模型就会显得无能了。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	现存的物联网方案是昂贵的，因为它的基础设施和维护费用极高，它需要中心云服务、大规模服务器集群和网络设备。当物联网设备以数十亿级别的速度增长时，它们之间要处理的通信量更是惊人，这样以来的费用会大幅度的增长。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	即使这种经济上和工程上的挑战不是问题，那么云服务器依然存在瓶颈，还有就是它出现一个故障点就会导致整个网络的崩溃。如果将来人类的生命健康依赖于物联网，那么这个问题就非常非常的严重。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	另外，不同设备间的多样化所有权，和它们支持的云服务架构多元化让机器对机器（machine-to-machine M2M）通信很困难。没有一个单独的设备可以连接其他所有设备，不同的云服务提供商也不会保证它们之间的互操作性和兼容性。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	<strong>分布式物联网（IoT）网络</strong>\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	物联网的分布式方案可以解决以上的很多问题。采用标准化的点对点通信模型处理成千上万设备间的交易，这有效的削减了成本，包括部署和维护大型数据中心的费用，而且可以通过成千上万的物联网设备把计算需求和存储需求去中心化。这将避免由于一个节点的失败而导致整个网络的崩溃。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	可是，建立点对点通信也有它自己的问题，其中首要问题是安全。我们都知道，物联网的安全不仅仅只是要保护敏感数据。解决方案必须在大规模物联网网络中保护隐私安全，还要为交易提供一些验证形式和共识形式，来避免被欺诈和偷盗。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	<strong>区块链方案</strong>\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	对于点对点通信平台问题，<a href=\"http://www.btckan.com/redirect?url=+http%3A%2F%2F8btc.com%2Farticle-44-1.html\">区块链</a>给出了精妙的解决方案，这种技术在网络节点间创建一种相互共享的分布式数字账簿，来记录交易，而不是把这些交易账簿存储于一个中心服务器。参与者通过区块链来记录交易。这个技术使用加密技术认证识别参与节点，保证它们安全的在账簿中添加交易记录。交易是被这个网络中的节点所验证和确认，所以这就消除了中心验证的必要性。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	这个账簿是防干扰和不可被恶意者修改的，因为它不单独存在于本地独立设备，它也不可能被中间人攻击，因为交易不是可被拦截的单独一个线程。区块链让去信任化、点对点通信成为现实，而且它在金融服务领域的价值已经通过加密货币（如<a name=\"tuilink_a_5dfe53e3dre3\" href=\"http://www.tuiunion.com/tuilink/redirect/8/?domain=www.btckan.com\" target=\"_black\">比特币</a>）证明，它在没有第三方支付参与的情况下为点对点支付做保障。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	科技公司现在试图让区块链的实用性与网联网领域磨合。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	这个概念可以直接解决物联网的规模化问题，不需要传统的昂贵资源就可以让数十亿计的设备共享于一个相同网络。区块链也可以解决不同供应商间的权威冲突，它提供了一个标准，让每个人有平等的权益。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	这将打通M2M(机器对机器)间的通信，在当前的模型中，这是无法实现的，这也让一些全新的使用案例成为现实。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	<strong>在物联网中混合使用区块链</strong>\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	物联网和区块链的结合正蓄势待发，创业公司和科技巨头都非常看好。IBM和三星引入他们的概念证明，ADEPT使用区块链技术支持下一代物联网生态，每天将会产生千亿计的交易。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	IBM作为最早研究把区块链用于物联网中的企业之一，IBM的Paul Brody 这样描述：新设备被工厂组装完成后在一个通用的区块链中注册，在被出售后转移进一个区域区块链，在这个区块链上它们可以与其它设备自主互动。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	物联网和区块链的结合让循环经济和资产流体化成为可能，资源可以被共享和再利用，而不是消费一次就处理掉。区块链平台领导者以太坊举办的物联网黑客马拉松中，一个区块链驱动的物联网概念被测试，其中还有很多非常有创意的项目，其中包括能源分享、电力燃气账单等领域中的项目。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	Filament是一个投身于物联网和区块链的创业公司，它专注于工业应用，像农业、制造业、石油和天然气等。Filament 使用一种名叫Taps的无线传感器，组成低功耗自治网状网络，来收集数据，监控资产，而且不需要云服务或中心网络服务器的参与。这家公司使用区块链技术识别认证设备，通过提供这样的网络和数据服务来获得收入，当然是以<a name=\"tuilink_a_5dfe53e3dre3\" href=\"http://www.tuiunion.com/tuilink/redirect/8/?domain=www.btckan.com\" target=\"_black\">比特币</a>为支付方式。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	Chain of Things 是一个联盟，他们的任务是探索区块链在处理物联网规模化和安全问题中所能扮演的角色。他们在最近伦敦举行的黑客马拉松中展示了区块链 和物联网的使用案例，包括一种太阳能堆栈设计，它可以提供可靠地、可验证的再生资源数据，加速刺激结算，减少其中的欺诈。这个系统加强了太阳能面板和数据记录器的连接过程，跟踪太阳能的生产量，安全的把这些数据提交给节点，节点把这些数据记录在分布式账簿中，然后在范围更广的全球节点网络同步。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	<strong>警示和挑战</strong>\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	把区块链技术应用于物联网并不是没有缺点的，还有一些问题需要解决。其一就是，在<a name=\"tuilink_a_5dfe53e3dre3\" href=\"http://www.tuiunion.com/tuilink/redirect/8/?domain=www.btckan.com\" target=\"_black\">比特币</a>开发者之间争吵不断的区块链基础问题，这个问题产生于，随着这个网络的发展，交易量和体积越来越大，当区块链技术应用于物联网时，这个问题也不可避免。科技公司也承认这是一种挑战，然而有一些解决方案正在测试，其中包括侧链、树链和迷你区块等方案。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	能源消耗也是一个问题，加密和验证区块链交易是一种计算力集约操作，需要消耗大量的电力资源，这是物联网设备所缺少的。与此同时，还需要较大的存储空间，随着账簿的增长，节点的存储空间需求也越来越大。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	还有，如Machina Research 的研究者 Jeremy Green所说，以区块链作为驱动的自治物联网对制造商来说，最大的挑战时寻求一种商业模型，其中包括持续盈利的长期合作伙伴，而且需要一个商业和经济模型的大转型。\r\n</p>\r\n<p style=\"color:#333333;font-family:ff-tisa-web-pro-1, ff-tisa-web-pro-2, \'Lucida Grande\', \'Helvetica Neue\', Helvetica, Arial, \'Hiragino Sans GB\', \'Hiragino Sans GB W3\', \'Microsoft YaHei UI\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif;font-size:15px;background-color:#FCFCFC;\">\r\n	物联网产业发展飞速，区块链是否是解决物联网面临的困难的关键，现在下结论还为时过早。它还不完美，然而与物联网结合非常的有希望，分布式自治网络将成为解决问题的关键因素。\r\n</p>',1,'news',0,0,1467287166,1471933905,1);

/*Table structure for table `movesay_article_type` */

DROP TABLE IF EXISTS `movesay_article_type`;

CREATE TABLE `movesay_article_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `shang` text COMMENT ' ',
  `content` text COMMENT ' ',
  `footer` varchar(200) NOT NULL DEFAULT '' COMMENT ' ',
  `name` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(50) NOT NULL DEFAULT '',
  `title_en` varchar(50) DEFAULT NULL,
  `remark` varchar(50) NOT NULL DEFAULT '',
  `index` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='分组分类别';

/*Data for the table `movesay_article_type` */

insert  into `movesay_article_type`(`id`,`shang`,`content`,`footer`,`name`,`title`,`title_en`,`remark`,`index`,`sort`,`addtime`,`endtime`,`status`) values (1,'','','','news','行业资讯','News','行业资讯','1',2,0,0,1),(2,'','','','notice','最新公告','Notice','最新公告','1',1,0,0,1),(3,'','','1','help','帮助中心','Help','帮助中心','1',3,1471604765,1471604771,1),(4,'','','','aboutus','关于我们','About us','关于我们','0',0,0,0,1);

/*Table structure for table `movesay_auth_extend` */

DROP TABLE IF EXISTS `movesay_auth_extend`;

CREATE TABLE `movesay_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `movesay_auth_extend` */

insert  into `movesay_auth_extend`(`group_id`,`extend_id`,`type`) values (1,1,1),(1,1,2),(1,2,1),(1,2,2),(1,3,1),(1,3,2),(1,4,1),(1,37,1);

/*Table structure for table `movesay_auth_group` */

DROP TABLE IF EXISTS `movesay_auth_group`;

CREATE TABLE `movesay_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `movesay_auth_group` */

insert  into `movesay_auth_group`(`id`,`module`,`type`,`title`,`description`,`status`,`rules`) values (1,'admin',1,'资讯管理员','拥有网站文章资讯相关权限',1,'134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,192,193,194,195,196,197,198,199,200,201,204,205,206,207,208,209,212,213,214,217,218,219,220,221,222,223,224,225,226,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,'),(3,'admin',1,'超级管理员','超级管理员组,拥有系统所有权限',1,'489,660,661,663,664,665,666,667,668,669,670,671,672,673,674,675,676,677,678,679,680,681,682,683,684,685,686,687,688,689,690,691,692,693,694,695,696,697,698,699,700,701,702,703,704,705,706,707,708,709,710,711,712,713,714,715,716,717,718,719,720,721,722,723,724,725,726,729,730,731,732,733,734,735,736,737,738,741,742,743,744,745,746,747,750,751,754,755,756,757,758,759,760,761,762,763,764,765,766,767,772,774,775,776,777,778,779,780,781,782,783,784,785,786,787,788,791,792,793,794,795,796,797,798,799,'),(2,'admin',1,'财务管理组','拥有网站资金相关的权限',1,'1,2,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,82,83,84,88,89,90,91,92,93,96,97,100,102,103,195'),(4,'admin',1,'资讯管理员','拥有网站文章资讯相关权限11',-1,''),(5,'admin',1,'资讯管理员','拥有网站文章资讯相关权限',1,''),(6,'admin',1,'财务管理组','拥有网站资金相关的权限333',1,'');

/*Table structure for table `movesay_auth_group_access` */

DROP TABLE IF EXISTS `movesay_auth_group_access`;

CREATE TABLE `movesay_auth_group_access` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `movesay_auth_group_access` */

insert  into `movesay_auth_group_access`(`uid`,`group_id`) values (2,3),(3,1),(7,3),(8,3),(10,3);

/*Table structure for table `movesay_auth_rule` */

DROP TABLE IF EXISTS `movesay_auth_rule`;

CREATE TABLE `movesay_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=827 DEFAULT CHARSET=utf8;

/*Data for the table `movesay_auth_rule` */

insert  into `movesay_auth_rule`(`id`,`module`,`type`,`name`,`title`,`status`,`condition`) values (782,'admin',1,'Admin/Tools/exportExcel','导出Excel',1,''),(781,'admin',1,'Admin/Tools/excel','导出数据库',1,''),(780,'admin',1,'Admin/Tools/import','还原数据库',1,''),(779,'admin',1,'Admin/Tools/export','备份数据库',1,''),(778,'admin',1,'Admin/Tools/del','删除备份文件',1,''),(777,'admin',1,'Admin/Tools/repair','修复表',1,''),(776,'admin',1,'Admin/Tools/optimize','优化表',1,''),(775,'admin',1,'Admin/Tools/invoke','其他模块调用',1,''),(774,'admin',1,'Admin/Cloud/theme','主题模板',1,''),(773,'admin',1,'Admin/Config/market_add','状态修改',1,''),(772,'admin',1,'Admin/User/log','登陆日志',1,''),(771,'admin',1,'Admin/Market/edit','编辑市场',1,''),(770,'admin',1,'Admin/Coin/status','状态修改',1,''),(769,'admin',1,'Admin/Coin/edit','编辑',1,''),(768,'admin',1,'Admin/Config/bank_edit','编辑',1,''),(767,'admin',1,'Admin/Config/bank','银行配置',1,''),(766,'admin',1,'Admin/Trade/comment','币种评论',1,''),(765,'admin',1,'Admin/Finance/mytx','人民币提现',1,''),(764,'admin',1,'Admin/Config/coin','币种配置',1,''),(763,'admin',1,'Admin/Finance/mytxExcel','导出选中',1,''),(762,'admin',1,'Admin/Tools/qianbao','钱包检查',1,''),(761,'admin',1,'Admin/Tools/queue','服务器队列',1,''),(760,'admin',1,'Admin/Article/adver','广告管理',1,''),(759,'admin',1,'Admin/Cloud/game','应用管理',1,''),(758,'admin',1,'Admin/Index/market','市场统计',1,''),(757,'admin',1,'Admin/Finance/myczType','人民币充值方式',1,''),(756,'admin',1,'Admin/User/auth','权限列表',1,''),(755,'admin',1,'Admin/Config/contact','客服配置',1,''),(754,'admin',1,'Admin/Issuelog/index','认购记录',1,''),(753,'admin',1,'Admin/Mycztype/status','状态修改',1,''),(752,'admin',1,'Admin/Mycz/status','修改',1,''),(751,'admin',1,'Admin/Usercoin/edit','财产修改',1,''),(750,'admin',1,'Admin/Trade/chat','交易聊天',1,''),(749,'admin',1,'Admin/Chat/status','修改',1,''),(748,'admin',1,'Admin/Chat/edit','编辑',1,''),(747,'admin',1,'Admin/Tools/dataImport','还原数据库',1,''),(746,'admin',1,'Admin/Tools/dataExport','备份数据库',1,''),(745,'admin',1,'Admin/Finance/mytxStatus','修改状态',1,''),(744,'admin',1,'Admin/Finance/myczTypeImage','上传图片',1,''),(743,'admin',1,'Admin/Finance/myczTypeStatus','状态修改',1,''),(742,'admin',1,'Admin/Article/type','文章类型',1,''),(741,'admin',1,'Admin/Index/coin','币种统计',1,''),(740,'admin',1,'Admin/Link/status','修改',1,''),(739,'admin',1,'Admin/Link/edit','编辑',1,''),(738,'admin',1,'Admin/Cloud/update','自动升级',1,''),(737,'admin',1,'Admin/Invit/config','推广配置',1,''),(736,'admin',1,'Admin/User/admin','管理员管理',1,''),(735,'admin',1,'Admin/Config/moble','短信配置',1,''),(734,'admin',1,'Admin/Issue/status','认购修改',1,''),(733,'admin',1,'Admin/Issue/edit','认购编辑',1,''),(732,'admin',1,'Admin/Finance/mycz','人民币充值',1,''),(731,'admin',1,'Admin/User/index_status','修改',1,''),(730,'admin',1,'Admin/User/index_edit','编辑',1,''),(729,'admin',1,'Admin/Trade/log','成交记录',1,''),(728,'admin',1,'Admin/Adver/status','修改',1,''),(727,'admin',1,'Admin/Adver/edit','编辑',1,''),(726,'admin',1,'Admin/Article/images','上传图片',1,''),(725,'admin',1,'Admin/User/goodsStatus','修改状态',1,''),(724,'admin',1,'Admin/User/goodsEdit','编辑添加',1,''),(723,'admin',1,'Admin/User/coinLog','财产统计',1,''),(722,'admin',1,'Admin/User/coinEdit','编辑添加',1,''),(721,'admin',1,'Admin/User/bankStatus','修改状态',1,''),(720,'admin',1,'Admin/User/bankEdit','编辑添加',1,''),(719,'admin',1,'Admin/User/qianbaoStatus','修改状态',1,''),(718,'admin',1,'Admin/User/qianbaoEdit','编辑添加',1,''),(717,'admin',1,'Admin/User/logStatus','修改状态',1,''),(716,'admin',1,'Admin/User/logEdit','编辑添加',1,''),(715,'admin',1,'Admin/User/authUserRemove','成员授权解除',1,''),(714,'admin',1,'Admin/User/authUserAdd','成员授权增加',1,''),(713,'admin',1,'Admin/User/authUser','成员授权',1,''),(712,'admin',1,'Admin/User/authAccessUp','访问授权修改',1,''),(711,'admin',1,'Admin/User/authAccess','访问授权',1,''),(710,'admin',1,'Admin/User/authStart','重新初始化权限',1,''),(709,'admin',1,'Admin/User/authStatus','修改状态',1,''),(708,'admin',1,'Admin/User/authEdit','编辑添加',1,''),(707,'admin',1,'Admin/User/adminStatus','修改状态',1,''),(706,'admin',1,'Admin/User/adminEdit','编辑添加',1,''),(705,'admin',1,'Admin/Tools/index','清理缓存',1,''),(704,'admin',1,'Admin/Article/adverEdit','编辑添加',1,''),(703,'admin',1,'Admin/Article/linkEdit','编辑添加',1,''),(702,'admin',1,'Admin/Article/typeEdit','编辑添加',1,''),(701,'admin',1,'Admin/Cloud/index','云市场',1,''),(700,'admin',1,'Admin/Articletype/edit','编辑',1,''),(699,'admin',1,'Admin/Index/operate','市场统计',1,''),(698,'admin',1,'AdminUser/edit','后台用户编辑',1,''),(697,'admin',1,'AdminUser/add','后台用户新增',1,''),(696,'admin',1,'AdminUser/status','后台用户状态',1,''),(695,'admin',1,'AdminUser/detail','后台用户详情',1,''),(694,'admin',1,'Admin/Finance/myczTypeEdit','编辑添加',1,''),(693,'admin',1,'Admin/Issue/log','认购记录',1,''),(692,'admin',1,'Admin/User/edit','编辑添加',1,''),(691,'admin',1,'Admin/User/status','修改状态',1,''),(690,'admin',1,'Admin/Config/index','基本配置',1,''),(689,'admin',1,'Admin/Issue/index','认购管理',1,''),(688,'admin',1,'Admin/Operate/index','推广奖励',1,''),(687,'admin',1,'Admin/Trade/index','委托管理',1,''),(686,'admin',1,'Admin/Finance/type_status','状态修改',1,''),(685,'admin',1,'Admin/Finance/type','类型',1,''),(684,'admin',1,'Admin/Finance/config','配置',1,''),(683,'admin',1,'Admin/Finance/index','财务明细',1,''),(682,'admin',1,'Admin/User/config','用户配置',1,''),(681,'admin',1,'Admin/User/index','用户管理',1,''),(680,'admin',1,'Admin/Text/status','修改',1,''),(679,'admin',1,'Admin/Text/edit','编辑',1,''),(678,'admin',1,'Admin/Text/index','提示文字',1,''),(489,'admin',2,'Admin/Operate/index','运营',1,''),(677,'admin',1,'Admin/Article/edit','编辑添加',1,''),(676,'admin',1,'Admin/Article/index','文章管理',1,''),(675,'admin',1,'Admin/Index/index','系统概览',1,''),(674,'admin',2,'Admin/Cloud/index','扩展',1,''),(673,'admin',2,'Admin/Tools/index','工具',1,''),(672,'admin',2,'Admin/Config/index','设置',1,''),(671,'admin',2,'Admin/Game/index','应用',1,''),(670,'admin',2,'Admin/Trade/index','交易',1,''),(669,'admin',2,'Admin/Finance/index','财务',1,''),(668,'admin',2,'Admin/User/index','用户',1,''),(667,'admin',2,'Admin/Article/index','内容',1,''),(666,'admin',2,'Admin/Index/index','系统',1,''),(665,'admin',1,'Admin/User/setpwd','修改管理员密码',1,''),(664,'admin',1,'Admin/Login/loginout','用户退出',1,''),(663,'admin',1,'Admin/Login/index','用户登录',1,''),(662,'admin',1,'Admin/Shop/images','图片',1,''),(661,'admin',1,'Admin/Trade/chexiao','撤销挂单',1,''),(660,'admin',1,'Admin/Trade/status','修改状态',1,''),(659,'admin',1,'Admin/AuthManager/addToModel','模型添加到用户组',1,''),(658,'admin',1,'Admin/AuthManager/addToCategory','分类添加到用户组',1,''),(657,'admin',1,'Admin/AuthManager/removeFromGroup','用户组移除',1,''),(656,'admin',1,'Admin/AuthManager/addToGroup','添加到用户组',1,''),(655,'admin',1,'Admin/AuthManager/group','用户组',1,''),(654,'admin',1,'Admin/AuthManager/tree','成员列表授权',1,''),(653,'admin',1,'Admin/AuthManager/user','成员授权',1,''),(652,'admin',1,'Admin/AuthManager/category','分类授权',1,''),(651,'admin',1,'Admin/AuthManager/access','访问授权',1,''),(650,'admin',1,'Admin/AuthManager/changeStatus','改变状态',1,''),(649,'admin',1,'Admin/AuthManager/writeGroup','更新用户组',1,''),(648,'admin',1,'Admin/AuthManager/editgroup','编辑用户组',1,''),(647,'admin',1,'Admin/AuthManager/createGroup','新增用户组',1,''),(783,'admin',1,'Admin/Tools/importExecl','导入Excel',1,''),(784,'admin',1,'Admin/User/detail','用户详情',1,''),(785,'admin',1,'Admin/Article/link','友情链接',1,''),(786,'admin',1,'Admin/Finance/mytxChuli','正在处理',1,''),(787,'admin',1,'Admin/Finance/mytxConfig','人民币提现配置',1,''),(788,'admin',1,'Admin/Trade/market','交易市场',1,''),(789,'admin',1,'Admin/Mytx/status','状态修改',1,''),(790,'admin',1,'Admin/Mytx/excel','取消',1,''),(791,'admin',1,'Admin/Mytx/exportExcel','导入excel',1,''),(792,'admin',1,'Admin/Menu/index','菜单管理',1,''),(793,'admin',1,'Admin/Menu/sort','排序',1,''),(794,'admin',1,'Admin/Menu/add','添加',1,''),(795,'admin',1,'Admin/Menu/edit','编辑',1,''),(796,'admin',1,'Admin/Menu/del','删除',1,''),(797,'admin',1,'Admin/Menu/toogleHide','是否隐藏',1,''),(798,'admin',1,'Admin/Menu/toogleDev','是否开发',1,''),(799,'admin',1,'Admin/Menu/importFile','导入文件',1,''),(800,'admin',1,'Admin/Menu/import','导入',1,''),(801,'admin',1,'Admin/User/qianbao','用户钱包',1,''),(802,'admin',1,'Admin/Config/text','提示文字',1,''),(803,'admin',1,'Admin/Finance/mytxChexiao','撤销提现',1,''),(804,'admin',1,'Admin/Cloud/kefu','客服代码',1,''),(805,'admin',1,'Admin/Cloud/kefuUp','使用',1,''),(806,'admin',1,'Admin/User/bank','提现地址',1,''),(807,'admin',1,'Admin/Finance/myzr','虚拟币转入',1,''),(808,'admin',1,'Admin/Trade/invit','交易推荐',1,''),(809,'admin',1,'Admin/Config/qita','其他配置',1,''),(810,'admin',1,'Admin/Finance/mytxQueren','确认提现',1,''),(811,'admin',1,'Admin/Finance/myzcQueren','确认转出',1,''),(812,'admin',1,'Admin/Config/daohang','导航配置',1,''),(813,'admin',1,'Admin/Verify/code','图形验证码',1,''),(814,'admin',1,'Admin/Verify/mobile','手机验证码',1,''),(815,'admin',1,'Admin/Verify/email','邮件验证码',1,''),(816,'admin',1,'Admin/Finance/myzc','虚拟币转出',1,''),(817,'admin',1,'Admin/User/coin','用户财产',1,''),(818,'admin',1,'Admin/User/myzc_qr','确认转出',1,''),(819,'admin',1,'Admin/User/goods','联系地址',1,''),(820,'admin',1,'Admin/Article/status','修改状态',1,''),(821,'admin',1,'Admin/Finance/myczStatus','修改状态',1,''),(822,'admin',1,'Admin/Finance/myczQueren','确认到账',1,''),(823,'admin',1,'Admin/Article/typeStatus','修改状态',1,''),(824,'admin',1,'Admin/Article/linkStatus','修改状态',1,''),(825,'admin',1,'Admin/Article/adverStatus','修改状态',1,''),(826,'admin',1,'Admin/Article/adverImage','上传图片',1,'');

/*Table structure for table `movesay_bazaar` */

DROP TABLE IF EXISTS `movesay_bazaar`;

CREATE TABLE `movesay_bazaar` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `coin` varchar(50) NOT NULL DEFAULT '',
  `price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `num` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `deal` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `mum` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `fee` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='集市交易表';

/*Data for the table `movesay_bazaar` */

/*Table structure for table `movesay_bazaar_log` */

DROP TABLE IF EXISTS `movesay_bazaar_log`;

CREATE TABLE `movesay_bazaar_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `peerid` int(11) unsigned NOT NULL DEFAULT '0',
  `coin` varchar(50) NOT NULL DEFAULT '',
  `price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `num` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `mum` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `fee` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `status` (`status`),
  KEY `peerid` (`peerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='集市交易记录表';

/*Data for the table `movesay_bazaar_log` */

/*Table structure for table `movesay_category` */

DROP TABLE IF EXISTS `movesay_category`;

CREATE TABLE `movesay_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '标志',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL DEFAULT '' COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL DEFAULT '' COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '关联模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='分类表';

/*Data for the table `movesay_category` */

insert  into `movesay_category`(`id`,`name`,`title`,`pid`,`sort`,`list_row`,`meta_title`,`keywords`,`description`,`template_index`,`template_lists`,`template_detail`,`template_edit`,`model`,`type`,`link_id`,`allow_publish`,`display`,`reply`,`check`,`reply_model`,`extend`,`create_time`,`update_time`,`status`,`icon`) values (1,'blog','默认',0,0,10,'','','','','','','','2','2,1',0,0,1,0,0,'1','',1379474947,1382701539,1,0),(2,'default_blog','默认分类',1,1,10,'','','','','','','','2','2,1,3',0,1,1,0,1,'1','',1379475028,1386839751,1,31);

/*Table structure for table `movesay_chat` */

DROP TABLE IF EXISTS `movesay_chat`;

CREATE TABLE `movesay_chat` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(20) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `content` varchar(255) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文字聊天表';

/*Data for the table `movesay_chat` */

/*Table structure for table `movesay_coin` */

DROP TABLE IF EXISTS `movesay_coin`;

CREATE TABLE `movesay_coin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `type` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(50) NOT NULL DEFAULT '',
  `img` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `fee_bili` varchar(50) NOT NULL DEFAULT '',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) unsigned NOT NULL DEFAULT '0',
  `dj_zj` varchar(200) NOT NULL DEFAULT '',
  `dj_dk` varchar(200) NOT NULL DEFAULT '',
  `dj_yh` varchar(200) NOT NULL DEFAULT '',
  `dj_mm` varchar(200) NOT NULL DEFAULT '',
  `zr_zs` varchar(50) NOT NULL DEFAULT '',
  `zr_jz` varchar(50) NOT NULL DEFAULT '',
  `zr_dz` varchar(50) NOT NULL DEFAULT '',
  `zr_sm` varchar(50) NOT NULL DEFAULT '',
  `zc_sm` varchar(50) NOT NULL DEFAULT '',
  `zc_fee` varchar(50) NOT NULL DEFAULT '',
  `zc_user` varchar(50) NOT NULL DEFAULT '',
  `zc_min` varchar(50) NOT NULL DEFAULT '',
  `zc_max` varchar(50) NOT NULL DEFAULT '',
  `zc_jz` varchar(50) NOT NULL DEFAULT '',
  `zc_zd` varchar(50) NOT NULL DEFAULT '',
  `js_yw` varchar(50) NOT NULL DEFAULT '',
  `js_sm` text,
  `js_qb` varchar(50) NOT NULL DEFAULT '',
  `js_ym` varchar(50) NOT NULL DEFAULT '',
  `js_gw` varchar(50) NOT NULL DEFAULT '',
  `js_lt` varchar(50) NOT NULL DEFAULT '',
  `js_wk` varchar(50) NOT NULL DEFAULT '',
  `cs_yf` varchar(50) NOT NULL DEFAULT '',
  `cs_sf` varchar(50) NOT NULL DEFAULT '',
  `cs_fb` varchar(50) NOT NULL DEFAULT '',
  `cs_qk` varchar(50) NOT NULL DEFAULT '',
  `cs_zl` varchar(50) NOT NULL DEFAULT '',
  `cs_cl` varchar(50) NOT NULL DEFAULT '',
  `cs_zm` varchar(50) NOT NULL DEFAULT '',
  `cs_nd` varchar(50) NOT NULL DEFAULT '',
  `cs_jl` varchar(50) NOT NULL DEFAULT '',
  `cs_ts` varchar(50) NOT NULL DEFAULT '',
  `cs_bz` varchar(50) NOT NULL DEFAULT '',
  `tp_zs` varchar(50) NOT NULL DEFAULT '',
  `tp_js` varchar(50) NOT NULL DEFAULT '',
  `tp_yy` varchar(50) NOT NULL DEFAULT '',
  `tp_qj` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='币种配置表';

/*Data for the table `movesay_coin` */

insert  into `movesay_coin`(`id`,`name`,`type`,`title`,`img`,`sort`,`fee_bili`,`endtime`,`addtime`,`status`,`dj_zj`,`dj_dk`,`dj_yh`,`dj_mm`,`zr_zs`,`zr_jz`,`zr_dz`,`zr_sm`,`zc_sm`,`zc_fee`,`zc_user`,`zc_min`,`zc_max`,`zc_jz`,`zc_zd`,`js_yw`,`js_sm`,`js_qb`,`js_ym`,`js_gw`,`js_lt`,`js_wk`,`cs_yf`,`cs_sf`,`cs_fb`,`cs_qk`,`cs_zl`,`cs_cl`,`cs_zm`,`cs_nd`,`cs_jl`,`cs_ts`,`cs_bz`,`tp_zs`,`tp_js`,`tp_yy`,`tp_qj`) values (1,'cny','rmb','人民币','cny.png',0,'',0,0,1,'182.254.134.191','0','0','0','0','1','0','0','0','','','','','1','','','','','','','','','','','','','','','','','','','','','','',''),(43,'btc','qbb','比特币','580c506a2a452.jpg',0,'100',0,0,1,'54.249.82.81','8332','btcuser','eafaefeawljioijlsergiu394805rtjkl34jthyo34i','0','1','1','','','0','0','0','10000','1','10','bitcoin','<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#FFFFFF;\">\r\n	       比特币（BitCoin）的概念最初由中本聪在2009年提出，根据中本聪的思路设计发布的开源软件以及建构其上的<a target=\"_blank\" href=\"http://baike.baidu.com/view/3280.htm\">P2P</a>网络。比特币是一种P2P形式的数字货币。点对点的传输意味着一个去中心化的支付系统。\r\n</div>\r\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#FFFFFF;\">\r\n	与大多数货币不同，比特币不依靠特定货币机构发行，它依据特定算法，通过大量的计算产生，比特币经济使用整个P2P网络中众多节点构成的<a target=\"_blank\" href=\"http://baike.baidu.com/view/68389.htm\">分布式数据库</a>来确认并记录所有的交易行为，并使用密码学的设计来确保货币流通各个环节<a target=\"_blank\" href=\"http://baike.baidu.com/view/421194.htm\">安全性</a>。P2P的去中心化特性与算法本身可以确保无法通过大量制造比特币来人为操控币值。基于密码学的设计可以使比特币只能被真实的拥有者转移或支付。这同样确保了货币所有权与流通交易的匿名性。比特币与其他<a target=\"_blank\" href=\"http://baike.baidu.com/view/16260.htm\">虚拟货币</a>最大的不同，是其总数量非常有限，具有极强的稀缺性。该货币系统曾在4年内只有不超过1050万个，之后的总数量将被永久限制在2100万个。\r\n</div>\r\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#FFFFFF;\">\r\n	比特币可以用来兑现，可以兑换成大多数国家的货币。使用者可以用比特币购买一些<a target=\"_blank\" href=\"http://baike.baidu.com/view/73493.htm\">虚拟物品</a>，比如网络游戏当中的衣服、<a target=\"_blank\" href=\"http://baike.baidu.com/view/54792.htm\">帽子</a>、装备等，只要有人接受，也可以使用比特币购买现实生活当中的物品。\r\n</div>','https://bitcoin.org/en/download','https://github.com/bitcoin/bitcoin','https://bitcoin.org','https://bitcointalk.org','https://en.bitcoin.it/wiki/Comparison_of_mining_po','Dorian S. Nakamoto','SHA-256','2009/01/09','600秒/块','21000000','14750000','pow','2016','50','虚拟币始创者，受众最广，被信任最高','确认时间长','2','10','10','10'),(47,'ftc','rgb','法特币','580c4cc362c49.jpg',0,'0',0,0,1,'','','','','0','1','1','','','0','','0','10000','1','100','Fast currency','','','','','','','','','','','','','','','','','','','','','');

/*Table structure for table `movesay_coin_comment` */

DROP TABLE IF EXISTS `movesay_coin_comment`;

CREATE TABLE `movesay_coin_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL DEFAULT '0',
  `coinname` varchar(50) NOT NULL DEFAULT '',
  `content` varchar(500) NOT NULL DEFAULT '',
  `cjz` int(11) unsigned NOT NULL DEFAULT '0',
  `tzy` int(11) unsigned NOT NULL DEFAULT '0',
  `xcd` int(11) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `movesay_coin_comment` */

/*Table structure for table `movesay_config` */

DROP TABLE IF EXISTS `movesay_config`;

CREATE TABLE `movesay_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `moble_key` varchar(200) NOT NULL DEFAULT '' COMMENT '名称',
  `footer_logo` varchar(200) NOT NULL DEFAULT '' COMMENT ' ',
  `kefu` varchar(200) NOT NULL DEFAULT '',
  `web_name` varchar(200) NOT NULL DEFAULT '',
  `web_title` varchar(200) NOT NULL DEFAULT '',
  `web_logo` varchar(200) NOT NULL DEFAULT '',
  `web_llogo_small` varchar(200) NOT NULL DEFAULT '',
  `web_keywords` varchar(200) NOT NULL DEFAULT '',
  `web_description` varchar(200) NOT NULL DEFAULT '',
  `web_close` varchar(50) NOT NULL DEFAULT '',
  `web_close_cause` varchar(200) NOT NULL DEFAULT '',
  `web_icp` varchar(50) NOT NULL DEFAULT '',
  `web_cnzz` text,
  `web_reg` text,
  `web_waring` text,
  `market_mr` varchar(50) NOT NULL DEFAULT '',
  `xnb_mr` varchar(50) NOT NULL DEFAULT '',
  `rmb_mr` varchar(50) NOT NULL DEFAULT '',
  `moble_type` text,
  `moble_url` text,
  `moble_user` text,
  `moble_pwd` text,
  `contact_moble` text,
  `contact_weibo` text,
  `contact_tqq` text,
  `contact_qq` text,
  `contact_qqun` text,
  `contact_weixin` text,
  `contact_weixin_img` text,
  `contact_email` text,
  `contact_alipay` text,
  `contact_alipay_img` text,
  `contact_bank` text,
  `user_truename` text,
  `user_moble` text,
  `user_alipay` text,
  `user_bank` text,
  `mytx_min` text,
  `mytx_max` text,
  `mytx_bei` text,
  `mytx_coin` text,
  `mytx_fee` text,
  `trade_min` text,
  `trade_max` text,
  `trade_limit` text,
  `trade_text_log` text,
  `issue_ci` text,
  `issue_jian` text,
  `issue_min` text,
  `issue_max` text,
  `money_min` text,
  `money_max` text,
  `money_bei` text,
  `invit_type` text,
  `invit_fee1` text,
  `invit_fee2` text,
  `invit_fee3` text,
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  `index_html` varchar(50) DEFAULT NULL,
  `invit_text_txt` text,
  `top_name` text,
  `dollar2rmb` float(10,2) DEFAULT '0.00' COMMENT '人民币对人民币汇率',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统配置表';

/*Data for the table `movesay_config` */

insert  into `movesay_config`(`id`,`moble_key`,`footer_logo`,`kefu`,`web_name`,`web_title`,`web_logo`,`web_llogo_small`,`web_keywords`,`web_description`,`web_close`,`web_close_cause`,`web_icp`,`web_cnzz`,`web_reg`,`web_waring`,`market_mr`,`xnb_mr`,`rmb_mr`,`moble_type`,`moble_url`,`moble_user`,`moble_pwd`,`contact_moble`,`contact_weibo`,`contact_tqq`,`contact_qq`,`contact_qqun`,`contact_weixin`,`contact_weixin_img`,`contact_email`,`contact_alipay`,`contact_alipay_img`,`contact_bank`,`user_truename`,`user_moble`,`user_alipay`,`user_bank`,`mytx_min`,`mytx_max`,`mytx_bei`,`mytx_coin`,`mytx_fee`,`trade_min`,`trade_max`,`trade_limit`,`trade_text_log`,`issue_ci`,`issue_jian`,`issue_min`,`issue_max`,`money_min`,`money_max`,`money_bei`,`invit_type`,`invit_fee1`,`invit_fee2`,`invit_fee3`,`addtime`,`status`,`index_html`,`invit_text_txt`,`top_name`,`dollar2rmb`) values (1,'251625db06d83c67ff666b81c825e43d','580c51fbb19a6.png','a','OK Money3','OK Money','580c51f4e1e5c.png','580c51f878c1e.png','法特币交易平台,比特币交易平台，莱特币交易平台','OK Money','1','升级中...','粤ICP备88888888号-1','<script type=\"text/javascript\">var cnzz_protocol = ((\"https:\" == document.location.protocol) ? \" https://\" : \" http://\");document.write(unescape(\"%3Cspan id=\'cnzz_stat_icon_1256773398\'%3E%3C/span%3E%3Cscript src=\'\" + cnzz_protocol + \"s11.cnzz.com/z_stat.php%3Fid%3D1256773398\' type=\'text/javascript\'%3E%3C/script%3E\"));</script>','<div style=\"text-align:center;\">\r\n	<div style=\"text-align:left;\">\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			<br />\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			<br />\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			用户协议\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			     OK MONEY交易平台所提供的各项服务的所有权和运作权均归OK MONEY交易所股份有限公司所有。OK MONEY交易平台用户注册使用协议（以下简称“本协议”） 系由OK MONEY交易平台用户与OK MONEY有限公司就OK MONEY交易平台的各项服务所订立的相关权利义务规范。用户通过访问或使用本网站， 即表示接受并同意本协议的所有条件和条款。OK MONEY有限公司作为OK MONEY交易平台的运营者依据本协议为用户提供服务。不愿接受本协议条款的， 不得访问或使用本网站。OK MONEY有限公司有权对本协议条款进行修改，修改后的协议一旦公布即有效代替原来的协议。用户可随时查阅最新协议。\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			服务内容\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			1、OK MONEY有限公司运用自己的系统，通过互联网络等方式为用户提供虚拟币的交易服务。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			2、用户必须自行准备如下设备和承担如下开支： \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			  ①上网设备，包括并不限于电脑或者其他上网终端、调制解调器及其他上网装置。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			  ②上网开支，包括并不限于网络接入费、上网设备租用费、手机流量费等。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			3、用户提供的注册资料，用户必须同意：\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			  ①提供中华人民共和国大陆地区合法、真实、准确、详尽的个人资料。\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			  ②如有变动，及时更新用户资料。如果用户提供的注册资料不合法、不真实、不准确、不详尽的，用户需承担因此引起的相应责任及后果， 并且OK MONEY有限公司保留终止用户使用OK MONEY交易平台各项服务的权利。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			<br />\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			服务的提供、修改及终止\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			1、用户在接受OK MONEY交易平台各项服务的同时，同意接受OK MONEY交易平台提供的各类信息服务。 用户在此授权OK MONEY有限公司可以向其电子邮件、手机、通信地址等发送商业信息。 用户有权选择不接受OK MONEY交易平台提供的各类信息服务，并进入OK MONEY交易平台相关页面进行更改。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			2、OK MONEY交易平台保留随时修改或中断服务而不需通知用户的权利。OK MONEY交易平台有权行使修改或中断服务的权利， 不需对用户或任何无直接关系的第三方负责。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			3、用户对本协议的修改有异议，或对OK MONEY交易平台的服务不满，可以行使如下权利： \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			  ①停止使用OK MONEY交易平台的网络服务。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			  ②通过客服等渠道告知OK MONEY交易平台停止对其服务。 结束服务后，用户使用OK MONEY交易平台网络服务的权利立即终止。 在此情况下，OK MONEY交易平台没有义务传送任何未处理的信息或未完成的服务给用户或任何无直接关系的第三方。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			<br />\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			用户信息的保密\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			1、本协议所称之OK MONEY交易平台用户信息是指符合法律、法规及相关规定，并符合下述范围的信息：\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			  ①用户注册OK MONEY账户时，向OK MONEY交易平台提供的个人信息。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			  ②用户在使用OK MONEY交易平台服务、参加网站活动或访问网站网页时，OK MONEY交易平台自动接收并记录的用户浏览器端或手机客户端数据， 包括但不限于IP地址、网站中的资料及用户要求取用的网页记录。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			  ③OK MONEY交易平台从商业伙伴处合法获取的用户个人信息。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			  ④其它OK MONEY交易平台通过合法途径获取的用户个人信息。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			2、OK MONEY有限公司承诺：非经法定原因或用户事先许可，不会向任何第三方透露用户的密码、姓名、 手机号码等非公开信息。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			3、在下述法定情况下，用户的个人信息将会被部分或全部披露： \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			  ①经用户同意向用户本人或其他第三方披露。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			  ②根据法律、法规等相关规定，或行政机构要求，向行政、司法机构或其他法律规定的第三方披露。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			  ③其它OK MONEY有限公司根据法律、法规等相关规定进行的披露。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			<br />\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			<br />\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			用户权利\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			1、用户的用户名、密码和安全性： \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			  ①用户有权选择是否成为OK MONEY交易平台用户，用户选择成为OK MONEY交易平台注册用户时，可自行输入手机号为帐号。 用户名和帐号使用应遵守相关法律法规并符合网络道德。用户名和帐号中不能含有任何侮辱、威胁、淫秽、 谩骂等侵害他人合法权益的文字。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			 ②用户一旦注册成功，成为OK MONEY交易平台的用户，将得到用户名和密码， 并对以此组用户名和密码登入系统后所发生的所有活动和事件负责，自行承担一切使用该用户名的言语、 行为等而直接或者间接导致的法律责任。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			 ③用户有义务妥善保管OK MONEY交易平台账号、用户名和密码，用户将对用户名和密码安全负全部责任。 因用户原因导致用户名或密码泄露而造成的任何法律后果由用户本人负责，由于用户自身原因泄露这些信息导致的财产损失， 本站不负相关责任。由于本站是交易网站，登录密码、提现密码、交易密码等不得使用相同密码，否则会有安全隐患， 相关责任由用户自身承担。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			④用户密码遗失的，可以通过绑定的手机号码重置密码。用户若发现任何非法使用用户名或存在其他安全漏洞的情况， 应立即告知OK MONEY交易平台运营平台。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			⑤OK MONEY交易平台不会向任何用户索取密码，不会让用户往任何非本站交易中心里提供的帐户打款， 请大家不要相信任何非OK MONEY有限公司提供的打折、优惠等诈骗信息，往非OK MONEY交易平台提供的账户、 地址里打款或币造成的损失本站不负责任。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			2、用户有权根据网站相关规定，在发布信息等贡献后，取得OK MONEY交易平台给予的奖励。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			3、用户有权修改其个人账户中各项可修改信息，自行录入介绍性文字，自行决定是否提供非必填项的内容。4、用户有权参加OK MONEY交易平台组织提供的各项线上、线下活动。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			5、用户有权根据OK MONEY交易平台网站规定，享受OK MONEY交易平台提供的其它各类服务。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			<br />\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			用户义务\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			1、不得利用本站危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益，不得利用本站制作、 复制和传播下列信息： \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			①煽动抗拒、破坏宪法和法律、行政法规实施的。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			②煽动颠覆国家政权，推翻社会主义制度的。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			③煽动分裂国家、破坏国家统一的。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			④煽动民族仇恨、民族歧视，破坏民族团结的。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			⑤捏造或者歪曲事实，散布谣言，扰乱社会秩序的。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			⑥宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			⑦公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			⑧损害国家机关信誉的。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			⑨其他违反宪法和法律行政法规的。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			⑩进行商业广告行为的。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			2、用户不得通过任何手段恶意注册OK MONEY交易平台网站帐号，包括但不限于以牟利、炒作、套现、 获奖等为目的多个账号注册。用户亦不得盗用其他用户帐号,或者利用OK MONEY交易平台以及交易平台漏洞刷取OK MONEY。 如用户违反上述规定，则OK MONEY交易平台有权直接采取一切必要的措施，包括但不限于删除用户发布的内容、 取消用户在网站获得的虚拟财富，暂停或查封用户帐号，取消因违规所获利益，乃至通过诉讼形式追究用户法律责任等。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			3、禁止用户将OK MONEY交易平台以任何形式作为从事各种非法活动的场所、平台或媒介。 未经OK MONEY交易平台运营平台的授权或许可，用户不得借用本站的名义从事任何商业活动， 也不得以任何形式将OK MONEY交易平台作为从事商业活动的场所、平台或媒介。如用户违反上述规定， 则OK MONEY交易平台运营平台有权直接采取一切必要的措施，包括但不限于删除用户发布的内容、取消用户在网站获得的虚拟财富， 暂停或查封用户帐号，取消因违规所获利益，乃至通过诉讼形式追究用户法律责任等。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			4、用户在OK MONEY交易平台以各种形式发布的一切信息，均应符合国家法律法规等相关规定及网站相关规定， 符合社会公序良俗，并不侵犯任何第三方主体的合法权益，否则用户自行承担因此产生的一切法律后果， 且OK MONEY有限公司因此受到的损失，有权向用户追偿。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			5、按照OK MONEY有限公司的要求准确提供并及时更新您正确、最新及完整的身份信息及相关资料。 若OK MONEY有限公司有合理理由怀疑您提供的身份信息即相关资料错误、不实、过失或不完整的， OK MONEY有限公司有权要求您补充相关资料来证明您身份的真实性。若您不能及时配合提供， OK MONEY有限公司有权暂停或终止向您提供服务。OK MONEY有限公司对此不承担任何责任， 您将承担因此产生的任何直接或间接支出。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			6、用户应当有独立的风险承担能力，以及具备相应的民事行为能力，注册实名认证用户应为中国大陆地区公民， 年龄限制在16周岁~70周岁。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			<br />\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			拒绝担保与免责\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			1、OK MONEY交易平台作为“网络服务提供者”的第三方平台，不担保网站平台上的信息及服务能充分满足用户的需求。 对于用户在接受OK MONEY交易平台的服务过程中可能遇到的错误、侮辱、诽谤、不作为、淫秽、色情或亵渎事件， OK MONEY交易平台不承担法律责任。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			2、基于互联网的特殊性，OK MONEY交易平台也不担保服务不会受中断，对服务的及时性、安全性都不作担保， 不承担非因OK MONEY交易平台导致的责任。 OK MONEY交易平台力图使用户能对本网站进行安全访问和使用， 但OK MONEY交易平台不声明也不保证本网站或其服务器是不含病毒或其它潜在有害因素的。 因此用户应使用业界公认的软件查杀任何自OK MONEY交易平台下载文件中的病毒。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			3、OK MONEY交易平台不对用户所发布信息的保存、修改、删除或储存失败负责。 对网站上的非因OK MONEY交易平台故意所导致的排字错误、疏忽等不承担责任。 OK MONEY交易平台有权但无义务， 改善或更正本网站任何部分之疏漏、错误。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			4、除非OK MONEY交易平台以书面形式明确约定，OK MONEY交易平台对于用户以任何方式（包括但不限于包含、经由、连接或下载 ）从本网站所获得的任何内容信息，包括但不限于广告等，不保证其准确性、完整性、可靠性； 对于用户因本网站上的内容信息而购买、获取的任何产品、服务、信息或资料，OK MONEY交易平台不承担责任。 用户自行承担使用本网站信息内容所导致的风险。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			5、OK MONEY交易平台内所有用户所发表的用户评论，仅代表用户个人观点， 并不表示本网站赞同其观点或证实其描述，本网站不承担用户评论引发的任何法律责任。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			6、OK MONEY有限公司有权删除OK MONEY交易平台内各类不符合法律或协议规定的信息，而保留不通知用户的权利。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			7、所有发给用户的通告，OK MONEY交易平台都将通过正式的页面公告、站内信、电子邮件、客服电话、 手机短信或常规的信件送达。任何非经OK MONEY交易平台正规渠道获得的中奖、优惠等活动或信息， OK MONEY交易平台不承担法律责任。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			<br />\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			适用法律和裁判地点\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			1、因用户使用OK MONEY交易平台而引起或与之相关的一切争议、权利主张或其它事项， 均受中华人民共和国法律的管辖。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			2、用户和OK MONEY有限公司发生争议的，应首先本着诚信原则通过协商加以解决。 如果协商不成，则应向OK MONEY有限公司所在地人民法院提起诉讼。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			<br />\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			可分性\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			如果本协议的任何条款被视为不合法、无效或因任何原因而无法执行，则此等规定应视为可分割， 不影响任何其它条款的法律效力。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			<br />\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			冲突选择\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			本协议是OK MONEY有限公司与用户注册成为OK MONEY交易平台用户，使用OK MONEY交易平台服务之间的重要法律文件， OK MONEY有限公司或者用户的任何其他书面或者口头意思表示与本协议不一致的，均应当以本协议为准。 \r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			               \r\n                 OK MONEY交易所股份有限公司\r\n		</p>\r\n		<p class=\"MsoNormal\" align=\"left\">\r\n			           \r\n    2016年1月1日<span></span> \r\n		</p>\r\n		<p>\r\n			<br />\r\n		</p>\r\n	</div>\r\n</div>\r\n<p>\r\n	<span style=\"font-size:10px;color:#E56600;\"></span> \r\n</p>','数字资产的交易存在极高风险(预挖、暴涨暴跌、庄家操控、团队解散、技术缺陷等)，作为全球的虚拟数字货币，他们都是全天24小时交易，没有涨跌限制，价格容易因为庄家、全球政府的政策影响而大幅波动，我们强烈建议您在自身能承受的风险范围内，参与虚拟货币交易，澳维网仅为数字货币的爱好者提供一个自由的网上交换平台，对币的投资价值不承担任何审查、担保、赔偿的责任，如果您不能接受，请不要进行交易！谢谢！','btc_cny','btc','cny','5c','http://utf8.sms.webchinese.cn/','mmmy','cyy15251','13888888888','http://weibo.com/','http://t.qq.com/','670551712|670551712','00000000|22222222','888888888','577504af69bde.png','88888888@qq.com','88888888@qq.com','577504af69fc0.png','中国银行|VFP交易所|0000 0000 0000 0000','2','2','2','2','100','10000','100','cny','1','1','10000000','10','&lt;span&gt;&lt;span&gt;你委托买入或者卖出成功交易后的记录.&lt;/span&gt;&lt;/span&gt;','5','24','1','100000','100','100000','100','1','5','3','2',1468988968,0,'a','OK Money','Tel：4000-000-000  Email：auvcoin@auvcoin.com  Work Time: mon-sun 8:00-23:00',6.80);

/*Table structure for table `movesay_daohang` */

DROP TABLE IF EXISTS `movesay_daohang`;

CREATE TABLE `movesay_daohang` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `title_en` varchar(255) DEFAULT NULL COMMENT '英文名称',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT 'url',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '编辑时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=gbk;

/*Data for the table `movesay_daohang` */

insert  into `movesay_daohang`(`id`,`name`,`title`,`title_en`,`url`,`sort`,`addtime`,`endtime`,`status`) values (1,'finance','财务中心','Financial','Finance/index',1,0,0,1),(2,'user','安全中心','Security','User/index',2,0,0,1),(3,'game','应用中心','Application','Game/index',3,0,0,1),(4,'article','帮助中心','Help','Article/index',4,0,0,1);

/*Table structure for table `movesay_fenhong` */

DROP TABLE IF EXISTS `movesay_fenhong`;

CREATE TABLE `movesay_fenhong` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `coinname` varchar(50) NOT NULL DEFAULT '',
  `coinjian` varchar(50) NOT NULL DEFAULT '',
  `num` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `movesay_fenhong` */

/*Table structure for table `movesay_fenhong_log` */

DROP TABLE IF EXISTS `movesay_fenhong_log`;

CREATE TABLE `movesay_fenhong_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `coinname` varchar(50) NOT NULL DEFAULT '',
  `coinjian` varchar(50) NOT NULL DEFAULT '',
  `fenzong` varchar(50) NOT NULL DEFAULT '',
  `fenchi` varchar(50) NOT NULL DEFAULT '',
  `price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `num` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `mum` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `movesay_fenhong_log` */

/*Table structure for table `movesay_finance` */

DROP TABLE IF EXISTS `movesay_finance`;

CREATE TABLE `movesay_finance` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `coinname` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '币种',
  `num_a` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000' COMMENT '之前正常',
  `num_b` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000' COMMENT '之前冻结',
  `num` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000' COMMENT '之前总计',
  `fee` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000' COMMENT '操作数量',
  `type` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '操作类型',
  `name` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '操作名称',
  `nameid` int(11) NOT NULL DEFAULT '0' COMMENT '操作详细',
  `remark` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '操作备注',
  `mum_a` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000' COMMENT '剩余正常',
  `mum_b` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000' COMMENT '剩余冻结',
  `mum` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000' COMMENT '剩余总计',
  `move` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '附加',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `coinname` (`coinname`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `movesay_finance` */

insert  into `movesay_finance`(`id`,`userid`,`coinname`,`num_a`,`num_b`,`num`,`fee`,`type`,`name`,`nameid`,`remark`,`mum_a`,`mum_b`,`mum`,`move`,`addtime`,`status`) values (1,2,'cny','7562898.80000000','2437100.20000000','9999999.00000000','10.00000000','1','mycz',16,'人民币充值-人工到账','7562908.80000000','2437100.20000000','10000009.00000000','8771417567c217ba74d128104a836a71',1467353433,0),(2,2,'cny','7562908.80000000','2437100.20000000','10000009.00000000','10.00000000','1','mycz',15,'人民币充值-人工到账','7562918.80000000','2437100.20000000','10000019.00000000','8f09dc3fb47c34decbd297fcc144fdc7',1467357883,1),(3,2,'cny','7562918.80000000','2437100.20000000','10000019.00000000','49999.00000000','1','mycz',18,'人民币充值-人工到账','7612917.80000000','2437100.20000000','10050018.00000000','73a87ed3cfae54c17432b0db24dab849',1467360090,1),(4,2,'cny','7612917.80000000','2437100.20000000','10050018.00000000','49999.00000000','1','mycz',17,'人民币充值-人工到账','7662916.80000000','2437100.20000000','10100017.00000000','53edc45aa13e9dcafe3af816ff72200f',1467360095,1),(5,2,'cny','7662916.80000000','2437100.20000000','10100017.00000000','1000.00000000','1','mycz',5,'人民币充值-人工到账','7663916.80000000','2437100.20000000','10101017.00000000','8b1d6d9202b76b144cc01206f8f90ca8',1467360110,1),(6,2,'cny','7663916.80000000','2437100.20000000','10101017.00000000','8000.00000000','2','mytx',1,'人民币提现-申请提现','7655916.80000000','2437100.20000000','10093017.00000000','db6ff11f28fc84b883678ddbee96b4b1',1467360198,1),(7,3,'cny','10000000.00000000','0.00000000','10000000.00000000','100.00000000','1','mycz',19,'人民币充值-人工到账','10000100.00000000','0.00000000','10000100.00000000','3007d59119b6ac51859da9d50eb9c529',1467614778,0),(8,2,'cny','0.00000000','2567875.60000000','2567875.60000000','47050.40000000','1','trade',71,'交易中心-交易撤销btc_cny','47050.40000000','2520825.20000000','2567875.60000000','d5492a53ad7cd3adb64fdbb734d49de3',1467633515,0),(9,2,'cny','0.00000000','2520825.20000000','2520825.20000000','999.00000000','1','mycz',27,'人民币充值-人工到账','999.00000000','2520825.20000000','2521824.20000000','f16f99c29419b64b61a8733edfe3c2a3',1469174860,0),(10,2,'cny','999.00000000','2520825.20000000','2521824.20000000','1.00000000','2','trade',84,'交易中心-委托买入-市场avc_cny','998.00000000','2520826.20000000','2521824.20000000','36edf021a79d8138f18beaab3c1ae401',1469772911,1),(11,2,'cny','998.00000000','2520826.20000000','2521824.20000000','1300650.00000000','1','trade',8,'交易中心-交易撤销btc_cny','1301648.00000000','1220176.20000000','2521824.20000000','7c19548e533925602532fdce4359a49b',1469773251,1),(12,2,'cny','1301648.00000000','1220176.20000000','2521824.20000000','218887.80000000','1','trade',7,'交易中心-交易撤销btc_cny','1520535.80000000','1001288.40000000','2521824.20000000','7cabecdb7417417d048f61ad1f6e4541',1469773253,1),(13,2,'cny','1520535.80000000','1001288.40000000','2521824.20000000','48946.40000000','1','trade',5,'交易中心-交易撤销btc_cny','1569482.20000000','952342.00000000','2521824.20000000','7f15c7dd04c46c577a8c0bb66693e339',1469773258,1),(14,2,'cny','1569482.20000000','952342.00000000','2521824.20000000','434000.00000000','1','trade',4,'交易中心-交易撤销btc_cny','2003482.20000000','518342.00000000','2521824.20000000','ce0171ab4086c240e020434f46dcf0a0',1469773275,1),(15,2,'cny','2003482.20000000','518342.00000000','2521824.20000000','2440.00000000','1','trade',1,'交易中心-交易撤销btc_cny','2005922.20000000','515902.00000000','2521824.20000000','633a82f741b4462480a1da7c7dd566ba',1469773282,1),(16,2,'cny','2005922.20000000','515902.00000000','2521824.20000000','3402.00000000','1','trade',24,'交易中心-交易撤销ltc_cny','2009324.20000000','512500.00000000','2521824.20000000','01e0400e08fb2d80027569f90b6a65bc',1469773290,1),(17,2,'cny','2009324.20000000','512500.00000000','2521824.20000000','7777.00000000','1','trade',23,'交易中心-交易撤销ltc_cny','2017101.20000000','504723.00000000','2521824.20000000','e578167f5a769f8a06edf64366ea1356',1469773294,1),(18,2,'cny','2017101.20000000','504723.00000000','2521824.20000000','4530.00000000','1','trade',22,'交易中心-交易撤销ltc_cny','2021631.20000000','500193.00000000','2521824.20000000','14c0cebbee277a147d7ddc3bcd2e728e',1469773297,1),(19,2,'cny','2021631.20000000','500193.00000000','2521824.20000000','11325.00000000','1','trade',21,'交易中心-交易撤销ltc_cny','2032956.20000000','488868.00000000','2521824.20000000','461027f67b76b7ea2e5af393352d2922',1469773301,1),(20,2,'cny','2032956.20000000','488868.00000000','2521824.20000000','24900.00000000','1','trade',15,'交易中心-交易撤销ltc_cny','2057856.20000000','463968.00000000','2521824.20000000','0f754203b942cd6c04b2bd718b2f4786',1469773575,1),(21,2,'cny','2057856.20000000','463968.00000000','2521824.20000000','4470.00000000','1','trade',31,'交易中心-交易撤销ytc_cny','2062326.20000000','459498.00000000','2521824.20000000','d411764a7542814a8c41c150979d4b78',1469773580,1),(22,2,'cny','2062326.20000000','459498.00000000','2521824.20000000','10000.00000000','1','trade',32,'交易中心-交易撤销ytc_cny','2072326.20000000','449498.00000000','2521824.20000000','64e5ab9fc58656ec5b0b2feafff821b4',1469773588,1),(23,2,'cny','2072326.20000000','449498.00000000','2521824.20000000','22685.00000000','1','trade',33,'交易中心-交易撤销ytc_cny','2095011.20000000','426813.00000000','2521824.20000000','ff9bf0f6866e5d010403270582dbbec1',1469773607,1),(24,2,'cny','2095011.20000000','426813.00000000','2521824.20000000','4359.00000000','1','trade',34,'交易中心-交易撤销ytc_cny','2099370.20000000','422454.00000000','2521824.20000000','894cc67bd5f0bda7bc3a07e8fe6164b7',1469773611,1),(25,2,'cny','2099370.20000000','422454.00000000','2521824.20000000','338728.00000000','1','trade',35,'交易中心-交易撤销ytc_cny','2438098.20000000','83726.00000000','2521824.20000000','08ab78a45b10ecd69d0a10eb576d8688',1469773616,1),(26,2,'cny','2438098.20000000','83726.00000000','2521824.20000000','83581.00000000','1','trade',48,'交易中心-交易撤销btc_cny','2521679.20000000','145.00000000','2521824.20000000','7a25abead15fefdccbeb7c822883e5c2',1469773628,1),(27,2,'cny','2521679.20000000','145.00000000','2521824.20000000','49.00000000','1','trade',62,'交易中心-交易撤销btc_cny','2521728.20000000','96.00000000','2521824.20000000','d341955059d94b854272695c83afaa77',1469773672,1),(28,2,'cny','2521728.20000000','96.00000000','2521824.20000000','36.00000000','1','trade',61,'交易中心-交易撤销btc_cny','2521764.20000000','60.00000000','2521824.20000000','83b681da2f61f76ab31c02f47f121dc3',1469773678,1),(29,2,'cny','2521764.20000000','60.00000000','2521824.20000000','25.00000000','1','trade',60,'交易中心-交易撤销btc_cny','2521789.20000000','35.00000000','2521824.20000000','78990d0a6b86f37741936ca2ce2e9048',1469773681,1),(30,2,'cny','2521789.20000000','35.00000000','2521824.20000000','20.00000000','1','trade',59,'交易中心-交易撤销btc_cny','2521809.20000000','15.00000000','2521824.20000000','903c1347c5e385e5875f1eaf07a114be',1469773686,1),(31,2,'cny','2521809.20000000','15.00000000','2521824.20000000','9.00000000','1','trade',58,'交易中心-交易撤销btc_cny','2521818.20000000','6.00000000','2521824.20000000','a3c94384e38d5df1e20fc25d945981ce',1469773690,1),(32,2,'cny','2521818.20000000','6.00000000','2521824.20000000','4.00000000','1','trade',57,'交易中心-交易撤销btc_cny','2521822.20000000','2.00000000','2521824.20000000','09973f4da6aedd1cde46dd994da0eedd',1469773694,1),(33,2,'cny','2521822.20000000','2.00000000','2521824.20000000','1.00000000','1','trade',56,'交易中心-交易撤销btc_cny','2521823.20000000','1.00000000','2521824.20000000','3bb86be15cd6a286c03821ea723c96f3',1469773700,1),(34,2,'cny','2521823.20000000','1.00000000','2521824.20000000','1.00000000','1','trade',84,'交易中心-交易撤销avc_cny','2521824.20000000','0.00000000','2521824.20000000','e9cc967577d1ffc9b49523a47e65e66a',1469773714,1),(35,2,'cny','2521824.20000000','0.00000000','2521824.20000000','15.00000000','2','trade',87,'交易中心-委托买入-市场avc_cny','2521809.20000000','15.00000000','2521824.20000000','2a8a749a2bea500bb206ffc4306d3c4f',1469773880,1),(36,2,'cny','2521809.20000000','15.00000000','2521824.20000000','5.00000000','2','tradelog',38,'交易中心-成功买入-市场avc_cny','2521809.20000000','10.00000000','2521819.20000000','a5a159a2c74a67a447d2f95f4df6e1b4',1469773880,1),(37,10,'cny','0.00000000','0.00000000','0.00000000','5.00000000','1','tradelog',38,'交易中心-成功卖出-市场avc_cny','4.95000000','0.00000000','4.95000000','27aba214ea8e66bc5e879ce5b8b79ac9',1469773880,0),(38,2,'cny','2521819.20000000','0.00000000','2521819.20000000','10.00000000','2','trade',88,'交易中心-委托买入-市场avc_cny','2521809.20000000','10.00000000','2521819.20000000','e1bf75e9995bacb541d62f47f727e0bf',1469773933,1),(39,2,'cny','2521809.20000000','10.00000000','2521819.20000000','10.00000000','2','tradelog',39,'交易中心-成功买入-市场avc_cny','2521809.20000000','0.00000000','2521809.20000000','4400f6eab0fb19d0b80dff20c2ba919a',1469773933,1),(40,10,'cny','4.95000000','0.00000000','4.95000000','10.00000000','1','tradelog',39,'交易中心-成功卖出-市场avc_cny','14.85000000','0.00000000','14.85000000','809daa6c569a36f321b907948acd8a48',1469773933,0),(41,2,'cny','2521809.20000000','0.00000000','2521809.20000000','1.00000000','2','trade',89,'交易中心-委托买入-市场avc_cny','2521808.20000000','1.00000000','2521809.20000000','53f14aed41c7f01881ade924d1c9a8df',1469774394,1),(42,2,'cny','2521808.20000000','1.00000000','2521809.20000000','1.00000000','1','trade',89,'交易中心-交易撤销avc_cny','2521809.20000000','0.00000000','2521809.20000000','4c0bb5216485c2dd9c69532d046a5fa2',1469774454,1),(43,2,'cny','2521809.20000000','0.00000000','2521809.20000000','22.00000000','2','trade',92,'交易中心-委托买入-市场avc_cny','2521787.20000000','22.00000000','2521809.20000000','7b14aeed8ad10dc82871809147947703',1469774520,1),(44,2,'cny','2521787.20000000','22.00000000','2521809.20000000','6.00000000','2','tradelog',40,'交易中心-成功买入-市场avc_cny','2521787.20000000','16.00000000','2521803.20000000','86420a2eb949b5d4b30306d087cda1e5',1469774520,1),(45,11,'cny','0.00000000','0.00000000','0.00000000','6.00000000','1','tradelog',40,'交易中心-成功卖出-市场avc_cny','5.94000000','0.00000000','5.94000000','b65ba326d8b8261089798ebfdfdfd345',1469774520,0),(46,2,'cny','2521792.20000000','11.00000000','2521803.20000000','11.00000000','2','tradelog',41,'交易中心-成功买入-市场avc_cny','2521792.20000000','0.00000000','2521792.20000000','1f71c49489b7382209b4bdf24747a9ae',1469774520,1),(47,11,'cny','5.94000000','0.00000000','5.94000000','11.00000000','1','tradelog',41,'交易中心-成功卖出-市场avc_cny','16.83000000','0.00000000','16.83000000','e4f082632282e557eb88038500abc01c',1469774520,0),(48,2,'cny','2521792.20000000','0.00000000','2521792.20000000','1.00000000','2','trade',93,'交易中心-委托买入-市场btc_cny','2521791.20000000','1.00000000','2521792.20000000','139209c863b0df8d202d220b553c6335',1469774737,1),(49,2,'cny','2521791.20000000','1.00000000','2521792.20000000','1.00000000','1','trade',93,'交易中心-交易撤销btc_cny','2521792.20000000','0.00000000','2521792.20000000','868e13c54735e850111df6540f8c39f6',1469774749,1),(50,2,'cny','2521792.20000000','0.00000000','2521792.20000000','1.33300000','2','trade',94,'交易中心-委托买入-市场btc_cny','2521790.86700000','1.33300000','2521792.20000000','3fc6fea61a53b09787e9720dc68de7f0',1469774809,1),(51,2,'cny','2521790.86700000','1.33300000','2521792.20000000','1.33300000','1','trade',94,'交易中心-交易撤销btc_cny','2521792.20000000','0.00000000','2521792.20000000','cab20e0450f00799cf184556acf6872a',1469774816,1),(52,11,'cny','16.83000000','0.00000000','16.83000000','15.00000000','2','trade',96,'交易中心-委托买入-市场avc_cny','1.83000000','15.00000000','16.83000000','28b7e486333f45c7e92849bb469c9539',1469798060,1),(53,11,'cny','1.83000000','15.00000000','16.83000000','15.00000000','1','trade',96,'交易中心-交易撤销avc_cny','16.83000000','0.00000000','16.83000000','d985354e9fb4b637b7dc51330a1b76e9',1477200184,1),(54,2,'cny','2521792.20000000','0.00000000','2521792.20000000','1.00000000','2','trade',97,'交易中心-委托买入-市场ftc_cny','2521791.20000000','1.00000000','2521792.20000000','139209c863b0df8d202d220b553c6335',1477212822,1),(55,2,'cny','2521791.20000000','1.00000000','2521792.20000000','1.00000000','1','trade',97,'交易中心-交易撤销ftc_cny','2521792.20000000','0.00000000','2521792.20000000','868e13c54735e850111df6540f8c39f6',1477212826,1);

/*Table structure for table `movesay_footer` */

DROP TABLE IF EXISTS `movesay_footer`;

CREATE TABLE `movesay_footer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `title` varchar(200) NOT NULL DEFAULT '',
  `url` varchar(200) NOT NULL DEFAULT '',
  `img` varchar(200) NOT NULL DEFAULT '',
  `type` varchar(200) NOT NULL DEFAULT '',
  `remark` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `movesay_footer` */

insert  into `movesay_footer`(`id`,`name`,`title`,`url`,`img`,`type`,`remark`,`sort`,`addtime`,`endtime`,`status`) values (1,'1','关于我们','/Article/index/type/aboutus.html','','1','',1,111,0,1),(2,'1','联系我们','/Article/index/type/aboutus.html','','1','',1,111,0,1),(3,'1','资质证明','/Article/index/type/aboutus.html','','1','',1,111,0,1),(4,'1','用户协议','/Article/index/type/aboutus.html','','1','',1,111,0,1),(5,'1','法律声明','/Article/index/type/aboutus.html','','1','',1,111,0,1),(6,'1','1','/','footer_1.png','2','',1,111,0,1),(7,'1','1','http://www.szfw.org/','footer_2.png','2','',1,111,0,1),(8,'1','1','http://www.miibeian.gov.cn/','footer_3.png','2','',1,111,0,1),(9,'1','1','http://www.cyberpolice.cn/','footer_4.png','2','',1,111,0,1);

/*Table structure for table `movesay_invit` */

DROP TABLE IF EXISTS `movesay_invit`;

CREATE TABLE `movesay_invit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `invit` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '',
  `type` varchar(50) NOT NULL DEFAULT '',
  `num` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `mum` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `fee` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `invit` (`invit`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='推广奖励表';

/*Data for the table `movesay_invit` */

insert  into `movesay_invit`(`id`,`userid`,`invit`,`name`,`type`,`num`,`mum`,`fee`,`sort`,`addtime`,`endtime`,`status`) values (1,2,4,'一代买入赠送','btc_cny买入交易赠送','1.00000000','4599.00000000','13.79700000',0,1467621257,0,1),(2,2,4,'一代买入赠送','btc_cny买入交易赠送','1.00000000','4599.00000000','13.79700000',0,1467621261,0,1);

/*Table structure for table `movesay_issue` */

DROP TABLE IF EXISTS `movesay_issue`;

CREATE TABLE `movesay_issue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `coinname` varchar(50) NOT NULL DEFAULT '',
  `buycoin` varchar(50) NOT NULL DEFAULT '',
  `num` bigint(20) unsigned NOT NULL DEFAULT '0',
  `deal` int(11) unsigned NOT NULL DEFAULT '0',
  `price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `limit` int(11) unsigned NOT NULL DEFAULT '0',
  `time` varchar(255) NOT NULL DEFAULT '',
  `tian` varchar(255) NOT NULL DEFAULT '',
  `ci` varchar(255) NOT NULL DEFAULT '',
  `jian` varchar(255) NOT NULL DEFAULT '',
  `min` varchar(255) NOT NULL DEFAULT '',
  `max` varchar(255) NOT NULL DEFAULT '',
  `content` text,
  `invit_coin` varchar(50) NOT NULL DEFAULT '',
  `invit_1` varchar(50) NOT NULL DEFAULT '',
  `invit_2` varchar(50) NOT NULL DEFAULT '',
  `invit_3` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `name` (`name`),
  KEY `coinname` (`coinname`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='认购发行表';

/*Data for the table `movesay_issue` */

insert  into `movesay_issue`(`id`,`name`,`coinname`,`buycoin`,`num`,`deal`,`price`,`limit`,`time`,`tian`,`ci`,`jian`,`min`,`max`,`content`,`invit_coin`,`invit_1`,`invit_2`,`invit_3`,`sort`,`addtime`,`endtime`,`status`) values (1,'法特币一期','ftc','cny',1000000,0,'0.15000000',100000,'2016-10-29 00:00:00','30','1','1','100','100000','','cny','','','',0,1477211385,0,1);

/*Table structure for table `movesay_issue_log` */

DROP TABLE IF EXISTS `movesay_issue_log`;

CREATE TABLE `movesay_issue_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `coinname` varchar(50) NOT NULL DEFAULT '',
  `buycoin` varchar(50) NOT NULL DEFAULT '',
  `price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `num` int(20) unsigned NOT NULL DEFAULT '0',
  `mum` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `ci` int(11) unsigned NOT NULL DEFAULT '0',
  `jian` varchar(255) NOT NULL DEFAULT '',
  `unlock` int(11) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='认购记录表';

/*Data for the table `movesay_issue_log` */

insert  into `movesay_issue_log`(`id`,`userid`,`name`,`coinname`,`buycoin`,`price`,`num`,`mum`,`ci`,`jian`,`unlock`,`sort`,`addtime`,`endtime`,`status`) values (1,2,'优特币第一期认购','ytc','cny','0.01000000',100,'1.00000000',5,'24',1,0,1467292452,1467292452,0);

/*Table structure for table `movesay_link` */

DROP TABLE IF EXISTS `movesay_link`;

CREATE TABLE `movesay_link` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `title` varchar(200) NOT NULL DEFAULT '',
  `url` varchar(200) NOT NULL DEFAULT '',
  `img` varchar(200) NOT NULL DEFAULT '',
  `mytx` varchar(200) NOT NULL DEFAULT '',
  `remark` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='常用银行地址';

/*Data for the table `movesay_link` */

insert  into `movesay_link`(`id`,`name`,`title`,`url`,`img`,`mytx`,`remark`,`sort`,`addtime`,`endtime`,`status`) values (4,'boc','BC','http://www.boc.cn/','img_56937003683ce.jpg','','',0,1452503043,1471857441,1),(5,'abc','ABC','http://www.abchina.com/cn/','img_569370458b18d.jpg','','',0,1452503109,1471857480,1),(6,'bccb','北京银行','http://www.bankofbeijing.com.cn/','img_569370588dcdc.jpg','','',0,1452503128,0,0),(8,'ccb','CCB','http://www.ccb.com/','img_5693709bbd20f.jpg','','',0,1452503195,1471857507,1),(9,'ceb','光大银行','http://www.bankofbeijing.com.cn/','img_569370b207cc8.jpg','','',0,1452503218,0,0),(10,'cib','兴业银行','http://www.cib.com.cn/cn/index.html','img_569370d29bf59.jpg','','',0,1452503250,0,0),(11,'citic','中信银行','http://www.ecitic.com/','img_569370fb7a1b3.jpg','','',0,1452503291,0,0),(12,'cmb','招商银行','http://www.cmbchina.com/','img_5693710a9ac9c.jpg','','',0,1452503306,0,0),(13,'cmbc','民生银行','http://www.cmbchina.com/','img_5693711f97a9d.jpg','','',0,1452503327,0,0),(14,'comm','交通银行','http://www.bankcomm.com/BankCommSite/default.shtml','img_5693713076351.jpg','','',0,1452503344,0,0),(16,'gdb','广发银行','http://www.cgbchina.com.cn/','img_56937154bebc5.jpg','','',0,1452503380,0,0),(17,'icbc','ICBC','http://www.icbc.com.cn/icbc/','img_56937162db7f5.jpg','','',0,1452503394,1471857410,1),(19,'psbc','邮政银行','http://www.psbc.com/portal/zh_CN/index.html','img_5693717eefaa3.jpg','','',0,1452503422,0,0),(20,'spdb','浦发银行','http://www.spdb.com.cn/chpage/c1/','img_5693718f1d70e.jpg','','',0,1452503439,0,0),(21,'szpab','平安银行','http://bank.pingan.com/','56c2e4c9aff85.jpg','','',0,1455613129,0,0);

/*Table structure for table `movesay_log` */

DROP TABLE IF EXISTS `movesay_log`;

CREATE TABLE `movesay_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `coinname` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `num` int(20) unsigned NOT NULL DEFAULT '0',
  `mum` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `unlock` int(11) unsigned NOT NULL DEFAULT '0',
  `ci` int(11) unsigned NOT NULL DEFAULT '0',
  `recycle` int(11) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `userid` (`userid`),
  KEY `coinname` (`coinname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `movesay_log` */

/*Table structure for table `movesay_market` */

DROP TABLE IF EXISTS `movesay_market`;

CREATE TABLE `movesay_market` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `round` varchar(255) NOT NULL DEFAULT '',
  `fee_buy` varchar(255) NOT NULL DEFAULT '',
  `fee_sell` varchar(255) NOT NULL DEFAULT '',
  `buy_min` varchar(255) NOT NULL DEFAULT '',
  `buy_max` varchar(255) NOT NULL DEFAULT '',
  `sell_min` varchar(255) NOT NULL DEFAULT '',
  `sell_max` varchar(255) NOT NULL DEFAULT '',
  `trade_min` varchar(255) NOT NULL DEFAULT '',
  `trade_max` varchar(255) NOT NULL DEFAULT '',
  `invit_buy` varchar(50) NOT NULL DEFAULT '',
  `invit_sell` varchar(50) NOT NULL DEFAULT '',
  `invit_1` varchar(50) NOT NULL DEFAULT '',
  `invit_2` varchar(50) NOT NULL DEFAULT '',
  `invit_3` varchar(50) NOT NULL DEFAULT '',
  `zhang` varchar(255) NOT NULL DEFAULT '',
  `die` varchar(255) NOT NULL DEFAULT '',
  `hou_price` varchar(255) NOT NULL DEFAULT '',
  `tendency` varchar(1000) NOT NULL DEFAULT '',
  `zoushi` text,
  `trade` int(11) unsigned NOT NULL DEFAULT '0',
  `new_price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `buy_price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `sell_price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `min_price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `max_price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `volume` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `change` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `api_min` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `api_max` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='行情配置表';

/*Data for the table `movesay_market` */

insert  into `movesay_market`(`id`,`name`,`round`,`fee_buy`,`fee_sell`,`buy_min`,`buy_max`,`sell_min`,`sell_max`,`trade_min`,`trade_max`,`invit_buy`,`invit_sell`,`invit_1`,`invit_2`,`invit_3`,`zhang`,`die`,`hou_price`,`tendency`,`zoushi`,`trade`,`new_price`,`buy_price`,`sell_price`,`min_price`,`max_price`,`volume`,`change`,`api_min`,`api_max`,`sort`,`addtime`,`endtime`,`status`) values (13,'ftc_cny','6','','','','','','','','','1','1','','','','','','','',NULL,1,'0.00000000','0.00000000','0.00000000','0.00000000','0.00000000','0.00000000','0.00000000','0.00000000','0.00000000',0,0,0,1),(14,'btc_cny','4','','','','','','','','','1','1','','','','','','','',NULL,1,'0.00000000','0.00000000','0.00000000','0.00000000','0.00000000','0.00000000','0.00000000','0.00000000','0.00000000',0,0,0,1);

/*Table structure for table `movesay_market_json` */

DROP TABLE IF EXISTS `movesay_market_json`;

CREATE TABLE `movesay_market_json` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `data` varchar(500) CHARACTER SET utf8 NOT NULL,
  `type` varchar(100) CHARACTER SET utf8 NOT NULL,
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `movesay_market_json` */

insert  into `movesay_market_json`(`id`,`name`,`data`,`type`,`sort`,`addtime`,`endtime`,`status`) values (1,'btc_cny','[\"1921.50000000\",\"45478.00000000\",\"0.00000000\",\"0.00000000\"]','',0,1467302399,0,0),(2,'btc_cny','[\"4.00000000\",\"17598.00000000\",\"0.00000000\",\"0.00000000\"]','',0,1467388799,0,0),(3,'btc_cny','[null,null,null,null]','',0,1467475199,0,0),(4,'btc_cny','[null,null,null,null]','',0,1467561599,0,0),(5,'btc_cny','[\"76.10000000\",\"142395.00000000\",\"413.91000000\",\"413.91000000\"]','',0,1467647999,0,0),(6,'btc_cny','[null,null,null,null]','',0,1467734399,0,0),(7,'btc_cny','[null,null,null,null]','',0,1467820799,0,0),(8,'btc_cny','[null,null,null,null]','',0,1467907199,0,0),(9,'btc_cny','','',0,4071311999,0,0),(10,'ltc_cny','[\"876.00000000\",\"23658.00000000\",\"0.00000000\",\"0.00000000\"]','',0,1467302399,0,0),(11,'avc_cny','','',0,2591193599,0,0),(12,'ltc_cny','','',0,1467734399,0,0),(13,'ltc_cny','','',0,1467734399,0,0),(14,'ltc_cny','[\"45.00000000\",\"1350.00000000\",\"0.00000000\",\"0.00000000\"]','',0,1467647999,0,0),(15,'ltc_cny','[\"45.00000000\",\"1350.00000000\",\"0.00000000\",\"0.00000000\"]','',0,1467647999,0,0);

/*Table structure for table `movesay_menu` */

DROP TABLE IF EXISTS `movesay_menu`;

CREATE TABLE `movesay_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  `ico_name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=227 DEFAULT CHARSET=utf8;

/*Data for the table `movesay_menu` */

insert  into `movesay_menu`(`id`,`title`,`pid`,`sort`,`url`,`hide`,`tip`,`group`,`is_dev`,`ico_name`) values (1,'系统',0,1,'Index/index',0,'','',0,'home'),(2,'内容',0,1,'Article/index',0,'','',0,'list-alt'),(3,'用户',0,1,'User/index',0,'','',0,'user'),(4,'财务',0,1,'Finance/index',0,'','',0,'th-list'),(5,'交易',0,1,'Trade/index',0,'','',0,'stats'),(6,'应用',0,1,'Game/index',0,'','',0,'globe'),(7,'设置',0,1,'Config/index',0,'','',0,'cog'),(8,'运营',0,1,'Operate/index',0,'','',0,'share'),(9,'工具',0,1,'Tools/index',0,'','',0,'wrench'),(10,'扩展',0,1,'Cloud/index',1,'','',0,'tasks'),(11,'系统概览',1,1,'Index/index',0,'','系统',0,'home'),(13,'文章管理',2,1,'Article/index',0,'','内容',0,'list-alt'),(14,'编辑添加',13,1,'Article/edit',1,'','内容',0,'home'),(15,'修改状态',13,100,'Article/status',1,'','内容',0,'home'),(16,'上传图片',13,2,'Article/images',1,'','内容管理',0,'0'),(156,'提现地址',3,6,'User/bank',0,'','用户',0,'user'),(18,'编辑',17,2,'Adver/edit',1,'','内容管理',0,'0'),(19,'修改',17,2,'Adver/status',1,'','内容管理',0,'0'),(220,'币种配置',7,4,'Config/coin',0,'','设置',0,'cog'),(21,'编辑',20,3,'Chat/edit',1,'','聊天管理',0,'0'),(22,'修改',20,3,'Chat/status',1,'','聊天管理',0,'0'),(23,'提示文字',2,1,'Text/index',1,'','提示管理',0,'exclamation-sign'),(24,'编辑',23,1,'Text/edit',1,'','提示管理',0,'0'),(25,'修改',23,1,'Text/status',1,'','提示管理',0,'0'),(26,'用户管理',3,1,'User/index',0,'','用户',0,'user'),(163,'虚拟币转入',4,6,'Finance/myzr',0,'','财务',0,'th-list'),(162,'人民币提现配置',4,5,'Finance/mytxConfig',0,'','财务',0,'th-list'),(161,'人民币提现',4,4,'Finance/mytx',0,'','财务',0,'th-list'),(165,'成交记录',5,2,'Trade/log',0,'','交易',0,'stats'),(166,'交易聊天',5,3,'Trade/chat',0,'','交易',0,'stats'),(32,'确认转出',26,8,'User/myzc_qr',1,'','用户管理',0,'0'),(33,'用户配置',3,1,'User/config',1,'','前台用户管理',0,'cog'),(34,'编辑',33,2,'User/index_edit',1,'','用户管理',0,'0'),(35,'修改',33,2,'User/index_status',1,'','用户管理',0,'0'),(37,'财产修改',26,3,'Usercoin/edit',1,'','用户管理',0,'0'),(221,'导航配置',7,7,'Config/daohang',0,'','设置',0,'cog'),(39,'新增用户组',38,0,'AuthManager/createGroup',1,'','权限管理',0,'0'),(40,'编辑用户组',38,0,'AuthManager/editgroup',1,'','权限管理',0,'0'),(41,'更新用户组',38,0,'AuthManager/writeGroup',1,'','权限管理',0,'0'),(42,'改变状态',38,0,'AuthManager/changeStatus',1,'','权限管理',0,'0'),(43,'访问授权',38,0,'AuthManager/access',1,'','权限管理',0,'0'),(44,'分类授权',38,0,'AuthManager/category',1,'','权限管理',0,'0'),(45,'成员授权',38,0,'AuthManager/user',1,'','权限管理',0,'0'),(46,'成员列表授权',38,0,'AuthManager/tree',1,'','权限管理',0,'0'),(47,'用户组',38,0,'AuthManager/group',1,'','权限管理',0,'0'),(48,'添加到用户组',38,0,'AuthManager/addToGroup',1,'','权限管理',0,'0'),(49,'用户组移除',38,0,'AuthManager/removeFromGroup',1,'','权限管理',0,'0'),(50,'分类添加到用户组',38,0,'AuthManager/addToCategory',1,'','权限管理',0,'0'),(51,'模型添加到用户组',38,0,'AuthManager/addToModel',1,'','权限管理',0,'0'),(52,'财务明细',4,1,'Finance/index',0,'','财务',0,'th-list'),(53,'配置',52,1,'Finance/config',1,'','',0,'0'),(159,'人民币充值',4,2,'Finance/mycz',0,'','财务',0,'th-list'),(55,'类型',52,1,'Finance/type',1,'','',0,'0'),(56,'状态修改',52,1,'Finance/type_status',1,'','',0,'0'),(169,'交易推荐',5,6,'Trade/invit',0,'','交易',0,'stats'),(172,'修改状态',159,100,'Finance/myczStatus',1,'','财务',0,'home'),(168,'交易市场',5,5,'Trade/market',0,'','交易',0,'stats'),(60,'修改',57,3,'Mycz/status',1,'','充值管理',0,'0'),(61,'状态修改',57,3,'Mycztype/status',1,'','充值管理',0,'0'),(167,'币种评论',5,4,'Trade/comment',0,'','交易',0,'stats'),(64,'状态修改',62,5,'Mytx/status',1,'','提现管理',0,'0'),(65,'取消',62,5,'Mytx/excel',1,'','提现管理',0,'0'),(66,'导入excel',9,5,'Mytx/exportExcel',1,'','提现管理',0,'0'),(68,'委托管理',5,1,'Trade/index',0,'','交易',0,'stats'),(222,'推广奖励',8,1,'Operate/index',0,'','运营',0,'share'),(70,'修改状态',68,0,'Trade/status',1,'','交易管理',0,'0'),(71,'撤销挂单',68,0,'Trade/chexiao',1,'','交易管理',0,'0'),(72,'认购管理',6,1,'Issue/index',0,'','认购管理',0,'globe'),(74,'认购编辑',72,2,'Issue/edit',1,'','认购管理',0,'0'),(75,'认购修改',72,2,'Issue/status',1,'','认购管理',0,'0'),(76,'认购记录',6,3,'Issuelog/index',0,'','认购管理',0,'time'),(79,'基本配置',7,1,'Config/index',0,'','设置',0,'cog'),(80,'短信配置',7,2,'Config/moble',0,'','设置',0,'cog'),(81,'客服配置',7,3,'Config/contact',0,'','设置',0,'cog'),(82,'银行配置',79,4,'Config/bank',0,'','网站配置',0,'credit-card'),(83,'编辑',82,4,'Config/bank_edit',1,'','网站配置',0,'0'),(85,'编辑',84,4,'Coin/edit',0,'','网站配置',0,'0'),(87,'状态修改',84,4,'Coin/status',1,'','网站配置',0,'0'),(196,'管理员管理',3,2,'User/admin',0,'','用户',0,'user'),(89,'编辑市场',88,4,'Market/edit',0,'','',0,'0'),(154,'登陆日志',3,4,'User/log',0,'','用户',0,'user'),(91,'状态修改',88,4,'Config/market_add',1,'','',0,'0'),(92,'图形验证码',95,7,'Verify/code',1,'','网站配置',0,'0'),(93,'手机验证码',95,7,'Verify/mobile',1,'','网站配置',0,'0'),(94,'邮件验证码',95,7,'Verify/email',1,'','网站配置',0,'0'),(95,'其他配置',7,6,'Config/qita',0,'','设置',0,'cog'),(223,'主题模板',10,4,'Cloud/theme',0,'','扩展',0,'tasks'),(97,'推广配置',8,2,'Invit/config',1,'','推广管理',0,'cog'),(199,'修改状态',26,1,'User/status',1,'','用户',0,'home'),(197,'权限列表',3,3,'User/auth',0,'','用户',0,'user'),(198,'编辑添加',26,1,'User/edit',1,'','用户',0,'home'),(101,'其他模块调用',9,4,'Tools/invoke',1,'','其他',0,'0'),(102,'优化表',9,4,'Tools/optimize',1,'','其他',0,'0'),(103,'修复表',9,4,'Tools/repair',1,'','其他',0,'0'),(104,'删除备份文件',9,4,'Tools/del',1,'','其他',0,'0'),(105,'备份数据库',9,4,'Tools/export',1,'','其他',0,''),(106,'还原数据库',9,4,'Tools/import',1,'','其他',0,'0'),(107,'导出数据库',9,4,'Tools/excel',1,'','其他',0,'0'),(108,'导出Excel',9,4,'Tools/exportExcel',1,'','其他',0,'0'),(109,'导入Excel',9,4,'Tools/importExecl',1,'','其他',0,'0'),(224,'认购记录',6,1,'Issue/log',0,'','认购管理',0,'globe'),(173,'确认到账',159,100,'Finance/myczQueren',1,'','财务',0,'home'),(174,'编辑添加',160,1,'Finance/myczTypeEdit',1,'','财务',0,'home'),(115,'图片',111,0,'Shop/images',0,'','云购商城',0,'0'),(116,'菜单管理',7,5,'Menu/index',1,'','开发组',0,'list'),(117,'排序',116,5,'Menu/sort',0,'','开发组',0,'0'),(118,'添加',116,5,'Menu/add',0,'','开发组',0,'0'),(119,'编辑',116,5,'Menu/edit',0,'','开发组',0,'0'),(120,'删除',116,5,'Menu/del',0,'','开发组',0,'0'),(121,'是否隐藏',116,5,'Menu/toogleHide',0,'','开发组',0,'0'),(122,'是否开发',116,5,'Menu/toogleDev',0,'','开发组',0,'0'),(123,'导入文件',7,5,'Menu/importFile',1,'','开发组',0,'log-in'),(124,'导入',7,5,'Menu/import',1,'','开发组',0,'log-in'),(164,'虚拟币转出',4,7,'Finance/myzc',0,'','财务',0,'th-list'),(127,'用户登录',3,0,'Login/index',1,'','用户配置',0,'0'),(128,'用户退出',3,0,'Login/loginout',1,'','用户配置',0,'0'),(129,'修改管理员密码',3,0,'User/setpwd',1,'','用户',0,'home'),(147,'自动升级',10,2,'Cloud/update',0,'','扩展',0,'tasks'),(131,'用户详情',3,4,'User/detail',1,'','前台用户管理',0,'time'),(132,'后台用户详情',3,1,'AdminUser/detail',1,'','后台用户管理',0,'th-list'),(133,'后台用户状态',3,1,'AdminUser/status',1,'','后台用户管理',0,'th-list'),(134,'后台用户新增',3,1,'AdminUser/add',1,'','后台用户管理',0,'th-list'),(135,'后台用户编辑',3,1,'AdminUser/edit',1,'','后台用户管理',0,'th-list'),(12,'市场统计',1,1,'Index/operate',1,'','首页',0,'home'),(138,'编辑',2,1,'Articletype/edit',1,'','内容管理',0,'list-alt'),(155,'用户钱包',3,5,'User/qianbao',0,'','用户',0,'user'),(140,'编辑',139,2,'Link/edit',1,'','内容管理',0,'0'),(141,'修改',139,2,'Link/status',1,'','内容管理',0,'0'),(160,'人民币充值方式',4,3,'Finance/myczType',0,'','财务',0,'th-list'),(145,'币种统计',1,2,'Index/coin',0,'','系统',0,'home'),(146,'市场统计',1,3,'Index/market',0,'','系统',0,'home'),(148,'应用管理',10,3,'Cloud/game',0,'','扩展',0,'tasks'),(149,'提示文字',7,5,'Config/text',0,'','设置',0,'cog'),(150,'文章类型',2,2,'Article/type',0,'','内容',0,'list-alt'),(151,'广告管理',2,3,'Article/adver',0,'','内容',0,'list-alt'),(152,'友情链接',2,4,'Article/link',0,'','内容',0,'list-alt'),(157,'用户财产',3,7,'User/coin',0,'','用户',0,'user'),(158,'联系地址',3,8,'User/goods',0,'','用户',0,'user'),(170,'服务器队列',9,3,'Tools/queue',0,'','工具',0,'wrench'),(171,'钱包检查',9,3,'Tools/qianbao',0,'','工具',0,'wrench'),(175,'状态修改',160,2,'Finance/myczTypeStatus',1,'','财务',0,'home'),(176,'上传图片',160,2,'Finance/myczTypeImage',1,'','财务',0,'home'),(177,'修改状态',161,2,'Finance/mytxStatus',1,'','财务',0,'home'),(178,'导出选中',161,3,'Finance/mytxExcel',1,'','财务',0,'home'),(179,'正在处理',161,4,'Finance/mytxChuli',1,'','财务',0,'home'),(180,'撤销提现',161,5,'Finance/mytxChexiao',1,'','财务',0,'home'),(181,'确认提现',161,6,'Finance/mytxQueren',1,'','财务',0,'home'),(182,'确认转出',164,6,'Finance/myzcQueren',1,'','财务',0,'home'),(183,'云市场',10,1,'Cloud/index',0,'','扩展',0,'tasks'),(184,'编辑添加',150,1,'Article/typeEdit',1,'','内容',0,'home'),(185,'修改状态',150,100,'Article/typeStatus',1,'','内容',0,'home'),(186,'编辑添加',152,1,'Article/linkEdit',1,'','内容',0,'home'),(187,'修改状态',152,100,'Article/linkStatus',1,'','内容',0,'home'),(188,'编辑添加',151,1,'Article/adverEdit',1,'','内容',0,'home'),(189,'修改状态',151,100,'Article/adverStatus',1,'','内容',0,'home'),(190,'上传图片',151,100,'Article/adverImage',1,'','内容',0,'home'),(191,'客服代码',10,5,'Cloud/kefu',0,'','扩展',0,'tasks'),(192,'使用',191,5,'Cloud/kefuUp',0,'','扩展',0,'tasks'),(193,'清理缓存',9,1,'Tools/index',0,'','工具',0,'wrench'),(194,'备份数据库',9,2,'Tools/dataExport',0,'','工具',0,'wrench'),(195,'还原数据库',9,2,'Tools/dataImport',0,'','工具',0,'wrench'),(200,'编辑添加',196,1,'User/adminEdit',1,'','用户',0,'home'),(201,'修改状态',196,1,'User/adminStatus',1,'','用户',0,'home'),(202,'编辑添加',197,1,'User/authEdit',1,'','用户',0,'home'),(203,'修改状态',197,1,'User/authStatus',1,'','用户',0,'home'),(204,'重新初始化权限',197,1,'User/authStart',1,'','用户',0,'home'),(205,'访问授权',197,1,'User/authAccess',1,'','用户',0,'home'),(206,'访问授权修改',197,1,'User/authAccessUp',1,'','用户',0,'home'),(207,'成员授权',197,1,'User/authUser',1,'','用户',0,'home'),(208,'成员授权增加',197,1,'User/authUserAdd',1,'','用户',0,'home'),(209,'成员授权解除',197,1,'User/authUserRemove',1,'','用户',0,'home'),(210,'编辑添加',154,1,'User/logEdit',1,'','用户',0,'home'),(211,'修改状态',154,1,'User/logStatus',1,'','用户',0,'home'),(212,'编辑添加',155,1,'User/qianbaoEdit',1,'','用户',0,'home'),(213,'修改状态',155,1,'User/qianbaoStatus',1,'','用户',0,'home'),(214,'编辑添加',156,1,'User/bankEdit',1,'','用户',0,'home'),(215,'修改状态',156,1,'User/bankStatus',1,'','用户',0,'home'),(216,'编辑添加',157,1,'User/coinEdit',1,'','用户',0,'home'),(217,'财产统计',157,1,'User/coinLog',1,'','用户',0,'home'),(218,'编辑添加',158,1,'User/goodsEdit',1,'','用户',0,'home'),(219,'修改状态',158,1,'User/goodsStatus',1,'','用户',0,'home');

/*Table structure for table `movesay_message` */

DROP TABLE IF EXISTS `movesay_message`;

CREATE TABLE `movesay_message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(50) NOT NULL DEFAULT '',
  `remark` varchar(50) NOT NULL DEFAULT '',
  `addip` varchar(200) NOT NULL DEFAULT '',
  `addr` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `movesay_message` */

/*Table structure for table `movesay_message_log` */

DROP TABLE IF EXISTS `movesay_message_log`;

CREATE TABLE `movesay_message_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(50) NOT NULL DEFAULT '',
  `remark` varchar(50) NOT NULL DEFAULT '',
  `addip` varchar(200) NOT NULL DEFAULT '',
  `addr` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `movesay_message_log` */

/*Table structure for table `movesay_money` */

DROP TABLE IF EXISTS `movesay_money`;

CREATE TABLE `movesay_money` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `coinname` varchar(50) NOT NULL DEFAULT '',
  `num` bigint(20) unsigned NOT NULL DEFAULT '0',
  `deal` int(11) unsigned NOT NULL DEFAULT '0',
  `tian` int(11) unsigned NOT NULL DEFAULT '0',
  `fee` int(11) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投资理财表';

/*Data for the table `movesay_money` */

/*Table structure for table `movesay_money_log` */

DROP TABLE IF EXISTS `movesay_money_log`;

CREATE TABLE `movesay_money_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '',
  `coinname` varchar(50) NOT NULL DEFAULT '',
  `num` int(11) unsigned NOT NULL DEFAULT '0',
  `fee` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `feea` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `tian` int(11) unsigned NOT NULL DEFAULT '0',
  `tiana` int(11) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='理财记录表';

/*Data for the table `movesay_money_log` */

/*Table structure for table `movesay_mycz` */

DROP TABLE IF EXISTS `movesay_mycz`;

CREATE TABLE `movesay_mycz` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `num` int(11) unsigned NOT NULL DEFAULT '0',
  `mum` int(11) unsigned NOT NULL DEFAULT '0',
  `type` varchar(50) NOT NULL DEFAULT '',
  `tradeno` varchar(50) NOT NULL DEFAULT '',
  `remark` varchar(250) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  `rmb` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '实际充值人民币',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='充值记录表';

/*Data for the table `movesay_mycz` */

insert  into `movesay_mycz`(`id`,`userid`,`num`,`mum`,`type`,`tradeno`,`remark`,`sort`,`addtime`,`endtime`,`status`,`rmb`) values (32,2,100,0,'alipay','EB484153','',0,1477201715,0,0,'0.00'),(33,2,100,0,'alipay','RY992658','',0,1477201752,0,0,'0.00'),(34,2,100,0,'alipay','YN857874','',0,1477201758,0,0,'0.00'),(35,2,100,0,'alipay','CS783538','',0,1477201763,0,0,'0.00'),(36,2,100,0,'alipay','QS484996','',0,1477201788,0,0,'0.00'),(37,2,100,0,'alipay','HF134843','',0,1477201806,0,0,'683.88'),(38,2,100,0,'weixin','FU139737','',0,1477212706,0,0,'685.37');

/*Table structure for table `movesay_mycz_type` */

DROP TABLE IF EXISTS `movesay_mycz_type`;

CREATE TABLE `movesay_mycz_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `max` varchar(200) NOT NULL DEFAULT '' COMMENT '名称',
  `min` varchar(200) NOT NULL DEFAULT '' COMMENT '名称',
  `img` varchar(200) NOT NULL DEFAULT '' COMMENT '名称',
  `kaihu` varchar(200) NOT NULL DEFAULT '' COMMENT '名称',
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(355) DEFAULT NULL,
  `truename` varchar(200) NOT NULL DEFAULT '' COMMENT '名称',
  `name` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(50) NOT NULL DEFAULT '',
  `remark` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='充值类型';

/*Data for the table `movesay_mycz_type` */

insert  into `movesay_mycz_type`(`id`,`max`,`min`,`img`,`kaihu`,`username`,`password`,`truename`,`name`,`title`,`remark`,`sort`,`addtime`,`endtime`,`status`) values (1,'20000','10','5775e2c222348.png','11','8888888','8888','澳维科技','alipay','支付宝支付','需要在联系方式里面设置支付宝账号',0,0,0,1),(4,'20000','10','5775fc73495ff.png','',NULL,NULL,'优特科技','weixin','微信支付','需要在联系方式里面设置微信账号',0,0,0,1),(7,'50000','100','','中国银行深圳市科技园支行','888888888888','222888888','优特科技','bank','网银支付','需要在联系方式里面按照格式天数收款银行账号',0,0,0,1);

/*Table structure for table `movesay_mytx` */

DROP TABLE IF EXISTS `movesay_mytx`;

CREATE TABLE `movesay_mytx` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `num` int(11) unsigned NOT NULL DEFAULT '0',
  `fee` decimal(20,2) unsigned NOT NULL DEFAULT '0.00',
  `mum` decimal(20,2) unsigned NOT NULL DEFAULT '0.00',
  `truename` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `bank` varchar(250) NOT NULL DEFAULT '',
  `bankprov` varchar(50) NOT NULL DEFAULT '',
  `bankcity` varchar(50) NOT NULL DEFAULT '',
  `bankaddr` varchar(50) NOT NULL DEFAULT '',
  `bankcard` varchar(200) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  `payrmb` float(10,2) DEFAULT '0.00' COMMENT '需支付人民币',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='提现记录表';

/*Data for the table `movesay_mytx` */

insert  into `movesay_mytx`(`id`,`userid`,`num`,`fee`,`mum`,`truename`,`name`,`bank`,`bankprov`,`bankcity`,`bankaddr`,`bankcard`,`sort`,`addtime`,`endtime`,`status`,`payrmb`) values (1,2,8000,'80.00','7920.00','牛牛','广东','平安银行','广东','深圳','科技园支行','8888888888888888',0,1467360198,0,1,0.00);

/*Table structure for table `movesay_myzc` */

DROP TABLE IF EXISTS `movesay_myzc`;

CREATE TABLE `movesay_myzc` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `username` varchar(200) NOT NULL DEFAULT '',
  `coinname` varchar(200) NOT NULL DEFAULT '',
  `txid` varchar(200) NOT NULL DEFAULT '',
  `num` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `fee` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `mum` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `status` (`status`),
  KEY `coinname` (`coinname`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `movesay_myzc` */

insert  into `movesay_myzc`(`id`,`userid`,`username`,`coinname`,`txid`,`num`,`fee`,`mum`,`sort`,`addtime`,`endtime`,`status`) values (1,2,'1D4ERnTbiEfAzkzczt7B2ANjbztTGo1fVy','btc','','0.00180000','0.00000000','0.00180000',0,1467711364,0,1);

/*Table structure for table `movesay_myzc_fee` */

DROP TABLE IF EXISTS `movesay_myzc_fee`;

CREATE TABLE `movesay_myzc_fee` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `username` varchar(200) CHARACTER SET utf8 NOT NULL,
  `coinname` varchar(200) CHARACTER SET utf8 NOT NULL,
  `txid` varchar(200) CHARACTER SET utf8 NOT NULL,
  `type` varchar(200) CHARACTER SET utf8 NOT NULL,
  `fee` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `num` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `mum` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `movesay_myzc_fee` */

/*Table structure for table `movesay_myzr` */

DROP TABLE IF EXISTS `movesay_myzr`;

CREATE TABLE `movesay_myzr` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `username` varchar(200) NOT NULL DEFAULT '',
  `coinname` varchar(200) NOT NULL DEFAULT '',
  `txid` varchar(200) NOT NULL DEFAULT '',
  `num` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `fee` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `mum` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `userid` (`userid`),
  KEY `coinname` (`coinname`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `movesay_myzr` */

insert  into `movesay_myzr`(`id`,`userid`,`username`,`coinname`,`txid`,`num`,`fee`,`mum`,`sort`,`addtime`,`endtime`,`status`) values (1,2,'14tUTyZ3G8gqSPwvhZrHsxUJnfEQpxHge5','btc','40eeabaf1129817207b6798bf77410218b9bda5a968024c1c298766c6d181e34','0.00190000','0.00000000','0.00190000',0,1467633601,0,1),(2,2,'AXMWEgkFShLMMtwkT3Q9x9eLRq2rBkGxAn','avc','5703e2aa81412f35388625f0cff5824a5717a14e0d6dcc3133c10c0b485f94b9','10.00000000','0.00000000','10.00000000',0,1468662361,0,1),(3,11,'AYqDrsF1dw3gRRRfbwjHjWhDHFsgcALhiQ','avc','d58a857bc636353807ed582a7cd9b80fc320a0c11bf6440552f260e5d20ba46f','20.00000000','0.00000000','20.00000000',0,1469769302,0,1),(4,10,'Ac7QzAa3TpBfWU1Hvvh5xN9imPTJ1XWpcS','avc','65c32bfea0d8d722f27b13a84b75e44dd837ed9ce218f6950075a8f7efd12089','10.00000000','0.00000000','10.00000000',0,1469771283,0,1);

/*Table structure for table `movesay_pool` */

DROP TABLE IF EXISTS `movesay_pool`;

CREATE TABLE `movesay_pool` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `coinname` varchar(50) NOT NULL DEFAULT '',
  `ico` varchar(50) NOT NULL DEFAULT '',
  `price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `tian` int(11) unsigned NOT NULL DEFAULT '0',
  `limit` varchar(50) NOT NULL DEFAULT '',
  `power` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='矿机类型表';

/*Data for the table `movesay_pool` */

/*Table structure for table `movesay_pool_log` */

DROP TABLE IF EXISTS `movesay_pool_log`;

CREATE TABLE `movesay_pool_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `coinname` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `ico` varchar(50) NOT NULL DEFAULT '',
  `price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `tian` int(11) unsigned NOT NULL DEFAULT '0',
  `limit` varchar(50) NOT NULL DEFAULT '',
  `power` varchar(50) NOT NULL DEFAULT '',
  `num` int(11) unsigned NOT NULL DEFAULT '0',
  `use` int(11) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='矿机管理';

/*Data for the table `movesay_pool_log` */

/*Table structure for table `movesay_prompt` */

DROP TABLE IF EXISTS `movesay_prompt`;

CREATE TABLE `movesay_prompt` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `title` varchar(200) NOT NULL DEFAULT '',
  `url` varchar(200) NOT NULL DEFAULT '',
  `img` varchar(200) NOT NULL DEFAULT '',
  `mytx` varchar(200) NOT NULL DEFAULT '',
  `remark` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `movesay_prompt` */

/*Table structure for table `movesay_shop` */

DROP TABLE IF EXISTS `movesay_shop`;

CREATE TABLE `movesay_shop` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `coinlist` varchar(255) NOT NULL DEFAULT '',
  `img` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(255) NOT NULL DEFAULT '',
  `price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `price_1` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `num` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `deal` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `content` text,
  `max` varchar(255) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `status` (`status`),
  KEY `deal` (`deal`),
  KEY `price` (`price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商城商品表';

/*Data for the table `movesay_shop` */

/*Table structure for table `movesay_shop_addr` */

DROP TABLE IF EXISTS `movesay_shop_addr`;

CREATE TABLE `movesay_shop_addr` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `truename` varchar(50) NOT NULL DEFAULT '0',
  `moble` varchar(500) NOT NULL DEFAULT '',
  `name` varchar(500) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `movesay_shop_addr` */

/*Table structure for table `movesay_shop_log` */

DROP TABLE IF EXISTS `movesay_shop_log`;

CREATE TABLE `movesay_shop_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) NOT NULL DEFAULT '',
  `shopid` varchar(50) NOT NULL DEFAULT '',
  `price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `coinname` varchar(50) NOT NULL DEFAULT '0.00',
  `num` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `mum` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `addr` varchar(50) NOT NULL DEFAULT '0.0000',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `fee` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购物记录表';

/*Data for the table `movesay_shop_log` */

/*Table structure for table `movesay_shop_type` */

DROP TABLE IF EXISTS `movesay_shop_type`;

CREATE TABLE `movesay_shop_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(50) NOT NULL DEFAULT '',
  `remark` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品分类';

/*Data for the table `movesay_shop_type` */

/*Table structure for table `movesay_text` */

DROP TABLE IF EXISTS `movesay_text`;

CREATE TABLE `movesay_text` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` text,
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

/*Data for the table `movesay_text` */

insert  into `movesay_text`(`id`,`name`,`title`,`content`,`sort`,`addtime`,`endtime`,`status`) values (1,'user_moble','手机认证','<span><span style=\"line-height:21px;background-color:#FFFFFF;\">用户认证时候请在电话号码前加国际区号，例如：中国地区号码13888888888，输入方式为13888888888.香港号码88888888，输入方式为85288888888.</span></span>',0,1467279597,0,1),(2,'user_alipay','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息2</span></span>',0,1467279632,0,1),(3,'game_issue','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息3</span></span>',0,1467279637,0,1),(4,'finance_index','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息4</span></span>',0,1467285974,0,0),(5,'game_issue_log','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息5</span></span>',0,1467285987,0,1),(6,'user_index','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息6</span></span>',0,1467286032,0,1),(7,'finance_mycz','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息7</span></span>',0,1467286037,0,1),(8,'finance_myzr','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息8</span></span>',0,1467286094,0,1),(9,'finance_myjp','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息9</span></span>',0,1467286101,0,1),(10,'finance_mywt','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息10</span></span>',0,1467286626,0,1),(11,'finance_mycj','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息11</span></span>',0,1467286630,0,1),(12,'finance_mytj','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息12</span></span>',0,1467286632,0,1),(13,'finance_mywd','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息</span></span>',0,1467286636,0,1),(14,'finance_mytx','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息14</span></span>',0,1467286642,0,1),(15,'finance_myzc','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息16</span></span>',0,1467291702,0,1),(16,'user_ga','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息</span></span>',0,1467292038,0,1),(17,'user_nameauth','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息17</span></span>',0,1467292042,0,1),(18,'user_bank','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息18</span></span>',0,1467292073,0,1),(19,'user_tpwdset','7','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息19</span></span>',0,1467292136,0,1),(20,'user_qianbao','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息20</span></span>',0,1467292148,0,1),(21,'user_goods','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息21</span></span>',0,1467292242,0,1),(22,'game_issue_buy','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息22</span></span>',0,1467292443,0,1),(23,'user_password','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息23</span></span>',0,1467354725,0,1),(24,'user_paypassword','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息24</span></span>',0,1467354727,0,1),(25,'user_log','','<span style=\"color:#0096E0;line-height:21px;background-color:#FFFFFF;\"><span>请在后台修改此处内容</span></span><span style=\"color:#0096E0;line-height:21px;font-family:\'Microsoft Yahei\', \'Sim sun\', tahoma, \'Helvetica,Neue\', Helvetica, STHeiTi, Arial, sans-serif;background-color:#FFFFFF;\">,<span style=\"color:#EE33EE;\">详细信息25</span></span>',0,1467354847,0,1),(26,'vv_1474513610','','',1,1474513610,1474513610,1),(27,'vv_1474513620','','',1,1474513620,1474513620,1),(28,'vv_1474513621','','',1,1474513621,1474513621,1),(29,'vv_1474513624','','',1,1474513624,1474513624,1),(30,'vv_1474513644','','',1,1474513644,1474513644,1),(31,'vv_1474513645','','',1,1474513645,1474513645,1),(32,'vv_1474513653','','',1,1474513653,1474513653,1),(33,'vv_1474513942','','',1,1474513942,1474513942,1),(34,'vv_1474513943','','',1,1474513943,1474513943,1),(35,'vv_1474513951','','',1,1474513951,1474513951,1),(36,'vv_1474514555','','',1,1474514555,1474514555,1),(37,'vv_1474514557','','',1,1474514557,1474514557,1),(38,'vv_1474514565','','',1,1474514565,1474514565,1);

/*Table structure for table `movesay_trade` */

DROP TABLE IF EXISTS `movesay_trade`;

CREATE TABLE `movesay_trade` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `market` varchar(50) NOT NULL DEFAULT '',
  `price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `num` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `deal` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `mum` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `fee` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `market_type_status` (`market`,`type`,`status`),
  KEY `num_deal` (`num`,`deal`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8 COMMENT='交易下单表';

/*Data for the table `movesay_trade` */

insert  into `movesay_trade`(`id`,`userid`,`market`,`price`,`num`,`deal`,`mum`,`fee`,`type`,`sort`,`addtime`,`endtime`,`status`) values (1,2,'btc_cny','100.00000000','24.40000000','0.00000000','2440.00000000','0.00000000',1,0,1467290821,0,2),(2,2,'btc_cny','5000.00000000','42.00000000','0.00000000','210000.00000000','0.00000000',2,0,1467290838,0,2),(3,2,'btc_cny','4568.00000000','12.00000000','12.00000000','54816.00000000','0.00000000',2,0,1467290857,0,1),(4,2,'btc_cny','3500.00000000','124.00000000','0.00000000','434000.00000000','0.00000000',1,0,1467290879,0,2),(5,2,'btc_cny','4012.00000000','12.20000000','0.00000000','48946.40000000','0.00000000',1,0,1467290901,0,2),(6,2,'btc_cny','8452.00000000','54.00000000','0.00000000','456408.00000000','0.00000000',2,0,1467290918,0,2),(7,2,'btc_cny','1486.00000000','147.30000000','0.00000000','218887.80000000','0.00000000',1,0,1467290964,0,2),(8,2,'btc_cny','4350.00000000','301.00000000','2.00000000','1309350.00000000','0.00000000',1,0,1467290997,0,2),(9,2,'btc_cny','4400.00000000','10.60000000','10.60000000','46640.00000000','0.00000000',2,0,1467291026,0,1),(10,2,'btc_cny','4350.00000000','1.00000000','1.00000000','4350.00000000','0.00000000',2,0,1467291031,0,1),(11,2,'btc_cny','4350.00000000','1.00000000','1.00000000','4350.00000000','0.00000000',2,0,1467291036,0,1),(12,2,'btc_cny','4400.00000000','0.30000000','0.30000000','1320.00000000','0.00000000',1,0,1467291050,0,1),(13,2,'btc_cny','4568.00000000','0.10000000','0.10000000','456.80000000','0.00000000',1,0,1467291059,0,1),(14,2,'btc_cny','4400.00000000','0.10000000','0.10000000','440.00000000','0.00000000',1,0,1467291073,0,1),(15,2,'ltc_cny','20.00000000','1245.00000000','0.00000000','24900.00000000','0.00000000',1,0,1467291151,0,2),(16,2,'ltc_cny','30.00000000','476.00000000','47.00000000','14280.00000000','0.00000000',2,0,1467291169,0,2),(17,2,'ltc_cny','40.00000000','453.00000000','0.00000000','18120.00000000','0.00000000',2,0,1467291186,0,2),(18,2,'ltc_cny','54.00000000','45.00000000','0.00000000','2430.00000000','0.00000000',2,0,1467291198,0,2),(19,2,'ltc_cny','32.40000000','786.00000000','0.00000000','25466.40000000','0.00000000',2,0,1467291211,0,2),(20,2,'ltc_cny','777.00000000','888.00000000','0.00000000','689976.00000000','0.00000000',2,0,1467291230,0,2),(21,2,'ltc_cny','25.00000000','453.00000000','0.00000000','11325.00000000','0.00000000',1,0,1467291240,0,2),(22,2,'ltc_cny','10.00000000','453.00000000','0.00000000','4530.00000000','0.00000000',1,0,1467291249,0,2),(23,2,'ltc_cny','1.00000000','7777.00000000','0.00000000','7777.00000000','0.00000000',1,0,1467291259,0,2),(24,2,'ltc_cny','27.00000000','1000.00000000','874.00000000','27000.00000000','0.00000000',1,0,1467291272,0,2),(25,2,'ltc_cny','27.00000000','42.00000000','42.00000000','1134.00000000','0.00000000',2,0,1467291282,0,1),(26,2,'ltc_cny','27.00000000','45.00000000','45.00000000','1215.00000000','0.00000000',2,0,1467291287,0,1),(27,2,'ltc_cny','27.00000000','786.00000000','786.00000000','21222.00000000','0.00000000',2,0,1467291295,0,1),(28,2,'ltc_cny','27.00000000','1.00000000','1.00000000','27.00000000','0.00000000',2,0,1467291307,0,1),(29,2,'ltc_cny','30.00000000','1.00000000','1.00000000','30.00000000','0.00000000',1,0,1467291314,0,1),(30,2,'ltc_cny','30.00000000','1.00000000','1.00000000','30.00000000','0.00000000',1,0,1467291319,0,1),(31,2,'ytc_cny','10.00000000','1000.00000000','553.00000000','10000.00000000','0.00000000',1,0,1467291499,0,2),(32,2,'ytc_cny','1.00000000','10000.00000000','0.00000000','10000.00000000','0.00000000',1,0,1467291511,0,2),(33,2,'ytc_cny','5.00000000','4537.00000000','0.00000000','22685.00000000','0.00000000',1,0,1467291516,0,2),(34,2,'ytc_cny','3.00000000','1453.00000000','0.00000000','4359.00000000','0.00000000',1,0,1467291524,0,2),(35,2,'ytc_cny','8.00000000','42341.00000000','0.00000000','338728.00000000','0.00000000',1,0,1467291531,0,2),(36,2,'ytc_cny','11.00000000','4753.00000000','490.00000000','52283.00000000','0.00000000',2,0,1467291543,0,2),(37,2,'ytc_cny','20.00000000','4123.00000000','0.00000000','82460.00000000','0.00000000',2,0,1467291548,0,2),(38,2,'ytc_cny','45.00000000','120.00000000','0.00000000','5400.00000000','0.00000000',2,0,1467291559,0,2),(39,2,'ytc_cny','35.00000000','7786.00000000','0.00000000','272510.00000000','0.00000000',2,0,1467291570,0,2),(40,2,'ytc_cny','14.50000000','955.00000000','0.00000000','13847.50000000','0.00000000',2,0,1467291585,0,2),(41,2,'ytc_cny','12.00000000','312.00000000','0.00000000','3744.00000000','0.00000000',2,0,1467291592,0,2),(42,2,'ytc_cny','11.00000000','1.00000000','1.00000000','11.00000000','0.00000000',1,0,1467291605,0,1),(43,2,'ytc_cny','10.00000000','453.00000000','453.00000000','4530.00000000','0.00000000',2,0,1467291610,0,1),(44,2,'ytc_cny','10.00000000','45.00000000','45.00000000','450.00000000','0.00000000',2,0,1467291620,0,1),(45,2,'ytc_cny','10.00000000','55.00000000','55.00000000','550.00000000','0.00000000',2,0,1467291624,0,1),(46,2,'ytc_cny','11.00000000','444.00000000','444.00000000','4884.00000000','0.00000000',1,0,1467291632,0,1),(47,2,'ytc_cny','11.00000000','45.00000000','45.00000000','495.00000000','0.00000000',1,0,1467291640,0,1),(48,2,'btc_cny','4399.00000000','21.00000000','2.00000000','92379.00000000','0.00000000',1,0,1467360494,0,2),(49,2,'btc_cny','5399.00000000','452.00000000','0.00000000','2440348.00000000','0.00000000',2,0,1467360524,0,2),(50,2,'btc_cny','7567.00000000','77.00000000','0.00000000','582659.00000000','0.00000000',2,0,1467360539,0,2),(51,2,'btc_cny','7888.00000000','78.00000000','0.00000000','615264.00000000','0.00000000',2,0,1467360551,0,2),(52,2,'btc_cny','5012.00000000','44.00000000','0.00000000','220528.00000000','0.00000000',2,0,1467360564,0,2),(53,2,'btc_cny','10000.00000000','2.00000000','0.00000000','20000.00000000','0.00000000',2,0,1467360581,0,2),(54,2,'btc_cny','4850.00000000','77.00000000','0.00000000','373450.00000000','0.00000000',2,0,1467360600,0,2),(55,2,'btc_cny','4599.00000000','24.00000000','11.00000000','110376.00000000','0.00000000',2,0,1467360614,0,2),(56,2,'btc_cny','1.00000000','1.00000000','0.00000000','1.00000000','0.00000000',1,0,1467360626,0,2),(57,2,'btc_cny','2.00000000','2.00000000','0.00000000','4.00000000','0.00000000',1,0,1467360630,0,2),(58,2,'btc_cny','3.00000000','3.00000000','0.00000000','9.00000000','0.00000000',1,0,1467360633,0,2),(59,2,'btc_cny','4.00000000','5.00000000','0.00000000','20.00000000','0.00000000',1,0,1467360637,0,2),(60,2,'btc_cny','5.00000000','5.00000000','0.00000000','25.00000000','0.00000000',1,0,1467360640,0,2),(61,2,'btc_cny','6.00000000','6.00000000','0.00000000','36.00000000','0.00000000',1,0,1467360647,0,2),(62,2,'btc_cny','7.00000000','7.00000000','0.00000000','49.00000000','0.00000000',1,0,1467360651,0,2),(63,2,'btc_cny','20000.00000000','2.00000000','0.00000000','40000.00000000','0.00000000',2,0,1467360666,0,2),(64,2,'btc_cny','9999.00000000','9.00000000','0.00000000','89991.00000000','0.00000000',2,0,1467360676,0,2),(65,2,'btc_cny','4400.00000000','1.00000000','1.00000000','4400.00000000','0.00000000',1,0,1467360689,0,1),(66,2,'btc_cny','4400.00000000','1.00000000','1.00000000','4400.00000000','0.00000000',1,0,1467360694,0,1),(67,2,'btc_cny','4399.00000000','1.00000000','1.00000000','4399.00000000','0.00000000',2,0,1467360697,0,1),(68,2,'btc_cny','4399.00000000','1.00000000','1.00000000','4399.00000000','0.00000000',2,0,1467360700,0,1),(69,2,'btc_cny','4400.00000000','1.00000000','1.00000000','4400.00000000','0.00000000',1,0,1467608890,0,1),(70,2,'btc_cny','4400.00000000','5.40000000','5.40000000','23760.00000000','0.00000000',1,0,1467608895,0,1),(71,2,'btc_cny','4568.00000000','24.00000000','13.70000000','109632.00000000','0.00000000',1,0,1467608900,0,2),(72,2,'btc_cny','4599.00000000','1.00000000','1.00000000','4599.00000000','0.00000000',1,0,1467608914,0,1),(73,2,'btc_cny','4599.00000000','1.00000000','1.00000000','4599.00000000','0.00000000',1,0,1467608921,0,1),(74,2,'ltc_cny','30.00000000','1.00000000','1.00000000','30.00000000','0.00000000',1,0,1467608938,0,1),(75,2,'ltc_cny','30.00000000','21.00000000','21.00000000','630.00000000','0.00000000',1,0,1467608941,0,1),(76,2,'ltc_cny','32.40000000','12.00000000','12.00000000','388.80000000','0.00000000',1,0,1467608945,0,1),(77,2,'ltc_cny','32.40000000','11.00000000','11.00000000','356.40000000','0.00000000',1,0,1467608949,0,1),(78,4,'btc_cny','4599.00000000','1.00000000','1.00000000','4644.99000000','45.99000000',1,0,1467620584,0,1),(79,4,'btc_cny','4850.00000000','2.00000000','2.00000000','9797.00000000','97.00000000',1,0,1467620590,0,1),(80,4,'btc_cny','4599.00000000','3.00000000','3.00000000','13934.97000000','137.97000000',1,0,1467620594,0,1),(81,4,'btc_cny','20000.00000000','1.00000000','1.00000000','20200.00000000','200.00000000',1,0,1467620891,0,1),(82,4,'btc_cny','5399.00000000','1.00000000','1.00000000','5452.99000000','53.99000000',1,0,1467621257,0,1),(83,4,'btc_cny','7567.00000000','1.00000000','1.00000000','7642.67000000','75.67000000',1,0,1467621261,0,1),(84,2,'avc_cny','1.00000000','1.00000000','0.00000000','1.00000000','0.00000000',1,0,1469772911,0,2),(85,2,'avc_cny','2.00000000','2.00000000','0.00000000','4.00000000','0.00000000',2,0,1469772923,0,2),(86,10,'avc_cny','5.00000000','3.00000000','3.00000000','14.85000000','0.15000000',2,0,1469773787,0,1),(87,2,'avc_cny','15.00000000','1.00000000','1.00000000','15.00000000','0.00000000',1,0,1469773880,0,1),(88,2,'avc_cny','5.00000000','2.00000000','2.00000000','10.00000000','0.00000000',1,0,1469773933,0,1),(89,2,'avc_cny','1.00000000','1.00000000','0.00000000','1.00000000','0.00000000',1,0,1469774394,0,2),(90,11,'avc_cny','11.00000000','1.00000000','1.00000000','10.89000000','0.11000000',2,0,1469774410,0,1),(91,11,'avc_cny','6.00000000','1.00000000','1.00000000','5.94000000','0.06000000',2,0,1469774470,0,1),(92,2,'avc_cny','11.00000000','2.00000000','2.00000000','22.00000000','0.00000000',1,0,1469774520,0,1),(93,2,'btc_cny','1.00000000','1.00000000','0.00000000','1.00000000','0.00000000',1,0,1469774737,0,2),(94,2,'btc_cny','1.33300000','1.00000000','0.00000000','1.33300000','0.00000000',1,0,1469774809,0,2),(95,11,'avc_cny','11.50000000','12.00000000','0.00000000','136.62000000','1.38000000',2,0,1469797918,0,2),(96,11,'avc_cny','5.00000000','3.00000000','0.00000000','15.00000000','0.00000000',1,0,1469798060,0,2),(97,2,'ftc_cny','1.00000000','1.00000000','0.00000000','1.00000000','0.00000000',1,0,1477212822,0,2);

/*Table structure for table `movesay_trade_json` */

DROP TABLE IF EXISTS `movesay_trade_json`;

CREATE TABLE `movesay_trade_json` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `market` varchar(100) NOT NULL DEFAULT '',
  `data` varchar(500) NOT NULL DEFAULT '',
  `type` varchar(100) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `market` (`market`),
  KEY `market_type_status` (`market`,`type`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=20220 DEFAULT CHARSET=utf8 COMMENT='交易图表表';

/*Data for the table `movesay_trade_json` */

insert  into `movesay_trade_json`(`id`,`market`,`data`,`type`,`sort`,`addtime`,`endtime`,`status`) values (1,'btc_cny','[1467291032,\"2.50000000\",\"4350.00000000\",\"4400.00000000\",\"4350.00000000\",\"4400.00000000\"]','1',0,1467291032,0,0),(2,'btc_cny','[1467290880,\"2.30000000\",\"4350.00000000\",\"4400.00000000\",\"4350.00000000\",\"4400.00000000\"]','3',0,1467290880,0,0),(3,'btc_cny','[1467291060,\"0.20000000\",\"4400.00000000\",\"4400.00000000\",\"4400.00000000\",\"4400.00000000\"]','3',0,1467291060,0,0),(4,'btc_cny','[1467291000,\"2.50000000\",\"4350.00000000\",\"4400.00000000\",\"4350.00000000\",\"4400.00000000\"]','5',0,1467291000,0,0),(5,'btc_cny','[1467291000,\"2.50000000\",\"4350.00000000\",\"4400.00000000\",\"4350.00000000\",\"4400.00000000\"]','10',0,1467291000,0,0),(6,'btc_cny','[1467290700,\"2.50000000\",\"4350.00000000\",\"4400.00000000\",\"4350.00000000\",\"4400.00000000\"]','15',0,1467290700,0,0),(7,'btc_cny','[1467289800,\"2.50000000\",\"4350.00000000\",\"4400.00000000\",\"4350.00000000\",\"4400.00000000\"]','30',0,1467289800,0,0),(8,'btc_cny','[1467288000,\"2.50000000\",\"4350.00000000\",\"4400.00000000\",\"4350.00000000\",\"4400.00000000\"]','60',0,1467288000,0,0),(9,'btc_cny','[1467288000,\"2.50000000\",\"4350.00000000\",\"4400.00000000\",\"4350.00000000\",\"4400.00000000\"]','120',0,1467288000,0,0),(10,'btc_cny','[1467288000,\"2.50000000\",\"4350.00000000\",\"4400.00000000\",\"4350.00000000\",\"4400.00000000\"]','240',0,1467288000,0,0),(11,'btc_cny','[1467288000,\"2.50000000\",\"4350.00000000\",\"4400.00000000\",\"4350.00000000\",\"4400.00000000\"]','360',0,1467288000,0,0),(12,'btc_cny','[1467288000,\"2.50000000\",\"4350.00000000\",\"4400.00000000\",\"4350.00000000\",\"4400.00000000\"]','720',0,1467288000,0,0),(13,'btc_cny','[1467288000,\"6.50000000\",\"4350.00000000\",\"4400.00000000\",\"4350.00000000\",\"4399.00000000\"]','1440',0,1467288000,0,0),(14,'btc_cny','[1467288000,\"37.60000000\",\"4350.00000000\",\"4599.00000000\",\"4350.00000000\",\"4599.00000000\"]','10080',0,1467288000,0,0),(18,'ltc_cny','[1467291282,\"876.00000000\",\"27.00000000\",\"30.00000000\",\"27.00000000\",\"30.00000000\"]','1',0,1467291282,0,0),(19,'ltc_cny','[1467291240,\"876.00000000\",\"27.00000000\",\"30.00000000\",\"27.00000000\",\"30.00000000\"]','3',0,1467291240,0,0),(20,'ltc_cny','[1467291000,\"873.00000000\",\"27.00000000\",\"27.00000000\",\"27.00000000\",\"27.00000000\"]','5',0,1467291000,0,0),(21,'ltc_cny','[1467291300,\"3.00000000\",\"27.00000000\",\"30.00000000\",\"27.00000000\",\"30.00000000\"]','5',0,1467291300,0,0),(22,'ltc_cny','[1467291000,\"876.00000000\",\"27.00000000\",\"30.00000000\",\"27.00000000\",\"30.00000000\"]','10',0,1467291000,0,0),(23,'ltc_cny','[1467290700,\"876.00000000\",\"27.00000000\",\"30.00000000\",\"27.00000000\",\"30.00000000\"]','15',0,1467290700,0,0),(24,'ltc_cny','[1467289800,\"876.00000000\",\"27.00000000\",\"30.00000000\",\"27.00000000\",\"30.00000000\"]','30',0,1467289800,0,0),(25,'ltc_cny','[1467288000,\"876.00000000\",\"27.00000000\",\"30.00000000\",\"27.00000000\",\"30.00000000\"]','60',0,1467288000,0,0),(26,'ltc_cny','[1467288000,\"876.00000000\",\"27.00000000\",\"30.00000000\",\"27.00000000\",\"30.00000000\"]','120',0,1467288000,0,0),(27,'ltc_cny','[1467288000,\"876.00000000\",\"27.00000000\",\"30.00000000\",\"27.00000000\",\"30.00000000\"]','240',0,1467288000,0,0),(28,'ltc_cny','[1467288000,\"876.00000000\",\"27.00000000\",\"30.00000000\",\"27.00000000\",\"30.00000000\"]','360',0,1467288000,0,0),(29,'ltc_cny','[1467288000,\"876.00000000\",\"27.00000000\",\"30.00000000\",\"27.00000000\",\"30.00000000\"]','720',0,1467288000,0,0),(30,'ltc_cny','[1467288000,\"876.00000000\",\"27.00000000\",\"30.00000000\",\"27.00000000\",\"30.00000000\"]','1440',0,1467288000,0,0),(31,'ltc_cny','[1467288000,\"921.00000000\",\"27.00000000\",\"30.00000000\",\"27.00000000\",\"30.00000000\"]','10080',0,1467288000,0,0),(43,'ytc_cny','[1467291605,\"1043.00000000\",\"11.00000000\",\"11.00000000\",\"10.00000000\",\"11.00000000\"]','1',0,1467291605,0,0),(44,'ytc_cny','[1467291600,\"1043.00000000\",\"11.00000000\",\"11.00000000\",\"10.00000000\",\"11.00000000\"]','3',0,1467291600,0,0),(45,'ytc_cny','[1467291600,\"1043.00000000\",\"11.00000000\",\"11.00000000\",\"10.00000000\",\"11.00000000\"]','5',0,1467291600,0,0),(46,'ytc_cny','[1467291600,\"1043.00000000\",\"11.00000000\",\"11.00000000\",\"10.00000000\",\"11.00000000\"]','10',0,1467291600,0,0),(47,'ytc_cny','[1467291600,\"1043.00000000\",\"11.00000000\",\"11.00000000\",\"10.00000000\",\"11.00000000\"]','15',0,1467291600,0,0),(48,'ytc_cny','[1467291600,\"1043.00000000\",\"11.00000000\",\"11.00000000\",\"10.00000000\",\"11.00000000\"]','30',0,1467291600,0,0),(49,'ytc_cny','[1467291600,\"1043.00000000\",\"11.00000000\",\"11.00000000\",\"10.00000000\",\"11.00000000\"]','60',0,1467291600,0,0),(50,'ytc_cny','[1467291600,\"1043.00000000\",\"11.00000000\",\"11.00000000\",\"10.00000000\",\"11.00000000\"]','120',0,1467291600,0,0),(51,'ytc_cny','[1467291600,\"1043.00000000\",\"11.00000000\",\"11.00000000\",\"10.00000000\",\"11.00000000\"]','240',0,1467291600,0,0),(52,'ytc_cny','[1467291600,\"1043.00000000\",\"11.00000000\",\"11.00000000\",\"10.00000000\",\"11.00000000\"]','360',0,1467291600,0,0),(53,'ytc_cny','[1467291600,\"1043.00000000\",\"11.00000000\",\"11.00000000\",\"10.00000000\",\"11.00000000\"]','720',0,1467291600,0,0),(54,'ytc_cny','[1467291600,\"1043.00000000\",\"11.00000000\",\"11.00000000\",\"10.00000000\",\"11.00000000\"]','1440',0,1467291600,0,0),(55,'ytc_cny','[1467291600,\"1043.00000000\",\"11.00000000\",\"11.00000000\",\"10.00000000\",\"11.00000000\"]','10080',0,1467291600,0,0),(56,'ytc_cny','','1',0,1467291665,0,0),(57,'ytc_cny','','3',0,1467291780,0,0),(58,'ytc_cny','','5',0,1467291900,0,0),(59,'ytc_cny','','10',0,1467292200,0,0),(60,'ytc_cny','','15',0,1467292500,0,0),(61,'ytc_cny','','30',0,1467293400,0,0),(64,'ytc_cny','','60',0,1467295200,0,0),(65,'ytc_cny','','120',0,1467298800,0,0),(72,'btc_cny','[1467331200,\"4.00000000\",\"4400.00000000\",\"4400.00000000\",\"4399.00000000\",\"4399.00000000\"]','720',0,1467331200,0,0),(80,'ytc_cny','','240',0,1467306000,0,0),(81,'ytc_cny','','240',0,1467320400,0,0),(82,'ytc_cny','','240',0,1467334800,0,0),(83,'ytc_cny','','360',0,1467313200,0,0),(84,'ytc_cny','','360',0,1467334800,0,0),(85,'ytc_cny','','720',0,1467334800,0,0),(231,'btc_cny','[1467360000,\"4.00000000\",\"4400.00000000\",\"4400.00000000\",\"4399.00000000\",\"4399.00000000\"]','60',0,1467360000,0,0),(241,'btc_cny','[1467360000,\"4.00000000\",\"4400.00000000\",\"4400.00000000\",\"4399.00000000\",\"4399.00000000\"]','120',0,1467360000,0,0),(243,'btc_cny','[1467360000,\"4.00000000\",\"4400.00000000\",\"4400.00000000\",\"4399.00000000\",\"4399.00000000\"]','240',0,1467360000,0,0),(245,'btc_cny','[1467352800,\"4.00000000\",\"4400.00000000\",\"4400.00000000\",\"4399.00000000\",\"4399.00000000\"]','360',0,1467352800,0,0),(369,'btc_cny','[1467360000,\"4.00000000\",\"4400.00000000\",\"4400.00000000\",\"4399.00000000\",\"4399.00000000\"]','30',0,1467360000,0,0),(575,'btc_cny','[1467360000,\"4.00000000\",\"4400.00000000\",\"4400.00000000\",\"4399.00000000\",\"4399.00000000\"]','15',0,1467360000,0,0),(739,'btc_cny','[1467360600,\"4.00000000\",\"4400.00000000\",\"4400.00000000\",\"4399.00000000\",\"4399.00000000\"]','10',0,1467360600,0,0),(1109,'btc_cny','[1467360600,\"4.00000000\",\"4400.00000000\",\"4400.00000000\",\"4399.00000000\",\"4399.00000000\"]','5',0,1467360600,0,0),(1433,'btc_cny','[1467360540,\"4.00000000\",\"4400.00000000\",\"4400.00000000\",\"4399.00000000\",\"4399.00000000\"]','3',0,1467360540,0,0),(2238,'btc_cny','[1467360632,\"1.00000000\",\"4400.00000000\",\"4400.00000000\",\"4400.00000000\",\"4400.00000000\"]','1',0,1467360632,0,0),(2239,'btc_cny','[1467360692,\"3.00000000\",\"4400.00000000\",\"4400.00000000\",\"4399.00000000\",\"4399.00000000\"]','1',0,1467360692,0,0),(2266,'ytc_cny','','1440',0,1467378000,0,0),(2451,'btc_cny','[1467604800,\"22.10000000\",\"4400.00000000\",\"4599.00000000\",\"4400.00000000\",\"4599.00000000\"]','240',0,1467604800,0,0),(2462,'btc_cny','[1467590400,\"22.10000000\",\"4400.00000000\",\"4599.00000000\",\"4400.00000000\",\"4599.00000000\"]','360',0,1467590400,0,0),(2468,'btc_cny','[1467590400,\"31.10000000\",\"4400.00000000\",\"4599.00000000\",\"4400.00000000\",\"4599.00000000\"]','720',0,1467590400,0,0),(2471,'btc_cny','[1467547200,\"31.10000000\",\"4400.00000000\",\"4599.00000000\",\"4400.00000000\",\"4599.00000000\"]','1440',0,1467547200,0,0),(2658,'ltc_cny','[1467604800,\"45.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\"]','240',0,1467604800,0,0),(2671,'ltc_cny','[1467590400,\"45.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\"]','360',0,1467590400,0,0),(2678,'ltc_cny','[1467590400,\"45.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\"]','720',0,1467590400,0,0),(2681,'ltc_cny','[1467547200,\"45.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\"]','1440',0,1467547200,0,0),(2842,'btc_cny','[1467604800,\"22.10000000\",\"4400.00000000\",\"4599.00000000\",\"4400.00000000\",\"4599.00000000\"]','120',0,1467604800,0,0),(3308,'ltc_cny','[1467604800,\"45.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\"]','120',0,1467604800,0,0),(3443,'btc_cny','[1467608400,\"22.10000000\",\"4400.00000000\",\"4599.00000000\",\"4400.00000000\",\"4599.00000000\"]','60',0,1467608400,0,0),(3851,'ltc_cny','[1467608400,\"45.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\"]','60',0,1467608400,0,0),(4226,'btc_cny','[1467608400,\"22.10000000\",\"4400.00000000\",\"4599.00000000\",\"4400.00000000\",\"4599.00000000\"]','30',0,1467608400,0,0),(4810,'ltc_cny','[1467608400,\"45.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\"]','30',0,1467608400,0,0),(5750,'btc_cny','[1467608400,\"22.10000000\",\"4400.00000000\",\"4599.00000000\",\"4400.00000000\",\"4599.00000000\"]','15',0,1467608400,0,0),(6604,'ltc_cny','[1467608400,\"45.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\"]','15',0,1467608400,0,0),(6605,'ltc_cny','','15',0,1467609300,0,0),(7017,'btc_cny','[1467608400,\"22.10000000\",\"4400.00000000\",\"4599.00000000\",\"4400.00000000\",\"4599.00000000\"]','10',0,1467608400,0,0),(7252,'ltc_cny','','30',0,1467610200,0,0),(7975,'ltc_cny','[1467608400,\"45.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\"]','10',0,1467608400,0,0),(7976,'ltc_cny','','10',0,1467609000,0,0),(7977,'ltc_cny','','10',0,1467609600,0,0),(7978,'ltc_cny','','10',0,1467610200,0,0),(9790,'btc_cny','[1467608700,\"22.10000000\",\"4400.00000000\",\"4599.00000000\",\"4400.00000000\",\"4599.00000000\"]','5',0,1467608700,0,0),(10852,'btc_cny','[1467612000,\"9.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','360',0,1467612000,0,0),(10916,'ltc_cny','','60',0,1467612000,0,0),(10917,'ltc_cny','','120',0,1467612000,0,0),(10918,'ltc_cny','','360',0,1467612000,0,0),(11020,'ltc_cny','[1467608700,\"45.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\"]','5',0,1467608700,0,0),(11021,'ltc_cny','','5',0,1467609000,0,0),(11022,'ltc_cny','','5',0,1467609300,0,0),(11023,'ltc_cny','','5',0,1467609600,0,0),(12317,'btc_cny','[1467608760,\"22.10000000\",\"4400.00000000\",\"4599.00000000\",\"4400.00000000\",\"4599.00000000\"]','3',0,1467608760,0,0),(13610,'ltc_cny','[1467608760,\"1.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\"]','3',0,1467608760,0,0),(13611,'ltc_cny','[1467608940,\"44.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\"]','3',0,1467608940,0,0),(13612,'ltc_cny','','3',0,1467609120,0,0),(13613,'ltc_cny','','3',0,1467609300,0,0),(13614,'ltc_cny','','3',0,1467609480,0,0),(13615,'ltc_cny','','3',0,1467609660,0,0),(13616,'ltc_cny','','3',0,1467609840,0,0),(13617,'ltc_cny','','3',0,1467610020,0,0),(13618,'ltc_cny','','3',0,1467610200,0,0),(13619,'ltc_cny','','3',0,1467610380,0,0),(13620,'ltc_cny','','3',0,1467610560,0,0),(13621,'ltc_cny','','3',0,1467610740,0,0),(13622,'ltc_cny','','3',0,1467610920,0,0),(13623,'ltc_cny','','3',0,1467611100,0,0),(13624,'ltc_cny','','3',0,1467611280,0,0),(13625,'ltc_cny','','3',0,1467611460,0,0),(13626,'ltc_cny','','3',0,1467611640,0,0),(13627,'ltc_cny','','3',0,1467611820,0,0),(16715,'btc_cny','[1467619200,\"9.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','240',0,1467619200,0,0),(16737,'ltc_cny','','240',0,1467619200,0,0),(17785,'btc_cny','[1467620400,\"7.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','10',0,1467620400,0,0),(17798,'btc_cny','[1467620100,\"7.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','15',0,1467620100,0,0),(17804,'btc_cny','[1467619200,\"7.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','30',0,1467619200,0,0),(17807,'btc_cny','[1467619200,\"9.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','60',0,1467619200,0,0),(17809,'btc_cny','[1467619200,\"9.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','120',0,1467619200,0,0),(17883,'btc_cny','[1467620400,\"6.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','5',0,1467620400,0,0),(17884,'btc_cny','[1467620700,\"1.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','5',0,1467620700,0,0),(17944,'btc_cny','[1467620460,\"6.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','3',0,1467620460,0,0),(18073,'btc_cny','[1467620820,\"1.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','3',0,1467620820,0,0),(18117,'btc_cny','[1467621000,\"2.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','5',0,1467621000,0,0),(18118,'btc_cny','[1467621000,\"2.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','10',0,1467621000,0,0),(18119,'btc_cny','[1467621000,\"2.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','15',0,1467621000,0,0),(18120,'btc_cny','[1467621000,\"2.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','30',0,1467621000,0,0),(18332,'btc_cny','[1467621180,\"2.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','3',0,1467621180,0,0),(18333,'btc_cny','','5',0,1467621300,0,0),(18376,'btc_cny','','3',0,1467621360,0,0),(18545,'btc_cny','','10',0,1467621600,0,0),(18667,'btc_cny','[1467608852,\"20.10000000\",\"4400.00000000\",\"4568.00000000\",\"4400.00000000\",\"4568.00000000\"]','1',0,1467608852,0,0),(18668,'btc_cny','[1467608912,\"2.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','1',0,1467608912,0,0),(18756,'btc_cny','','15',0,1467621900,0,0),(19083,'btc_cny','[1467620552,\"6.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','1',0,1467620552,0,0),(19088,'btc_cny','[1467620852,\"1.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','1',0,1467620852,0,0),(19116,'btc_cny','[1467621212,\"2.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\",\"4599.00000000\"]','1',0,1467621212,0,0),(19117,'btc_cny','','1',0,1467621272,0,0),(19118,'btc_cny','','1',0,1467621332,0,0),(19119,'btc_cny','','1',0,1467621392,0,0),(19120,'btc_cny','','1',0,1467621452,0,0),(19121,'btc_cny','','1',0,1467621512,0,0),(19122,'btc_cny','','1',0,1467621572,0,0),(19123,'btc_cny','','1',0,1467621632,0,0),(19124,'btc_cny','','1',0,1467621692,0,0),(19125,'btc_cny','','1',0,1467621752,0,0),(19126,'btc_cny','','1',0,1467621812,0,0),(19127,'btc_cny','','1',0,1467621872,0,0),(19128,'btc_cny','','1',0,1467621932,0,0),(19129,'btc_cny','','1',0,1467621992,0,0),(19130,'btc_cny','','1',0,1467622052,0,0),(19131,'btc_cny','','1',0,1467622112,0,0),(19132,'btc_cny','','1',0,1467622172,0,0),(19133,'btc_cny','','1',0,1467622232,0,0),(19134,'btc_cny','','1',0,1467622292,0,0),(19261,'btc_cny','','30',0,1467622800,0,0),(19262,'btc_cny','','60',0,1467622800,0,0),(20158,'ltc_cny','[1467608922,\"45.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\",\"30.00000000\"]','1',0,1467608922,0,0),(20159,'ltc_cny','','1',0,1467608982,0,0),(20160,'ltc_cny','','1',0,1467609042,0,0),(20161,'ltc_cny','','1',0,1467609102,0,0),(20162,'ltc_cny','','1',0,1467609162,0,0),(20163,'ltc_cny','','1',0,1467609222,0,0),(20164,'ltc_cny','','1',0,1467609282,0,0),(20165,'ltc_cny','','1',0,1467609342,0,0),(20166,'btc_cny','','120',0,1467626400,0,0),(20167,'btc_cny','','240',0,1467633600,0,0),(20168,'btc_cny','','360',0,1467633600,0,0),(20169,'btc_cny','','720',0,1467633600,0,0),(20170,'btc_cny','','1440',0,1467633600,0,0),(20171,'ltc_cny','','720',0,1467633600,0,0),(20172,'ltc_cny','','1440',0,1467633600,0,0),(20173,'btc_cny','','10080',0,1467892800,0,0),(20174,'ltc_cny','','10080',0,1467892800,0,0),(20175,'avc_cny','[1469773880,\"3.00000000\",\"5.00000000\",\"5.00000000\",\"5.00000000\",\"5.00000000\"]','1',0,1469773880,0,0),(20176,'avc_cny','[1469773800,\"3.00000000\",\"5.00000000\",\"5.00000000\",\"5.00000000\",\"5.00000000\"]','3',0,1469773800,0,0),(20177,'avc_cny','[1469773800,\"3.00000000\",\"5.00000000\",\"5.00000000\",\"5.00000000\",\"5.00000000\"]','5',0,1469773800,0,0),(20178,'avc_cny','[1469773800,\"3.00000000\",\"5.00000000\",\"5.00000000\",\"5.00000000\",\"5.00000000\"]','10',0,1469773800,0,0),(20179,'avc_cny','[1469773800,\"5.00000000\",\"5.00000000\",\"11.00000000\",\"5.00000000\",\"11.00000000\"]','15',0,1469773800,0,0),(20180,'avc_cny','[1469773800,\"5.00000000\",\"5.00000000\",\"11.00000000\",\"5.00000000\",\"11.00000000\"]','30',0,1469773800,0,0),(20181,'avc_cny','[1469772000,\"5.00000000\",\"5.00000000\",\"11.00000000\",\"5.00000000\",\"11.00000000\"]','60',0,1469772000,0,0),(20182,'avc_cny','[1469772000,\"5.00000000\",\"5.00000000\",\"11.00000000\",\"5.00000000\",\"11.00000000\"]','120',0,1469772000,0,0),(20183,'avc_cny','[1469772000,\"5.00000000\",\"5.00000000\",\"11.00000000\",\"5.00000000\",\"11.00000000\"]','240',0,1469772000,0,0),(20184,'avc_cny','[1469772000,\"5.00000000\",\"5.00000000\",\"11.00000000\",\"5.00000000\",\"11.00000000\"]','360',0,1469772000,0,0),(20185,'avc_cny','[1469772000,\"5.00000000\",\"5.00000000\",\"11.00000000\",\"5.00000000\",\"11.00000000\"]','720',0,1469772000,0,0),(20186,'avc_cny','[1469772000,\"5.00000000\",\"5.00000000\",\"11.00000000\",\"5.00000000\",\"11.00000000\"]','1440',0,1469772000,0,0),(20187,'avc_cny','[1469772000,\"5.00000000\",\"5.00000000\",\"11.00000000\",\"5.00000000\",\"11.00000000\"]','10080',0,1469772000,0,0),(20191,'avc_cny','[1469774400,\"2.00000000\",\"6.00000000\",\"11.00000000\",\"6.00000000\",\"11.00000000\"]','10',0,1469774400,0,0),(20201,'avc_cny','[1469774480,\"2.00000000\",\"6.00000000\",\"11.00000000\",\"6.00000000\",\"11.00000000\"]','1',0,1469774480,0,0),(20205,'avc_cny','[1469774520,\"2.00000000\",\"6.00000000\",\"11.00000000\",\"6.00000000\",\"11.00000000\"]','3',0,1469774520,0,0),(20207,'avc_cny','[1469774400,\"2.00000000\",\"6.00000000\",\"11.00000000\",\"6.00000000\",\"11.00000000\"]','5',0,1469774400,0,0),(20208,'avc_cny','','1',0,1469774540,0,0),(20209,'avc_cny','','3',0,1469774700,0,0),(20210,'avc_cny','','5',0,1469774700,0,0),(20211,'avc_cny','','15',0,1469774700,0,0),(20212,'avc_cny','','10',0,1469775000,0,0),(20213,'avc_cny','','30',0,1469775600,0,0),(20214,'avc_cny','','60',0,1469775600,0,0),(20215,'avc_cny','','120',0,1469779200,0,0),(20216,'avc_cny','','240',0,1469786400,0,0),(20217,'avc_cny','','360',0,1469793600,0,0),(20218,'avc_cny','','720',0,1469815200,0,0),(20219,'avc_cny','','1440',0,1469858400,0,0);

/*Table structure for table `movesay_trade_log` */

DROP TABLE IF EXISTS `movesay_trade_log`;

CREATE TABLE `movesay_trade_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `peerid` int(11) unsigned NOT NULL DEFAULT '0',
  `market` varchar(50) NOT NULL DEFAULT '',
  `price` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `num` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `mum` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `fee_buy` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `fee_sell` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `userid` (`userid`),
  KEY `peerid` (`peerid`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=gbk;

/*Data for the table `movesay_trade_log` */

insert  into `movesay_trade_log`(`id`,`userid`,`peerid`,`market`,`price`,`num`,`mum`,`fee_buy`,`fee_sell`,`type`,`sort`,`addtime`,`endtime`,`status`) values (1,2,2,'btc_cny','4350.00000000','1.00000000','4350.00000000','0.00000000','0.00000000',2,0,1467291032,0,1),(2,2,2,'btc_cny','4350.00000000','1.00000000','4350.00000000','0.00000000','0.00000000',2,0,1467291036,0,1),(3,2,2,'btc_cny','4400.00000000','0.30000000','1320.00000000','0.00000000','0.00000000',1,0,1467291050,0,1),(4,2,2,'btc_cny','4400.00000000','0.10000000','440.00000000','0.00000000','0.00000000',1,0,1467291060,0,1),(5,2,2,'btc_cny','4400.00000000','0.10000000','440.00000000','0.00000000','0.00000000',1,0,1467291073,0,1),(6,2,2,'ltc_cny','27.00000000','42.00000000','1134.00000000','0.00000000','0.00000000',2,0,1467291282,0,1),(7,2,2,'ltc_cny','27.00000000','45.00000000','1215.00000000','0.00000000','0.00000000',2,0,1467291288,0,1),(8,2,2,'ltc_cny','27.00000000','786.00000000','21222.00000000','0.00000000','0.00000000',2,0,1467291295,0,1),(9,2,2,'ltc_cny','27.00000000','1.00000000','27.00000000','0.00000000','0.00000000',2,0,1467291307,0,1),(10,2,2,'ltc_cny','30.00000000','1.00000000','30.00000000','0.00000000','0.00000000',1,0,1467291314,0,1),(11,2,2,'ltc_cny','30.00000000','1.00000000','30.00000000','0.00000000','0.00000000',1,0,1467291319,0,1),(12,2,2,'ytc_cny','11.00000000','1.00000000','11.00000000','0.00000000','0.00000000',1,0,1467291605,0,1),(13,2,2,'ytc_cny','10.00000000','453.00000000','4530.00000000','0.00000000','0.00000000',2,0,1467291610,0,1),(14,2,2,'ytc_cny','10.00000000','45.00000000','450.00000000','0.00000000','0.00000000',2,0,1467291620,0,1),(15,2,2,'ytc_cny','10.00000000','55.00000000','550.00000000','0.00000000','0.00000000',2,0,1467291624,0,1),(16,2,2,'ytc_cny','11.00000000','444.00000000','4884.00000000','0.00000000','0.00000000',1,0,1467291632,0,1),(17,2,2,'ytc_cny','11.00000000','45.00000000','495.00000000','0.00000000','0.00000000',1,0,1467291640,0,1),(18,2,2,'btc_cny','4400.00000000','1.00000000','4400.00000000','0.00000000','0.00000000',1,0,1467360689,0,1),(19,2,2,'btc_cny','4400.00000000','1.00000000','4400.00000000','0.00000000','0.00000000',1,0,1467360694,0,1),(20,2,2,'btc_cny','4399.00000000','1.00000000','4399.00000000','0.00000000','0.00000000',2,0,1467360697,0,1),(21,2,2,'btc_cny','4399.00000000','1.00000000','4399.00000000','0.00000000','0.00000000',2,0,1467360700,0,1),(22,2,2,'btc_cny','4400.00000000','1.00000000','4400.00000000','0.00000000','0.00000000',1,0,1467608890,0,1),(23,2,2,'btc_cny','4400.00000000','5.40000000','23760.00000000','0.00000000','0.00000000',1,0,1467608895,0,1),(24,2,2,'btc_cny','4400.00000000','1.70000000','7480.00000000','0.00000000','0.00000000',1,0,1467608900,0,1),(25,2,2,'btc_cny','4568.00000000','12.00000000','54816.00000000','0.00000000','0.00000000',1,0,1467608900,0,1),(26,2,2,'btc_cny','4599.00000000','1.00000000','4599.00000000','0.00000000','0.00000000',1,0,1467608914,0,1),(27,2,2,'btc_cny','4599.00000000','1.00000000','4599.00000000','0.00000000','0.00000000',1,0,1467608921,0,1),(28,2,2,'ltc_cny','30.00000000','1.00000000','30.00000000','0.00000000','0.00000000',1,0,1467608938,0,1),(29,2,2,'ltc_cny','30.00000000','21.00000000','630.00000000','0.00000000','0.00000000',1,0,1467608941,0,1),(30,2,2,'ltc_cny','30.00000000','12.00000000','360.00000000','0.00000000','0.00000000',1,0,1467608945,0,1),(31,2,2,'ltc_cny','30.00000000','11.00000000','330.00000000','0.00000000','0.00000000',1,0,1467608949,0,1),(32,4,2,'btc_cny','4599.00000000','1.00000000','4599.00000000','45.99000000','45.99000000',1,0,1467620584,0,1),(33,4,2,'btc_cny','4599.00000000','2.00000000','9198.00000000','91.98000000','91.98000000',1,0,1467620590,0,1),(34,4,2,'btc_cny','4599.00000000','3.00000000','13797.00000000','137.97000000','137.97000000',1,0,1467620594,0,1),(35,4,2,'btc_cny','4599.00000000','1.00000000','4599.00000000','45.99000000','45.99000000',1,0,1467620891,0,1),(36,4,2,'btc_cny','4599.00000000','1.00000000','4599.00000000','45.99000000','45.99000000',1,0,1467621257,0,1),(37,4,2,'btc_cny','4599.00000000','1.00000000','4599.00000000','45.99000000','45.99000000',1,0,1467621261,0,1),(38,2,10,'avc_cny','5.00000000','1.00000000','5.00000000','0.00000000','0.05000000',1,0,1469773880,0,1),(39,2,10,'avc_cny','5.00000000','2.00000000','10.00000000','0.00000000','0.10000000',1,0,1469773933,0,1),(40,2,11,'avc_cny','6.00000000','1.00000000','6.00000000','0.00000000','0.06000000',1,0,1469774520,0,1),(41,2,11,'avc_cny','11.00000000','1.00000000','11.00000000','0.00000000','0.11000000',1,0,1469774520,0,1);

/*Table structure for table `movesay_user` */

DROP TABLE IF EXISTS `movesay_user`;

CREATE TABLE `movesay_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '',
  `moble` varchar(50) NOT NULL DEFAULT '',
  `mobletime` int(11) unsigned NOT NULL DEFAULT '0',
  `password` varchar(32) NOT NULL DEFAULT '',
  `tpwdsetting` varchar(32) NOT NULL DEFAULT '',
  `paypassword` varchar(32) NOT NULL DEFAULT '',
  `invit` varchar(32) NOT NULL DEFAULT '',
  `invit_1` varchar(50) NOT NULL DEFAULT '',
  `invit_2` varchar(50) NOT NULL DEFAULT '',
  `invit_3` varchar(50) NOT NULL DEFAULT '',
  `truename` varchar(32) NOT NULL DEFAULT '',
  `idcardtype` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1:身份证2:护照',
  `idcard` varchar(32) NOT NULL DEFAULT '',
  `logins` int(11) unsigned NOT NULL DEFAULT '0',
  `ga` varchar(50) NOT NULL DEFAULT '',
  `addip` varchar(50) NOT NULL DEFAULT '',
  `addr` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `alipay` varchar(200) DEFAULT NULL COMMENT '支付宝',
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

/*Data for the table `movesay_user` */

insert  into `movesay_user`(`id`,`username`,`moble`,`mobletime`,`password`,`tpwdsetting`,`paypassword`,`invit`,`invit_1`,`invit_2`,`invit_3`,`truename`,`idcardtype`,`idcard`,`logins`,`ga`,`addip`,`addr`,`sort`,`addtime`,`endtime`,`status`,`email`,`alipay`) values (1,'movesay','',0,'b887cbf3cbbc67a332b47eab6fadbc89','1','0a7de7a81d7e87b6f2cde05d0e692d07','RLSHFK','0','0','0','牛一',1,'420117198804074311',1,'','127.0.0.1','未分配或者内网IP',0,1459584765,0,1,NULL,NULL),(2,'BTC10000','8618573148630',1467359791,'e10adc3949ba59abbe56e057f20f883e','1','fcea920f7412b5da7be0cf42b8c93759','EXHGTU','0','0','0','牛牛',1,'430822198712120000',52,'','121.34.129.214','未分配或者内网IP',0,1467279524,0,1,NULL,NULL),(3,'yjj123','',0,'e10adc3949ba59abbe56e057f20f883e','1','c33367701511b4f6020ec61ded352059','QMHJWR','0','0','0','的广泛的',1,'111111111111111111',6,'','112.95.136.101','未分配或者内网IP',0,1467285932,0,1,NULL,NULL),(4,'btc20000','13888888888',1469894400,'e10adc3949ba59abbe56e057f20f883e','1','fcea920f7412b5da7be0cf42b8c93759','HLAMGQ','2','0','0','牛位',1,'430901195012120000',5,'','121.34.129.214','未分配或者内网IP',0,1467353358,0,1,NULL,NULL),(5,'btc30000','',0,'e10adc3949ba59abbe56e057f20f883e','1','fcea920f7412b5da7be0cf42b8c93759','YBLAGN','0','0','0','大刘',1,'430822199911111111',5,'','183.54.81.121','未分配或者内网IP',0,1467710139,0,1,NULL,NULL),(6,'btc40000','85211111111',1469152075,'e10adc3949ba59abbe56e057f20f883e','1','fcea920f7412b5da7be0cf42b8c93759','RLQYPV','0','0','0','呵呵',1,'430821199901011111',4,'','121.34.145.66','未分配或者内网IP',0,1468894086,0,1,NULL,NULL),(7,'BTC50000','85292710570',1469099760,'e10adc3949ba59abbe56e057f20f883e','1','fcea920f7412b5da7be0cf42b8c93759','ZYPKUD','0','0','0','呵呵哈',1,'430822199903031111',1,'','113.102.160.118','未分配或者内网IP',0,1469094586,0,1,NULL,NULL),(8,'btc60000','',0,'e10adc3949ba59abbe56e057f20f883e','1','fcea920f7412b5da7be0cf42b8c93759','QHFYJC','0','0','0','',1,'',2,'','113.102.160.118','未分配或者内网IP',0,1469151023,0,1,NULL,NULL),(9,'btc100','',0,'e10adc3949ba59abbe56e057f20f883e','1','fcea920f7412b5da7be0cf42b8c93759','RCYQWE','0','0','0','',1,'',0,'','113.102.160.118','未分配或者内网IP',0,1469177988,0,1,NULL,NULL),(10,'z13662293706','8613662293706',1469770162,'a45fdb1e4ac646c9e65a1769663e5704','1','a45fdb1e4ac646c9e65a1769663e5704','ZQMFNP','0','0','0','张飞',1,'370684199002288116',5,'','116.25.31.163','未分配或者内网IP',0,1469258454,0,1,NULL,NULL),(11,'zzz999','8618510755953',1469770972,'8f31c1023b1eb0ca522c8019322d0271','1','2c9201b8eb0640cb7e62cd60bbf2d02c','GJIBFV','0','0','0','在的',1,'111222111122222121',2,'','121.35.86.168','未分配或者内网IP',0,1469429468,0,1,NULL,NULL),(12,'qweqwe','',0,'d0dcbf0d12a6b1e7fbfa2ce5848f3eff','1','3fd6ebe43dab8b6ce6d033a5da6e6ac5','XBLDKZ','0','0','0','张清洋',1,'210905197807210541',0,'','98.126.61.242','未分配或者内网IP',0,1469971286,0,1,NULL,NULL),(13,'Xiaocufeng','',0,'59300e0889608e865bf8496f983a0199','1','19d8f85ddce091c032fe2c9da95d3af3','VCEAUF','0','0','0','肖楚丰',1,'440527197611023713',3,'','211.162.34.35','未分配或者内网IP',0,1469977085,0,1,NULL,NULL),(14,'BMM1313','',0,'5fd057d91d27ab18ba7309419620586c','1','091dcb5fc970c50dbdcd199aed5db965','BDHEPI','0','0','0','',1,'',0,'','115.134.176.166','未分配或者内网IP',0,1469981521,0,1,NULL,NULL),(15,'tm8755','',0,'e84e93ccb5f28369755e1d1b72da13d1','1','d60468cb3cccac5bab686855a11bb190','FQHEJW','0','0','0','汤明',1,'340702196311270013',0,'','36.4.135.102','未分配或者内网IP',0,1470036559,0,1,NULL,NULL),(16,'lkv666','',0,'6ef44947c4df3f53f8b9feee370fa868','1','8ddcff3a80f4189ca1c9d4d902c3c909','FUGKLW','0','0','0','马云龙',1,'423057246792366245',0,'','183.234.194.224','未分配或者内网IP',0,1470042494,0,1,NULL,NULL),(17,'woaiwojia','',0,'44ea4672d59895f821bfed2962393e5f','1','41aa0276882c29ca47124ffa5248ada2','CZRFPA','0','0','0','王娟',1,'64022119811010212x',0,'','111.50.52.193','未分配或者内网IP',0,1470103444,0,1,NULL,NULL),(18,'whwece','',0,'da89f1810aff21c66c3c421c68a5ec03','1','4c3b63a21a1f816745bed6569ec64529','ZGRDVC','0','0','0','吴华伟',1,'610502197806218435',0,'','36.40.42.58','未分配或者内网IP',0,1470138383,0,1,NULL,NULL),(23,'smithuang','18926015545',1470652414,'25f9e794323b453885f5181f1b624d0b','1','16cdf76023afa88e031cfa969414d9a6','WLPMFR','0','0','0','smith',2,'G12345678',8,'','127.0.0.1','未分配或者内网IP',0,1470645591,0,1,NULL,NULL),(24,'btc88888','',0,'e10adc3949ba59abbe56e057f20f883e','1','96e79218965eb72c92a549dd5a330112','SWRXQV','0','0','0','大大',1,'430821198810103333',1,'','14.127.89.72','未分配或者内网IP',0,1477204148,0,1,NULL,NULL),(25,'k15251','',0,'577c9c120ddae065326591ea5a74a5a8','1','17aad7884fe4e529d6b2c7b67f897c43','QKGECS','0','0','0',' 蔡洋洋',1,'410224198807260352',0,'','182.112.14.219','未分配或者内网IP',0,1477212776,0,1,NULL,NULL);

/*Table structure for table `movesay_user_bank` */

DROP TABLE IF EXISTS `movesay_user_bank`;

CREATE TABLE `movesay_user_bank` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(200) NOT NULL DEFAULT '',
  `bank` varchar(200) NOT NULL DEFAULT '',
  `bankprov` varchar(200) NOT NULL DEFAULT '',
  `bankcity` varchar(200) NOT NULL DEFAULT '',
  `bankaddr` varchar(200) NOT NULL DEFAULT '',
  `bankcard` varchar(200) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `movesay_user_bank` */

insert  into `movesay_user_bank`(`id`,`userid`,`name`,`bank`,`bankprov`,`bankcity`,`bankaddr`,`bankcard`,`sort`,`addtime`,`endtime`,`status`) values (1,2,'广东','平安银行','广东','深圳','科技园支行','8888888888888888',0,1467292115,0,1),(2,4,'123','平安银行','北京','西城区','哈哈哈','88888888',0,1467354708,0,1);

/*Table structure for table `movesay_user_bank_type` */

DROP TABLE IF EXISTS `movesay_user_bank_type`;

CREATE TABLE `movesay_user_bank_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `title` varchar(200) NOT NULL DEFAULT '',
  `url` varchar(200) NOT NULL DEFAULT '',
  `img` varchar(200) NOT NULL DEFAULT '',
  `mytx` varchar(200) NOT NULL DEFAULT '',
  `remark` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='常用银行地址';

/*Data for the table `movesay_user_bank_type` */

insert  into `movesay_user_bank_type`(`id`,`name`,`title`,`url`,`img`,`mytx`,`remark`,`sort`,`addtime`,`endtime`,`status`) values (4,'boc','中国银行','http://www.boc.cn/','img_56937003683ce.jpg','','',0,1452503043,0,1),(5,'abc','农业银行','http://www.abchina.com/cn/','img_569370458b18d.jpg','','',0,1452503109,0,1),(6,'bccb','北京银行','http://www.bankofbeijing.com.cn/','img_569370588dcdc.jpg','','',0,1452503128,0,1),(8,'ccb','建设银行','http://www.ccb.com/','img_5693709bbd20f.jpg','','',0,1452503195,0,1),(9,'ceb','光大银行','http://www.bankofbeijing.com.cn/','img_569370b207cc8.jpg','','',0,1452503218,0,1),(10,'cib','兴业银行','http://www.cib.com.cn/cn/index.html','img_569370d29bf59.jpg','','',0,1452503250,0,1),(11,'citic','中信银行','http://www.ecitic.com/','img_569370fb7a1b3.jpg','','',0,1452503291,0,1),(12,'cmb','招商银行','http://www.cmbchina.com/','img_5693710a9ac9c.jpg','','',0,1452503306,0,1),(13,'cmbc','民生银行','http://www.cmbchina.com/','img_5693711f97a9d.jpg','','',0,1452503327,0,1),(14,'comm','交通银行','http://www.bankcomm.com/BankCommSite/default.shtml','img_5693713076351.jpg','','',0,1452503344,0,1),(16,'gdb','广发银行','http://www.cgbchina.com.cn/','img_56937154bebc5.jpg','','',0,1452503380,0,1),(17,'icbc','工商银行','http://www.icbc.com.cn/icbc/','img_56937162db7f5.jpg','','',0,1452503394,0,1),(19,'psbc','邮政银行','http://www.psbc.com/portal/zh_CN/index.html','img_5693717eefaa3.jpg','','',0,1452503422,0,1),(20,'spdb','浦发银行','http://www.spdb.com.cn/chpage/c1/','img_5693718f1d70e.jpg','','',0,1452503439,0,1),(21,'szpab','平安银行','http://bank.pingan.com/','56c2e4c9aff85.jpg','','',0,1455613129,0,1);

/*Table structure for table `movesay_user_coin` */

DROP TABLE IF EXISTS `movesay_user_coin`;

CREATE TABLE `movesay_user_coin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL DEFAULT '0',
  `cny` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `cnyd` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `btc` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `btcd` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `btcb` varchar(200) NOT NULL DEFAULT '',
  `ftc` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `ftcd` decimal(20,8) unsigned NOT NULL DEFAULT '0.00000000',
  `ftcb` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='用户币种表';

/*Data for the table `movesay_user_coin` */

insert  into `movesay_user_coin`(`id`,`userid`,`cny`,`cnyd`,`btc`,`btcd`,`btcb`,`ftc`,`ftcd`,`ftcb`) values (1,1,'0.00000000','0.00000000','0.00000000','0.00000000','15WmqCpYF79L3TNJVWhQk6dmtJqzVr3Ebs','0.00000000','0.00000000',''),(2,2,'2521792.20000000','0.00000000','841.00010000','0.00000000','14tUTyZ3G8gqSPwvhZrHsxUJnfEQpxHge5','0.00000000','0.00000000','7eb85bb7001344d3b887ebf32a5bb389'),(3,3,'0.00000000','0.00000000','0.00000000','0.00000000','185bkEMABm57MbwZLeRgQrbtjKDfn9AgUt','0.00000000','0.00000000',''),(4,4,'0.00000000','0.00000000','0.00000000','0.00000000','1N2d2abBhMnyYptYALvskKX6oEHSiEsyje','0.00000000','0.00000000',''),(5,5,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(6,6,'0.00000000','0.00000000','0.00000000','0.00000000','1Mr5soybpESzaT1D94hUz1qGCkYCZGrvU6','0.00000000','0.00000000',''),(7,7,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(8,8,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(9,9,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(10,10,'0.00000000','0.00000000','0.00000000','0.00000000','1BxAjbosy8rbpjAherftCG8HAQU6UynPJ8','0.00000000','0.00000000',''),(11,11,'0.00000000','0.00000000','0.00000000','0.00000000','175xxFKaoVwEwZvfuWvu5P3Zu8WbAoegpm','0.00000000','0.00000000',''),(12,12,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(13,13,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(14,14,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(15,15,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(16,16,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(17,17,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(18,18,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(19,19,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(20,19,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(21,20,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(22,21,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(23,22,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(24,23,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(25,24,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000',''),(26,25,'0.00000000','0.00000000','0.00000000','0.00000000','','0.00000000','0.00000000','');

/*Table structure for table `movesay_user_goods` */

DROP TABLE IF EXISTS `movesay_user_goods`;

CREATE TABLE `movesay_user_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(200) NOT NULL DEFAULT '',
  `truename` varchar(200) NOT NULL DEFAULT '',
  `idcard` varchar(200) NOT NULL DEFAULT '',
  `moble` varchar(200) NOT NULL DEFAULT '',
  `addr` varchar(200) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `movesay_user_goods` */

insert  into `movesay_user_goods`(`id`,`userid`,`name`,`truename`,`idcard`,`moble`,`addr`,`sort`,`addtime`,`endtime`,`status`) values (1,2,'123','请问','430821198802023333','13888888888','啊发而非阿瑟发全国',0,1467292285,0,1);

/*Table structure for table `movesay_user_log` */

DROP TABLE IF EXISTS `movesay_user_log`;

CREATE TABLE `movesay_user_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(200) NOT NULL DEFAULT '',
  `remark` varchar(200) NOT NULL DEFAULT '',
  `addip` varchar(200) NOT NULL DEFAULT '',
  `addr` varchar(200) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COMMENT='用户记录表';

/*Data for the table `movesay_user_log` */

insert  into `movesay_user_log`(`id`,`userid`,`type`,`remark`,`addip`,`addr`,`sort`,`addtime`,`endtime`,`status`) values (1,3,'登录','通过用户名登录','112.95.136.101','未分配或者内网IP',0,1467286436,0,1),(2,2,'登录','通过用户名登录','121.34.129.214','未分配或者内网IP',0,1467349383,0,1),(3,2,'登录','通过用户名登录','121.34.129.214','未分配或者内网IP',0,1467349889,0,1),(4,2,'登录','通过用户名登录','121.34.129.214','未分配或者内网IP',0,1467370264,0,1),(5,3,'登录','通过用户名登录','112.95.136.101','未分配或者内网IP',0,1467594987,0,1),(6,2,'登录','通过用户名登录','220.202.152.42','未分配或者内网IP',0,1467595193,0,1),(7,3,'登录','通过用户名登录','112.95.136.101','未分配或者内网IP',0,1467595305,0,1),(8,2,'登录','通过用户名登录','113.102.161.228','未分配或者内网IP',0,1467603419,0,1),(9,2,'登录','通过用户名登录','183.54.81.121','未分配或者内网IP',0,1467615422,0,1),(10,2,'登录','通过用户名登录','183.54.81.121','未分配或者内网IP',0,1467619884,0,1),(11,4,'登录','通过用户名登录','183.54.81.121','未分配或者内网IP',0,1467620567,0,1),(12,2,'登录','通过用户名登录','183.54.81.121','未分配或者内网IP',0,1467624426,0,1),(13,3,'登录','通过用户名登录','112.95.136.101','未分配或者内网IP',0,1467631307,0,1),(14,2,'登录','通过用户名登录','183.54.81.121','未分配或者内网IP',0,1467633504,0,1),(15,4,'登录','通过用户名登录','183.54.81.121','未分配或者内网IP',0,1467710104,0,1),(16,1,'登录','通过用户名登录','5.134.156.255','未分配或者内网IP',0,1467713064,0,1),(17,4,'登录','通过用户名登录','5.134.156.255','未分配或者内网IP',0,1467713119,0,1),(18,2,'登录','通过用户名登录','5.72.168.95','未分配或者内网IP',0,1468163538,0,1),(19,3,'登录','通过用户名登录','5.72.168.95','未分配或者内网IP',0,1468163677,0,1),(20,2,'登录','通过用户名登录','113.102.162.234','未分配或者内网IP',0,1468219577,0,1),(21,2,'登录','通过用户名登录','113.102.162.234','未分配或者内网IP',0,1468219577,0,1),(22,3,'登录','通过用户名登录','103.41.177.226','未分配或者内网IP',0,1468249205,0,1),(23,4,'登录','通过用户名登录','103.41.177.226','未分配或者内网IP',0,1468249248,0,1),(24,2,'登录','通过手机号登录','113.116.61.106','未分配或者内网IP',0,1468655330,0,1),(25,2,'登录','通过手机号登录','113.116.61.106','未分配或者内网IP',0,1468662166,0,1),(26,6,'登录','通过用户名登录','121.34.145.66','未分配或者内网IP',0,1468981974,0,1),(27,7,'登录','通过用户名登录','113.102.160.118','未分配或者内网IP',0,1469095366,0,1),(28,8,'登录','通过用户名登录','113.102.160.118','未分配或者内网IP',0,1469151538,0,1),(29,8,'登录','通过用户名登录','113.102.160.118','未分配或者内网IP',0,1469151556,0,1),(30,6,'登录','通过用户名登录','113.102.160.118','未分配或者内网IP',0,1469151896,0,1),(31,6,'登录','通过用户名登录','113.102.160.118','未分配或者内网IP',0,1469152692,0,1),(32,5,'登录','通过用户名登录','113.102.160.118','未分配或者内网IP',0,1469152722,0,1),(33,2,'登录','通过手机号登录','113.102.160.118','未分配或者内网IP',0,1469154760,0,1),(34,2,'登录','通过手机号登录','113.102.160.118','未分配或者内网IP',0,1469163029,0,1),(35,2,'登录','通过手机号登录','113.102.160.118','未分配或者内网IP',0,1469171459,0,1),(36,2,'登录','通过用户名登录','113.102.160.118','未分配或者内网IP',0,1469178074,0,1),(37,10,'登录','通过用户名登录','116.25.31.163','未分配或者内网IP',0,1469351770,0,1),(38,10,'登录','通过用户名登录','116.25.31.163','未分配或者内网IP',0,1469423326,0,1),(39,10,'登录','通过用户名登录','121.35.86.168','未分配或者内网IP',0,1469429657,0,1),(40,2,'登录','通过手机号登录','113.102.161.42','未分配或者内网IP',0,1469439835,0,1),(41,2,'登录','通过手机号登录','113.102.161.42','未分配或者内网IP',0,1469439838,0,1),(42,2,'登录','通过手机号登录','113.102.161.42','未分配或者内网IP',0,1469516318,0,1),(43,6,'登录','通过用户名登录','113.102.161.42','未分配或者内网IP',0,1469516352,0,1),(44,5,'登录','通过用户名登录','113.102.161.42','未分配或者内网IP',0,1469516369,0,1),(45,10,'登录','通过用户名登录','116.25.30.100','未分配或者内网IP',0,1469765717,0,1),(46,2,'登录','通过手机号登录','113.116.61.156','未分配或者内网IP',0,1469765743,0,1),(47,5,'登录','通过用户名登录','113.116.61.156','未分配或者内网IP',0,1469765810,0,1),(48,5,'登录','通过用户名登录','113.116.61.156','未分配或者内网IP',0,1469766410,0,1),(49,11,'登录','通过用户名登录','59.38.97.252','未分配或者内网IP',0,1469768917,0,1),(50,5,'登录','通过用户名登录','113.116.61.156','未分配或者内网IP',0,1469769352,0,1),(51,2,'登录','通过手机号登录','113.116.61.156','未分配或者内网IP',0,1469772401,0,1),(52,11,'登录','通过用户名登录','59.38.97.252','未分配或者内网IP',0,1469797892,0,1),(53,13,'登录','通过用户名登录','119.137.17.33','未分配或者内网IP',0,1470022206,0,1),(54,13,'登录','通过用户名登录','119.137.18.34','未分配或者内网IP',0,1470107661,0,1),(55,10,'登录','通过用户名登录','116.25.28.226','未分配或者内网IP',0,1470129676,0,1),(56,13,'登录','通过用户名登录','113.97.89.207','未分配或者内网IP',0,1470196390,0,1),(57,4,'登录','通过用户名登录','192.168.0.101','未分配或者内网IP',0,1470215949,0,1),(58,2,'登录','通过用户名登录','192.168.0.101','未分配或者内网IP',0,1470300511,0,1),(59,2,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1470638849,0,1),(60,23,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1470648814,0,1),(61,23,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1470654435,0,1),(62,23,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1470654668,0,1),(63,2,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1471402877,0,1),(64,2,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1471404333,0,1),(65,2,'登录','通过手机号登录','192.168.0.101','未分配或者内网IP',0,1471486885,0,1),(66,2,'登录','通过手机号登录','192.168.0.101','未分配或者内网IP',0,1471487022,0,1),(67,2,'登录','通过手机号登录','192.168.0.101','未分配或者内网IP',0,1471487100,0,1),(68,2,'登录','通过手机号登录','192.168.0.101','未分配或者内网IP',0,1471487372,0,1),(69,2,'登录','通过手机号登录','192.168.0.101','未分配或者内网IP',0,1471488455,0,1),(70,2,'登录','通过手机号登录','192.168.0.101','未分配或者内网IP',0,1471488487,0,1),(71,2,'登录','通过手机号登录','192.168.0.101','未分配或者内网IP',0,1471501112,0,1),(72,2,'登录','通过手机号登录','192.168.0.101','未分配或者内网IP',0,1471511385,0,1),(73,2,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1471576723,0,1),(74,2,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1471602761,0,1),(75,2,'登录','通过手机号登录','192.168.0.101','未分配或者内网IP',0,1471836580,0,1),(76,2,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1471848207,0,1),(77,2,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1471859763,0,1),(78,2,'登录','通过手机号登录','192.168.0.101','未分配或者内网IP',0,1471859899,0,1),(79,2,'登录','通过手机号登录','192.168.0.101','未分配或者内网IP',0,1471918869,0,1),(80,2,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1471922919,0,1),(81,2,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1471935391,0,1),(82,23,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1474374048,0,1),(83,23,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1474452212,0,1),(84,2,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1474452349,0,1),(85,24,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1474606637,0,1),(86,2,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1474616427,0,1),(87,2,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1475066214,0,1),(88,2,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1475129757,0,1),(89,2,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1475159907,0,1),(90,23,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1476099554,0,1),(91,23,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1476344676,0,1),(92,23,'登录','通过用户名登录','127.0.0.1','未分配或者内网IP',0,1476439185,0,1),(93,2,'登录','通过用户名登录','14.127.89.72','未分配或者内网IP',0,1477201602,0,1),(94,24,'登录','通过用户名登录','14.127.89.72','未分配或者内网IP',0,1477204405,0,1),(95,2,'登录','通过用户名登录','14.127.89.72','未分配或者内网IP',0,1477204556,0,1),(96,2,'登录','通过用户名登录','182.112.14.219','未分配或者内网IP',0,1477212036,0,1);

/*Table structure for table `movesay_user_qianbao` */

DROP TABLE IF EXISTS `movesay_user_qianbao`;

CREATE TABLE `movesay_user_qianbao` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `coinname` varchar(200) NOT NULL DEFAULT '',
  `name` varchar(200) NOT NULL DEFAULT '',
  `addr` varchar(200) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `userid` (`userid`),
  KEY `coinname` (`coinname`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户钱包表';

/*Data for the table `movesay_user_qianbao` */

insert  into `movesay_user_qianbao`(`id`,`userid`,`coinname`,`name`,`addr`,`sort`,`addtime`,`endtime`,`status`) values (1,2,'btc','比特1','7fc388730328525271a39bae0becd54f75bc0d5f ',0,1467292195,0,1),(2,2,'ltc','莱特1','7fc388730328525271a39bae0becd54f75bc0d5f ',0,1467292222,0,1),(3,2,'btc','币看','1D4ERnTbiEfAzkzczt7B2ANjbztTGo1fVy',0,1467633752,0,1),(4,4,'btc','1GWACeZJNGAH6B5iK4hkqwpgah8DhMXVSu','1GWACeZJNGAH6B5iK4hkqwpgah8DhMXVSu',0,1467713274,0,1);

/*Table structure for table `movesay_user_shopaddr` */

DROP TABLE IF EXISTS `movesay_user_shopaddr`;

CREATE TABLE `movesay_user_shopaddr` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `truename` varchar(200) NOT NULL DEFAULT '0',
  `moble` varchar(500) NOT NULL DEFAULT '',
  `name` varchar(500) NOT NULL DEFAULT '',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `movesay_user_shopaddr` */

/*Table structure for table `movesay_version` */

DROP TABLE IF EXISTS `movesay_version`;

CREATE TABLE `movesay_version` (
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '版本号',
  `number` int(11) NOT NULL DEFAULT '0' COMMENT '序列号，一般用日期数字标示',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '版本名',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '发布时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新的时间',
  `log` text COMMENT '更新日志',
  `url` varchar(150) NOT NULL DEFAULT '' COMMENT '链接到的远程文章',
  `is_current` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `id` (`number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='自动更新表';

/*Data for the table `movesay_version` */

insert  into `movesay_version`(`name`,`number`,`title`,`create_time`,`update_time`,`log`,`url`,`is_current`,`status`) values ('2.4.8',10026,'优化自动更新功能',1467361623,1467617382,'优化自动更新功能','http://101.201.199.224/Update/download/2.4.8.zip',0,0),('2.4.7',10025,'更新人民币充值功能',1467352025,1467352740,'更新人民币充值功能\r\n优化软件不能自动到账\r\n优化前台充值弹窗的状态','http://101.201.199.224/Update/download/2.4.7.zip',0,0),('2.4.6',10024,'优化财务部分',1467346688,1467350864,'优化充值提现转入转出','http://101.201.199.224/Update/download/2.4.6.zip',0,0),('2.4.9',10027,'优化后台首页',1467362093,1467617445,'优化后台首页\r\n增加扩展 -客服代码  可以更换钱袋客服代码 \r\n更新之后，需要清理缓存','http://os.movesay.com/Auth/upFile/version/2.4.9',0,0),('2.5.5',10033,'优化后台核心',1467856087,0,'优化后台核心','http://os.movesay.com/Auth/upFile/version/2.5.5',0,0),('2.5.4',10032,'优化文章时间文字',1467795268,0,'优化文章时间不能修改的问题','http://os.movesay.com/Auth/upFile/version/2.5.4',0,0),('2.5.3',10031,'更新底部和文章部分',1467785561,0,'更新底部新样式\r\n更新文章部分具体效果可以看我们的演示网站\r\n优化首页文章部分\r\n优化交易中心拉100%不能交易\r\n优化后台撤销有时候会出现失败','http://os.movesay.com/Auth/upFile/version/2.5.3',0,0),('2.5.0',10028,'优化所有后台功能',1467601458,0,'优化所有后台功能但不包括应用部分\r\n在设置里面增加了导航设置可以控制前台导航了\r\n扩展里面增加客服代码可以更新客服代码了\r\n应用管理里面支持已经购买的 应用安装和卸载了\r\n增加有新的升级所有后台页面都会提示\r\n及时更新修复漏洞能使网站更安全\r\n更新人民币充值方式需要重新配置\r\n优化大部分后台授权可能有个别没有添加授权后期完善\r\n优化整个后台样式让您看着更舒服\r\n优化认购中心需要重新安装卸载如果提示没有授权请联系我们','http://os.movesay.com/Auth/upFile/version/2.5.0',0,0),('2.4.2',10020,'优化后台用户编辑',1467185261,1467277842,'优化后台用户编辑','http://101.201.199.224/Update/download/2.4.2.zip',0,0),('2.4.1',10019,'优化扩展功能',1467119925,1467277816,'优化扩展功能','http://101.201.199.224/Update/download/2.4.1.zip',0,0),('2.4.0',10018,'更新后台用户管理部分',1467111754,1467277791,'更新后台用户管理部分','http://101.201.199.224/Update/download/2.4.0.zip',0,0),('2.3.9',10017,'更新后台内容管理',1467105573,0,'更新后台内容管理','http://101.201.199.224/Update/download/2.3.9.zip',0,0),('2.3.8',10016,'更新权限',1467096687,0,'更新权限部分（还未完善）','http://101.201.199.224/Update/download/2.3.8.zip',0,0),('2.3.7',10015,'修复更新',1466394377,0,'修复首页下拉导航条显示bug\r\n修复交易界面导航条下拉bug','http://101.201.199.224/Update/download/2.3.7.zip',0,0),('2.4.5',10023,'优化财务部分',1467270688,1467277927,'优化人民币充值 提现\r\n优化虚拟币转入 转出\r\n\r\n需要重新配置充值方式','http://101.201.199.224/Update/download/2.4.5.zip',0,0),('2.4.4',10022,'更新后台交易管理部分',1467266348,1467277897,'更新后台交易管理部分','http://101.201.199.224/Update/download/2.4.4.zip',0,0),('2.4.3',10021,'优化后台菜单部分',1467265786,1467277868,'优化后台菜单部分','http://101.201.199.224/Update/download/2.4.3.zip',0,0),('2.5.1',10029,'模板更新  更新之后在扩展里面主题设置一下 不然前台打不开不了',1467685524,0,'支持客服代码定制\r\n扩展里面增加模板切换支持定制\r\n设置其他设置里面取消模板切换\r\n优化应用管理支持新应用预定\r\n优化用户管理搜索用户名不能用\r\n优化后台提现不能导出选中\r\n优化认购详情界面换成币种图标\r\n\r\n\r\n\r\n\r\n\r\n','http://os.movesay.com/Auth/upFile/version/2.5.1',0,0),('2.5.2',10030,'优化超级管理员功能',1467714463,0,'优化只有超级管理员才能看到升级提示\r\n优化只有超级管理员才能升级系统\r\n优化只有超级管理员才能切换模板\r\n优化只有超级管理员才能切换客服代码\r\n','http://os.movesay.com/Auth/upFile/version/2.5.2',0,0),('2.5.6',10034,'升级系统文件部分过期的问题',1469073091,0,'升级系统文件部分过期的问题','http://os.movesay.com/Auth/upFile/version/2.5.6',0,0);

/*Table structure for table `movesay_version_game` */

DROP TABLE IF EXISTS `movesay_version_game`;

CREATE TABLE `movesay_version_game` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `gongsi` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `shuoming` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `class` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `number` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='应用管理表';

/*Data for the table `movesay_version_game` */

insert  into `movesay_version_game`(`id`,`name`,`title`,`gongsi`,`shuoming`,`class`,`status`) values (1,'shop','云购商城','武汉动说科技有限公司','支持虚拟币的购物商城','#F1AB0F',0),(2,'fenhong','分红中心','武汉动说科技有限公司','支持对用户进行持币比例分红','#C53CE7',0),(3,'huafei','话费充值','武汉动说科技有限公司','支持用虚拟币充值手机话费','#428bca',0),(4,'issue','认购中心','武汉动说科技有限公司','可以发行虚拟币让用户认购','#e74c3c',1),(5,'vote','新币投票','武汉动说科技有限公司','可以对要生效的新币进行投票','#1abc9c',0),(6,'money','理财中心','武汉动说科技有限公司','存币涨利息类型于存在钱到银行涨利息','#f1c40f',0),(7,'bazaar','集市交易','武汉动说科技有限公司','支持单对单交易','#3c763d',0),(8,'pool','矿机工厂','武汉动说科技有限公司','<span style=\"color: #e74c3c;\">支持预定(8折优惠)原价3000元</span>','',0),(9,'crowd','众筹中心','武汉动说科技有限公司','<span style=\"color: #e74c3c;\">支持预定(8折优惠)原价3000元</span>','',0),(10,'qiandao','签到功能','武汉动说科技有限公司','<span style=\"color: #e74c3c;\">支持预定(8折优惠)原价2000元</span>','',0),(11,'hongbao','人人红包','武汉动说科技有限公司','<span style=\"color: #e74c3c;\">支持预定(8折优惠)原价2000元</span>','',0),(12,'weike','威客任务','武汉动说科技有限公司','<span style=\"color: #e74c3c;\">支持预定(8折优惠)原价3000元</span>','',0),(13,'duihuan','币币兑换','武汉动说科技有限公司','<span style=\"color: #e74c3c;\">支持预定(8折优惠)原价2000元</span>','',0),(14,'shoujiang','幸运抽奖','武汉动说科技有限公司','<span style=\"color: #e74c3c;\">支持预定(8折优惠)原价2000元</span>','',0),(15,'duobao','一元夺宝','武汉动说科技有限公司','<span style=\"color: #e74c3c;\">支持预定(8折优惠)原价3000元</span>','',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
