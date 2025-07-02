pipeline {
    agent none
    
    stages {
        stage('Checkout') {
            agent any
            steps {
                git branch: 'main', 
                     url: 'https://github.com/norahalr/flask-redis-app.git'
            }
        }

        stage('Run Web App') {
            agent {
                docker {
                    image 'python:3.9-slim'
                    args '--network=host'  // No comments allowed in declarations
                }
            }
            steps {
                sh '''
                    pip install -r requirements.txt
                    python app.py &
                    sleep 5
                '''
            }
        }

        stage('Test Visits') {
            agent any
            steps {
                sh 'curl -s http://localhost:5000'
            }
        }

        stage('Clear Cache') {
            agent {
                docker {
                    image 'redis:alpine'
                    args '--network host'
                }
            }
            steps {
                sh 'redis-cli -h localhost DEL visits'
            }
        }
    }
}