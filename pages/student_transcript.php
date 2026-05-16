<?php
include '../db.php';
?>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../style.css">
    <title>Student Transcript</title>
</head>
<body>

<a href="../index.php">Home</a> > Student Transcript
<h1>Student Transcript</h1>

<form method="GET">
    Student ID:
    <input type="number" name="student_id">

    <input type="submit" value="Search">
</form>

<?php

if (isset($_GET['student_id'])) {

    $student_id = $_GET['student_id'];

    $sql = "SELECT C.course_no, C.title, E.grade
                FROM Enrollments E
            JOIN Courses C
                ON  E.course_no = C.course_no
            WHERE E.student_id = ?";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $student_id);
    $stmt->execute();

    $result = $stmt->get_result();

    echo "<table border='1'>";
    echo "<tr>
            <th>Course Number</th>
            <th>Title</th>
            <th>Grade</th>
          </tr>";

    while ($row = $result->fetch_assoc()) {

        echo "<tr>";
        echo "<td>{$row['course_no']}</td>";
        echo "<td>{$row['title']}</td>";
        echo "<td>{$row['grade']}</td>";
        echo "</tr>";
    }

    echo "</table>";
}
?>

</body>
</html>