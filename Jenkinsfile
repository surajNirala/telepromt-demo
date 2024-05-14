pipeline {
    agent any
    // environment {
    //     DOCKER_IMAGE = 'snirala1995/teleprompter1' // Name for your Docker image
    //     CONTAINER_NAME = 'srj1' // Name for your Docker container
    //     HOST_PORT = '8283' // Port on the host machine
    //     CONTAINER_PORT = '8181' // Port inside the Docker container
    // }
    environment {
        DOCKER_IMAGE = 'snirala1995/teleprompter' // Name for your Docker image
        CONTAINER_NAME = 'srj1' // Name for your Docker container
        HOST_PORT = '8283' // Port on the host machine
        CONTAINER_PORT = '8181' // Port inside the Docker container
        DOCKER_HUB_CREDENTIALS = credentials('5440e9a0-2f5d-4f0b-9fb8-096353218e63')
        DOCKER_IMAGE_NAME = 'snirala1995/teleprompter'
        DOCKER_IMAGE_TAG = 'latest'
        DOCKER_HUB_REPO = 'snirala1995/teleprompter'
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
                    sh "echo NEW Build the image ==== ${DOCKER_IMAGE}"
                    // sh "docker build -t ${DOCKER_IMAGE} ."
                    docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
                }
            }
        }
        stage('Push Docker Image to Docker Hub') {
            steps {
                 script {
                    // Check if the Docker image already exists on Docker Hub
                    def imageExists = docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}").exists()

                    // Push the Docker image to Docker Hub if it doesn't already exist
                    if (!imageExists) {
                        docker.withRegistry('https://index.docker.io/v1/', ${DOCKER_HUB_CREDENTIALS}) {
                            docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}").push()
                        }
                    } else {
                        echo "Docker image ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} already exists on Docker Hub"
                    }
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
    
    post {
        success {
            echo "Docker image ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER} has been successfully pushed to Docker Hub (${DOCKER_HUB_REPO})"
        }
        failure {
            echo "Failed to push Docker image ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER} to Docker Hub (${DOCKER_HUB_REPO})"
        }
    }
}
