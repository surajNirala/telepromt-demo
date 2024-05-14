pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'snirala1995/teleprompter' // Name for your Docker image
        CONTAINER_NAME = 'srj' // Name for your Docker container
        HOST_PORT = '8282' // Port on the host machine
        CONTAINER_PORT = '8181' // Port inside the Docker container
    }
    
    stages {
        stage('Check Existing Container') {
            steps {
                script {
                    // Check if the container already exists
                    def existingContainer = sh(script: "docker ps -aqf name=${CONTAINER_NAME}", returnStdout: true).trim()
                    if (existingContainer) {
                        sh "echo Remove the existing container ==== ${CONTAINER_NAME}"
                        // Stop and remove the existing container
                        sh "docker rm -f ${CONTAINER_NAME}"
                    }
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh "echo Build the image ==== ${DOCKER_IMAGE}"
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    // Run Docker container
                    sh "echo Run the Image ==== ${CONTAINER_NAME} ${DOCKER_IMAGE}"
                    sh "docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
                }
            }
        }
    }
    
    // post {
    //     always {
    //         // Clean up Docker container
    //         script {
    //             sh "docker rm -f ${CONTAINER_NAME} || true"
    //         }
    //     }
    // }
}
