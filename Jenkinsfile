pipeline {
    agent any
    
    environment {
        DOCKER_HUB_REPO = 'snirala1995/teleprompter'
        DOCKER_IMAGE_TAG = "${DOCKER_HUB_REPO}:${env.BUILD_NUMBER}"
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
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
    }
    
    post {
        success {
            script {
                // Display success message
                echo "Docker image ${DOCKER_IMAGE_TAG} successfully pushed to Docker Hub."
            }
        }
    }
}
