## Bitbucket 서버 설치 스크립트 정리

 
 

``` console
  echo "export PATH=$PATH" | sudo tee -a /etc/profile 
  echo "umask 027" | sudo tee -a /etc/profile 
  source /etc/profile 
  
  
    # Set JAVA_HOME & JRE_HOME & BIN PATH
  source /etc/environment
  source /etc/profile

  echo "JAVA_HOME=/opt/java/jdk_11" | sudo tee -a /etc/environment
  echo "JRE_HOME=/opt/java/jdk_11" | sudo tee -a /etc/environment
  
  
  echo "export PATH=$PATH" | sudo tee -a /etc/profile
  
  source /etc/environment
  source /etc/profile
```
