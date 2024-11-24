FROM owncloud/server:latest

# Agrega el script de configuración
COPY setup-owncloud.sh /usr/local/bin/setup-owncloud.sh
RUN chmod +x /usr/local/bin/setup-owncloud.sh

# Ejecuta el script al iniciar el contenedor
ENTRYPOINT ["/usr/local/bin/setup-owncloud.sh"]
CMD ["apache2-foreground"]

