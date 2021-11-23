pipeline {

    //connect to the dockerhub enviroment by the dockerhub_id credentials
    environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub_id')
	}

    agent any
    stages {

        //first stage: cloning the project form github repo
        stage('git clone') {
            steps {
                git 'https://github.com/samahAbbas11/Kaltura_Task.git'
            }
        }

        //second stage: build an image by docker
        stage('Build image') {
            steps {

                sh 'docker build -t kaltura .'

            }
        }

        //third stage: login to dockerhub in order to push the image
        //by username and password saved in jenkins global credintials
        stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

        //last stage: Push the image to dockerhub repositorey
		stage('Push') {

			steps {
			    sh' docker tag kaltura samahabbas11/kaltura-nginx'
				sh ' docker push samahabbas11/kaltura-nginx'
			}
		}

    }

}