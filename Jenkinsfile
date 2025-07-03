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
                    // Try to use netcat if available, otherwise use redis-cli from the redis container
                    try {
                        sh '''
                            (printf "*2\r\n\$3\r\nDEL\r\n\$6\r\nvisits\r\n"; sleep 1) | \
                            nc -w 2 ${REDIS_HOST} 6379 && \
                            echo "Cache cleared successfully" || \
                            echo "Cache clear failed - check Redis connection"
                        '''
                    } catch (Exception e) {
                        echo "Netcat approach failed, trying redis-cli alternative"
                        // Execute redis-cli inside the redis container
                        sh "docker exec flask-redis-app-new-redis-1 redis-cli DEL visits"
                        echo "Cache cleared via redis-cli"
                    }
                }
            }
        }
    }
}