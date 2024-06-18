<?php
include("dbconnect.php");
$con = dbconnect();

if(isset($_POST["sno"])){
    $sno=$_POST["sno"];
}
else return;
 
$query = "DELETE FROM `user_table` WHERE sno='$sno'";
$exe = mysqli_query($con, $query);

$response = [];

if ($exe) {
    $response['status'] = 'success';
    $response['message'] = 'Record inserted successfully';
} else {
    $response['status'] = 'error';
    $response['message'] = 'Failed to insert record';
}

echo json_encode($response);



?>