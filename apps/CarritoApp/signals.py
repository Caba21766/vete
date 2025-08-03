from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Compra, Venta, Producto

# Incrementar el stock cuando se registra una compra
@receiver(post_save, sender=Compra)
def incrementar_stock(sender, instance, created, **kwargs):
    if created:  # Solo cuando se crea una nueva compra
        producto = instance.producto
        producto.stock += instance.cantidad
        producto.save()


# Reducir el stock cuando se registra una venta
@receiver(post_save, sender=Venta)
def reducir_stock(sender, instance, created, **kwargs):
    if created:  # Solo cuando se crea una nueva venta
        producto = instance.producto
        if producto.stock >= instance.cantidad:
            producto.stock -= instance.cantidad
            producto.save()
        else:
            raise ValueError("No hay suficiente stock disponible.")
