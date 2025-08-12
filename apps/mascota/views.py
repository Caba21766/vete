from django.core.paginator import Paginator
from django.shortcuts import render
from .models import Mascota
from django.contrib.auth.models import User

def lista_mascotas(request):
    dni = request.GET.get('dni')
    first_name = ''
    last_name = ''
    imagen_usuario = ''

    if request.user.is_authenticated:
        # Si el usuario está logueado, obtener su dni_usuario
        dni_usuario = getattr(request.user, 'dni_usuario', None)

        if dni:  # Si el usuario busca un DNI
            usuario = User.objects.filter(dni_usuario=dni, is_active=True).first()
            if usuario:
                mascotas_list = Mascota.objects.filter(usuario=usuario)
                first_name = usuario.first_name
                last_name = usuario.last_name
                imagen_usuario = usuario.imagen_usuario  # ✅ CAMBIO AQUÍ
            else:
                mascotas_list = []
        else:
            # Mostrar solo las mascotas del usuario autenticado
            mascotas_list = Mascota.objects.filter(usuario=request.user)
            first_name = request.user.first_name
            last_name = request.user.last_name
            imagen_usuario = request.user.imagen_usuario  # ✅ CAMBIO AQUÍ
    else:
        mascotas_list = []

    # Paginación: 3 tarjetas por página
    paginator = Paginator(mascotas_list, 3)
    page = request.GET.get('page')
    mascotas_pagina = paginator.get_page(page)

    return render(request, "mascota/lista_mascotas.html", {
        "dni": dni,
        "mascotas_pagina": mascotas_pagina,
        "first_name": first_name,
        "last_name": last_name,
        "imagen_usuario": imagen_usuario,
    })

#------------------------------------------------------------------------

from django.core.paginator import Paginator
from django.shortcuts import render
from .models import Mascota
from django.contrib.auth.models import User

def buscar_mascota(request):
    dni = request.GET.get('dni')
    mascotas_list = []

    if dni:
        # Buscar en auth_user si existe el usuario con ese dni_usuario
        usuario = User.objects.filter(dni_usuario=dni).first()

        if usuario:
            mascotas_list = Mascota.objects.filter(usuario=usuario)
        else:
            mascotas_list = []  # No hay usuario con ese dni

    # Paginación: 3 tarjetas por página
    paginator = Paginator(mascotas_list, 3)
    page = request.GET.get('page')
    mascotas_pagina = paginator.get_page(page)

    return render(request, "mascota/lista_mascotas.html", {
        "dni": dni,
        "mascotas_pagina": mascotas_pagina
    })


#------------------------------------------------------------------------


from django.shortcuts import render, get_object_or_404, redirect
from .models import Mascota
from .forms import MascotaForm  # type: ignore # Creamos este formulario en el siguiente paso

def editar_mascota(request, pk):
    mascota = get_object_or_404(Mascota, pk=pk)

    if request.method == 'POST':
        form = MascotaForm(request.POST, request.FILES, instance=mascota)
        if form.is_valid():
            form.save()
            return redirect('mascota:lista_mascotas')  # Redirige a la lista después de guardar
    else:
        form = MascotaForm(instance=mascota)

    return render(request, 'mascota/editar_mascota.html', {'form': form, 'mascota': mascota})

#------------------------------------------------------------------------
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib import messages
from .models import Mascota

def eliminar_mascota(request, pk):
    mascota = get_object_or_404(Mascota, pk=pk)

    if request.method == 'POST':
        mascota.delete()
        messages.success(request, f"La mascota {mascota.nombre} ha sido eliminada.")
        return redirect('mascota:lista_mascotas')

    return render(request, 'mascota/confirmar_eliminacion.html', {'mascota': mascota})

#------------------------------------------------------------------------
from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from django.contrib import messages
from .forms import MascotaForm
from .models import Mascota

def agregar_mascota(request):
    if request.method == "POST":
        form = MascotaForm(request.POST, request.FILES)
        if form.is_valid():
            dni_usuario = form.cleaned_data.get('dni_usuario')

            # Buscar si el usuario con ese DNI existe en auth_user
            usuario = User.objects.filter(dni_usuario=dni_usuario).first()
            if not usuario:
                messages.error(request, f"No existe un usuario con el DNI {dni_usuario}. Debe registrarse primero.")
                return render(request, "mascota/agregar_mascota.html", {"form": form})

            # Guardar la mascota con el usuario asociado
            mascota = form.save(commit=False)
            mascota.usuario = usuario
            mascota.save()

            messages.success(request, "Mascota guardada correctamente.")
            return redirect('mascota:lista_mascotas')

    else:
        form = MascotaForm()

    return render(request, "mascota/agregar_mascota.html", {"form": form})

#------------------------------------------------------------------------

from django.shortcuts import render, get_object_or_404
from .models import Mascota, Informe
from .forms import InformeForm

