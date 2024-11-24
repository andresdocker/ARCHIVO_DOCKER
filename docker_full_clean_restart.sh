#!/bin/bash

echo "========== Iniciando limpieza completa de Docker =========="

# Detener y eliminar todos los servicios usando docker-compose
if [ -f docker-compose.yml ]; then
    echo "Deteniendo y eliminando servicios definidos en docker-compose.yml..."
    docker-compose down --remove-orphans
else
    echo "No se encontró docker-compose.yml en el directorio actual."
fi

# Eliminar todos los contenedores
echo "Eliminando todos los contenedores..."
docker rm -f $(docker ps -aq) 2>/dev/null || echo "No hay contenedores para eliminar."

# Eliminar todas las imágenes
echo "Eliminando todas las imágenes..."
docker rmi -f $(docker images -aq) 2>/dev/null || echo "No hay imágenes para eliminar."

# Eliminar volúmenes no utilizados
echo "Eliminando volúmenes no utilizados..."
docker volume prune -f

# Eliminar redes no utilizadas
echo "Eliminando redes no utilizadas..."
docker network prune -f

# Eliminar imágenes dangling (sin etiquetas)
echo "Eliminando imágenes dangling (sin etiquetas)..."
docker image prune -f

# Mostrar el uso actual del sistema Docker
echo "Estado del sistema Docker después de la limpieza:"
docker system df

# Reiniciar el servicio Docker
echo "Reiniciando el servicio Docker..."
systemctl restart docker

echo "========== Limpieza y reinicio completados =========="

