from django.urls import path
from . import views
from .views import listar_respaldos, crear_respaldo, descargar_respaldo, eliminar_respaldo
from .views import (
    listar_respaldos, crear_respaldo,
    descargar_respaldo, eliminar_respaldo,
    exportar_provedores_excel  # 👉 Agregar esta línea
)
from .views import exportar_categorias_excel
from .views import exportar_productos_excel
from .views import exportar_compras_excel
from .views import exportar_facturas_excel
from .views import exportar_cuenta_corriente_excel 


app_name = 'backup'  # Define el namespace
urlpatterns = [
    path('', listar_respaldos, name='listar_respaldos'),  # Ruta principal de respaldos
    path('crear/', crear_respaldo, name='crear_respaldo'),
    path('descargar/<str:nombre>/', descargar_respaldo, name='descargar_respaldo'),
    path('eliminar/<str:nombre>/', eliminar_respaldo, name='eliminar_respaldo'),
    path('exportar_provedores/', exportar_provedores_excel, name='exportar_provedores'),  # 👉 
    path('exportar_categorias/', exportar_categorias_excel, name='exportar_categorias'),  # Nueva ruta
    path('exportar_productos/', exportar_productos_excel, name='exportar_productos'),
    path('exportar_compras/', exportar_compras_excel, name='exportar_compras'),
    path('exportar_facturas/', exportar_facturas_excel, name='exportar_facturas'),
    path('exportar_cuenta_corriente/', exportar_cuenta_corriente_excel, name='exportar_cuenta_corriente'),
    
]
