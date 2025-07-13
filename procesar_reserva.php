<?php
// Inicia la sesión al principio del script
session_start();
include 'conexion.php'; // Asegúrate de que esta ruta sea correcta

$nombre = $_POST['nombre'];
$apellido = $_POST['apellido'];
$fecha_inicio = $_POST['fecha_inicio'];
$fecha_fin = $_POST['fecha_fin'];
$personas = intval($_POST['personas']);
$traslado = isset($_POST['traslado']) ? 1 : 0;
$precio_traslado = $traslado ? floatval($_POST['precio_traslado']) : 0;

// 1. Insertar cliente
// Antes de insertar, verifica si el cliente ya existe para evitar duplicados, o gestiona el ID de alguna manera
$stmt_cliente = $conn->prepare("INSERT INTO clientes (nombre, apellido) VALUES (?, ?)");
$stmt_cliente->bind_param("ss", $nombre, $apellido);
$stmt_cliente->execute();
$id_cliente = $stmt_cliente->insert_id;
$stmt_cliente->close();

// 2. Calcular número de días y noches
$timestamp_inicio = strtotime($fecha_inicio);
$timestamp_fin = strtotime($fecha_fin);
$dias = ($timestamp_fin - $timestamp_inicio) / (60 * 60 * 24);
if ($dias < 1) $dias = 1; // Asegurar al menos 1 día
$noches = $dias - 1;
if ($noches < 0) $noches = 0; // Asegurar al menos 0 noches

// 3. Obtener hoteles
$hoteles_query = $conn->query("SELECT id, nombre FROM hoteles");

$tarifas_calculadas = [];

while ($hotel = $hoteles_query->fetch_assoc()) {
    $id_hotel = $hotel['id'];
    $nombre_hotel = $hotel['nombre'];

    // Consultar tarifa vigente por tipo para este hotel y fechas
    $stmt_tarifas = $conn->prepare("SELECT tipo_habitacion, precio FROM tarifas 
                                    WHERE id_hotel = ? 
                                    AND ? BETWEEN fecha_inicio AND fecha_fin");
    $stmt_tarifas->bind_param("is", $id_hotel, $fecha_inicio);
    $stmt_tarifas->execute();
    $res_tarifas = $stmt_tarifas->get_result();

    $precio_total_hotel = 0;

    // Mapear precios por tipo de habitación para fácil acceso
    $precios_habitacion = [];
    while ($tarifa_row = $res_tarifas->fetch_assoc()) {
        $precios_habitacion[$tarifa_row['tipo_habitacion']] = $tarifa_row['precio'];
    }
    $stmt_tarifas->close();

    // Calcular precio basado en el número de personas
    if ($personas == 1 && isset($precios_habitacion['sencilla'])) {
        $precio_total_hotel = $precios_habitacion['sencilla'] * $dias;
    } elseif ($personas >= 2 && isset($precios_habitacion['doble'])) {
        $precio_total_hotel = ceil($personas / 2) * $precios_habitacion['doble'] * $dias;
    } elseif ($personas >= 3 && isset($precios_habitacion['triple'])) {
        $precio_total_hotel = ceil($personas / 3) * $precios_habitacion['triple'] * $dias;
    } else {
        // Fallback si no hay tarifa específica o personas no encajan
        $precio_total_hotel = 0;
    }

    // Sumar el costo de traslado si aplica
    if ($traslado) {
        $precio_total_hotel += $precio_traslado;
    }

    // Guardar los datos del hotel y su tarifa calculada, incluyendo el ID
    $tarifas_calculadas[] = [
        'id_hotel' => $id_hotel,
        'nombre' => $nombre_hotel,
        'total' => $precio_total_hotel
    ];

    // Opcional: Guardar cada opción de reserva en la base de datos
    // Si solo quieres guardar la reserva FINALMENTE seleccionada, quita este INSERT de aquí
    // y mueve la lógica de inserción a confirmar_reserva.php después de la selección.
    $stmt_reserva = $conn->prepare("INSERT INTO reservas 
        (id_cliente, id_hotel, fecha_inicio, fecha_fin, cantidad_personas, traslado, precio_traslado, total)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt_reserva->bind_param("iisssidd", $id_cliente, $id_hotel, $fecha_inicio, $fecha_fin, $personas, $traslado, $precio_traslado, $precio_total_hotel);
    $stmt_reserva->execute();
    $stmt_reserva->close();
}

// Guardar los datos importantes en la sesión para resumen.php y confirmar_reserva.php
$_SESSION['nombre_completo'] = "$nombre $apellido";
$_SESSION['fecha_inicio'] = $fecha_inicio;
$_SESSION['fecha_fin'] = $fecha_fin;
$_SESSION['dias'] = $dias;
$_SESSION['noches'] = $noches;
$_SESSION['tarifas'] = $tarifas_calculadas;

// Guardar estas variables adicionales que se necesitan en confirmar_reserva.php
$_SESSION['id_cliente'] = $id_cliente;
$_SESSION['personas'] = $personas;
$_SESSION['traslado'] = $traslado;
$_SESSION['precio_traslado'] = $precio_traslado;

header("Location: resumen.php");
exit;
?>