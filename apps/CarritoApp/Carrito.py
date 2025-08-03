class Carrito:
    def __init__(self, request):
        self.request = request
        self.session = request.session
        carrito = self.session.get("carrito")
        if not carrito:
            self.session["carrito"] = {}
            self.carrito = self.session["carrito"]
        else:
            self.carrito = carrito

    def agregar(self, producto):
        producto_id = str(producto.id)  # Renombramos para claridad
        if producto_id not in self.carrito:
            # Convertimos el precio a float antes de guardarlo en la sesión
            self.carrito[producto_id] = {
                "producto_id": producto.id,
                "nombre": producto.titulo,
                "precio_unitario": float(producto.precio),  # Convertimos a float
                "cantidad": 1,  # Inicializamos la cantidad
                "acumulado": float(producto.precio),  # Convertimos a float
            }
        else:
            # Si el producto ya está en el carrito, actualizamos la cantidad y el acumulado
            self.carrito[producto_id]["cantidad"] += 1
            self.carrito[producto_id]["acumulado"] += float(producto.precio)  # Convertimos a float
        self.guardar_carrito()


    def guardar_carrito(self):
        self.session["carrito"] = self.carrito
        self.session.modified = True

    def limpiar(self):
        """
        Este método limpia el carrito (elimina todos los productos).
        """
        self.carrito = {}  # Vaciamos el carrito
        self.guardar_carrito()  # Guardamos los cambios en la sesión
        

    def eliminar(self, producto):
        producto_id = str(producto.id)
        if producto_id in self.carrito:
            del self.carrito[producto_id]
            self.guardar_carrito()

    def restar(self, producto):
        producto_id = str(producto.id)
        if producto_id in self.carrito:
            self.carrito[producto_id]["cantidad"] -= 1
            self.carrito[producto_id]["acumulado"] -= float(producto.precio)  # Convertimos a float
            if self.carrito[producto_id]["cantidad"] <= 0:
                self.eliminar(producto)  # Si la cantidad llega a cero, eliminamos el producto
            self.guardar_carrito()

    def total(self):
        """
        Este método calcula el total sumando el acumulado de cada producto en el carrito.
        """
        total = 0
        for producto in self.carrito.values():
            total += producto["acumulado"]  # Sumamos el acumulado de cada producto
        return total
