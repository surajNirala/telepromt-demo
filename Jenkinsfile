pipeline {
    agent any
    // environment {
    //     DOCKER_IMAGE = 'my-nginx-image'
    //     DOCKER_CONTAINER = 'my-nginx-container'
    //     CONTAINER_PORT = sh(script: 'echo $(( ( RANDOM % 1000 )  + 8000 ))', returnStdout: true).trim()
    //     HOST_PORT = sh(script: 'echo $(( ( RANDOM % 1000 )  + 8000 ))', returnStdout: true).trim()
    // }
    environment {
        DOCKER_IMAGE = 'snirala1995/teleprompter' // Name for your Docker image
        CONTAINER_NAME = 'srj' // Name for your Docker container
        HOST_PORT = '8282' // Port on the host machine
        CONTAINER_PORT = '8181' // Port inside the Docker container
    }
    stages {
        stage('Checkout') {
            steps {
                sh 'echo "Fetch the code from main branch in github"'
                checkout([$class: 'GitSCM',
                        branches: [[name: '*/main']], // Specify the branch to checkout
                        userRemoteConfigs: [[url: 'https://github.com/surajNirala/telepromt-demo.git']]]) // Specify your GitHub repository URL
            }
        }
        stage('Build Docker Image') {
            steps {
                // This could be any build command like Maven, Gradle, etc.
                sh 'echo "Building Docker Image!!!"'
                // Build the Docker image
                // sh 'docker build -t snirala1995/teleprompter .'
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Run Docker container
                    sh "docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
                }
            }
        }
    }
}
