pipeline{
    options {
        skipDefaultCheckout()
    }
    agent {
        label "mac"
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
                sh 'ruby build.rb'
                script {
                    env.BUILD_NUMBER = "${sh(returnStdout: true, script: 'ruby ./scripts/get-version.rb').trim()}"
                }
            }
        }


        stage("Development") {
            steps {
                sh 'echo $BUILD_NUMBER'
            }
        }

        stage("Preprod") {
            steps {
                sh 'echo $BUILD_NUMBER'
            }
        }
    }
}