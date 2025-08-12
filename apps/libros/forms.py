from django import forms
from .models import CtaCorriente

class CtaCorrienteForm(forms.ModelForm):
    class Meta:
        model = CtaCorriente
        fields = [
            'dni_cliente',
            'nombre_cliente',
            'monto',
            'metodo_pago',
            'observacion',
            'facturas'
        ]  # Excluir 'fecha' porque es no editable
        widgets = {
            'dni_cliente': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Ingrese el DNI del cliente'}),
            'nombre_cliente': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Ingrese el nombre del cliente'}),
            'monto': forms.NumberInput(attrs={'class': 'form-control', 'placeholder': 'Ingrese el monto pagado'}),
            'metodo_pago': forms.Select(attrs={'class': 'form-control'}),
            'observacion': forms.Textarea(attrs={'class': 'form-control', 'placeholder': 'Observaciones', 'rows': 3}),
            'facturas': forms.SelectMultiple(attrs={'class': 'form-control'}),
        }
