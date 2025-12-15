pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'localhost:5000'
        APP_VERSION = "${env.BUILD_NUMBER}"
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Получение исходного кода...'
                checkout scm
            }
        }

        stage('Build Contracts') {
            steps {
                echo 'Сборка контрактов...'
                retry(3) {
                    dir('events-contract') {
                        sh 'chmod +x ./mvnw && ./mvnw clean install -DskipTests'
                    }
                }
                retry(3) {
                    dir('books-api-contract') {
                        sh 'chmod +x ./mvnw && ./mvnw clean install -DskipTests'
                    }
                }
            }
        }

        stage('Build Services') {
            parallel {
                stage('Build Demo REST') {
                    steps {
                        echo 'Сборка Demo REST...'
                        dir('demo-rest') {
                            sh 'chmod +x ./mvnw && ./mvnw clean package -DskipTests'
                        }
                    }
                }
                stage('Build Analytics Service') {
                    steps {
                        echo 'Сборка Analytics Service...'
                        dir('analytics-service') {
                            sh 'chmod +x ./mvnw && ./mvnw clean package -DskipTests'
                        }
                    }
                }
                stage('Build Audit Service') {
                    steps {
                        echo 'Сборка Audit Service...'
                        dir('audit-service') {
                            sh 'chmod +x ./mvnw && ./mvnw clean package -DskipTests'
                        }
                    }
                }
                stage('Build Notification Service') {
                    steps {
                        echo 'Сборка Notification Service (WS)...'
                        dir('ws') {
                            sh 'chmod +x ./mvnw && ./mvnw clean package -DskipTests'
                        }
                    }
                }
            }
        }

        stage('Run Tests') {
            parallel {
                stage('Test Demo REST') {
                    steps {
                        dir('demo-rest') {
                            sh 'chmod +x ./mvnw && ./mvnw test'
                        }
                    }
                }
                stage('Test Audit Service') {
                    steps {
                        dir('audit-service') {
                            sh 'chmod +x ./mvnw && ./mvnw test'
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline завершен'
            deleteDir()
        }
        success {
            echo 'Сборка успешно завершена!'
        }
        failure {
            echo 'Сборка завершилась с ошибкой!'
        }
    }
}