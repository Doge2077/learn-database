# 创建表

****

```mysql
CREATE TABLE Student (
	Sno CHAR(9) NOT NULL COMMENT '学号',
	Sname CHAR(20) NULL COMMENT '姓名',
	Ssex CHAR(2) NULL COMMENT '性别',
	Sage SMALLINT NULL COMMENT '年龄',
	Sdept CHAR(20) NULL COMMENT '所在系',
	PRIMARY KEY (Sno)
)ENGINE=INNODB DEFAULT CHARSET=utf8;
```

```mysql
CREATE TABLE Course (
	Cno CHAR(4) NOT NULL COMMENT '课程号',
	Cname CHAR(40) NULL COMMENT '课程名',
	Cpno CHAR(4) NULL COMMENT '先行课',
	Ccredit SMALLINT NULL COMMENT '学分',
	PRIMARY KEY (Cno),
	FOREIGN KEY (Cpno) REFERENCES Course(Cno)
)ENGINE=INNODB DEFAULT CHARSET=utf8;
```

```mysql
CREATE TABLE SC (
	Sno CHAR(9) NOT NULL COMMENT '学号',
	Cno CHAR(4) NOT NULL COMMENT '课程号',
	Grade SMALLINT NULL COMMENT '成绩',
	PRIMARY KEY (Sno, Cno),
	FOREIGN KEY (Sno) REFERENCES Student(Sno),
	FOREIGN KEY (Cno) REFERENCES Course(Cno)
)ENGINE=INNODB DEFAULT CHARSET=utf8;
```

****

# 修改表

****

```mysql
ALTER TABLE Course ADD Ctype CHAR(10) NULL COMMENT '课程类型';
```

```mysql
ALTER TABLE Course DROP Ctype;
```

```mysql
ALTER TABLE Course RENAME TO Coursel;
```

```mysql
DROP TABLE Coursel;
```

```mysql
INSERT INTO Course (Cno, Cname, Cpno, Ccredit)
										VALUES
										('2', '数学', NULL, 2);
INSERT INTO Course (Cno, Cname, Cpno, Ccredit)
										VALUES
										('6', '数据处理', NULL, 2);
INSERT INTO Course (Cno, Cname, Cpno, Ccredit)
										VALUES
										('7', 'PASCAL语言', '6', 4);
INSERT INTO Course (Cno, Cname, Cpno, Ccredit)
										VALUES
										('4', '操作系统', '6', 3);
INSERT INTO Course (Cno, Cname, Cpno, Ccredit)
										VALUES
										('5', '数据结构', '7', 4);
INSERT INTO Course (Cno, Cname, Cpno, Ccredit)
										VALUES
										('1', '数据库', '5', 4);
INSERT INTO Course (Cno, Cname, Cpno, Ccredit)
										VALUES
										('3', '信息系统', '1', 4);
```

```mysql
INSERT INTO SC (Sno, Cno, Grade)
										VALUES
										('200215121', '1', 92);
INSERT INTO SC (Sno, Cno, Grade)
										VALUES
										('200215121', '2', 85);
INSERT INTO SC (Sno, Cno, Grade)
										VALUES
										('200215121', '3', 88);
INSERT INTO SC (Sno, Cno, Grade)
										VALUES
										('200215122', '2', 90);
INSERT INTO SC (Sno, Cno, Grade)
										VALUES
										('200215122', '3', 80);
```

```makefile
UPDATE Course SET Ccredit=4 WHERE Cno='2'; 
```

```mysql
UPDATE SC SET Grade=Grade*0.8 WHERE Cno='2'; 
```

```mysql
DELETE FROM SC WHERE Cno=(SELECT Cno FROM Course WHERE Cname='信息系统');
```

```mysql
DELETE FROM SC;
```

```mysql
# PowerShell 
mysqldump -u root -p --default-character-set=utf8mb4 [DATABASE] --hex-blob --result-file=D:\path\name.sql
```

