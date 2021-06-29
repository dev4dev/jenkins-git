pipeline{
    options {
        skipDefaultCheckout()
    }
    agent {
        label "mac"
    }
    stages {
        stage("Checkout") {
            options {
                // if git stuck, then cancel a build
                timeout(time: 10, unit: 'MINUTES')
            }
            steps {
                // checkout scm
                checkout([
                    $class: 'GitSCM',
                    branches: scm.branches,
                    doGenerateSubmoduleConfigurations: scm.doGenerateSubmoduleConfigurations,
                    extensions: scm.extensions + [
                        // Base Clone options
                        [
                            $class: 'CloneOption',
                            depth: 10,
                            noTags: false,
                            reference: '',
                            shallow: true
                        ],
                        Git LFS
                        [
                            $class: 'GitLFSPull'
                        ],
                        // Submodules
                        [
                            $class: 'SubmoduleOption',
                            depth: 1,
                            disableSubmodules: false,
                            recursiveSubmodules: false,
                            reference: '',
                            shallow: true,
                            trackingSubmodules: false
                        ]
                    ],
                    userRemoteConfigs: scm.userRemoteConfigs
                ])

                script {
                    // overwrite BUILD_NUMBER with a custom value from our script
                    env.BUILD_NUMBER = "${sh(returnStdout: true, script: 'ruby ./scripts/get-version.rb').trim()}"
                    // mark PRs
                    env.PULL_REQUEST = env.BRANCH_NAME.startsWith('PR')
                }
            }
        }

        stage("GIT") {
            steps {
                sh 'arch -x86_64 git lfs install'
                sh 'arch -x86_64 git lfs pull'
            }
        }


        stage("Development") {
            steps {
                sh "echo $BUILD_NUMBER"
                sh "echo $env.CHANGE_ID"
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