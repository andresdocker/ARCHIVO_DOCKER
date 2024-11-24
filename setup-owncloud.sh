#!/bin/bash

# Archivo de configuración de OwnCloud
CONFIG_FILE="/var/www/html/config/config.php"

# Verifica si el archivo existe antes de modificarlo
if [ -f "$CONFIG_FILE" ]; then
    # Agrega el dominio confiable automáticamente
    echo "Modificando trusted_domains en $CONFIG_FILE..."
    sed -i "/'trusted_domains' => array (/a\\
        1 => '$(hostname -I | awk '{print $1})'," $CONFIG_FILE
else
    echo "Archivo de configuración no encontrado. Verifica la instalación de OwnCloud."
fi

# Continúa con el inicio normal del contenedor
exec apache2-foreground

