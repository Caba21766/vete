#----------------- Prueba1 de modulo1 en Factura
from django.shortcuts import render
from django.contrib.auth.models import User

from datetime import date, datetime
from apps.CarritoApp.models import Factura, MetodoPago
from django.contrib import messages
from django.contrib.messages import get_messages
from django.contrib.auth.decorators import login_required, permission_required

@login_required
@permission_required('CarritoApp.add_factura', raise_exception=True)
def prueba(request):
   
    vendedor = request.user
    fecha_actual = date.today().strftime('%d/%m/%Y')
    hora = datetime.now().strftime('%H:%M:%S')  # ⬅️ AGREGADO

    dni_usuario = ""
    first_name = ""
    last_name = ""
    tel1_usuario = ""
    domicilio_usuario = ""
    cuil = ""
    iva = ""
    numero_factura = None

    try:
        # Obtener la última factura y calcular el nuevo número
        ultima_factura = Factura.objects.order_by('-numero_factura').first()
        if ultima_factura and ultima_factura.numero_factura.isdigit():
            numero_factura = str(int(ultima_factura.numero_factura) + 1).zfill(5)
        else:
            numero_factura = "00001"
    except Exception as e:
        print(f"Error al obtener el número de factura: {e}")
        numero_factura = "00001"

    # Limpiar mensajes previos antes de agregar uno nuevo
    storage = get_messages(request)
    for _ in storage:
        pass  # Consumir los mensajes previos

    if request.method == 'POST':
        dni_usuario = request.POST.get('dni_cliente', '')

        try:
            # Buscar el usuario por DNI
            user = User.objects.get(dni_usuario=dni_usuario)
            first_name = user.first_name
            last_name = user.last_name
            tel1_usuario = getattr(user, 'tel1_usuario', "No registrado")
            domicilio_usuario = getattr(user, 'domicilio_usuario', "No registrado")
            cuil = getattr(user, 'cuil', "No registrado")
            iva = getattr(user, 'iva', "No registrado")
        except User.DoesNotExist:
            first_name = "No encontrado"
            last_name = "No encontrado"
            tel1_usuario = "No encontrado"
            domicilio_usuario = "No encontrado"
            cuil = "No encontrado"
            iva = "No encontrado"
            messages.error(request, "Usuario no encontrado. Debe cargar un usuario existente.")

    # Obtener los métodos de pago
    metodos_pago = MetodoPago.objects.all()

    return render(request, 'prueba.html', {  
        'fecha_actual': fecha_actual,
        'hora': hora,  # ⬅️ AGREGADO
        'numero_factura': numero_factura,
        'dni_cliente': dni_usuario,
        'first_name': first_name,
        'last_name': last_name,
        'tel1_usuario': tel1_usuario,
        'domicilio_usuario': domicilio_usuario,
        'cuil': cuil,
        'iva': iva,
        'vendedor': vendedor.username if vendedor.is_authenticated else "Anónimo",
        'metodos_pago': metodos_pago
    })

#--------------Listado de las facturas------------------------------
def lista_facturas(request):
    return render(request, 'modulo1/lista_facturas.html')

from django.shortcuts import render
from datetime import date

#--------------Buscar Mercaderia------------------------------------------------------

from django.http import HttpResponse, JsonResponse
from apps.CarritoApp.models import Producto

def buscar_mercaderia(request):
    numero_producto = request.GET.get('numero_producto')
    nombre_producto = request.GET.get('nombre_producto')
    
    try:
        if numero_producto:
            producto = Producto.objects.get(numero_producto=numero_producto)
            return JsonResponse({
                'numero_producto': producto.numero_producto,
                'nombre_producto': producto.nombre_producto,
                'precio': str(producto.precio),
            })
        elif nombre_producto:
            productos = Producto.objects.filter(nombre_producto__icontains=nombre_producto)[:10]
            productos_list = [
                {
                    'numero_producto': producto.numero_producto,
                    'nombre_producto': producto.nombre_producto,
                    'precio': str(producto.precio),  # Agregado precio para consistencia
                }
                for producto in productos
            ]
            # Devolver una lista sin la clave 'productos'
            return JsonResponse(productos_list, safe=False)
        else:
            return JsonResponse({'error': 'Debe proporcionar un número o nombre de producto.'})
    except Exception as e:
        return JsonResponse({'error': 'Error al buscar el producto.'})


#--------------Crear Factura Modulo1---------------------
from django.shortcuts import render
from datetime import date
from apps.CarritoApp.models import Factura

