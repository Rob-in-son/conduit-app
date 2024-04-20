def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]
pipeline{
    agent any 

    stages{
        stage("Clone repo"){
            steps{
                checkout scm
            }
        }

        stage('Sonar Analysis'){
            steps{
               withSonarQubeEnv('Sonarqube') {
                    sh """
                    sonar-scanner \
                    -Dsonar.projectKey=conduit-app \
                    -Dsonar.projectName=conduit-app \
                    -Dsonar.projectVersion=1.0 \
                    -Dsonar.sources=frontend/**/*.{js,jsx,ts,tsx},backend/**/*.{js,jsx,ts,tsx} \
                    -Dsonar.languages=js,ts \
                    -Dsonar.host.url=http://localhost:9000 \
                    -Dsonar.login=${SONAR_USER_TOKEN}
                    """
                }
            }
        }

        stage("Quality Gate"){
            steps{
                timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
        }

        stage("Build frontend image"){
            steps{
                app = docker.build('robinson202/conduit-frontend:v1')
            }
        }

        stage("Build backend image"){
           steps{
                app = docker.build('robinson202/conduit-backend:v1')
            } 
        }

        stagge("Push images to docker registry"){
            steps{

            }
        }
    }

    post {
        always {
            echo 'Slack Notifications.'
            slackSend channel: '#jenkinscicd',
                color: COLOR_MAP[currentBuild.currentResult],
                message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
    }
}