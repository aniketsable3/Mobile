<?php
include("dbconnect.php");
$con = dbconnect();


if(isset($_POST["name"])){
    $name=$_POST["name"];
}
else return;
if(isset($_POST["email"])){
    $email=$_POST["email"];
}
else return;


$query = "UPDATE `user_table` SET `name`='$name' WHERE `email`='$email'";
$exe = mysqli_query($con, $query);

$arr=[];


if ($exe) {
    $response['status'] = 'success';
    $response['message'] = 'Record inserted successfully';
} else {
    $response['status'] = 'error';
    $response['message'] = 'Failed to insert record';
}

echo json_encode($response);

?>