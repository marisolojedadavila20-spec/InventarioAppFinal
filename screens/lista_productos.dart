import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../services/inventario_service.dart';
import 'agregar_producto.dart';
import 'detalle_producto.dart';
import 'editar_producto.dart'; // ⬅️ IMPORTACIÓN NECESARIA

class ListaProductos extends StatefulWidget {
  const ListaProductos({super.key});

  @override
  State<ListaProductos> createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  late Future<List<Producto>> _productos;

  @override
  void initState() {
    super.initState();
    _productos = InventarioService.obtenerProductos();
  }

  Future<void> _recargar() async {
    setState(() {
      _productos = InventarioService.obtenerProductos();
    });
  }

  Future<void> _eliminarProducto(int? id) async { // Usamos int? para manejar posible null
    if (id != null) {
      bool exito = await InventarioService.eliminarProducto(id);
      if (exito) _recargar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Productos"),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Producto>>(
        future: _productos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay productos disponibles"));
          }

          final productos = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _recargar,
            child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final p = productos[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.shopping_bag),
                    title: Text(p.nombre),
                    subtitle: Text("S/. ${p.precio.toStringAsFixed(2)} | Stock: ${p.stock}"),
                    
                    // ⬇️ CORRECCIÓN: SE USA ROW PARA INCLUIR EDITAR Y ELIMINAR ⬇️
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min, // Ocupa el menor espacio posible
                      children: <Widget>[
                        // ✅ BOTÓN DE EDITAR AGREGADO
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            // Navega y espera el resultado de la edición
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => EditarProducto(producto: p)),
                            );
                            _recargar(); // Recarga la lista para mostrar cambios
                          },
                        ),
                        // BOTÓN DE ELIMINAR (Tu botón original)
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _eliminarProducto(p.id),
                        ),
                      ],
                    ),
                    // ... (Tu onTap original)
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetalleProducto(producto: p)),
                    ).then((_) => _recargar()),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AgregarProducto()),
          );
          _recargar();
        },
      ),
    );
  }
}