def crear_factura(request):
    # Obtener la fecha actual
    fecha_actual = date.today().strftime('%d/%m/%Y')

    # Inicializar el número de factura
    numero_factura = None

    try:
        # Obtener la última factura
        ultima_factura = Factura.objects.order_by('-numero_factura').first()
        
        if ultima_factura:
            # Validar que el número de factura sea un número válido
            if ultima_factura.numero_factura and ultima_factura.numero_factura.isdigit():
                numero_factura = str(int(ultima_factura.numero_factura) + 1).zfill(5)
            else:
                # Si el número no es válido, comenzar desde "00001"
                print(f"Número de factura inválido: {ultima_factura.numero_factura}")
                numero_factura = "00001"
        else:
            # Si no hay facturas en la base de datos, comenzar desde "00001"
            numero_factura = "00001"
    except Exception as e:
        print(f"Error al obtener el número de factura: {e}")
        numero_factura = "00001"

    # Imprimir para verificar valores
    print("Fecha actual:", fecha_actual)
    print("Número de factura generado:", numero_factura)

    # Renderizar la plantilla
    return render(request, 'modulo1/prueba.html', { 
        'fecha_actual': fecha_actual,
        'numero_factura': numero_factura,
    })

#--------- Guardar Prueba (FACTURA) Modulo1 es el SAVE()---------------------
import json 
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.db import transaction, IntegrityError
from apps.CarritoApp.models import Factura, Producto
from apps.CarritoApp.models import MetodoPago, Factura, Producto

@csrf_exempt
def guardar_prueba(request):
    if request.method != 'POST':
        return JsonResponse({'error': 'Método no permitido.'}, status=405)

    try:
        data = json.loads(request.body)
        print("📨 Datos recibidos en la vista:", json.dumps(data, indent=2))
        print(f"📌 Domicilio recibido: {data.get('domicilio_factura', 'No recibido')}")
        print(f"📌 CUIL recibido: {data.get('cuil', 'No recibido')}")
        print(f"📌 IVA recibido: {data.get('iva', 'No recibido')}")
        print(f"📌 Método de pago: {data.get('metodo_pago', 'No recibido')}")

      
        # ✅ Soporte para "Efectivo" y "Cuenta Corriente" fijos
        metodo_pago_nombre = data.get('metodo_pago', 'Efectivo')
        if metodo_pago_nombre in ["Efectivo", "Cuenta Corriente"]:
            metodo_pago_obj = None  # No se guarda como FK, pero sí el nombre
        else:
            metodo_pago_obj = MetodoPago.objects.filter(tarjeta_nombre=metodo_pago_nombre).first()
            if not metodo_pago_obj:
                return JsonResponse({'error': 'Método de pago inválido. Asegúrate de que esté registrado en la BD.'}, status=400)

        detalle_productos = data.get('detalle_productos', [])
        if not detalle_productos:
            return JsonResponse({'error': 'La factura no tiene productos. Por favor, cargue productos antes de guardar.'}, status=400)

        # **Verificar stock antes de guardar**
        for detalle in detalle_productos:
            numero_producto = detalle.get('numero_producto')
            cantidad_vendida = detalle.get('cantidad_vendida')

            try:
                producto = Producto.objects.get(numero_producto=numero_producto)
            except Producto.DoesNotExist:
                return JsonResponse({'error': f'Producto con número {numero_producto} no encontrado.'}, status=400)

            if producto.stock < cantidad_vendida:
                return JsonResponse({'error': f'Stock insuficiente para el producto {producto.nombre_producto}.'}, status=400)

        # **Obtener valores para la factura**
        total_con_interes = data.get('total_con_interes', None)

        # **Si no se envió total_con_interes, usar total_con_descuento**
        if total_con_interes in [None, ""]:
            total_con_interes = data.get('total_con_descuento', 0)

        # **Convertir a float**
        try:
            total_con_interes = float(total_con_interes)
        except ValueError:
            total_con_interes = 0  # Si hay un error, asignar 0

        print(f"✅ total_con_interes procesado: {total_con_interes}")

        # ✅ Obtener datos de la tarjeta si se elige un método de pago con tarjeta
        tarjeta_nombre = data.get('tarjeta_nombre', None)
        tarjeta_numero = data.get('tarjeta_numero', None)


        # ✅ Buscar método de pago como instancia
        metodo_pago_obj = None
        metodo_pago_nombre = data.get('metodo_pago', 'Efectivo')

        if metodo_pago_nombre not in ["Efectivo", "Cuenta Corriente"]:
            metodo_pago_obj = MetodoPago.objects.filter(tarjeta_nombre=metodo_pago_nombre).first()
            if not metodo_pago_obj:
                return JsonResponse({'error': f'Método de pago "{metodo_pago_nombre}" no encontrado.'}, status=400)

        # **Guardar la factura y actualizar el stock**
        with transaction.atomic():
            nueva_factura = Factura.objects.create(
                fecha=data.get('fecha'),
                dni_cliente=data.get('dni_cliente'),
                nombre_cliente=data.get('nombre_cliente'),
                apellido_cliente=data.get('apellido_cliente', 'Desconocido'),
                domicilio=data.get("domicilio_factura"),  # ✅ Aquí debe guardarse
                cuil=data.get("cuil"),  # ✅ Aquí debe guardarse
                iva=data.get("iva"),  # ✅ Aquí debe guardarse
                metodo_pago=metodo_pago_obj,  # instancia FK o None
                metodo_pago_manual=metodo_pago_nombre if metodo_pago_obj is None else None,
                total=data.get('total', 0),
                descuento=data.get('descuento', 0),
                total_descuento=data.get('total_con_descuento', 0),
                total_con_interes=total_con_interes,  # ✅ Guardar correctamente
                cuota_mensual=float(data.get('cuota_mensual', 0)),  # 🆕 Guardamos la cuota mensual
                detalle_productos=json.dumps(detalle_productos),
                vendedor=request.user.get_full_name() if request.user.is_authenticated else 'Sin asignar',
                cuotas=data.get('cuotas', 1),
                interes=data.get('interes', 0),
                tarjeta_nombre=tarjeta_nombre,  # ✅ Guardamos el nombre de la tarjeta
                tarjeta_numero=tarjeta_numero,  # ✅ Guardamos el número de la tarjeta
                numero_tiket=data.get('numero_tiket', None),  # ✅ Guardamos el número de ticket
            )

            # **Asignar número de factura**
            nueva_factura.numero_factura = str(nueva_factura.id).zfill(5)
            nueva_factura.save()

            # **Actualizar stock de productos**
            for detalle in detalle_productos:
                numero_producto = detalle.get('numero_producto')
                cantidad_vendida = detalle.get('cantidad_vendida')
                producto = Producto.objects.get(numero_producto=numero_producto)
                producto.stock -= cantidad_vendida
                producto.save()

        print(f"✅ Factura {nueva_factura.id} guardada con total_con_interes: {nueva_factura.total_con_interes}")

        # Redireccionar al resumen de CarritoApp
        url_resumen = reverse('CarritoApp:resumen_factura', args=[nueva_factura.id])
        return JsonResponse({'redirect': url_resumen})

    except ValueError as e:
        return JsonResponse({'error': str(e)}, status=400)
    except IntegrityError:
        return JsonResponse({'error': 'Error de integridad: posible duplicado.'}, status=400)
    except Exception as e:
        return JsonResponse({'error': f'Error interno: {str(e)}'}, status=500)


