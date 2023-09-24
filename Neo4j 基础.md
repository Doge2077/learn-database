# Neo4j 基础

****

## 简介

****

[Neo4j](https://neo4j.com/) 是用 `Java` 实现的开源 `NoSQL` 图数据库。从2003年开始开发，2007年正式发布第一版，其源码托管于 [GitHub](https://github.com/neo4j/neo4j)。

与常见的关系型数据库不同，`Neo4j` 基于图图结构来表示和存储数据，并提供了申明式的查询语言 `Cypher` 来处理图数据。`Neo4j` 实现了专业数据库级别的图数据模型的存储，提供了完整的数据库特性，包括 `ACID` 事务的支持、集群的支持、备份和故障转移等。

`Neo4j` 作为图数据库中的代表产品，已经在众多的行业项目中进行了应用，如：网络管理、软件分析、组织和项目管理、社交项目等方面。

****

## 安装

****

这里为了便于练习，我将其使用 `Docker` 部署到了我滴云服务器上，参考 [Docker部署](https://neo4j.com/docs/operations-manual/4.4/docker/)，其他部署方式[参考](https://neo4j.com/docs/operations-manual/4.4/)。

首先拉取镜像（可以指定版本）：

```shell
docker pull neo4j:4.4.5
```

然后编写一个简单的运行脚本 `run.sh`：

```sh
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

然后运行脚本部署即可，`web` 管理端口为 `7474`。

如果没有在启动容器时指定密码，登录的默认密码为 `neo4j`，首次登录后需要重设密码。

****

### 基础语法

****