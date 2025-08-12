from django.urls import path
from .views import generar_pdf_credito
from .views import (
    ver_factura_pdf,
    mostrar_factura_cta,
    pago_credito,
    generar_factura_pdf,
    listar_ctacorriente,
    eliminar_pago_credito,
    listar_cuenta_corriente,
    sumar_imp_cuota
)

app_name = 'libros'  # Namespace para las URLs

urlpatterns = [
    path('ctacorriente/', listar_ctacorriente, name='listar_ctacorriente'),
    path('factura/<int:factura_id>/pdf/', ver_factura_pdf, name='ver_factura_pdf'),
    path('factura/<int:factura_id>/', mostrar_factura_cta, name='mostrar_factura_cta'),
    path('factura/<int:factura_id>/pago_credito/', pago_credito, name='pago_credito'),
    path('factura/<int:factura_id>/pdf/', generar_factura_pdf, name='generar_factura_pdf'),
    
    path("cuentas_corrientes/", listar_ctacorriente, name="listar_ctacorriente"),
    path("eliminar_pago/<int:pago_id>/", eliminar_pago_credito, name="eliminar_pago_credito"),

    path('cuenta-corriente/<int:factura_id>/', listar_cuenta_corriente, name='listar_cuenta_corriente'),
    
    path('listar_cuenta_corriente/<int:factura_id>/', listar_cuenta_corriente, name='listar_cuenta_corriente'),
    path('generar_pdf_credito/<int:factura_id>/', generar_pdf_credito, name='generar_pdf_credito'),
    path('libros/generar_pdf_credito/<int:factura_id>/', generar_pdf_credito, name='generar_pdf_credito'),

    
]
