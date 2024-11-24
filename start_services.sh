#!/bin/bash

# Obtener la IP pública del servidor
HOST_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
echo "La IP pública del servidor es: $HOST_IP"

# Crear archivo .env para las variables de entorno
echo "HOST_IP=${HOST_IP}" > .env
echo "Archivo .env actualizado con HOST_IP=${HOST_IP}"

# Regenerar nginx.conf a partir de la plantilla
if [ -f "nginx.conf.template" ]; then
    envsubst '$HOST_IP' < nginx.conf.template > nginx.conf
    echo "Archivo nginx.conf generado correctamente."
else
    echo "Error: Plantilla nginx.conf.template no encontrada. Abortando."
    exit 1
fi

# Detener y limpiar los servicios existentes
echo "Deteniendo y limpiando servicios existentes..."
docker compose down --volumes
docker system prune -af
docker volume prune -f
echo "Limpieza completada."

# Iniciar servicios
echo "Iniciando servicios..."
docker compose up -d

# Verificar si los servicios están en ejecución
docker ps
echo "Verifica que los servicios estén activos accediendo a http://${HOST_IP}/"