#------------------Mostrar Factura con Botones--------------------------
#------------------Mostrar Factura con Botones--------------------------
#------------------Mostrar Factura con Botones--------------------------
from django.urls import reverse
from django.shortcuts import render

def mostrar_factura_con_botones(request, factura_id):
    # Construir la URL absoluta para el PDF
    pdf_url = request.build_absolute_uri(reverse('modulo1:generar_factura_pdf_directo', args=[factura_id]))
    print("PDF URL:", pdf_url)  # Depuración para verificar la URL generada

    # Renderizar la plantilla pasando la URL del PDF y el ID de la factura
    return render(request, 'facturaprueba_pdf.html', {'pdf_url': pdf_url, 'factura_id': factura_id})


#------------------Generar Factura PDF--------------------------
from django.shortcuts import render
from django.http import HttpResponse
from apps.CarritoApp.models import Factura
import json

def generar_facturaprueba_pdf(request, factura_id):
    try:
        factura = Factura.objects.get(id=factura_id)
        detalle_productos = json.loads(factura.detalle_productos)

        return render(request, 'modulo1/facturaprueba_pdf.html', {
            'factura': factura,
            'detalle_productos': detalle_productos
        })

    except Factura.DoesNotExist:
        return HttpResponse("Factura no encontrada.", status=404)

#----------------------------------------------------------------------------------
from django.shortcuts import render
from django.http import HttpResponse
from apps.CarritoApp.models import Factura

