from django.db import models

class Contacto(models.Model):
    nombre = models.CharField(max_length=100)
    email = models.EmailField()
    consulta = models.TextField()

    def __str__(self):
        return self.nombre
    