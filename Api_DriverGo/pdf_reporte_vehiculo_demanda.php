<?php
require('../FPDF/fpdf.php');
require_once 'bd.php';

$sql = "SELECT 
            v.mat_veh,
            v.mar_veh,
            v.mod_veh,
            COUNT(r.id_res) AS cantidad_reservas
        FROM reservas r
        INNER JOIN vehiculos v ON r.matricula_veh = v.mat_veh
        GROUP BY v.mat_veh, v.mar_veh, v.mod_veh
        ORDER BY cantidad_reservas DESC";
$stmt = $conn->prepare($sql);
$stmt->execute();
$vehiculos = $stmt->fetchAll(PDO::FETCH_ASSOC);

if (!$vehiculos) {
    echo json_encode(["error" => "No se encontraron datos de reservas para generar el reporte."]);
    exit;
}

class PDF extends FPDF {
    function Header() {
        $this->SetFillColor(0, 102, 204);
        $this->Rect(0, 0, 210, 30, 'F');
        $this->Image('../public/DriveGo-02-01.png', 150, 0, 50);
        $this->SetFont('Arial', 'B', 20);
        $this->SetTextColor(255, 255, 255);
        $this->Cell(170, 15, iconv("UTF-8","ISO-8859-1","Reporte de Vehículos Más Usados"), 0, 1, 'L', false);
        $this->Ln(10);
    }

    function Footer() {
        $this->SetY(-15);
        $this->SetFont('Arial', 'I', 8);
        $this->SetTextColor(128, 128, 128);
        $this->Cell(0, 10, 'Pagina ' . $this->PageNo() . '/{nb}', 0, 0, 'C');
    }
}

$pdf = new PDF();
$pdf->AliasNbPages();
$pdf->AddPage();

$pdf->SetFont('Arial', 'B', 8);
$pdf->SetFillColor(0, 102, 204);
$pdf->SetTextColor(255, 255, 255);
$pdf->Cell(40, 10, 'Matricula', 1, 0, 'C', true);
$pdf->Cell(40, 10, 'Marca', 1, 0, 'C', true);
$pdf->Cell(40, 10, 'Modelo', 1, 0, 'C', true);
$pdf->Cell(40, 10, 'Cantidad de Reservas', 1, 1, 'C', true);

$pdf->SetFont('Arial', '', 8);
$pdf->SetTextColor(0, 0, 0);
foreach ($vehiculos as $vehiculo) {
    $pdf->Cell(40, 10, $vehiculo['mat_veh'], 1, 0, 'C');
    $pdf->Cell(40, 10, $vehiculo['mar_veh'], 1, 0, 'C');
    $pdf->Cell(40, 10, $vehiculo['mod_veh'], 1, 0, 'C');
    $pdf->Cell(40, 10, $vehiculo['cantidad_reservas'], 1, 1, 'C');
}

$pdf->Output('D', "reporte_vehiculos_mas_usados.pdf");
?>