def registrar_credito(request, factura_id):
    try:
        factura = Factura.objects.get(id=factura_id)

        if request.method == "POST":
            cuotas = request.POST.get("cuotas")
            interes = request.POST.get("interes")
            # Aquí puedes guardar los datos en la base de datos si es necesario
            return HttpResponse(f"Crédito registrado para la Factura Nº {factura.numero_factura}")

        return render(request, 'modulo1/registrar_credito.html', {'factura': factura})

    except Factura.DoesNotExist:
        return HttpResponse("Factura no encontrada.", status=404)

#----------------------------------------------------------------------------------
from django.shortcuts import render
def listar_ctacorriente(request):
    return render(request, 'modulo1/listar_ctacorriente.html')
#----------------------------------------------------------------------------------
from django.shortcuts import render
from apps.CarritoApp.models import MetodoPago

def forma_pago(request):
    metodos_pago = MetodoPago.objects.all()
    return render(request, "prueba.html", {"metodos_pago": metodos_pago})



#------- de las tarjetas de crédito de factura---------------------
from django.shortcuts import render, redirect
from django.contrib import messages
from django.db.models import Prefetch
from apps.CarritoApp.models import MetodoPago, CuotaInteres


def agregar_metodo_pago(request):
    if request.method == 'POST':
        nombre = request.POST.get('tarjeta_nombre')

        if MetodoPago.objects.filter(tarjeta_nombre__iexact=nombre).exists():
            messages.warning(request, "Ya existe un método con ese nombre.")
        else:
            MetodoPago.objects.create(tarjeta_nombre=nombre)
            messages.success(request, "Método de pago guardado correctamente.")

        return redirect('modulo1:agregar_metodo_pago')

    cuotas_ordenadas = Prefetch(
        'cuotas_interes',
        queryset=CuotaInteres.objects.order_by('cantidad_cuotas')
    )

    metodos_pago = MetodoPago.objects.prefetch_related(cuotas_ordenadas).order_by('id')
    return render(request, 'modulo1/agregar_metodo_pago.html', {
        'metodos_pago': metodos_pago
    })


#------------- Editar tarjeta o cargar cuota  -------------------  
from django.shortcuts import render, get_object_or_404, redirect
from apps.CarritoApp.models import MetodoPago
from django.contrib import messages

def editar_metodo_pago(request, metodo_id):
    metodo = get_object_or_404(MetodoPago, id=metodo_id)

    if request.method == 'POST':
        metodo.tarjeta_cuota = request.POST.get('tarjeta_cuota')
        metodo.tarjeta_porcentaje = request.POST.get('tarjeta_porcentaje') or 0
        metodo.save()
        messages.success(request, "Método de pago actualizado.")
        return redirect('modulo1:agregar_metodo_pago')

    return render(request, 'modulo1/editar_metodo_pago.html', {'metodo': metodo})

# --------------------de las tarjetas de crédito de factura----------------------
# views.py
def asignar_cuotas(request, metodo_id):
    metodo = get_object_or_404(MetodoPago, id=metodo_id)
    if request.method == "POST":
        cuotas = request.POST.getlist('cantidad_cuotas[]')
        intereses = request.POST.getlist('porcentaje_interes[]')
        for c, i in zip(cuotas, intereses):
            CuotaInteres.objects.get_or_create(
                metodo_pago=metodo,
                cantidad_cuotas=c,
                defaults={'porcentaje_interes': i}
            )
        return redirect('modulo1:asignar_cuotas', metodo_id=metodo.id)

    cuotas_existentes = metodo.cuotas_interes.order_by('cantidad_cuotas')
    return render(request, 'modulo1/asignar_cuotas.html', {
        'metodo': metodo,
        'cuotas_existentes': cuotas_existentes
    })

#------------de elimiar  las tarjetas de crédito  o metodo pago de factura 
from django.shortcuts import render, get_object_or_404, redirect
from apps.CarritoApp.models import MetodoPago
from django.contrib import messages

def eliminar_metodo_pago(request, metodo_id):
    metodo_pago = get_object_or_404(MetodoPago, id=metodo_id)
    metodo_pago.delete()
    messages.success(request, "Método de pago eliminado correctamente.")
    return redirect('modulo1:agregar_metodo_pago')  # Redirige a la vista de agregar_metodo_pago

#------------de elimiar  cuotas las tarjetas de crédito  o metodo pago de factura 
# views.py
# apps/modulo1/views.py
from django.shortcuts import get_object_or_404, redirect
from apps.CarritoApp.models import CuotaInteres

