import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/producto.dart';

class InventarioService {
  // 🔗 URL base del backend PHP
  // Usa localhost si estás corriendo en Flutter Web (Chrome)
  // Usa 10.0.2.2 si estás corriendo en un emulador Android
  static const String baseUrl = 'http://localhost/api_inventario/api_inventario.php';
  // Si usas emulador Android, cambia a:
  // static const String baseUrl = 'http://10.0.2.2/api_inventario/api_inventario.php';

  // 🔹 Obtener todos los productos
  static Future<List<Producto>> obtenerProductos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        List productos = data['data'];
        return productos.map((e) => Producto.fromJson(e)).toList();
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception("Error al conectar con el servidor (${response.statusCode})");
    }
  }

  // 🔹 Agregar un nuevo producto
  static Future<bool> agregarProducto(Producto producto) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(producto.toJson()),
    );
    final data = json.decode(response.body);
    return data['success'] == true;
  }

  // 🔹 Actualizar un producto existente
  static Future<bool> actualizarProducto(Producto producto) async {
    final response = await http.put(
      Uri.parse("$baseUrl?id=${producto.id}"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(producto.toJson()),
    );
    final data = json.decode(response.body);
    return data['success'] == true;
  }

  // 🔹 Eliminar un producto
  static Future<bool> eliminarProducto(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl?id=$id"));
    final data = json.decode(response.body);
    return data['success'] == true;
  }
}
