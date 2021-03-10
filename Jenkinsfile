pipeline{
    options {
        skipDefaultCheckout()
    }
    agent {
        label "mac"
    }
    environment {
        PULL_REQUEST = $CHANGE_ID != ""
    }
    stages {
        stage("Checkout") {
            steps {
                // checkout scm
                checkout([
                    $class: 'GitSCM',
                    branches: scm.branches,
                    doGenerateSubmoduleConfigurations: scm.doGenerateSubmoduleConfigurations,
                    extensions: scm.extensions + [
                        [
                            $class: 'CloneOption', 
                            depth: 3, 
                            noTags: false, 
                            reference: '', 
                            shallow: true
                        ], 
                        [
                            $class: 'GitLFSPull'
                        ]
                    ], 
                    userRemoteConfigs: scm.userRemoteConfigs
                ])
                script {
                    env.BUILD_NUMBER = "${sh(returnStdout: true, script: 'ruby ./scripts/get-version.rb').trim()}"
                }
            }
        }


        stage("Development") {
            steps {
                sh 'echo $BUILD_NUMBER'
                sh '$CHANGE_ID'
                sh 'git tag'
            }
        }

        stage("Preprod") {
            steps {
                sh 'echo $BUILD_NUMBER'
            }
        }
    }
}