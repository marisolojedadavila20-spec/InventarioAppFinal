import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../services/inventario_service.dart';

class AgregarProducto extends StatefulWidget {
  const AgregarProducto({super.key});

  @override
  State<AgregarProducto> createState() => _AgregarProductoState();
}

class _AgregarProductoState extends State<AgregarProducto> {
  final _formKey = GlobalKey<FormState>();
  final producto = {
    'nombre': '',
    'descripcion': '',
    'codigo_barras': '',
    'categoria': '',
    'precio': '',
    'stock': '',
    'proveedor': '',
  };

  Future<void> _guardar() async {
    if (_formKey.currentState!.validate()) {
      final nuevo = Producto(
        id: 0,
        nombre: producto['nombre']!,
        descripcion: producto['descripcion']!,
        codigoBarras: producto['codigo_barras']!,
        categoria: producto['categoria']!,
        precio: double.parse(producto['precio']!),
        stock: int.parse(producto['stock']!),
        proveedor: producto['proveedor']!,
        activo: true,
      );
      bool exito = await InventarioService.agregarProducto(nuevo);
      if (exito && mounted) Navigator.pop(context);
    }
  }

  Widget campo(String label, String key, {bool num = false}) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: num ? TextInputType.number : TextInputType.text,
      validator: (v) => v == null || v.isEmpty ? 'Campo requerido' : null,
      onChanged: (v) => producto[key] = v,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Producto"), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              campo("Nombre", "nombre"),
              campo("Descripción", "descripcion"),
              campo("Código de Barras", "codigo_barras"),
              campo("Categoría", "categoria"),
              campo("Precio", "precio", num: true),
              campo("Stock", "stock", num: true),
              campo("Proveedor", "proveedor"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardar,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: const Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

