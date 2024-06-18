<?php
header('Content-Type: application/json');

$host = 'localhost'; // Your database host
$db = 'mmcrud'; // Your database name
$user = 'root'; // Your database username
$pass = ''; // Your database password

// Connect to the database
$conn = new mysqli($host, $user, $pass, $db);

// Check connection
if ($conn->connect_error) {
    echo json_encode(['status' => 'error', 'message' => 'Database connection failed: ' . $conn->connect_error]);
    exit();
}

// Capture POST data
$name = isset($_POST['name']) ? $conn->real_escape_string($_POST['name']) : '';
$email = isset($_POST['email']) ? $conn->real_escape_string($_POST['email']) : '';

if ($name && $email) {
    $query = "SELECT * FROM user_table WHERE name = '$name' AND email = '$email'";
    $result = $conn->query($query);

    if ($result && $result->num_rows > 0) {
        echo json_encode(['status' => 'success', 'message' => 'Login successful']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Invalid name or email']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Please fill all the fields']);
}

$conn->close();
?>
