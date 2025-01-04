<?php
require('../FPDF/fpdf.php');
require_once 'bd.php';

$data = json_decode(file_get_contents('php://input'), true);
if (!isset($data['anio']) || !isset($data['mes'])) {
    echo json_encode(["error" => "Faltan parámetros 'anio' o 'mes'."]);
    exit;
}

$anio = $data['anio'];
$mes = $data['mes'];

$sql_count = "SELECT COUNT(*) AS total_reportes
              FROM reservas r
              WHERE EXTRACT(YEAR FROM r.fec_res) = :anio AND EXTRACT(MONTH FROM r.fec_res) = :mes";
$stmt_count = $conn->prepare($sql_count);
$stmt_count->bindParam(':anio', $anio, PDO::PARAM_INT);
$stmt_count->bindParam(':mes', $mes, PDO::PARAM_INT);
$stmt_count->execute();
$result_count = $stmt_count->fetch(PDO::FETCH_ASSOC);
$total_reportes = $result_count['total_reportes'];

$sql = "SELECT 
            v.mat_veh,
            v.mar_veh,
            v.mod_veh,
            COUNT(r.id_res) AS cantidad_reservas
        FROM reservas r
        INNER JOIN vehiculos v ON r.matricula_veh = v.mat_veh
        WHERE EXTRACT(YEAR FROM r.fec_res) = :anio AND EXTRACT(MONTH FROM r.fec_res) = :mes
        GROUP BY v.mat_veh, v.mar_veh, v.mod_veh
        ORDER BY cantidad_reservas DESC";
$stmt = $conn->prepare($sql);
$stmt->bindParam(':anio', $anio, PDO::PARAM_INT);
$stmt->bindParam(':mes', $mes, PDO::PARAM_INT);
$stmt->execute();
$vehiculos = $stmt->fetchAll(PDO::FETCH_ASSOC);

if (!$vehiculos) {
    echo json_encode(["error" => "No se encontraron datos para el mes especificado."]);
    exit;
}

class PDF extends FPDF {
    function Header() {
        $this->SetFillColor(0, 102, 204);
        $this->Rect(0, 0, 210, 30, 'F');
        $this->Image('../public/DriveGo-02-01.png', 150, 0, 50);
        $this->SetFont('Arial', 'B', 20);
        $this->SetTextColor(255, 255, 255);
        $this->Cell(170, 15, iconv("UTF-8", "ISO-8859-1","Reporte Mensual de Vehículos"), 0, 1, 'L', false);
        $this->Ln(10);
    }

    function Footer() {
        $this->SetY(-15);
        $this->SetFont('Arial', 'I', 8);
        $this->SetTextColor(128, 128, 128);
        $this->Cell(0, 10, 'Página ' . $this->PageNo() . '/{nb}', 0, 0, 'C');
    }
}

$pdf = new PDF();
$pdf->AliasNbPages();
$pdf->AddPage();

$pdf->SetFont('Arial', 'B', 12);
$pdf->SetTextColor(0, 0, 0);
$pdf->Cell(0, 10, iconv("UTF-8", "ISO-8859-1",'Reporte de Vehículos Más Usados - Mes: ' . $anio . '-' . str_pad($mes, 2, '0', STR_PAD_LEFT)), 0, 1, 'L');
$pdf->Cell(0, 10, iconv("UTF-8", "ISO-8859-1","Número de Vehículos: $total_reportes"), 0, 1, 'L');
$pdf->Ln(5);

$pdf->SetFont('Arial', 'B', 10);
$pdf->SetFillColor(0, 102, 204);
$pdf->SetTextColor(255, 255, 255);
$pdf->Cell(40, 10, 'Matricula', 1, 0, 'C', true);
$pdf->Cell(40, 10, 'Marca', 1, 0, 'C', true);
$pdf->Cell(40, 10, 'Modelo', 1, 0, 'C', true);
$pdf->Cell(40, 10, 'Cantidad de Reservas', 1, 1, 'C', true);

$pdf->SetFont('Arial', '', 9);
$pdf->SetTextColor(0, 0, 0);

foreach ($vehiculos as $vehiculo) {
    $pdf->Cell(40, 10, $vehiculo['mat_veh'], 1, 0, 'C');
    $pdf->Cell(40, 10, $vehiculo['mar_veh'], 1, 0, 'C');
    $pdf->Cell(40, 10, $vehiculo['mod_veh'], 1, 0, 'C');
    $pdf->Cell(40, 10, $vehiculo['cantidad_reservas'], 1, 1, 'C');
}

$pdf->Output('D', 'reporte_vehiculos_mas_usados_' . $anio . '_' . $mes . '.pdf');
?>

?>