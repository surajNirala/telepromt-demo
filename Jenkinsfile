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
        DOCKER_HUB_REPO = 'snirala1995/teleprompter'
        DOCKER_IMAGE_TAG = "${DOCKER_HUB_REPO}:${env.BUILD_NUMBER}"
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
                    // docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
                    docker.build(DOCKER_IMAGE_TAG)
                }
            }
        }
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    try {
                        // Push Docker image to Docker Hub
                        docker.withRegistry('https://registry.hub.docker.com', '5440e9a0-2f5d-4f0b-9fb8-096353218e63') {
                            docker.image(DOCKER_IMAGE_TAG).push()
                        }
                    } catch (Exception e) {
                        echo "Failed to push Docker image: ${e.message}"
                    }
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    // Run Docker container
                    sh "echo Run the Image ==== ${CONTAINER_NAME} ${DOCKER_IMAGE_TAG}"
                    sh "docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${DOCKER_IMAGE_TAG}"
                }
            }
        }
    }
    
    post {
        always {
            // Clean up Docker container
            script {
                sh "docker rm -f ${CONTAINER_NAME} || true"
            }
        }
    }
}
