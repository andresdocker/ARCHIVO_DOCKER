#!/bin/bash

CONFIG_FILE="/var/www/html/config/config.php"

# Agrega el dominio confiable automáticamente
if [ -f "$CONFIG_FILE" ]; then
    echo "Agregando dominio confiable automáticamente..."
    sed -i "/'trusted_domains' => array (/a\\
        1 => '$(hostname -I | awk '{print $1})'," $CONFIG_FILE
else
    echo "Archivo config.php no encontrado. Verifica la instalación de OwnCloud."
fi

# Inicia el servidor Apache
exec apache2-foreground

