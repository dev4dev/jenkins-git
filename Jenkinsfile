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
                checkout([
                    $class: 'GitSCM',
                    branches: scm.branches,
                    doGenerateSubmoduleConfigurations: scm.doGenerateSubmoduleConfigurations
                    extensions: scm.extensions + [
                        [
                            $class: 'CloneOption', 
                            depth: 1, 
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
            }
        }
    }
}