<?php

function dbconnect(){
    $con=mysqli_connect("localhost","root","","mmcrud");
    return $con;
}

?>