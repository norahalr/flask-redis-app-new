pipeline {
    agent none

    stages {
        // Stage 1: Checkout code
        stage('Checkout') {
            agent any
            steps {
                git branch: 'main', 
                     url: 'https://github.com/norahalr/flask-redis-app.git'
            }
        }

        // Stage 2: Run Flask app
        stage('Run Web App') {
            agent {
                docker {
                    image 'python:3.9-slim'
                    args '--network=redis-web-app_default'
                }
            }
            steps {
                sh '''
                    pip install -r requirements.txt
                    python app.py &
                    sleep 5  # Wait for app to start
                '''
            }
        }

        // Stage 3: Test visits
        stage('Test Visits') {
            agent any
            steps {
                sh 'curl -s http://web:5000'
                sh 'curl -s http://web:5000'
            }
        }

        // Stage 4: Clear Redis cache
        stage('Clear Cache') {
            agent {
                docker {
                    image 'redis:alpine'
                    args '--network=redis-web-app_default'
                }
            }
            steps {
                sh 'redis-cli DEL visits'
                sh 'echo "Visit counter reset to 0"'
            }
        }
    }
}