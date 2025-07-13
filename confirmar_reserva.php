<?php
session_start();
include 'conexion.php'; 

if (!isset($_SESSION['nombre_completo']) || !isset($_POST['hotel_seleccionado'])) {
    
    header("Location: Index.php");
    exit;
}

$id_cliente = $_SESSION['id_cliente']; 
$id_hotel_seleccionado = intval($_POST['hotel_seleccionado']);


$tarifas_en_sesion = $_SESSION['tarifas'];
$hotel_final_seleccionado = null;

foreach ($tarifas_en_sesion as $hotel_info) {
    if ($hotel_info['id_hotel'] == $id_hotel_seleccionado) {
        $hotel_final_seleccionado = $hotel_info;
        break;
    }
}

if ($hotel_final_seleccionado === null) {
   
    echo "Error: Hotel seleccionado no encontrado en los datos de la sesión.";
    exit;
}


$nombre_hotel_final = $hotel_final_seleccionado['nombre'];
$total_final = $hotel_final_seleccionado['total'];


$nombre_cliente = $_SESSION['nombre_completo'];
$fecha_inicio = $_SESSION['fecha_inicio'];
$fecha_fin = $_SESSION['fecha_fin'];
$cantidad_personas = $_SESSION['personas'];
$traslado = $_SESSION['traslado'];
$precio_traslado = $_SESSION['precio_traslado'];


?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Confirmación de Reserva</title>
  <link rel="stylesheet" href="estilo.css">
  <style>
    body {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 100vh; 
        background-color: #e0f7fa;
        font-family: Arial, sans-serif;
        color: #333;
        text-align: center;
        padding: 20px;
    }
    h1 {
        color: #007bff;
        margin-bottom: 20px;
    }
    p {
        font-size: 1.1em;
        margin-bottom: 10px;
    }
    strong {
        color: #0056b3;
    }
    a {
        display: inline-block;
        margin-top: 30px;
        padding: 12px 25px;
        background-color: #28a745; 
        color: white;
        text-decoration: none;
        border-radius: 8px;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }
    a:hover {
        background-color: #218838;
        transform: translateY(-2px);
    }
  </style>
</head>
<body>
  <h1>¡Reserva Confirmada!</h1>
  <p>Gracias, <strong><?php echo $nombre_cliente; ?></strong>.</p>
  <p>Has seleccionado el <strong><?php echo $nombre_hotel_final; ?></strong>.</p>
  <p>Tu reserva es del <strong><?php echo $fecha_inicio; ?></strong> al <strong><?php echo $fecha_fin; ?></strong>.</p>
  <p>Costo total: <strong>$<?php echo number_format($total_final, 2); ?></strong></p>
  <p>Pronto recibirás un correo electrónico con los detalles de tu reserva.</p>
  <a href="Index.php">Volver al inicio</a>
</body>
</html>