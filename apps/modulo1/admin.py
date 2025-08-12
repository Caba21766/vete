from django.contrib import admin
from django.apps import apps  # Importamos get_model de apps

Factura = apps.get_model('CarritoApp', 'Factura')  # Obtenemos Factura sin registrarlo

# No registramos Factura aquí, solo lo usamos si es necesario

