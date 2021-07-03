#!/bin/bash
# 
# Create Jenkins job
# 
cat <<EOF | java -jar /opt/jenkins-cli.jar -s http://localhost:8080/ -http -auth ddelsizov:secretpassword create-job dob-2021-04-exam
<?xml version='1.1' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <com.coravy.hudson.plugins.github.GithubProjectProperty plugin="github">
      <projectUrl>https://github.com/shekeriev/dob-2021-04-exam.git</projectUrl>
      <displayName>dob-2021-04-exam</displayName>
    </com.coravy.hudson.plugins.github.GithubProjectProperty>
  </properties>
  <scm class="hudson.plugins.git.GitSCM" plugin="git">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <url>https://github.com/shekeriev/dob-2021-04-exam.git</url>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>*/main</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
    <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
    <submoduleCfg class="list"/>
    <extensions/>
  </scm>
  <assignedNode>slavehost</assignedNode>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <hudson.triggers.SCMTrigger>
      <spec>H/2 * * * *</spec>
      <ignorePostCommitHooks>false</ignorePostCommitHooks>
    </hudson.triggers.SCMTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <customWorkspace>/opt/jenkins/projects/</customWorkspace>
  <builders>
  <hudson.tasks.Shell>
   <command>
#!/bin/bash -l 
/vagrant/cleanup.sh
   </command>
  </hudson.tasks.Shell>
    <hudson.tasks.Shell>
   <command>
 sudo rm -rf /opt/jenkins/projects/docker
 git clone https://github.com/shekeriev/dob-2021-04-exam.git /opt/jenkins/projects/docker
   </command>
  </hudson.tasks.Shell>
  <hudson.tasks.Shell>
 <command>
docker image build -t dob-consumer /opt/jenkins/projects/docker/consumer
docker image build -t dob-producer /opt/jenkins/projects/docker/producer
docker image build -t dob-storage /opt/jenkins/projects/docker/storage
</command>
    </hudson.tasks.Shell>
    <hudson.tasks.Shell>
      <command>docker container run -d --net dob-network -p 5000:5000 --name dob-consumer dob-consumer
               docker container run -d --net dob-network --name dob-storage --env="MARIADB_ROOT_PASSWORD=Exam-2021" --publish 3306:3306 dob-storage
			   docker container run -d --net dob-network --name dob-producer dob-producer
      </command>
    </hudson.tasks.Shell>
  </builders>
  <publishers/>
  <buildWrappers/>
</project>
EOF