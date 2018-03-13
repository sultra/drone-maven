# Drone-Maven
- 0.1.1

- 基于maven构件JAVA应用的一个drone的插件，可以发布到**Nexus**（具体看应用中的pom.xml）

- 版本： java:8-alpine； maven 3.3.9


## 使用
``` yaml
pipeline:
  maven:
    image: drone-maven
    user: maven #nexus 账号
    pass: 1234 #nexus 密码
    url: "http://nexus-repository" #nexus 仓库路径
    maven_cmd: "clean package" #执行的build命令，不用包含“mvn”指令
  look-look: #该步骤纯粹为了测试查看构建好的文件
    image: alpine
    commands:
      - ls -a
```
+ 构件完成后会将在target文件夹中的“.jar”文件移动到drone工作目录层，改名为 “app.jar”




## Licens

打个招呼，随便使用