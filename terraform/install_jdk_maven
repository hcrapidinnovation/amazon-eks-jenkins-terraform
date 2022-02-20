

#!/bin/bash
sudo yum -y update

echo "Install Java JDK 8"
yum remove -y java
yum install -y java-1.8.0-openjdk

echo "Install Maven"
yum install -y maven 
sudo git clone https://github.com/scmgalaxy/helloworld-java-maven.git
cd helloworld-java-maven
mvn clean install
