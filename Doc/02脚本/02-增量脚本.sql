ALTER TABLE `movesay_config`   
  ADD COLUMN `dollar2rmb` FLOAT(10,2) DEFAULT 0  NULL  COMMENT '人民币对人民币汇率' AFTER `top_name`;
ALTER TABLE `movesay_mycz`   
  ADD COLUMN `rmb` decimal(10,2) NOT NULL DEFAULT '0'   COMMENT '实际充值人民币' AFTER `status`;
ALTER TABLE `movesay_mytx`   
  ADD COLUMN `payrmb` decimal(20,2) DEFAULT 0  NULL  COMMENT '需支付人民币' AFTER `status`;
ALTER TABLE `movesay_user`   
  ADD COLUMN `quota` decimal(10,2) DEFAULT 0  NULL  COMMENT '最大配额' AFTER `alipay`;
insert into movesay_text (`name`,`status`)VALUES('finance_buyquota','1'); 

-- ----------------------------
-- Table structure for movesay_buyquota_order
-- ----------------------------
DROP TABLE IF EXISTS `movesay_buyquota_order`;
CREATE TABLE `movesay_buyquota_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quota_type` int(11) DEFAULT NULL COMMENT '配额等级ID',
  `quota_price` decimal(10,2) DEFAULT '0.00' COMMENT '配额价格',
  `quota` int(11) DEFAULT '0' COMMENT '配额',
  `uid` int(11) DEFAULT NULL COMMENT '会员ID',
  `buy_time` int(11) DEFAULT NULL COMMENT '购买时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '1已付款 ,0未付款',
  `update_time` int(11) DEFAULT NULL COMMENT '审核时间',
  `type` varchar(50) DEFAULT NULL COMMENT '支付方式',
  `amount` decimal(10,2) DEFAULT '0.00' COMMENT '需付金额',
  `order_number` varchar(12) DEFAULT NULL COMMENT '订单号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for movesay_commision_level
-- ----------------------------
DROP TABLE IF EXISTS `movesay_commision_level`;
CREATE TABLE `movesay_commision_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` varchar(10) DEFAULT NULL COMMENT '代级',
  `scale` tinyint(4) DEFAULT '0' COMMENT '分佣比例',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of movesay_commision_level
-- ----------------------------
INSERT INTO `movesay_commision_level` VALUES ('1', 'firist', '0');
INSERT INTO `movesay_commision_level` VALUES ('2', 'third', '0');
INSERT INTO `movesay_commision_level` VALUES ('3', 'second', '0');
INSERT INTO `movesay_commision_level` VALUES ('4', 'fourth', '0');
INSERT INTO `movesay_commision_level` VALUES ('5', 'fifth', '0');
INSERT INTO `movesay_commision_level` VALUES ('6', 'sixth', '0');
INSERT INTO `movesay_commision_level` VALUES ('7', 'seventh', '0');
INSERT INTO `movesay_commision_level` VALUES ('8', 'eighth', '0');
INSERT INTO `movesay_commision_level` VALUES ('9', 'ninth', '0');
INSERT INTO `movesay_commision_level` VALUES ('10', 'tenth', '0');

-- ----------------------------
-- Table structure for movesay_commision_log
-- ----------------------------
DROP TABLE IF EXISTS `movesay_commision_log`;
CREATE TABLE `movesay_commision_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '会员ID',
  `task_id` int(11) DEFAULT NULL COMMENT '任务ID',
  `message` varchar(100) DEFAULT NULL COMMENT '日志',
  `creattime` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for movesay_commision_task
-- ----------------------------
DROP TABLE IF EXISTS `movesay_commision_task`;
CREATE TABLE `movesay_commision_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '会员ID',
  `commision` decimal(10,2) DEFAULT '0.00' COMMENT '直推佣金',
  `starttime` int(11) DEFAULT NULL COMMENT '开始时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态 1未发放，2已发放',
  `level_id` tinyint(4) DEFAULT NULL COMMENT '等级id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of movesay_commision_task
-- ----------------------------
INSERT INTO `movesay_commision_task` VALUES ('1', '2', '300.00', null, '1', '2');

