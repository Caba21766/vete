from django import template

register = template.Library()

@register.filter
def range_filter(value):
    """Devuelve un rango basado en el valor dado."""
    if value is None or not isinstance(value, int):
        return range(0)  # Devuelve un rango vacío si el valor es inválido
    return range(1, value + 1)

#------------------------------------------------------------
from django import template

register = template.Library()

@register.filter
def get_item(dictionary, key):
    """Devuelve el valor de un diccionario para una clave específica."""
    return dictionary.get(key, 0)

#------------------------------------------------------------

from django import template

register = template.Library()

@register.filter
def get_item(dictionary, key):
    return dictionary.get(key, 0)







