from django.apps import AppConfig

class BackupConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.backup'  # Asegúrate de que el nombre coincida con la estructura del proyecto