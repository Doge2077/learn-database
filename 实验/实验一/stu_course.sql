/*
 Navicat Premium Data Transfer

 Source Server         : MySql
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : stu_course

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 17/03/2023 22:30:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `Cno` char(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '课程号',
  `Cname` char(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '课程名',
  `Cpno` char(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '先行课',
  `Ccredit` smallint NULL DEFAULT NULL COMMENT '学分',
  PRIMARY KEY (`Cno`) USING BTREE,
  INDEX `Cpno`(`Cpno` ASC) USING BTREE,
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`Cpno`) REFERENCES `course` (`Cno`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', '数据库', '5', 4);
INSERT INTO `course` VALUES ('2', '数学', NULL, 2);
INSERT INTO `course` VALUES ('3', '信息系统', '1', 4);
INSERT INTO `course` VALUES ('4', '操作系统', '6', 3);
INSERT INTO `course` VALUES ('5', '数据结构', '7', 4);
INSERT INTO `course` VALUES ('6', '数据处理', NULL, 2);
INSERT INTO `course` VALUES ('7', 'PASCAL语言', '6', 4);
INSERT INTO `course` VALUES ('8', 'Visual_Basic', '2', 2);

-- ----------------------------
-- Table structure for sc
-- ----------------------------
DROP TABLE IF EXISTS `sc`;
CREATE TABLE `sc`  (
  `Sno` char(9) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '学号',
  `Cno` char(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '课程号',
  `Grade` smallint NULL DEFAULT NULL COMMENT '成绩',
  PRIMARY KEY (`Sno`, `Cno`) USING BTREE,
  INDEX `Cno`(`Cno` ASC) USING BTREE,
  CONSTRAINT `sc_ibfk_1` FOREIGN KEY (`Sno`) REFERENCES `student` (`Sno`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sc_ibfk_2` FOREIGN KEY (`Cno`) REFERENCES `course` (`Cno`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sc
-- ----------------------------
INSERT INTO `sc` VALUES ('200215121', '1', 92);
INSERT INTO `sc` VALUES ('200215121', '2', 85);
INSERT INTO `sc` VALUES ('200215121', '3', 88);
INSERT INTO `sc` VALUES ('200215121', '4', 62);
INSERT INTO `sc` VALUES ('200215121', '5', 77);
INSERT INTO `sc` VALUES ('200215121', '6', 66);
INSERT INTO `sc` VALUES ('200215121', '7', 98);
INSERT INTO `sc` VALUES ('200215122', '1', 88);
INSERT INTO `sc` VALUES ('200215122', '2', 90);
INSERT INTO `sc` VALUES ('200215122', '3', 80);
INSERT INTO `sc` VALUES ('200215122', '4', 99);
INSERT INTO `sc` VALUES ('200215122', '5', 87);
INSERT INTO `sc` VALUES ('200215122', '6', 66);
INSERT INTO `sc` VALUES ('200215122', '7', 88);
INSERT INTO `sc` VALUES ('200215123', '1', 88);
INSERT INTO `sc` VALUES ('200215123', '2', 55);
INSERT INTO `sc` VALUES ('200215123', '3', 79);
INSERT INTO `sc` VALUES ('200215123', '4', 88);
INSERT INTO `sc` VALUES ('200215123', '5', 62);
INSERT INTO `sc` VALUES ('200215123', '6', 52);
INSERT INTO `sc` VALUES ('200215123', '7', 59);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `Sno` char(9) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '学号',
  `Sname` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `Ssex` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '性别',
  `Sage` smallint NULL DEFAULT NULL COMMENT '年龄',
  `Sdept` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '所在系',
  PRIMARY KEY (`Sno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('200215121', '李勇', '男', 20, 'CS');
INSERT INTO `student` VALUES ('200215122', '刘晨', '女', 19, 'CS');
INSERT INTO `student` VALUES ('200215123', '王敏', '女', 18, 'MA');
INSERT INTO `student` VALUES ('200215125', '张立', '男', 19, 'IS');
INSERT INTO `student` VALUES ('200215126', '张红', '女', 19, 'CS');
INSERT INTO `student` VALUES ('200215127', '王虹星', '男', 20, 'IS');
INSERT INTO `student` VALUES ('200215128', '李红樱', '女', 18, 'MA');
INSERT INTO `student` VALUES ('200215129', '刘星', '男', 19, 'IS');

SET FOREIGN_KEY_CHECKS = 1;
