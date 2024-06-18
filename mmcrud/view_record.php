<?php
include("dbconnect.php");
$con = dbconnect();

$query = "SELECT * FROM `user_table`;";
$exe = mysqli_query($con, $query);

$arr = [];

if ($exe) {
    while ($row = mysqli_fetch_array($exe)) {
        $arr[] = $row;
    }
} else {
    $arr['status'] = 'error';
    $arr['message'] = 'Failed to fetch records';
}

echo json_encode($arr);
?>
