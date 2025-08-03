from django.urls import path
from . import views

app_name = 'opiniones'

urlpatterns = [
    # Ruta para agregar una opinión
    path('agregar/<int:producto_id>/', views.agregar_opinion, name='agregar_opinion'),

    # Ruta para modificar una opinión
    path('modificar/<int:id>/', views.modificar_opinion, name='modificar_opinion'),

    # Ruta para eliminar una opinión
    path('eliminar/<int:id>/', views.eliminar_opinion, name='eliminar_opinion'),

    # Ruta para listar opiniones
    path('listar/', views.listar_opinion, name='listar_opinion'),
    path('listar/', views.listar_opinion_usuarios, name='listar'),
    
    # Ruta para mostrar una página de éxito después de agregar una opinión
    #path('opinion_exito/', views.opinion_exito, name='opinion_exito'),
    path('opinion_exito/<int:producto_id>/', views.opinion_exito, name='opinion_exito'),

    
     # Ruta para administrar/modificar opiniones
    path('administrar/<int:id>/', views.opinion_administrador, name='opinion_administrador'),
    # Ruta para listar opiniones
    path('listar/', views.listar_opiniones, name='listar_opiniones'),

    path('eliminar/<int:id>/', views.eliminar_opinion, name='eliminar_opinion'),
    

    path('agregar/', views.agregar_opinion, name='agregar_opinion'),

    path('eliminar_opinion_nueva/<int:id>/', views.eliminar_opinion_nueva, name='eliminar_opinion_nueva'),
]
