import 'package:flutter/material.dart';
import '../models/producto.dart';
import 'editar_producto.dart';

class DetalleProducto extends StatelessWidget {
  final Producto producto;
  const DetalleProducto({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(producto.nombre),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EditarProducto(producto: producto)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Descripción: ${producto.descripcion}"),
            Text("Categoría: ${producto.categoria}"),
            Text("Precio: S/. ${producto.precio}"),
            Text("Stock: ${producto.stock}"),
            Text("Proveedor: ${producto.proveedor}"),
            Text("Activo: ${producto.activo ? 'Sí' : 'No'}"),
          ],
        ),
      ),
    );
  }
}
