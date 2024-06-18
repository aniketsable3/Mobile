<?php
include("dbconnect.php");
$con = dbconnect();

$name = $_POST['name'];
$email = $_POST['email'];


$query = "INSERT INTO `user_table` (`sno`, `name`, `email`) VALUES (NULL, '$name', '$email');";
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
