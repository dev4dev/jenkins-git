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
                script {
                    env.BUILD_NUMBER = "${sh(returnStdout: true, script: 'ruby ./scripts/get-version.rb').trim()}"
                    env.PULL_REQUEST = env.CHANGE_ID != ""
                }
            }
        }


        stage("Development") {
            steps {
                sh "echo $BUILD_NUMBER"
                sh "$env.CHANGE_ID"
                sh 'git tag'
                sh "$PULL_REQUEST"
            }
        }

        stage("Preprod") {
            steps {
                sh "echo $BUILD_NUMBER"
            }
        }
    }
}