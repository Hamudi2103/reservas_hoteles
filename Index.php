<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Reserva de Hotel</title>
  <link rel="stylesheet" href="estilo.css">
</head>
<body>  
  <h1>Reserva de Hotel</h1>
  <form action="procesar_reserva.php" method="post">
    <label>Nombre:</label>
    <input type="text" name="nombre" required><br>
    <label>Apellido:</label>
    <input type="text" name="apellido" required><br>
    <label>Fecha Inicio:</label>
    <input type="date" name="fecha_inicio" required><br>
    <label>Fecha Fin:</label>
    <input type="date" name="fecha_fin" required><br>
    <label>Número de personas:</label>
    <input type="number" name="personas" min="1" required><br>
    <label>¿Desea traslado?:</label>
    <input type="checkbox" name="traslado"><br>
    <input type="submit" value="Reservar">
  </form>
</body>
</html>
