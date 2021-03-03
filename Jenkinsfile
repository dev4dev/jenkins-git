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
                    $class: scm.branches, 
                    branches: [
                        [
                            name: '**'
                        ]
                    ],
                    doGenerateSubmoduleConfigurations: scm.doGenerateSubmoduleConfigurations,
                    extensions: [
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