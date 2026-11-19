#!/bin/bash

# Mostrar ayuda
if [ "$1" = "-help" ]; then
    echo "Uso: $0 ORIGEN DESTINO"
    echo "Ejemplo: $0 /www_dir /backup_dir"
    exit 0
fi

# Verificar cantidad de argumentos
if [ "$#" -ne 2 ]; then
    echo "Error: debes indicar origen y destino."
    exit 1
fi

ORIGEN="$1"
DESTINO="$2"
FECHA=$(date +%Y%m%d)

# Verificar que el origen exista
if [ ! -d "$ORIGEN" ]; then
    echo "Error: el directorio de origen no existe."
    exit 1
fi

# Verificar que el destino exista
if [ ! -d "$DESTINO" ]; then
    echo "Error: el directorio de destino no existe."
    exit 1
fi

# Verificar que el destino esté montado
if ! mountpoint -q "$DESTINO"; then
    echo "Error: el destino no está montado."
    exit 1
fi

# Crear backup comprimido
ARCHIVO="$DESTINO/backup_$(basename "$ORIGEN")_$FECHA.tar.gz"

tar -czf "$ARCHIVO" -C "$(dirname "$ORIGEN")" "$(basename "$ORIGEN")"

echo "Backup creado: $ARCHIVO"
