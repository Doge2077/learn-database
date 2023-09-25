# 简介

****

[Neo4j](https://neo4j.com/) 是用 `Java` 实现的开源 `NoSQL` 图数据库。从2003年开始开发，2007年正式发布第一版，其源码托管于 [GitHub](https://github.com/neo4j/neo4j)。

与常见的关系型数据库不同，`Neo4j` 基于图图结构来表示和存储数据，并提供了申明式的查询语言 `Cypher` 来处理图数据。`Neo4j` 实现了专业数据库级别的图数据模型的存储，提供了完整的数据库特性，包括 `ACID` 事务的支持、集群的支持、备份和故障转移等。

`Neo4j` 作为图数据库中的代表产品，已经在众多的行业项目中进行了应用，如：网络管理、软件分析、组织和项目管理、社交项目等方面。

****

# 安装

****

## Docker 部署

****

这里为了便于练习，我将其使用 `Docker` 部署到了我滴云服务器上，参考 [Docker部署](https://neo4j.com/docs/operations-manual/4.4/docker/)，其他部署方式[参考](https://neo4j.com/docs/operations-manual/4.4/)。

首先拉取镜像（可以指定版本）：

```shell
docker pull neo4j:4.4.5
```

然后编写一个简单的运行脚本 `run.sh`：

```shell
#!/bin/bash

docker run \
        -d \
        --restart=always \
        --name neo4j \
        -p 7474:7474 \
        -p 7687:7687 \
        -v $HOME/docker/neo4j/data:/data \
        neo4j:4.4.5
```

然后运行脚本部署即可，`browser` 管理端口为 `7474`。

****

## Browser

****

`Browser` 端是 `Neo4j` 提供的一个图形用户界面（GUI）工具，用于管理和操作 `Neo4j` 图数据库。

浏览器打开：`http://服务器地址:7474` 即可访问。

如果没有在启动容器时指定密码，登录的默认密码为 `neo4j`，**首次登录后需要重设密码**。

不出意外的，便能看到如下界面，建议想要快速入门的话直接跟着官方教程走一遍：

![image-20230924162531006](https://image.itbaima.net/images/40/image-2023092416710991.png)

`Browser` 端支持：

- `Cypher` 语言支持：允许用户编写和执行 `Cypher` 语句，支持对数据库中的节点和关系进行查询或编辑操作。
- 图形可视化：支持节点和关系的可视化布局，能够更直观地体现和反映图数据库中的数据模型和关系。
- 图形分析：提供了一些图形分析功能，如路径查找、社区检测和聚类分析等。
- 用户管理：管理 `Neo4j` 数据库的用户和权限，创建和管理用户账号，分配不同的角色和权限，以控制对数据库的访问和操作。

****

## Cypher-shell

****

`Cypher-shell` 是 `Neo4j` 提供的官方命令行工具，用于执行 `Cypher` 语言。

使用如下命令进行连接：

```shell
cypher-shell -u <用户名> -p <密码> -a <数据库地址>
```

如果是 `Docker` 部署，进入容器操作即可：

```shell
docker exec -it <容器名> cypher-shell -u <用户名> -p <密码>
```

退出 `Cypher-shell` ：

```shell
:exit
```

****

# Cypher 基础语法

****

`Cypher` 是用于图形数据库 `Neo4j` 的查询语言，它用于在图形数据库中进行数据检索和操作。`Cypher` 的语法简洁而直观，旨在提供一种易于理解和使用的方式来查询和操作图形数据。

**注意**：

- `CQL` 与关系型数据库中的 `SQL`，一些关键词来源于 `SQL`，比如：`CREATE`、`WHERE`、`RETURN` 等。
- `CQL` 关键字大小写不敏感，也使用 `;` 分割多条查询语句。

****

## 数据结构

****

在学习 `Cypher` 语法前，首先需要了解 `Neo4j` 数据库的数据结构。

如果你在 `Browser` 端尝试运行了 `Try Neo4j with live data` 教程中的第一段代码，你会看到如下界面：

![image-20230924163019460](https://image.itbaima.net/images/40/image-20230924163742275.png)

如图所示，`Neo4j` 中采用节点、属性、关系、标签来存储数据，即右半部分出现的图谱。

- 节点： 
  - 节点是图数据模型的基本单元，用于存储实体数据。
  - 例如，在上图中，演员、电影都是节点，其中每个节点都有对应的属性。
  - 可以将一个节点理解为关系型数据库表中的一条数据，其字段对应节点的属性。
- 关系： 
  - 关系用于表示节点之间的连接或关联，具有一个类型（Type），用于描述节点之间的关系。
  - 关系有且只有一个类型，且必须声明其开始节点和结束节点以及指向。
  - 关系可以自我循环引用，但是两头永远不能为空。
- 属性：
  - 节点和关系都可以有属性，它是由键值对组成的。
  - 属性可以是基本数据类型（例如字符串、整数、浮点数等）或复杂数据类型（例如数组、日期等）。
  - 节点的属性可以理解为关系型数据库中的字段。关系中的属性进一步的明确了关系。
- 标签：
  - 标签是对节点的分类，这样使得构建 `Neo4j` 数据模型更加简单。
  - 在上面的电影案例中，`Movie`、`Person` 就是标签。

****

## 数据库操作

****

创建数据库：

```cypher
CREATE DATABASE name;
```

删除数据库：

```cypher
DROP DATABASE name;
```

修改数据库：

```cypher
ALTER DATABASE name;
```

`Neo4j` 社区版不支持创建、删除和修改数据库，即上面的三个命令社区版用不鸟🤡，只能使用默认的 `neo4j` 和 `system` 数据库。

查看所有数据库：

```cypher
SHOW DATABASES;
```

打开数据库：

```cypher
START DATABASE name;
```

关闭数据库：

```cypher
STOP DATABASE name;
```

社区版只能同时运行一个数据库实例，如果存在正在运行的实例则启动失败🤡，想同时管理多个还是用企业版吧（

****

## CREATE

****

### 创建节点

****

使用 `CREATE` 命令来创建节点：

```cypher
CREATE (n); // 创建一个节点，没有任何标签和属性
```

创建一个标签为 `DOG` 的节点：

```cypher
CREATE (n:DOG);
```

支持存在多个标签：

```cypher
CREATE (n:ANIMAL:DOG);
```

添加属性：

```cypher
CREATE (n:DOG {name: "LYS", age: "14"});
```

创建多个节点：

```cypher
CREATE (n:DOG {name: "LYS", age: "14"}), (m:CAT {name: "Hiiro", age: "17"});
```

`n` 和 `m` 只是节点的变量名，在同一条创建语句中节点的变量名不能相同，节点的变量名不会影响后续的查询。

当然也可以不加变量名：

```cypher
CREATE (:DOG {name: "LYS", age: "14"}), (:CAT {name: "Hiiro", age: "17"});
```

****

### 创建关系

****

创建两个节点的同时创建关系：

```cypher
CREATE (n:DOG {name: "LYS", age: "14"}) -[r:IN_FAN]-> (m:CAT {name: "Hiiro", age: "17"});
```

也可以反向创建关系：

```cypher
CREATE (n:DOG {name: "LYS", age: "14"}) <-[r:out_FAN]- (m:CAT {name: "Hiiro", age: "17"});
```

关系也可以设置属性：

```cypher
CREATE (n:DOG {name: "LYS", age: "14"}) -[r:IN_FAN {action: "watch live any time"}]-> (m:CAT {name: "Hiiro", age: "17"});
```

可以一次性直接创建一条路径：

```cypher
CREATE (n:DOG {name: "LYS"}) -[:IN_FAN] -> (i:CAT {name: "Hiiro"}) -[:WORK_FOR]-> (m:MOUSE {name: "ChenRay"});
```

****

## RETURN

****

`RETURN` 语句可以返回 `Cypher` 的执行结果。

比如，我们创建完节点后直接返回：

```cypher
CREATE (n:DOG {name: "LYS", age: "14"}) RETURN n;
```

也可以返回我们创建好的关系：

```cypher
CREATE (n:DOG {name: "LYS", age: "14"}) -[:IN_FAN]-> (m:CAT {name: "Hiiro", age: "17"}) RETURN n, m;
```

也可以给返回的结果取别名：

```cypher
CREATE (n:DOG {name: "LYS", age: "14"})
RETURN n.name AS LYS_NAME;
```

更多关于 `RETURN` 的用法将在下文陆续提到。

****

## MATCH

****

首先我们导入一些数据用于后面的示例：

```cypher
CREATE(n:DOG {name: "LYS", age: "14"}) -[:LOVER]-> (:BIRD {name: "Astesia", age: "13"}) -[:FRIEND]-> (m:CAT {name: "Hiiro", age: "17"}), (n) -[:FAN_OF]-> (m), (c:MOUSE {name: "ChenRay", age: "114"}), (c) -[:FAN_OF]-> (m), (p:PLANTFROM {name: "BILIBILI"}), (p) -[:BELONGS_to]-> (c);
CREATE(:WORKER:DOG {name: "打工人", age: "60"}) -[:WORK_FOR]-> (:BOSS:DOG {name: "老板", age: "20"});
```

****

### 条件查询

****

查询所有的节点及其关系：

```cypher
MATCH(n) 
RETURN n;
```

根据标签查询节点，例如查询所有标签包含 `DOG` 的节点：：

```cypher
MATCH(n: DOG)
RETURN n;
```

我们在上面提到过关系的创建，现在我们可以通过 `MATCH` 和 `CREATE` 查询节点并创建关系了：

```cypher
MATCH(n:CAT) , (m:PLANTFROM)
CREATE (n) -[:WORK_FOR]-> (m)
RETURN n, m;
```

使用上述语句创建关系时，必须**注意查询结果集的大小**，若存在多个符合条件的节点，则会对结果集中所有的节点创建对应关系。

查询所有与某节点有关系的节点：

```cypher
MATCH (n:CAT {name: "Hiiro"})--(m)
RETURN n, m;
```

根据关系查询，例如查询关系为 `WORK_FOR` 的节点：

```cypher
MATCH (n)--(WORK_FOR)
RETURN n;
```

`--` 并没有指定方向，如需指定使用 `-->` 或 `<--`：

```cypher
MATCH (n)-->(WORK_FOR)
RETURN n;
```

```cypher
MATCH (n)<--(WORK_FOR)
RETURN n;
```

查询两个节点的关系：

```cypher
MATCH(n:DOG {name:"打工人"}) -[r]-> (m:DOG {name: "老板"})
RETURN type(r);
```

****

### 关系深度查询

****







****

### 分页查询

****









****

## SET

****











****

## DELETE

****











****

## 索引

****







