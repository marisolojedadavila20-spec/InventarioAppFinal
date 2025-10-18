<?php
// Configuración de la base de datos
define('DB_HOST', 'localhost');
define('DB_USER', 'root'); 
define('DB_PASSWORD', ''); 
define('DB_NAME', 'inventario_tienda');
define('DB_CHARSET', 'utf8mb4');

class Conexion {
    private static $conexion = null;

    public static function obtenerConexion() {
        if (self::$conexion === null) {
            try {
                $dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=' . DB_CHARSET;
                self::$conexion = new PDO($dsn, DB_USER, DB_PASSWORD);
                self::$conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                self::$conexion->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            } catch (PDOException $e) {
                // Si la conexión falla, se detiene y envía error JSON
                http_response_code(500); 
                echo json_encode([
                    'success' => false,
                    'message' => 'Error de conexión a la base de datos: ' . $e->getMessage()
                ]);
                exit();
            }
        }
        return self::$conexion;
    }
}
// NOTA: No cierres la etiqueta ?>