pipeline{
    options {
        skipDefaultCheckout()
    }
    agent {
        label "mac"
    }
    stages {
        stage("Build") {
            steps {
                // checkout scm
                sh 'ruby build.rb'
            }
        }
    }
}