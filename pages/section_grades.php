<?php
include '../db.php';
?>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../style.css">
    <title>Grade Report</title>
</head>
<body>

<a href="../index.php">Home</a> > Course Sections
<h1>Grade Distribution</h1>

<form method="GET">
    Course Number:
    <input type="text" name="course_no">

    Section Number:
    <input type="number" name="section_no">

    <input type="submit" value="Search">
</form>

<?php

if (isset($_GET['course_no']) && isset($_GET['section_no'])) {

    $course_no = $_GET['course_no'];
    $section_no = $_GET['section_no'];

    $sql = "SELECT grade, COUNT(*) AS total
                FROM Enrollments
            WHERE course_no = ?
            AND section_no = ?
            GROUP BY grade";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("si", $course_no, $section_no);
    $stmt->execute();

    $result = $stmt->get_result();

    echo "<table border='1'>";
    echo "<tr>
            <th>Grade</th>
            <th>Count</th>
          </tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>{$row['grade']}</td>";
        echo "<td>{$row['total']}</td>";
        echo "</tr>";
    }

    echo "</table>";
}
?>

</body>
</html>