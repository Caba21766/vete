from django import views
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from . import views
from .views import buscar_mascota

from .views import (
    lista_mascotas, editar_mascota, eliminar_mascota, 
    agregar_mascota, detalle_mascota, agregar_informe, editar_informe, gestionar_informe, eliminar_informe
)

app_name = 'mascota'

urlpatterns = [
    path('', lista_mascotas, name='lista_mascotas'),
    path('agregar/', agregar_mascota, name='agregar_mascota'),
    path('editar/<int:pk>/', editar_mascota, name='editar_mascota'),
    path('eliminar/<int:pk>/', eliminar_mascota, name='eliminar_mascota'),
    path('detalle/<int:pk>/', detalle_mascota, name='detalle_mascota'),
    path('detalle/<int:pk>/informe/', agregar_informe, name='agregar_informe'),  # Ruta corregida
    path('informe/editar/<int:pk>/', editar_informe, name='editar_informe'),
    path('detalle/<int:mascota_id>/informe/', gestionar_informe, name='agregar_informe'),
    path('detalle/<int:mascota_id>/informe/<int:informe_id>/', gestionar_informe, name='editar_informe'),
    path('detalle/<int:mascota_id>/informe/eliminar/<int:informe_id>/', eliminar_informe, name='eliminar_informe'),
    path('tomar-foto/', views.tomar_foto, name='tomar_foto'),
    path('guardar-foto/', views.guardar_foto, name='guardar_foto'),
    path('guardar-foto/<int:informe_id>/', views.guardar_foto, name='guardar_foto'), 
    path('tomar-foto/<int:informe_id>/', views.tomar_foto, name='tomar_foto'),
    path('buscar/', buscar_mascota, name='buscar_mascota'),

]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
