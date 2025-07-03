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
                    // Using bash built-ins and /dev/tcp
                    sh '''
                        exec 3<>/dev/tcp/${REDIS_HOST}/6379
                        echo -e "DEL visits\r\n" >&3
                        cat <&3
                        exec 3>&-
                        echo "Cache cleared successfully"
                    '''
                }
            }
        }
    }
}