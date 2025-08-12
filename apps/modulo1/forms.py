from django import forms
from apps.CarritoApp.models import MetodoPago

class MetodoPagoForm(forms.ModelForm):
    class Meta:
        model = MetodoPago
        fields = ['tarjeta_nombre']
        
    tarjeta_nombre = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Nombre de la tarjeta'}))
