from apps.CarritoApp.models import Producto
from django.db import models
from django.contrib.auth.models import User

class Opinion(models.Model):
    usuario = models.ForeignKey(User, on_delete=models.CASCADE, related_name="opiniones")
    producto = models.ForeignKey(Producto, on_delete=models.CASCADE, related_name="opiniones_producto")
    texto = models.TextField()
    fecha = models.DateTimeField(auto_now_add=True)
    administrador = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        related_name="respuestas_administrador",
        null=True,
        blank=True,
    )

    def agregar_respuesta(self, administrador, respuesta):
        """
        Método para agregar la respuesta del administrador al texto existente.
        """
        self.texto += f"\nRespuesta del Administrador ({administrador.first_name} {administrador.last_name}): {respuesta.strip()}"
        self.administrador = administrador  # Asignamos el administrador que respondió
        self.save()

    def __str__(self):
        return f"Opinión de {self.usuario.username} sobre {self.producto.nombre_producto}"

    class Meta:
        verbose_name = "Opinión"
        verbose_name_plural = "Opiniones"