-- ----------------------------
-- Table structure for movesay_level_config
-- ----------------------------
DROP TABLE IF EXISTS `movesay_level_config`;
CREATE TABLE `movesay_level_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level_name` varchar(20) DEFAULT NULL COMMENT '等级名',
  `people_num` int(11) DEFAULT '0' COMMENT '人数',
  `c_money` decimal(10,2) DEFAULT '0.00' COMMENT '直推佣金',
  `quota` int(11) DEFAULT '0' COMMENT '等级对应配额',
  `quota_price` decimal(10,2) DEFAULT '0.00' COMMENT '购买配额价格',
  `scale` decimal(10,2) DEFAULT '0.00' COMMENT '手续费比例',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of movesay_level_config
-- ----------------------------
INSERT INTO `movesay_level_config` VALUES ('1', '会员', '0', '0.00', '100', '0.00', '3.00');
INSERT INTO `movesay_level_config` VALUES ('2', '金级', '4', '300.00', '1000', '0.00', '3.00');
INSERT INTO `movesay_level_config` VALUES ('3', 'V1', '6', '400.00', '3000', '100.00', '1.50');
INSERT INTO `movesay_level_config` VALUES ('4', 'V2', '8', '500.00', '5000', '280.00', '1.00');
INSERT INTO `movesay_level_config` VALUES ('5', 'V3', '10', '500.00', '8000', '380.00', '0.50');
INSERT INTO `movesay_level_config` VALUES ('6', 'V4', '12', '500.00', '15000', '580.00', '0.30');
INSERT INTO `movesay_level_config` VALUES ('7', 'V5', '14', '500.00', '30000', '680.00', '0.30');
INSERT INTO `movesay_level_config` VALUES ('8', 'V6', '16', '500.00', '999999999', '0.00', '0.10');

/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : move

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2016-10-28 18:42:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for movesay_bonuses_task
-- ----------------------------
DROP TABLE IF EXISTS `movesay_bonuses_task`;
CREATE TABLE `movesay_bonuses_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bonuses` decimal(10,2) DEFAULT '0.00',
  `add_time` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1' COMMENT '1：未到账.2已到账',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of movesay_bonuses_task
-- ----------------------------
INSERT INTO `movesay_bonuses_task` VALUES ('1', '50.00', '1477651246', '65', '1');


/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : move

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2016-10-28 18:42:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for movesay_distribution_task
-- ----------------------------
DROP TABLE IF EXISTS `movesay_distribution_task`;
CREATE TABLE `movesay_distribution_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL COMMENT '来源订单ID（充值订单）',
  `order_uid` int(11) DEFAULT NULL COMMENT '来源订单会员ID',
  `order_level` int(11) DEFAULT NULL COMMENT '关系级别',
  `userid` int(11) DEFAULT NULL COMMENT '收款会员',
  `money` decimal(10,8) DEFAULT '0.00000000' COMMENT '收益金额',
  `add_time` int(11) DEFAULT NULL COMMENT '产生时间',
  `update_time` int(11) DEFAULT NULL COMMENT '操作时间',
  `msg` varchar(50) DEFAULT NULL COMMENT '记录',
  `status` tinyint(4) DEFAULT '1' COMMENT '1:未到账 2：已到账',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of movesay_distribution_task
-- ----------------------------
INSERT INTO `movesay_distribution_task` VALUES ('15', '72', '2', '1', '62', '0.65000000', '1477646214', null, '您的1级会员充值13产生0.65佣金', '1');
INSERT INTO `movesay_distribution_task` VALUES ('16', '72', '2', '3', '2', '0.39000000', '1477646214', null, '您的3级会员充值13产生0.39佣金', '1');


alter table movesay_commision_task engine = InnoDB;
alter table movesay_bonuses_task engine = InnoDB;
UPDATE `movesay_menu` set hide=1 where id=145;
insert into `movesay_menu` (`title`,`pid`,`sort`,`url`,`hide`,`group`,`ico_name`)VALUES('会员等级配置','7','10','Member/index','0','设置','cog');
  ALTER TABLE `movesay_mytx`   
MODIFY  `payrmb` decimal(20,2) DEFAULT 0  NULL COMMENT '需支付人民币';