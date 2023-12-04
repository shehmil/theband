pipeline {
  agent any
 environment {
        IMAGE_TAG = "${BUILD_NUMBER}"

 }
  stages {
    stage('checkout') {
      steps {
              git 'https://github.com/shehmil/theband.git'
      }
      }
      
      stage('build') {
      steps {
        sh 'docker build  -t shehmil/theband:${BUILD_NUMBER} .'
      }
      
    }
      
      stage('test') {
      steps {
        echo "testing completed"
      }
      }

   stage('Push Docker Image to Dockerhub'){
            steps{
                script{
         //          withCredentials([string(credentialsId: 'dockerhub_TOKEN', variable: 'DOCKERHUB_USER_PASS')]) {
         //          sh 'docker login -u shehmil -p ${DOCKERHUB_USER_PASS}'
         //           sh 'docker push shehmil/theband:${BUILD_NUMBER}'

               withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerpasswd', usernameVariable: 'dockerhubuser')]) {
            
               sh "docker login -u ${env.dockerhubuser} -p ${env.dockerpasswd}"
                 sh "docker push ${env.dockerhubuser}/theband:${BUILD_NUMBER}"
}
                   
                }
            }

  }


      //    stage('DEPLOYMENT') { 

      //   steps { 

      //       sh 'docker run -dp 5001:3000 shehmil/theband:${BUILD_NUMBER}'

      // }
      //    }


    stage('Update Deployment File') {
        environment {
            GIT_REPO_NAME = "theband"
            GIT_USER_NAME = "shehmil"
        }
        steps {

                 withCredentials([string(credentialsId: 'github', variable: 'gittoken')]) {


                sh '''
                    git config user.email "shehmiljamal@gmail.com"
                    git config user.name "shehmil"
                    sed -i "s/theband:.*/theband:replaceImageTag/g" manifest/deployment.yml
                    sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" manifest/deployment.yml
                    git add manifest/deployment.yml
                    git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                    git push https://${gittoken}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:master
                '''
            }
        }
    }
    
    stage('Cleaning up') { 

     steps { 

    //         sh 'docker rmi shehmil/theband:${BUILD_NUMBER}'

      echo "cleaning completed"

        }

     } 

}

}
