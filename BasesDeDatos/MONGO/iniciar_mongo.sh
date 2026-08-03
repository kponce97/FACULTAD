#!/bin/bash

CONTAINER_NAME="mongo-labs"

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sin color

case "$1" in
  start)
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
      echo -e "${YELLOW}El contenedor $CONTAINER_NAME ya está corriendo.${NC}"
    else
      echo -e "${GREEN}Iniciando contenedor $CONTAINER_NAME...${NC}"
      docker start $CONTAINER_NAME
    fi
    ;;

  stop)
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
      echo -e "${GREEN}Deteniendo contenedor $CONTAINER_NAME...${NC}"
      docker stop $CONTAINER_NAME
    else
      echo -e "${YELLOW}El contenedor $CONTAINER_NAME ya está detenido.${NC}"
    fi
    ;;

  shell)
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
      docker exec -it $CONTAINER_NAME mongosh
    else
      echo -e "${RED}El contenedor $CONTAINER_NAME no está corriendo. Inicia el contenedor primero.${NC}"
    fi
    ;;

  help|*)
    echo -e "${GREEN}Uso:${NC} $0 {start|stop|shell|help}"
    echo -e "  ${YELLOW}start${NC}  - Arranca el contenedor MongoDB"
    echo -e "  ${YELLOW}stop${NC}   - Detiene el contenedor MongoDB"
    echo -e "  ${YELLOW}shell${NC}  - Entra al mongo shell dentro del contenedor"
    echo -e "  ${YELLOW}help${NC}   - Muestra esta ayuda"
    ;;
esac
