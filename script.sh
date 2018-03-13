#!/bin/sh
#处理环境变量获取及判空逻辑

if [ ! -n "$PLUGIN_USER" ] ;then
	echo "you have not input USER"
	exit 1
else 
	USER="$PLUGIN_USER"
fi

if [ ! -n "$PLUGIN_PASS" ] ;then
	echo "you have not input PASS"
	exit 1
else 
	PASS="$PLUGIN_PASS"
fi

if [ ! -n "$PLUGIN_URL" ] ;then
	echo "you have not input URL"
	exit 1
else 
	URL="$PLUGIN_URL"
fi

if [ ! -n "$PLUGIN_MAVEN_CMD" ] ;then
	echo "you have not input MAVEN_CMD"
	exit 1
else 
	MAVEN_CMD="$PLUGIN_MAVEN_CMD"
fi


JAR_DIR=$(pwd)/target

MAVEN_CONFIG_PATH=/opt/apache-maven/conf/settings.xml
echo "Generate files"
cat <<EOF >${MAVEN_CONFIG_PATH}
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" 
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <pluginGroups>
  </pluginGroups>
  <proxies>
  </proxies>
  <servers>
    <server>  
     <id>releases</id>  
     <username>${PLUGIN_USER}</username>  
     <password>${PASS}</password>  
    </server>  
    <server>  
     <id>snapshots</id>  
     <username>${PLUGIN_USER}</username>  
     <password>${PASS}</password>  
   </server>  
  </servers>
  <mirrors>
     <mirror>
      <id>nexus</id>
      <mirrorOf>*</mirrorOf>
      <url>${URL}</url>
     </mirror>
  </mirrors>
  <profiles>
    <profile>
      <id>nexus</id>
      <repositories>
        <repository>
          <id>central</id>
          <url>${URL}</url>
          <releases>
            <enabled>true</enabled>
          </releases>
          <snapshots>
            <enabled>true</enabled>
          </snapshots>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <id>central</id>
          <url>${URL}</url>
          <releases>
            <enabled>true</enabled>
          </releases>
          <snapshots>
            <enabled>true</enabled>
          </snapshots>
        </pluginRepository>
      </pluginRepositories>      
    </profile>
  </profiles>
  <activeProfiles>
    <activeProfile>nexus</activeProfile>
  </activeProfiles>
</settings>

EOF
echo "config file Done"

echo "do mvn ..."
# 执行maven命令
echo "do mvn ${MAVEN_CMD}"
mvn ${MAVEN_CMD}

echo "Uploading Nexus successful"
echo "get Jar file"

mv ${JAR_DIR}/*.jar app.jar
