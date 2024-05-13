pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                sh 'echo "\u001B[34mFetch the code from main branch in github\u001B[0m"'
                checkout([$class: 'GitSCM',
                        branches: [[name: '*/main']], // Specify the branch to checkout
                        userRemoteConfigs: [[url: 'https://github.com/surajNirala/telepromt-demo.git']]]) // Specify your GitHub repository URL
            }
        }
        stage('Build') {
            steps {
                // This could be any build command like Maven, Gradle, etc.
                sh 'echo "Building..."'
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
