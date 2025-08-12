from django import template

register = template.Library()

@register.filter
def split(value, delimiter):
    """
    Divide un string por el delimitador especificado.
    """
    if isinstance(value, str):
        return value.split(delimiter)
    return []
