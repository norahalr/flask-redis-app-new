pipeline {
    agent {
        docker {
            image 'alpine:latest'  // Small (~5MB) and has netcat
            args '--network host'  // Ensures network access to other containers
        }
    }
    
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