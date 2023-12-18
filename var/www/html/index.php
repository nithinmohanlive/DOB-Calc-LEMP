<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Age Calculator</title>
</head>
<body>
    <h2>Enter Your Information</h2>
    <form action="" method="post">
        <label for="name">Name:</label>
        <input type="text" name="name" required>

        <label for="dob">Date of Birth:</label>
        <input type="date" name="dob" required>

        <button type="submit" name="submit">Submit</button>
    </form>

    <?php
    // Database connection details
    $servername = "localhost";
    $username = "nithin";
    $password = "P@t(h@2021";
    $dbname = "dob_db";
    
    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    
    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    
    // If the form is submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['submit'])) {
        $name = $_POST['name'];
        $dob = $_POST['dob'];
    
        // Calculate age
        $today = new DateTime();
        $birthdate = new DateTime($dob);
        $age = $today->diff($birthdate)->y;
    
        // Insert data into the database
        $sql = "INSERT INTO dob_table (name, dob, age) VALUES ('$name', '$dob', $age)";
    
        if ($conn->query($sql) === TRUE) {
            // Redirect to avoid form resubmission
            header("Location: " . $_SERVER['PHP_SELF']);
            exit();
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }
    }
    
    // Display current data in the table
    $result = $conn->query("SELECT * FROM dob_table");
    
    if ($result->num_rows > 0) {
        echo "<h2>Current Data in the Table</h2>";
        echo "<table border='1'>";
        echo "<tr><th>Name</th><th>Date of Birth</th><th>Age</th></tr>";
    
        while ($row = $result->fetch_assoc()) {
            echo "<tr><td>{$row['name']}</td><td>{$row['dob']}</td><td>{$row['age']}</td></tr>";
        }
    
        echo "</table>";
    } else {
        echo "<p>No data in the table.</p>";
    }
    
    // Close connection
    $conn->close();    
    ?>
</body>
</html>

