from django.contrib import admin
from apps.CarritoApp.models import Factura

class FacturaAdmin(admin.ModelAdmin):
    list_display = ('numero_factura', 'nombre_cliente', 'fecha', 'total')
    search_fields = ('numero_factura', 'nombre_cliente', 'dni_cliente')
    list_filter = ('fecha', 'metodo_pago')

