jenkins-cli.jar:
	wget localhost:8080/jnlpJars/jenkins-cli.jar

admin_password:
	docker-compose exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword > admin_password
