/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : PostgreSQL
 Source Server Version : 90601
 Source Host           : localhost
 Source Database       : wlblog
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 90601
 File Encoding         : utf-8

 Date: 04/10/2017 17:34:29 PM
*/

-- ----------------------------
--  Sequence structure for articles_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."articles_id_seq";
CREATE SEQUENCE "public"."articles_id_seq" INCREMENT 1 START 11 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."articles_id_seq" OWNER TO "wulong";

-- ----------------------------
--  Sequence structure for catagorys_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."catagorys_id_seq";
CREATE SEQUENCE "public"."catagorys_id_seq" INCREMENT 1 START 12 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."catagorys_id_seq" OWNER TO "wulong";

-- ----------------------------
--  Sequence structure for fluent_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."fluent_id_seq";
CREATE SEQUENCE "public"."fluent_id_seq" INCREMENT 1 START 5 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."fluent_id_seq" OWNER TO "wulong";

-- ----------------------------
--  Sequence structure for users_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."users_id_seq";
CREATE SEQUENCE "public"."users_id_seq" INCREMENT 1 START 2 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."users_id_seq" OWNER TO "wulong";

-- ----------------------------
--  Table structure for fluent
-- ----------------------------
DROP TABLE IF EXISTS "public"."fluent";
CREATE TABLE "public"."fluent" (
	"id" int4 NOT NULL DEFAULT nextval('fluent_id_seq'::regclass),
	"name" varchar(255) NOT NULL COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."fluent" OWNER TO "wulong";

-- ----------------------------
--  Records of fluent
-- ----------------------------
BEGIN;
INSERT INTO "public"."fluent" VALUES ('1', 'User');
INSERT INTO "public"."fluent" VALUES ('3', 'Catagory');
INSERT INTO "public"."fluent" VALUES ('5', 'Article');
COMMIT;

-- ----------------------------
--  Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "public"."users";
CREATE TABLE "public"."users" (
	"id" int4 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
	"name" varchar(255) NOT NULL COLLATE "default",
	"password" varchar(255) NOT NULL COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."users" OWNER TO "wulong";

-- ----------------------------
--  Records of users
-- ----------------------------
BEGIN;
INSERT INTO "public"."users" VALUES ('1', 'admin', '123456');
INSERT INTO "public"."users" VALUES ('2', 'admin2', '123456');
COMMIT;

-- ----------------------------
--  Table structure for catagorys
-- ----------------------------
DROP TABLE IF EXISTS "public"."catagorys";
CREATE TABLE "public"."catagorys" (
	"id" int4 NOT NULL DEFAULT nextval('catagorys_id_seq'::regclass),
	"cate_name" varchar(255) NOT NULL COLLATE "default",
	"cate_title" varchar(255) NOT NULL COLLATE "default",
	"cate_description" varchar(255) NOT NULL COLLATE "default",
	"cate_keywords" varchar(255) NOT NULL COLLATE "default",
	"cate_view" varchar(255) NOT NULL COLLATE "default",
	"cate_order" varchar(255) NOT NULL COLLATE "default",
	"cate_pid" varchar(255) NOT NULL COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."catagorys" OWNER TO "wulong";

-- ----------------------------
--  Records of catagorys
-- ----------------------------
BEGIN;
INSERT INTO "public"."catagorys" VALUES ('1', '技术', '酷爱技术', '', '', '2', '2', '0');
INSERT INTO "public"."catagorys" VALUES ('2', '电玩', '超级电玩人', '', '', '5', '2', '0');
INSERT INTO "public"."catagorys" VALUES ('4', 'php技术', '快速开发网站', '', '', '5', '8', '1');
INSERT INTO "public"."catagorys" VALUES ('5', '读书技术', '有品位的读书', '', '', '1', '7', '1');
INSERT INTO "public"."catagorys" VALUES ('6', '生活技术', '生活中的小窍门', '', '', '1', '7', '1');
INSERT INTO "public"."catagorys" VALUES ('7', '电玩巴士', '
::TGbus.com::中国游戏第一门户_电玩巴士_电视游戏_...', '', '', '1', '7', '2');
INSERT INTO "public"."catagorys" VALUES ('8', '移动电玩城', '手机移动电玩城-百姓网', '', '', '1', '10', '2');
INSERT INTO "public"."catagorys" VALUES ('9', '99电玩', 'www.99dianwan.com # 99电玩官方网站 森林舞会 动物王国 万能鲨鱼...', '', '', '1', '7', '2');
INSERT INTO "public"."catagorys" VALUES ('10', 'vapor', 'Swift服务端框架-vapor', 'Swift服务端框架-vapor', 'Swift', '0', '11', '1');
INSERT INTO "public"."catagorys" VALUES ('11', '编程', '编程', '编程之美', '编程', '0', '2', '0');
INSERT INTO "public"."catagorys" VALUES ('12', '朋友', '朋友', '朋友', '朋友', '0', '5', '0');
COMMIT;

-- ----------------------------
--  Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS "public"."articles";
CREATE TABLE "public"."articles" (
	"id" int4 NOT NULL DEFAULT nextval('articles_id_seq'::regclass),
	"art_title" varchar(255) NOT NULL COLLATE "default",
	"art_content" text NOT NULL COLLATE "default",
	"art_description" varchar(255) NOT NULL COLLATE "default",
	"art_keywords" varchar(255) NOT NULL COLLATE "default",
	"art_tag" varchar(255) NOT NULL COLLATE "default",
	"art_thumb" varchar(255) NOT NULL COLLATE "default",
	"art_time" varchar(255) NOT NULL COLLATE "default",
	"art_editor" varchar(255) NOT NULL COLLATE "default",
	"art_view" varchar(255) NOT NULL COLLATE "default",
	"catagory_id" int4 NOT NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."articles" OWNER TO "wulong";

-- ----------------------------
--  Records of articles
-- ----------------------------
BEGIN;
INSERT INTO "public"."articles" VALUES ('5', '嘻嘻嘻', '<p style="white-space: normal; text-align: center;"><img src="/wlblog_admin_front/admin/bower_components/ueditor/php/upload/image/20170303/1488510593130415.png" title="1488510593130415.png" alt="scrawl.png"/>ios-正确的圆角</p><p style="white-space: normal;"><img src="http://img.baidu.com/hi/bobo/B_0014.gif"/></p><p style="white-space: normal;">测试</p><table><tbody><tr class="firstRow"><td width="105" valign="top" style="word-break: break-all;">测试</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td></tr><tr><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td></tr><tr><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td></tr><tr><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td></tr><tr><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td></tr><tr><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td></tr><tr><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td><td width="105" valign="top" style="word-break: break-all;">测试数据</td></tr></tbody></table><p style="white-space: normal;"><br/></p><p style="white-space: normal;"><br/></p><p><br/></p>', '嘻嘻嘻', '', '', 'upload_images/1484876769.png', '', '嘻嘻嘻', '', '11');
INSERT INTO "public"."articles" VALUES ('10', 'hello5', '<p>hello5</p>', 'hello5', '', '', '', '', 'hello5', '', '11');
INSERT INTO "public"."articles" VALUES ('11', 'hello6', '<p>hello6</p>', 'hello6', '', '', '', '', 'hello6', '', '11');
INSERT INTO "public"."articles" VALUES ('6', 'hello', '<p>hello</p><p><img src="/wlblog_admin_front/admin/bower_components/ueditor/php/upload/image/20170214/1487052471527132.png" title="1487052471527132.png" alt="mmc_lottery_frame.png" width="250" height="82" style="width: 250px; height: 82px; float: left;"/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p>nice</p>', 'hello', '', '', '', '', 'hello', '', '11');
INSERT INTO "public"."articles" VALUES ('7', 'hello2', '<p>hello2</p><p><img src="/wlblog_admin_front/admin/bower_components/ueditor/php/upload/image/20170214/1487053666191989.png" title="1487053666191989.png" alt="scrawl.png"/></p><p><br/></p>', 'hello2', '', '', '', '', 'hello2', '', '11');
INSERT INTO "public"."articles" VALUES ('8', 'hello3', '<p>hello3</p><p><img src="/wlblog_admin_front/admin/bower_components/ueditor/php/upload/image/20170214/1487053791710046.png" title="1487053791710046.png" alt="Simulator Screen Shot 2017年2月10日 下午2.44.45.png" width="307" height="507" style="width: 307px; height: 507px;"/></p>', 'hello3', '', '', '', '', 'hello3', '', '11');
INSERT INTO "public"."articles" VALUES ('9', 'hello4', '<p>hello4</p><p><img src="/wlblog_admin_front/admin/bower_components/ueditor/php/upload/image/20170303/1488523091229739.png" title="1488523091229739.png" alt="scrawl.png"/></p>', 'hello4', '', '', '', '', 'hello4', '', '11');
INSERT INTO "public"."articles" VALUES ('2', 'PSV破解来袭-hello-爱上的 按时大', '<p>PSV玩家最近总算又活跃了起来，不是什么游戏大作发售了，而是PSV这次真的破解了！</p><p style="margin-top: 20px; margin-bottom: 20px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, &#39;Helvetica Neue&#39;, Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; font-variant-ligatures: normal; orphans: 2; white-space: normal; widows: 2; background-color: rgb(255, 255, 255);">经过了漫长的破解过程，几乎沦为PS4手柄的小V从新回到了大部分玩家的视线当中，最重要的是这次的破解再也不是之前的仅仅能玩玩PSP游戏的程度，而是可以成功运行自制软件以及破解的游戏。</p><p style="margin-top: 20px; margin-bottom: 20px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, &#39;Helvetica Neue&#39;, Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; font-variant-ligatures: normal; orphans: 2; white-space: normal; widows: 2; background-color: rgb(255, 255, 255);">　　玩家只要<span style="color: rgb(255, 0, 0);">保持主机系统在3.60下就能够安装HENkaku，经用浏览器访问固定地址就能够执行破解操作</span>，这种方法类似于之前WiiU的破解方法。</p><p style="margin-top: 20px; margin-bottom: 20px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, &#39;Helvetica Neue&#39;, Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; font-variant-ligatures: normal; orphans: 2; white-space: normal; widows: 2; background-color: rgb(255, 255, 255);">而目前游戏的破解速度也算迅速，像最先出现的《东京幻想乡》、随后的《萤火虫日记》《以撒 重生》等作品都稳步破解发布，甚至更有已经可以对应汉化补丁的《胧村正》这样的重量级作品。</p><p style="margin-top: 20px; margin-bottom: 20px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, &#39;Helvetica Neue&#39;, Helvetica, Tahoma, Arial, sans-serif; font-size: 14px; font-variant-ligatures: normal; orphans: 2; white-space: normal; widows: 2; background-color: rgb(255, 255, 255);">　　而游戏的Dump方式其实也已经发布，不过<span style="color: rgb(255, 0, 0);">对于一般普通玩家来说Dump破解游戏可能会显得麻烦</span>，相信应该有不少的玩家选择等待别人发布。另外和很多主机破解一样，PSV破解后也是基本建立在主机要离线的状态下才会安全，所以<span style="color: rgb(255, 0, 0);">想要通过破解版来体验在线联机是非常危险的</span>。</p><p style="margin-top: 20px; margin-bottom: 20px; padding: 0px;">当然，除了破解游戏外，PSV高破之后更有吸引力的一点其实是各种各样的自制软件，相信不会再有人说PSV没游戏玩了，因为不玩游戏你还可以期待更多其他有趣的功能。</p><p><img src="/wlblog_admin_front/admin/bower_components/ueditor/php/upload/image/20170303/1488523170416068.png" title="1488523170416068.png" alt="scrawl.png"/></p>', 'PSV全面告破！胧村正、东京幻想乡等作品相继发布', '', '', 'https://www.codercq.com/wlblog_upload/20161228214623826.jpg', '', '巫龙', '', '8');
COMMIT;


-- ----------------------------
--  Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."articles_id_seq" RESTART 12 OWNED BY "articles"."id";
ALTER SEQUENCE "public"."catagorys_id_seq" RESTART 13 OWNED BY "catagorys"."id";
ALTER SEQUENCE "public"."fluent_id_seq" RESTART 6 OWNED BY "fluent"."id";
ALTER SEQUENCE "public"."users_id_seq" RESTART 3 OWNED BY "users"."id";
-- ----------------------------
--  Primary key structure for table fluent
-- ----------------------------
ALTER TABLE "public"."fluent" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table catagorys
-- ----------------------------
ALTER TABLE "public"."catagorys" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table articles
-- ----------------------------
ALTER TABLE "public"."articles" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

