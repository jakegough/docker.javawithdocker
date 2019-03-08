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
                    def dockerRegistryImageRelease = "${dockerRegistryImage}:${timestamp}"
                        
                    helper.tagDockerImage(dockerLocalTag, dockerRegistryImageRelease)
                    helper.tagDockerImage(dockerLocalTag, dockerRegistryImage)
                    
                    helper.pushDockerImage(dockerRegistryImageRelease)
                    helper.pushDockerImage(dockerRegistryImage)                    
                    
                    helper.removeDockerImage(dockerRegistryImageRelease)
                    helper.removeDockerImage(dockerRegistryImage)                    
                } else {
                    def dockerRegistryImageBeta = "${dockerRegistryImage}:beta"
                    def dockerRegistryImagePrerelease = "${dockerRegistryImageBeta}-${timestamp}"
                    
                    helper.tagDockerImage(dockerLocalTag, dockerRegistryImagePrerelease)
                    helper.tagDockerImage(dockerLocalTag, dockerRegistryImageBeta)
                    
                    helper.pushDockerImage(dockerRegistryImagePrerelease)
                    helper.pushDockerImage(dockerRegistryImageBeta)
                    
                    helper.removeDockerImage(dockerRegistryImagePrerelease)
                    helper.removeDockerImage(dockerRegistryImageBeta)                    
                }
            }
        }
    }
    finally {
        // not wrapped in a stage because it throws off stage history when cleanup happens because of a failed stage
        helper.removeDockerImage(dockerLocalTag)
    }
})
