from django import forms
from .models import Mascota

class MascotaForm(forms.ModelForm):
    dni_usuario = forms.CharField(max_length=15, required=True, label="DNI del Titular")
    class Meta:
        model = Mascota
        fields = ['dni_usuario', 'nombre', 'edad', 'especie', 'descripcion', 'imagen', 'imagen1', 'imagen2', 'imagen3', 'imagen4', 'imagen5']


#----------------------------------------------------------------------------------------

from django import forms
from .models import Informe

class InformeForm(forms.ModelForm):
    class Meta:
        model = Informe
        fields = ['informe', 'foto_imagen']
        widgets = {
            'informe': forms.Textarea(attrs={'rows': 3, 'class': 'form-control'}),  # Cambia la altura
        }
