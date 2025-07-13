<?php
session_start();
// Recuperar datos de la sesión
$nombre_completo = $_SESSION['nombre_completo'];
$fecha_inicio = $_SESSION['fecha_inicio'];
$fecha_fin = $_SESSION['fecha_fin'];
$dias = $_SESSION['dias'];
$noches = $_SESSION['noches'];
$tarifas_hoteles = $_SESSION['tarifas']; // Renombrado para evitar conflicto con la variable $tarifas

// Asegurarse de que $dias y $noches sean números y no strings
$dias_int = (int)$dias;
$noches_int = (int)$noches;

// Re-calcular si es necesario, aunque ya vienen de procesar_reserva.php
if ($dias_int < 1) {
    $dias_int = (strtotime($fecha_fin) - strtotime($fecha_inicio)) / (60 * 60 * 24);
    if ($dias_int < 1) $dias_int = 1; // Asegurar al menos 1 día
    $noches_int = $dias_int - 1;
    if ($noches_int < 0) $noches_int = 0; // Asegurar al menos 0 noches
}

?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Resumen de Paquetes</title>
  <link rel="stylesheet" href="estilo.css">
  <style>
    /* Estilos adicionales para la selección de hotel */
    .hotel-selection-container {
        display: flex;
        flex-direction: column;
        gap: 15px; /* Espacio entre los elementos */
        margin-top: 20px;
    }
    .hotel-option {
        background-color: #e9f5f9; /* Fondo claro para cada opción */
        padding: 15px;
        border-left: 5px solid #007bff; /* Borde azul a la izquierda */
        border-radius: 8px;
        display: flex;
        align-items: center;
        transition: background-color 0.3s ease;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1); /* Sombra suave */
    }
    .hotel-option:hover {
        background-color: #d1eff6;
    }
    .hotel-option input[type="radio"] {
        margin-right: 15px;
        transform: scale(1.5); /* Aumenta el tamaño del radio button */
    }
    .hotel-option label {
        font-size: 1.2em;
        font-weight: bold;
        color: #333;
        flex-grow: 1; /* Permite que el label ocupe el espacio restante */
    }
    .hotel-option span {
        font-size: 1.1em;
        color: #007bff;
        font-weight: bold;
    }
    .select-hotel-button {
        background-color: #007bff; /* Azul para el botón de selección */
        color: white;
        padding: 15px 30px;
        border: none;
        border-radius: 8px;
        font-size: 1.3em;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s ease;
        margin-top: 30px;
        align-self: center; /* Centra el botón en el flex container */
    }
    .select-hotel-button:hover {
        background-color: #0056b3;
        transform: translateY(-2px);
    }

    /* Estilos para el layout general y las columnas (ver imagen de referencia) */
    body {
        display: flex;
        flex-direction: column; /* Cambia a columna para un mejor control del flujo principal */
        align-items: center; /* Centra el contenido horizontalmente */
        padding: 20px;
        background-color: #e0f7fa; /* Fondo más claro y azulado para la página */
        color: #333;
        font-family: Arial, sans-serif;
    }
    h1, h2, h3 {
        color: #007bff; /* Títulos azules */
    }
    .main-content {
        display: flex;
        flex-wrap: wrap; /* Permite que las columnas se envuelvan en pantallas pequeñas */
        justify-content: center; /* Centra los bloques horizontalmente */
        gap: 40px; /* Espacio entre las columnas */
        width: 100%;
        max-width: 1200px; /* Ancho máximo para el contenido */
        margin-top: 20px;
    }
    .column {
        background-color: #fff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        flex: 1; /* Permite que las columnas crezcan y se encojan */
        min-width: 300px; /* Ancho mínimo para las columnas */
    }
    .column ul {
        list-style: none; /* Quitar viñetas predeterminadas */
        padding: 0;
    }
    .column ul li {
        background-color: #f8f9fa;
        margin-bottom: 10px;
        padding: 12px;
        border-radius: 5px;
        border-left: 4px solid #6c757d; /* Borde sutil para los ítems */
    }
    .column ul li strong {
        color: #0056b3; /* Color para los nombres de hotel */
    }
  </style>
</head>
<body>
  <div class="main-content">
    <div class="column">
        <h1>Resumen de tu Paquete</h1>
        <p>Buen día <strong><?php echo $nombre_completo; ?></strong>, espero que se encuentre bien.</p>
        <p>Paquete disponible para: <strong><?php echo $fecha_inicio; ?></strong> hasta <strong><?php echo $fecha_fin; ?></strong><br>
        PLAN <?php echo $dias_int; ?> DÍAS / <?php echo $noches_int; ?> NOCHES</p>
    </div>

    <div class="column">
        <h2>Selecciona tu Hotel Preferido:</h2>
        <form action="confirmar_reserva.php" method="post" class="hotel-selection-container">
            <?php if (!empty($tarifas_hoteles)): ?>
              <?php foreach ($tarifas_hoteles as $hotel_info): ?>
                <div class="hotel-option">
                  <input type="radio" id="hotel_<?php echo $hotel_info['id_hotel']; ?>" name="hotel_seleccionado" value="<?php echo $hotel_info['id_hotel']; ?>" required>
                  <label for="hotel_<?php echo $hotel_info['id_hotel']; ?>">
                    <?php echo strtoupper($hotel_info['nombre']); ?>:
                  </label>
                  <span>$<?php echo number_format($hotel_info['total'], 2); ?></span>
                </div>
              <?php endforeach; ?>
            <?php else: ?>
                <p>No se encontraron tarifas de hoteles para las fechas seleccionadas. Por favor, intente con otras fechas o consulte con el administrador.</p>
            <?php endif; ?>

            <button type="submit" class="select-hotel-button">Confirmar Reserva</button>
        </form>
    </div>

    <div class="column">
        <h3>El paquete enviado incluye:</h3>
        <ul>
            <li>Traslado ida y vuelta desde el terminal de ferrys hasta el hotel de su preferencia</li>
            <li>Desayuno, almuerzo y cena</li>
            <li>Snack de media tarde</li>
            <li>Bebidas alcohólicas y no alcohólicas de 11:00am a 11:00pm</li>
            <li>Uso de piscinas</li>
            <li>Bar en la piscina</li>
            <li>Gimnasio y resto de las instalaciones del hotel</li>
        </ul>
    </div>
  </div>
</body>
</html>