def detalle_mascota(request, pk):
    mascota = get_object_or_404(Mascota, pk=pk)
    informes = Informe.objects.filter(mascota=mascota).order_by('-fecha')  # Cargar los informes de la mascota
    form = InformeForm()  # Cargar el formulario vacío para nuevos informes

    return render(request, 'mascota/detalle_mascota.html', {
        'mascota': mascota,
        'informes': informes,
        'form': form  # Enviar el formulario a la plantilla
    })


#------------------------------------------------------------------------


from django.shortcuts import render, redirect, get_object_or_404
from .models import Informe, Mascota
from .forms import InformeForm
from django.contrib.auth.decorators import login_required

@login_required
def agregar_informe(request, pk):
    mascota = get_object_or_404(Mascota, pk=pk)
    if request.method == 'POST':
        form = InformeForm(request.POST, request.FILES)
        if form.is_valid():
            informe = form.save(commit=False)
            informe.usuario = request.user  # Asignamos el usuario actual
            informe.mascota = mascota  # Relacionamos el informe con la mascota
            informe.save()
            return redirect('mascota:detalle_mascota', pk=pk)  # Redirige para evitar doble envío
    else:
        form = InformeForm()
    
    informes = Informe.objects.filter(mascota=mascota).order_by('-fecha')  # Cargar los informes asociados
    return render(request, 'mascota/detalle_mascota.html', {'mascota': mascota, 'form': form, 'informes': informes})

#------------------------------------------------------------------------
from django.shortcuts import render, get_object_or_404, redirect
from .models import Informe
from .forms import InformeForm

def editar_informe(request, pk):
    informe = get_object_or_404(Informe, pk=pk)
    
    if request.method == 'POST':
        form = InformeForm(request.POST, request.FILES, instance=informe)
        if form.is_valid():
            form.save()
            return redirect('mascota:detalle_mascota', pk=informe.mascota.id)  # Redirigir al detalle de la mascota
    else:
        form = InformeForm(instance=informe)
    
    return render(request, 'mascota/editar_informe.html', {'form': form, 'informe': informe})

#------------------------------------------------------------------------
from django.shortcuts import render, get_object_or_404, redirect
from .models import Informe, Mascota
from .forms import InformeForm

def gestionar_informe(request, mascota_id, informe_id=None):
    mascota = get_object_or_404(Mascota, id=mascota_id)

    if informe_id:
        informe = get_object_or_404(Informe, id=informe_id)
    else:
        informe = None

    if request.method == 'POST':
        form = InformeForm(request.POST, request.FILES, instance=informe)
        if form.is_valid():
            informe = form.save(commit=False)
            informe.usuario = request.user
            informe.mascota = mascota  # Relacionamos el informe con la mascota
            informe.save()
            return redirect('mascota:detalle_mascota', pk=mascota.id)
    else:
        form = InformeForm(instance=informe)

    informes = Informe.objects.filter(mascota=mascota).order_by('-fecha')

    return render(request, 'mascota/detalle_mascota.html', {
        'mascota': mascota,
        'form': form,
        'informes': informes,
        'editar': bool(informe_id),  # Para detectar si se está editando
        'informe_id': informe.id if informe else None,
    })

#------------------------------------------------------------------------
from django.shortcuts import render, get_object_or_404, redirect
from .models import Informe, Mascota
from django.contrib.auth.decorators import login_required

@login_required
def eliminar_informe(request, mascota_id, informe_id):
    mascota = get_object_or_404(Mascota, id=mascota_id)
    informe = get_object_or_404(Informe, id=informe_id)

    if request.method == "POST":
        informe.delete()
        return redirect('mascota:detalle_mascota', pk=mascota.id)

    return render(request, 'mascota/confirmar_eliminar.html', {'mascota': mascota, 'informe': informe})

#------------------------------------------------------------------------
from django.shortcuts import render, get_object_or_404
from .models import Informe

def tomar_foto(request, informe_id):
    informe = get_object_or_404(Informe, id=informe_id)  # ✅ Obtiene el informe correcto
    return render(request, 'mascota/tomar_foto.html', {'informe': informe})  # ✅ Pasa informe al template

#------------------------------------------------------------------------
import base64
from django.core.files.base import ContentFile
from django.shortcuts import redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from .models import Informe

@login_required  # Asegura que el usuario esté autenticado
def guardar_foto(request, informe_id):
    if request.method == 'POST':
        foto_data = request.POST.get('foto')  # Obtener la imagen en base64
        if foto_data:
            format, imgstr = foto_data.split(';base64,')
            ext = format.split('/')[-1]  # Extrae la extensión del archivo
            data = ContentFile(base64.b64decode(imgstr), name=f"foto.{ext}")

            # Obtener el informe correspondiente
            informe = get_object_or_404(Informe, id=informe_id)

            # Asignar la imagen al informe existente
            informe.foto_imagen = data
            informe.save()

            return redirect('mascota:detalle_mascota', pk=informe.mascota.id)  # Redirige después de guardar

    return redirect('mascota:lista_mascotas')  # En caso de error, redirige a la lista
