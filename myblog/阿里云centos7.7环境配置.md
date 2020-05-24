# 阿里云centos7.7环境配置
---
  + vim设置请参照[vim教程网](https://vimjc.com/)
  
  ```
  yum update
  // 创建下载目录
  $ mkdir /download  && cd /download

  // wget
  $ yum install -y wget
  // 相关依赖
  $ yum -y install gcc gcc-c++ openssl openssl-devel pcre pcre-devel zlib zlib-devel
  // git
  $ yum -y install git
  $ git version
  ```
  
   ```
  // nginx
  // 默认安装位置/etc/nginx
  $ yum install nginx
  $ nginx -v
   ```
   
    ```
  // fuck
  $ pip install --upgrade pip
  $ pip install  thefuck
  // tldr
  $ pip install tldr
  // tmux
  $ yum -y install tmux
  // tab补全路径且大小写不敏感(重启终端)
  $ vi /etc/inputrc
  set completion-ignore-case on
   ```
   
    ```
  // docker、管理界面
  $ yum install docker
  $ service docker start
  $ docker volume create portainer_data
  $ docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
   ```
  
   ```
  // golang
  $ yum install golang
  go version
  // go代理，1.13+
  $ go env -w GO111MODULE=on
  // 七牛云代理
  $ go env -w GOPROXY=https://goproxy.cn,direct
  // 阿里云代理（阿里服务器，选了阿里云）
  $ go env -w GOPROXY=https://mirrors.aliyun.com/goproxy/,direct
   ```
   
   ```
  // nodejs
  $ yum install nodejs
  $ node -v
  $ npm -v
  $ npm install -g n
  $ n stable
  ```
  
  ```
  // java
  $ yum install java
  $ java -version
  
  <!--jdk路径-->
  $ which java
  $ ls -lrt 结果
  $ ls -lrt 结果 
  ```
  
   
*    docker
    *    zookeeper
    
        ```bash
 $ docker run -d -p 2181:2181 -p 2888:2888 -p 2222:22 -p 3888:3888 --name zk zookeeper
   ```
    * jenkins
    
        ```bash
  $ docker run -d --restart=always --name jenkins -p 9001:8080 -v /usr/bin/git:/usr/bin/git -v /data/services/jenkins/sources:/data/services/jenkins/sources -v /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.el7_8.x86_64/jre/bin/java:/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.el7_8.x86_64/jre/bin/java jenkins:2.60.3-alpine
   ```