from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from django.core.exceptions import ValidationError

class RegistrarseForm(UserCreationForm):
    cuil = forms.CharField(max_length=13, required=True, label="CUIL")
    iva = forms.ChoiceField(choices=User._meta.get_field('iva').choices, required=True, label="Condición de IVA")
    imagen_usuario = forms.ImageField(required=False, label="Imagen de Perfil")

    class Meta:
        model = User
        fields = [
            'username', 'first_name', 'last_name', 'email', 
            'dni_usuario', 'domicilio_usuario', 'tel1_usuario', 'tel2_usuario', 
            'cuil', 'iva', 'imagen_usuario', 'password1', 'password2'
        ]

    def clean_imagen_usuario(self):
        imagen = self.cleaned_data.get('imagen_usuario')
        if imagen:
            if imagen.size > 500 * 1024:  # Peso máximo: 500 KB
                raise ValidationError("La imagen no puede pesar más de 500 KB.")
            try:
                width, height = imagen.image.size
                if width > 1024 or height > 768:
                    raise ValidationError("La imagen no puede superar 1024 x 768 píxeles.")
            except AttributeError:
                raise ValidationError("No se pudo verificar la resolución de la imagen.")
        return imagen


class EditarUsuarioForm(forms.ModelForm):
    imagen_usuario = forms.ImageField(required=False, label="Imagen de Perfil")  # 📌 Agregado aquí

    class Meta:
        model = User
        fields = [
            'username', 'first_name', 'last_name', 'email', 'dni_usuario', 
            'domicilio_usuario', 'tel1_usuario', 'tel2_usuario', 'cuil', 'iva', 'imagen_usuario'  # 📌 Agregar aquí
        ]

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if self.instance:
            self.fields['dni_usuario'].initial = self.instance.dni_usuario
            self.fields['domicilio_usuario'].initial = self.instance.domicilio_usuario
            self.fields['tel1_usuario'].initial = self.instance.tel1_usuario
            self.fields['tel2_usuario'].initial = self.instance.tel2_usuario
            self.fields['cuil'].initial = self.instance.cuil
            self.fields['iva'].initial = self.instance.iva
            self.fields['email'].initial = self.instance.email
            self.fields['imagen_usuario'].initial = self.instance.imagen_usuario  # 📌 Agregado aquí

    def save(self, commit=True):
        user = super().save(commit=False)
        if self.cleaned_data.get('imagen_usuario'):
            user.imagen_usuario = self.cleaned_data['imagen_usuario']  # 📌 Guardar la imagen correctamente
        if commit:
            user.save()
        return user


from django.contrib.auth.forms import AuthenticationForm
from django import forms

class CustomLoginForm(AuthenticationForm):
    username = forms.CharField(
        widget=forms.TextInput(attrs={
            'autocomplete': 'off',
            'class': 'form-control',
            'placeholder': 'Nombre de usuario',
            'id': 'fakeuser',
            
        })
    )
    password = forms.CharField(
        widget=forms.PasswordInput(attrs={
            'autocomplete': 'new-password',
            'class': 'form-control',
            'placeholder': 'Contraseña',
            'id': 'fakepass',
            
        })
    )
