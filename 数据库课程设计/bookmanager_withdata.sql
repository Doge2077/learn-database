/*
 Navicat Premium Data Transfer

 Source Server         : MySql
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : bookmanager

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 13/06/2023 02:09:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `bid` int NOT NULL COMMENT '书籍编号',
  `bname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书籍名称',
  `bprice` double NOT NULL COMMENT '书籍价格',
  PRIMARY KEY (`bid`) USING BTREE,
  UNIQUE INDEX `i_bid`(`bid` ASC) USING BTREE,
  INDEX `i_bname`(`bname` ASC) USING BTREE,
  CONSTRAINT `c_bprice` CHECK (`bprice` > 0)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '护身符', 29.9);
INSERT INTO `book` VALUES (2, '帝国游戏', 25.8);
INSERT INTO `book` VALUES (3, '智利之夜', 21.2);
INSERT INTO `book` VALUES (4, '佩恩先生', 33.7);
INSERT INTO `book` VALUES (5, '地球上最后的夜晚', 29.3);
INSERT INTO `book` VALUES (6, '未知大学', 89.5);
INSERT INTO `book` VALUES (7, '荒野侦探', 49.8);
INSERT INTO `book` VALUES (8, '2666', 138.6);
INSERT INTO `book` VALUES (9, '遥远的星辰', 21.6);
INSERT INTO `book` VALUES (10, '重返暗夜', 34.9);
INSERT INTO `book` VALUES (11, '美洲纳粹文学', 41.2);
INSERT INTO `book` VALUES (13, '卡夫卡小说全集', 53.6);

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `sid` int NOT NULL,
  `bid` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `i_sid_bid`(`sid` ASC, `bid` ASC) USING BTREE,
  INDEX `f_bid`(`bid` ASC) USING BTREE,
  CONSTRAINT `f_bid` FOREIGN KEY (`bid`) REFERENCES `book` (`bid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `f_sid` FOREIGN KEY (`sid`) REFERENCES `student` (`sid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrow
-- ----------------------------
INSERT INTO `borrow` VALUES (12, 1, 2);
INSERT INTO `borrow` VALUES (13, 1, 4);
INSERT INTO `borrow` VALUES (14, 1, 9);
INSERT INTO `borrow` VALUES (15, 2, 1);
INSERT INTO `borrow` VALUES (16, 2, 2);
INSERT INTO `borrow` VALUES (17, 2, 11);
INSERT INTO `borrow` VALUES (18, 3, 2);
INSERT INTO `borrow` VALUES (19, 3, 6);
INSERT INTO `borrow` VALUES (20, 3, 8);
INSERT INTO `borrow` VALUES (23, 5, 1);
INSERT INTO `borrow` VALUES (24, 5, 4);
INSERT INTO `borrow` VALUES (25, 5, 10);
INSERT INTO `borrow` VALUES (26, 5, 11);
INSERT INTO `borrow` VALUES (27, 6, 6);
INSERT INTO `borrow` VALUES (28, 6, 7);
INSERT INTO `borrow` VALUES (29, 6, 9);
INSERT INTO `borrow` VALUES (30, 7, 1);
INSERT INTO `borrow` VALUES (31, 7, 3);
INSERT INTO `borrow` VALUES (32, 7, 5);
INSERT INTO `borrow` VALUES (34, 8, 2);
INSERT INTO `borrow` VALUES (35, 8, 3);
INSERT INTO `borrow` VALUES (33, 8, 7);
INSERT INTO `borrow` VALUES (36, 10, 2);
INSERT INTO `borrow` VALUES (37, 10, 7);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `sid` int NOT NULL COMMENT '学号',
  `sname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名',
  `ssex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '性别',
  PRIMARY KEY (`sid`) USING BTREE,
  UNIQUE INDEX `i_sid`(`sid` ASC) USING BTREE,
  INDEX `i_sname`(`sname` ASC) USING BTREE,
  CONSTRAINT `c_sex` CHECK ((`ssex` = _utf8mb4'男') or (`ssex` = _utf8mb4'女'))
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, '李明', '男');
INSERT INTO `student` VALUES (2, '周雯', '女');
INSERT INTO `student` VALUES (3, '陈芳菲', '女');
INSERT INTO `student` VALUES (4, '张晓燕', '女');
INSERT INTO `student` VALUES (5, '王鹏', '男');
INSERT INTO `student` VALUES (6, '刘佳', '女');
INSERT INTO `student` VALUES (7, '李文浩', '男');
INSERT INTO `student` VALUES (8, '胡小果', '女');
INSERT INTO `student` VALUES (9, '赵彤彤', '女');
INSERT INTO `student` VALUES (10, '冯智涵', '男');

-- ----------------------------
-- View structure for borrow_view
-- ----------------------------
DROP VIEW IF EXISTS `borrow_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `borrow_view` AS select `s`.`sid` AS `sid`,`s`.`sname` AS `sname`,`s`.`ssex` AS `ssex`,`b`.`bid` AS `bid`,`b`.`bname` AS `bname`,`b`.`bprice` AS `bprice` from ((`borrow` `bor` join `student` `s` on((`bor`.`sid` = `s`.`sid`))) join `book` `b` on((`bor`.`bid` = `b`.`bid`)));

-- ----------------------------
-- Triggers structure for table book
-- ----------------------------
DROP TRIGGER IF EXISTS `t_d_bid`;
delimiter ;;
CREATE TRIGGER `t_d_bid` BEFORE DELETE ON `book` FOR EACH ROW DELETE FROM borrow WHERE bid = old.bid
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table student
-- ----------------------------
DROP TRIGGER IF EXISTS `t_d_sid`;
delimiter ;;
CREATE TRIGGER `t_d_sid` BEFORE DELETE ON `student` FOR EACH ROW DELETE FROM borrow WHERE sid = old.sid
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