def eliminar_cuota(request, cuota_id):
    cuota = get_object_or_404(CuotaInteres, id=cuota_id)
    metodo_id = cuota.metodo_pago.id
    cuota.delete()
    return redirect('modulo1:asignar_cuotas', metodo_id)

#----------------------------------------------------------------------------------

# views.py en modulo1
from django.http import FileResponse
from django.conf import settings
from django.shortcuts import get_object_or_404
from apps.CarritoApp.models import Factura
import os, json
from reportlab.pdfgen import canvas

def vista_prueba_pdf(request, factura_id):
    factura = get_object_or_404(Factura, id=factura_id)
    ruta_carpeta = os.path.join(settings.MEDIA_ROOT, 'facturas')
    os.makedirs(ruta_carpeta, exist_ok=True)

    print("🔴 Vista PRUEBA PDF ACTIVADA")
    nombre_pdf = f"factura_{factura.id}.pdf"
    ruta_pdf = os.path.join(ruta_carpeta, nombre_pdf)

    if not os.path.exists(ruta_pdf):
        
        pdf.drawString(100, y, f"Factura N°:vista_prueba_pdf {factura.numero_factura}")
        y -= 20
        pdf.setFont("Helvetica", 12)
        pdf.drawString(100, y, f"Fecha: {factura.fecha}")
        y -= 20
        pdf.drawString(100, y, f"Cliente: {factura.nombre_cliente} {factura.apellido_cliente}")
        y -= 20
        pdf.drawString(100, y, f"DNI: {factura.dni_cliente}")
        y -= 20
        pdf.drawString(100, y, f"Vendedor: {factura.vendedor}")
        y -= 20
        pdf.drawString(100, y, f"Método de Pago: {factura.metodo_pago}")
        y -= 20
        pdf.drawString(100, y, f"Número de Ticket: {factura.numero_tiket or '-'}")

        y -= 130
        pdf.setFont("Helvetica-Bold", 12)
        pdf.drawString(100, y, "Productos:")
        y -= 20
        pdf.setFont("Helvetica", 10)

        for producto in productos:
            pdf.drawString(110, y, f"{producto['nombre_producto']} x {producto['cantidad_vendida']} - ${producto['subtotal']}")
            y -= 20

        y -= 10
        pdf.setFont("Helvetica-Bold", 12)
        pdf.drawString(100, y, f"Total: ${factura.total}")
        pdf.save()

    return FileResponse(open(ruta_pdf, 'rb'), content_type='application/pdf')
#----------------------------------------------------------------------------------
from django.template.loader import get_template
from django.http import HttpResponse
from xhtml2pdf import pisa
from django.shortcuts import get_object_or_404
import json
from apps.CarritoApp.models import Factura

def generar_factura_pdf(request, factura_id):
    factura = get_object_or_404(Factura, id=factura_id)
    try:
        productos = json.loads(factura.detalle_productos)
    except json.JSONDecodeError:
        productos = []

    template = get_template('modulo1/factura_pdf_simple.html')
    html = template.render({'factura': factura, 'productos': productos})

    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = f'inline; filename=factura_{factura.id}.pdf'

    pisa_status = pisa.CreatePDF(html, dest=response)
    if pisa_status.err:
        return HttpResponse("Error al generar el PDF", status=500)

    return response

#----------------------------------------------------------------------------------
from django.http import JsonResponse
from apps.CarritoApp.models import CuotaInteres

def obtener_cuotas_tarjeta(request, tarjeta_nombre):
    cuotas = CuotaInteres.objects.filter(metodo_pago__tarjeta_nombre=tarjeta_nombre).values(
        'cantidad_cuotas', 'porcentaje_interes'
    ).order_by('cantidad_cuotas')

    # Renombrar las claves para que coincidan con el JS
    data = [
        {
            'cuotas': item['cantidad_cuotas'],
            'interes': float(item['porcentaje_interes']),
        }
        for item in cuotas
    ]

    return JsonResponse(data, safe=False)

#--------------------------------------------------------

from django.http import JsonResponse
from django.contrib.auth.models import User
from django.views.decorators.http import require_GET
from django.db.models import Q

@require_GET
def buscar_clientes(request):
    q = request.GET.get('q', '').strip()
    if q:
        usuarios = User.objects.filter(
            Q(first_name__icontains=q) | Q(last_name__icontains=q)
        )[:10]
        resultados = [
            {
                'first_name': u.first_name,
                'last_name': u.last_name,
                'dni_usuario': u.dni_usuario or '',
            }
            for u in usuarios
        ]
        return JsonResponse(resultados, safe=False)
    return JsonResponse([], safe=False)
