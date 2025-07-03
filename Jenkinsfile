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
                    // Install netcat if missing (will cache the installation)
                    sh '''
                        if ! command -v nc >/dev/null 2>&1; then
                            apt-get update && apt-get install -y netcat-openbsd
                        fi
                    '''
                    
                    // Proper Redis protocol command
                    sh '''
                        (printf "*2\r\n\$3\r\nDEL\r\n\$6\r\nvisits\r\n"; sleep 1) | \
                        nc -w 2 ${REDIS_HOST} 6379 && \
                        echo "Cache cleared successfully" || \
                        echo "Cache clear failed - check Redis connection"
                    '''
                }
            }
        }
    }
}