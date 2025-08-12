from django.core.management.base import BaseCommand
from django.urls import get_resolver

class Command(BaseCommand):
    help = 'Muestra todas las URLs registradas en el proyecto'

    def handle(self, *args, **kwargs):
        urls = get_resolver().url_patterns
        for url in urls:
            self.stdout.write(str(url))
