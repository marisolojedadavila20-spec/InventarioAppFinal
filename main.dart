import 'package:flutter/material.dart';
import 'screens/lista_productos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventario de Tienda',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const ListaProductos(),
    );
  }
}
