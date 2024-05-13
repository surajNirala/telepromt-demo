pipeline {
    agent any
    enviroment {
        DOCKER_IMAGE = 'snirala1995/teleprompter'
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
                sh 'docker build -t surajnirala/teleprompter .'
            }
        }
        stage('Test') {
            steps {
                // This could be any test command like running unit tests
                sh 'echo "Testing..."'
            }
        }
        stage('Deploy') {
            steps {
                // This could be any deployment command like deploying to a server
                sh 'echo "Deploying..."'
            }
        }
    }
    
    post {
        always {
            // Clean up tasks, e.g., sending notifications, archiving artifacts, etc.
            echo 'Pipeline finished'
        }
    }
}
