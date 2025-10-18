import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../services/inventario_service.dart';

class EditarProducto extends StatefulWidget {
  final Producto producto;
  const EditarProducto({super.key, required this.producto});

  @override
  State<EditarProducto> createState() => _EditarProductoState();
}

class _EditarProductoState extends State<EditarProducto> {
  late TextEditingController nombreCtrl;
  late TextEditingController descripcionCtrl;
  late TextEditingController categoriaCtrl;
  late TextEditingController precioCtrl;
  late TextEditingController stockCtrl;

  @override
  void initState() {
    super.initState();
    nombreCtrl = TextEditingController(text: widget.producto.nombre);
    descripcionCtrl = TextEditingController(text: widget.producto.descripcion);
    categoriaCtrl = TextEditingController(text: widget.producto.categoria);
    precioCtrl = TextEditingController(text: widget.producto.precio.toString());
    stockCtrl = TextEditingController(text: widget.producto.stock.toString());
  }

  Future<void> _actualizar() async {
    final actualizado = Producto(
      id: widget.producto.id,
      nombre: nombreCtrl.text,
      descripcion: descripcionCtrl.text,
      codigoBarras: widget.producto.codigoBarras,
      categoria: categoriaCtrl.text,
      precio: double.parse(precioCtrl.text),
      stock: int.parse(stockCtrl.text),
      proveedor: widget.producto.proveedor,
      activo: widget.producto.activo,
    );
    await InventarioService.actualizarProducto(actualizado);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Producto"), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: nombreCtrl, decoration: const InputDecoration(labelText: "Nombre")),
            TextField(controller: descripcionCtrl, decoration: const InputDecoration(labelText: "Descripción")),
            TextField(controller: categoriaCtrl, decoration: const InputDecoration(labelText: "Categoría")),
            TextField(controller: precioCtrl, decoration: const InputDecoration(labelText: "Precio"), keyboardType: TextInputType.number),
            TextField(controller: stockCtrl, decoration: const InputDecoration(labelText: "Stock"), keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _actualizar,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text("Actualizar"),
            ),
          ],
        ),
      ),
    );
  }
}

