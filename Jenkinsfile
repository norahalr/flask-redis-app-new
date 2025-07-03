pipeline {
    agent any
    
    environment {
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
                    // Using printf for proper Redis protocol formatting
                    sh '''
                        (printf "*1\r\n\$3\r\nDEL\r\n\$6\r\nvisits\r\n"; sleep 1) | \
                        nc -w 1 ${REDIS_HOST} 6379 2>/dev/null || \
                        echo "Cache clear attempted (verify Redis connection)"
                        echo "Visit counter should be reset"
                    '''
                }
            }
        }
    }
}