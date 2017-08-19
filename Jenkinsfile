pipeline {
  agent {
    label 'jenkins-slave1'
  }
  environment {
    GOOGLE_PROJECT = 'unique-caldron-775'
    GOOGLE_REGION = 'us-central1'
    TF_VAR_zone = 'us-central1-f'
    TF_VAR_prefix = 'jenkins-tf'
  }
  stages {    
    stage('Cluster Preparation') { // for display purposes
      // Get some code from a GitHub repository
      steps {
        git 'git@github.com:tigera/calico-ready-clusters.git'
        dir('openshift') {
          sh "make ansible_key"
          sh "terraform apply"
        }
      }
    }
    stage('Openshift-Ansible Execution') {
      steps {
        dir('openshift') {
          sh 'make run-openshift-ansible'
        }
      }
    }
    stage('Test') {
      steps {
        dir('openshift') {
          sh "make run-e2e"
        }
      }
    }
  }
  post {
    always {
      dir('openshift') {
        sh "terraform destroy -force"
      }
    }
  } 
}
