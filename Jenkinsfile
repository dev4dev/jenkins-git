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
                    branches: [[name: '**']],
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
                    userRemoteConfigs: [[]]]
                )
                sh 'ruby build.rb'
            }
        }
    }
}