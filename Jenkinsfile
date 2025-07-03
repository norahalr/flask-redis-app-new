pipeline {
    agent any
    
    environment {
        // Use the full compose-prefixed names
        REDIS_HOST = 'flask-redis-app-new-redis-1'
        WEB_URL = 'http://flask-redis-app-new-web-1:5000'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                     url: 'https://github.com/norahalr/flask-redis-app-new.git'
            }
        }

        stage('Test Visits') {
            steps {
                sh "curl -s ${WEB_URL}"
            }
        }

        stage('Clear Cache') {
            steps {
                script {
                    def result = sh(script: 'nc -zv flask-redis-app-new-redis-1 6379', returnStatus: true)
                    if (result == 0) {
                        sh '''
                            printf "DEL visits\n" | nc flask-redis-app-new-redis-1 6379
                            echo "Cache cleared via direct Redis connection"
                        '''
                    } else {
                        error "Cannot connect to Redis"
                    }
                }
            }
        }
    }
}