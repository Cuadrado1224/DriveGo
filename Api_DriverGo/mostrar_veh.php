<?php
header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: GET");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

include 'bd.php';

try {
    $query = "SELECT * FROM VEHICULOS";
    $stmt = $conn->prepare($query);
    $stmt->execute();

    if ($stmt->rowCount() > 0) {
        $vehiculos = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $response = array(
            "status" => true,
            "message" => "Datos extraidos con exito",
            "data" => $vehiculos
        );
       
    } else {
        $response = array(
            "status" => false,
            "message" => "No existen datos " . $e->getMessage()
        );
    }
} catch (PDOException $e) {
    $response = array(
        "status" => false,
        "message" => "Error al traer los datos " . $e->getMessage()
    );
}

$conn = null;
header('Content-Type: application/json');
echo json_encode($response);
?>