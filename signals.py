from django.db.models.signals import post_save
from django.contrib.auth.models import User
from django.dispatch import receiver
from .models import Profile  # type: ignore # Asegúrate de usar el nombre correcto del modelo

# Crear un perfil automáticamente cuando se crea un usuario
@receiver(post_save, sender=User)
def create_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)

# Guardar automáticamente el perfil cuando se guarda un usuario
@receiver(post_save, sender=User)
def save_profile(sender, instance, **kwargs):
    # Verifica si el perfil existe antes de intentar guardarlo
    if hasattr(instance, 'profile'):
        instance.profile.save()
