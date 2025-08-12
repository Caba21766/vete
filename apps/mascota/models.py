from django.db import models
from django.contrib.auth.models import User

class Mascota(models.Model):
    usuario = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    dni_usuario = models.CharField(max_length=15, null=True, blank=True) 
    nombre = models.CharField(max_length=100)
    edad = models.IntegerField()
    especie = models.CharField(max_length=50, choices=[('Perro', 'Perro'), ('Gato', 'Gato'), ('Otro', 'Otro')])
    descripcion = models.TextField()
    imagen = models.ImageField(upload_to='mascotas/', blank=True, null=True)  
    imagen1 = models.ImageField(upload_to='mascotas/', blank=True, null=True)
    imagen2 = models.ImageField(upload_to='mascotas/', blank=True, null=True)
    imagen3 = models.ImageField(upload_to='mascotas/', blank=True, null=True)
    imagen4 = models.ImageField(upload_to='mascotas/', blank=True, null=True)
    imagen5 = models.ImageField(upload_to='mascotas/', blank=True, null=True)  

    def save(self, *args, **kwargs):
        # Asegurar que el dni_usuario siempre sea igual al del usuario relacionado
        if self.usuario and hasattr(self.usuario, 'dni_usuario'):
            self.dni_usuario = self.usuario.dni_usuario
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.nombre} - {self.usuario.username if self.usuario else 'Sin Usuario'}"
    

#--------------------------------------------------------------------
class Informe(models.Model):
    usuario = models.ForeignKey(User, on_delete=models.CASCADE)  
    mascota = models.ForeignKey(Mascota, on_delete=models.CASCADE, null=True, blank=True)  # Permitir nulos
    fecha = models.DateTimeField(auto_now_add=True)  
    informe = models.TextField()
    foto_imagen = models.ImageField(upload_to='informes/', blank=True, null=True)
    

    def __str__(self):
        return f"Informe de {self.usuario.username} para {self.mascota.nombre if self.mascota else 'Sin Mascota'} - {self.fecha.strftime('%d/%m/%Y %H:%M')}"
