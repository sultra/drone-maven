# Drone-Maven
- 0.3.0

- 基于maven构件JAVA应用的一个drone的插件，可以发布到**Nexus**（具体看应用中的pom.xml）

- 版本： java:8-alpine； maven 3.3.9


## 使用
``` yaml
pipeline:
  maven:
    image: drone-maven
    url: "http://nexus-repository" #nexus 仓库路径
    maven_cmd: "clean package" #执行的build命令，不用包含“mvn”指令
    ismodule: true #只build组件类，不写改属性或是false表示build App
    secrets: [nexus_username, nexus_password]
  look-look: #该步骤纯粹为了测试查看构建好的文件
    image: alpine
    commands:
      - ls -a
```
### 环境变量
+ NEXUS_USERNAME nexus的账号
+ NEXUS_PASSWORD nexus的密码

### 注意点
+ 构件完成后会将在target文件夹中的“.jar”文件移动到drone工作目录层，改名为 “app.jar”


## Licens
打个招呼，随便使用