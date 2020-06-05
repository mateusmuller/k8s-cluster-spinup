pipeline {
    agent any
    stages {
      stage ('Cloning Git') {
          steps {
              git ( url:    'https://github.com/mateusmuller/k8s-cluster-spinup'
              ,     branch: 'master' )
          }
      }
    }
}