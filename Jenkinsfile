library 'JenkinsBuilderLibrary'

helper.gitHubUsername = 'jakegough'
helper.gitHubRepository = 'docker.javawithdocker'
helper.gitHubTokenCredentialsId = 'github-personal-access-token-jakegough'
helper.dockerImageName = 'javawithdocker'
helper.dockerRegistry = null // null for docker hub
helper.dockerRegistryCredentialsId = 'userpass-dockerhub-jakegough'

helper.run('linux && make && docker', {
    def timestamp = helper.getTimestamp()
    def dockerLocalTag = "jenkins__${helper.dockerImageName}__${timestamp}"
    def dockerRegistryImage = helper.getDockerRegistryImageName()

    try {
        stage ('Build') {
            sh "docker build --tag $dockerLocalTag ."
        }
        if(env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'develop'){
            stage ('Publish Docker') {                        
                helper.dockerLogin()
                
                if(env.BRANCH_NAME == 'master'){
                    helper.tagDockerImage(dockerLocalTag, dockerRegistryImage)
                    helper.pushDockerImage(dockerRegistryImage)
                    helper.removeDockerImage(dockerRegistryImage)
                } else {
                    def dockerRegistryImageBeta = "${dockerRegistryImage}:beta"
                    def dockerRegistryImagePrerelease = "${dockerRegistryImageBeta}-${timestamp}"
                    
                    helper.tagDockerImage(dockerLocalTag, dockerRegistryImageBeta)
                    helper.tagDockerImage(dockerLocalTag, dockerRegistryImagePrerelease)
                    
                    helper.pushDockerImage(dockerRegistryImageBeta)
                    helper.pushDockerImage(dockerRegistryImagePrerelease)
                    
                    helper.removeDockerImage(dockerRegistryImageBeta)
                    helper.removeDockerImage(dockerRegistryImagePrerelease)
                }
            }
        }
    }
    finally {
        // not wrapped in a stage because it throws off stage history when cleanup happens because of a failed stage
        helper.removeDockerImage(dockerLocalTag)
    }
})
