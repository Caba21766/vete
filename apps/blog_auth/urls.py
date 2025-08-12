from django.urls import path
from django.contrib.auth.views import LoginView, LogoutView
from .views import RegistrarseView, EditarPerfil
from .views import lista_usuarios
from . import views

app_name = 'apps.blog_auth'

urlpatterns = [
    path("registrarse/", RegistrarseView.as_view(), name = 'registrarse'),
    path("iniciar_sesion/", LoginView.as_view(template_name='users/iniciar_sesion.html'), name = 'iniciar_sesion'),
    path("cerrar_sesion/", LogoutView.as_view(), name = 'cerrar_sesion'),
    path('perfil/', views.perfil_view, name='perfil'),
    
    path('pedir_con/', views.pedir_con_view, name='pedir_con'),
    
    path("editar_perfil/<int:pk>", EditarPerfil.as_view(), name='editar_perfil'),
    path('editar/<int:pk>/', views.editar_usuario, name='editar_usuario'),
    path('editar/', views.editar_usuario, name='editar_usuario'),
    
    path('', lista_usuarios, name='lista_usuarios'),  # Esto manejará /usuarios/
    path('lista/', lista_usuarios, name='lista_usuarios'),
    

]