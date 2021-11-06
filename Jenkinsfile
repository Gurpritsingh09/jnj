#!/usr/bin/env groovy

pipeline {
    agent { label 'testing-linux' }

	options {
      ansiColor('xterm')
    }
	
    // Environment Variables
    environment {
		AZURE_CREDENTIALS_ID = "dsp-jenkins"
    }

    // Parameters
    parameters {
		choice(choices: [
          'npd_shared', 'npd_sbx', 'npd_dev','npd_mnt', 'npd_sit'], description: 'Environment', name: 'ENVIRONMENT')
		string(name: 'ResourceId_ResourceName', defaultValue: 'ALL', description: 'refer code base & provide ResourceId.ResourceName if interested to provision a specific resource. For e.g. 1.resource-groups')
		booleanParam(name: 'include_adv_infra', defaultValue: false, description: 'Select if need to setup Advanced Infra for the chosen env- Doesnt Apply to shared')
    }

    stages {
      stage('Initialize Runtime') {
        steps {
          script{
            FAILED_STAGE=env.STAGE_NAME
          }
          withCredentials([azureServicePrincipal('dsp-jenkins')]) {
            sh('''
              sudo -E chown -R $USER ~/.azure
              sudo -E chown -R $USER .
              

              #Make sure jq is installed
              which jq || sudo apt-get install jq -y


              #Make sure we have the latest terraform
              CURRR_VER="0.13.0" 
              curl -o terraform.zip "https://releases.hashicorp.com/terraform/${CURRR_VER}/terraform_${CURRR_VER}_linux_amd64.zip"
              unzip -u terraform.zip
              sudo mv terraform /usr/local/bin/terraform
              sudo chmod +x /usr/local/bin/terraform

              #Make sure Azure CLI is installed
              which az || (sudo apt-get install azure-cli -y && sudo az extension add --name azure-cli-iot-ext)

              #Make sure kubectl is installed
              which kubectl || sudo az aks install-cli


              #Install AD module for Terraform
              sudo add-apt-repository ppa:longsleep/golang-backports
              sudo apt update
              sudo apt install golang-go -y
              go get github.com/GSLabDev/terraform-provider-ad
              mkdir -p ~/.terraform.d/plugins/
              cp ~/go/bin/terraform-provider-ad ~/.terraform.d/plugins/


            ''')
          }
        }
      }
	stage('Display Required Utilities') {
        steps{
         script{
            FAILED_STAGE=env.STAGE_NAME
          }

          withCredentials([azureServicePrincipal(
            clientIdVariable: 'ARM_CLIENT_ID',
            clientSecretVariable: 'ARM_CLIENT_SECRET', 
            credentialsId: env.AZURE_CREDENTIALS_ID, 
            subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID', 
            tenantIdVariable: 'ARM_TENANT_ID'
          )]) {
            sh('''#!/bin/bash
              chmod +x deployment/${ENVIRONMENT}.sh
              
              echo "****  Installed Binaries  ****"
              md5sum "$(which terraform)"
              md5sum "$(which az)"

              terraform version
              az --version
            ''')
          }
        }
      }
	 stage('Execute Terraform') {
        steps {
         script{
            FAILED_STAGE=env.STAGE_NAME
         }

          withCredentials([azureServicePrincipal(
            clientIdVariable: 'ARM_CLIENT_ID',
            clientSecretVariable: 'ARM_CLIENT_SECRET', 
            credentialsId: env.AZURE_CREDENTIALS_ID, 
            subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID', 
            tenantIdVariable: 'ARM_TENANT_ID'
          )]) {
            
            sh('''#!/bin/bash
              set -ex
              echo "Executing Terraform against Environment "
              echo "${ENVIRONMENT}"
              echo "${ResourceId_ResourceName}"
              echo "${include_adv_infra}"
   	      #cwd=`pwd`  
              cd deployment
              find . -name run.sh -exec chmod 755 {} \\;

	      #ls -l
              
	      ./"${ENVIRONMENT}".sh "${ResourceId_ResourceName}" "${include_adv_infra}"

            ''')            

          }
        }
      }

    }
}
