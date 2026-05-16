<?php
include 'db.php';
?>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
    <title>Professor Schedule</title>
</head>
<body>

<a href="../index.php">Home</a> > Professor Schedule
<h1>Professor Schedule</h1>

<form method="GET">
    Professor SSN:
    <input type="text" name="ssn">
    <input type="submit" value="Search">
</form>

<?php

if (isset($_GET['ssn'])) {

    $ssn = $_GET['ssn'];

    $sql = "SELECT C.title,
                S.classroom,
                S.meeting_days,
                S.begin_time,
                S.end_time
            FROM Sections S
            JOIN Courses C
                ON S.course_no = C.course_no
            WHERE S.professor_ssn = ?";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $ssn);
    $stmt->execute();

    $result = $stmt->get_result();

    echo "<table border='1'>";
    echo "<tr>
            <th>Course</th>
            <th>Classroom</th>
            <th>Days</th>
            <th>Begin</th>
            <th>End</th>
          </tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>{$row['title']}</td>";
        echo "<td>{$row['classroom']}</td>";
        echo "<td>{$row['meeting_days']}</td>";
        echo "<td>{$row['begin_time']}</td>";
        echo "<td>{$row['end_time']}</td>";
        echo "</tr>";
    }

    echo "</table>";
}
?>

</body>
</html>