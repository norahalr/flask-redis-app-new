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
                    // Using Python's built-in socket module
                    sh """
                        python -c \"
                        import socket
                        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                        s.connect(('${env.REDIS_HOST}', 6379))
                        s.sendall(b'DEL visits\\r\\n')
                        print(s.recv(1024).decode())
                        s.close()
                        \"
                    """
                }
            }
        }
    }
}