from django.contrib.auth.models import User
from django.shortcuts import render, get_object_or_404, redirect
from .models import Producto, Opinion

def agregar_opinion(request, producto_id):
    # Obtén el producto correspondiente
    producto = get_object_or_404(Producto, id=producto_id)
    
    if request.method == 'POST':
        # Crear la nueva opinión
        Opinion.objects.create(
            usuario=request.user,
            producto=producto,
            texto=request.POST.get('texto'),  # Asegúrate de usar .get para evitar errores
        )
        # Redirigir a la página de éxito con el producto_id
        return redirect('opiniones:opinion_exito', producto_id=producto.id)

    # Obtener las opiniones para este producto
    opiniones = Opinion.objects.filter(producto=producto).order_by('-fecha')
    
    # Renderiza la plantilla con el formulario y las opiniones
    return render(request, 'opiniones/agregar_opinion.html', {
        'producto': producto,
        'opiniones': opiniones
    })


#----------------opinion_exito---------------------------
from django.shortcuts import render, get_object_or_404
from .models import Producto  # Asegúrate de importar el modelo correspondiente

def opinion_exito(request, producto_id):
    # Obtén el producto correspondiente al ID
    producto = get_object_or_404(Producto, id=producto_id)
    
    # Renderiza la plantilla con el contexto necesario
    return render(request, 'opiniones/opinion_exito.html', {'producto': producto})


#------------Modificar opiniones------------------------------
from django.shortcuts import render, get_object_or_404, redirect
from .models import Opinion, Producto

def modificar_opinion(request, id):
    # Obtén la opinión a modificar
    opinion = get_object_or_404(Opinion, id=id)

    if request.method == 'POST':
        # Actualiza el texto de la opinión
        opinion.texto = request.POST.get('texto')
        opinion.save()
        # Redirige a la plantilla opinion_exito
        return redirect('opiniones:opinion_exito', producto_id=opinion.producto.id)

    # Renderiza la misma plantilla para agregar o modificar opiniones
    return render(request, 'opiniones/agregar_opinion.html', {
        'opinion': opinion,  # Pasar la opinión existente al formulario
        'producto': opinion.producto  # Pasar el producto asociado, si es necesario
    })

#------------Eliminar opiniones  del usuario------------------------------
from django.shortcuts import get_object_or_404, redirect
from django.urls import reverse
from django.http import Http404

def eliminar_opinion(request, id):
    try:
        opinion = get_object_or_404(Opinion, id=id)
        producto_id = opinion.producto.id  # Obtener el producto antes de eliminar
        opinion.delete()

        # Redirige a la página de agregar opinión con el producto_id
        next_url = request.GET.get('next', reverse('opiniones:agregar_opinion', args=[producto_id]))
        return redirect(next_url)

    except Opinion.DoesNotExist:
        raise Http404("La opinión que intentas eliminar no existe.")


#------------Eliminar opiniones del adminstrador------------------------------
from django.shortcuts import get_object_or_404, redirect
from django.http import Http404
from .models import Opinion  # Asegúrate de importar el modelo correcto

def eliminar_opinion_nueva(request, id):
    """
    Elimina una opinión específica y redirige a la lista de opiniones.
    """
    try:
        opinion = get_object_or_404(Opinion, id=id)
        opinion.delete()

        # Redirige siempre a la página de listar opiniones
        return redirect('opiniones:listar')  # Usa el nombre de la URL que apunta a /opiniones/listar/

    except Opinion.DoesNotExist:
        raise Http404("La opinión que intentas eliminar no existe.")


#----------Listar opiniones /// opinion---------------------------------
from django.shortcuts import render
from .models import Opinion
def listar_opiniones(request):
    opiniones = Opinion.objects.all().order_by('-fecha')
    return render(request, 'opiniones/listar_opiniones.html', {'opiniones': opiniones})


from django.shortcuts import render
from .models import Opinion
from django.core.paginator import Paginator
from django.shortcuts import render
from .models import Opinion
def listar_opinion(request):
    opiniones = Opinion.objects.all().order_by('-fecha')  # Ordenar por fecha descendente
    return render(request, 'opiniones/listar_opiniones.html', {'opiniones': opiniones})


#----------------OPINION usuario--------------------------------------------#
from django.shortcuts import render
from .models import Opinion

def listar_opinion_usuarios(request):
    opiniones = Opinion.objects.all()  # Obtiene todas las opiniones de la base de datos
    return render(request, 'opiniones/listar_opinion_usuario.html', {'opiniones': opiniones})




#----------------OPINION ADMINISTRADOR-------------------------------------------#
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from .models import Opinion

@login_required
def opinion_administrador(request, id):
    # Obtener la opinión
    opinion = get_object_or_404(Opinion, id=id)

    if request.method == 'POST':
        # Determinar qué acción realizar (responder o eliminar)
        accion = request.POST.get('accion')

        if accion == 'responder':
            # Procesar la respuesta del administrador
            respuesta_texto = request.POST.get('respuesta', '').strip()
            if respuesta_texto:
                opinion.texto += f'<br><strong><span style="color:green;">...Respuesta:</span></strong> {respuesta_texto}'
                opinion.administrador = request.user
                opinion.save()

        elif accion == 'eliminar':
            # Eliminar la última respuesta agregada por el administrador
            lineas = opinion.texto.splitlines()
            if len(lineas) > 1:
                # Remover la última línea (última respuesta)
                lineas.pop()
                opinion.texto = "\n".join(lineas)
                opinion.save()

        # Redirigir al listado de opiniones después de la acción
        return redirect('opiniones:listar_opiniones')

    # Renderizar la plantilla
    return render(request, 'opiniones/opinion_administrador.html', {'opinion': opinion})
