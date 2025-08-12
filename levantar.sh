#!/bin/bash

# Activar entorno virtual
source /root/Vete/env/bin/activate

# Reiniciar Gunicorn y Nginx
sudo systemctl restart gunicorn
sudo systemctl restart nginx

echo "✅ Proyecto reiniciado correctamente."

