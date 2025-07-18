<?php
// conexion.php
$host = 'localhost';
$user = 'root';
$pass = '';
$db = 'negocio_fotografia';

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die('Error de conexión a la base de datos: ' . $conn->connect_error);
}
?>
