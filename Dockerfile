# Utiliser l'image officielle de Tomcat 9 comme image de base
FROM tomcat:9.0

# Renommer le répertoire webapps par défaut en webappsSS

RUN mv webapps webappsSS
RUN mv webapps.dist webapps

# Renommer webapps.dist en webapps pour restaurer le répertoire webapps par défaut de Tomcat
RUN mv /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps

# Copier le fichier WAR du répertoire du projet vers le répertoire webapps de Tomcat
COPY ./javulna-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/

# Exposer le port par défaut de Tomcat (8080)
EXPOSE 8080

# Démarrer Tomcat lorsque le conteneur démarre
CMD ["catalina.sh", "run"]
