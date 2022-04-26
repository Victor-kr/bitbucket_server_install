## Bitbucket 서버 설치 스크립트 정리

``` console
  $ ./install_java.sh 
  $ ./install_git.sh
  $ echo "umask 027" | sudo tee -a /etc/profile 
  $ echo "JAVA_HOME=/opt/java/jdk_11" | sudo tee -a /etc/environment
  $ echo "JRE_HOME=/opt/java/jdk_11" | sudo tee -a /etc/environment
  $ echo "PATH=$PATH:/opt/java/jdk_11/bin:/usr/local/git/bin" | sudo tee -a /etc/environment
  $ source /etc/environment
  $ source /etc/profile
  $ ./install_bbk.sh
```
