

#!/bin/bash
sudo yum -y update
sudo yum remove -y java
sudo yum install -y java-1.8.0-openjdk

sudo yum install -y maven 
sudo git clone https://github.com/scmgalaxy/helloworld-java-maven.git
cd helloworld-java-maven
sudo mvn clean install
