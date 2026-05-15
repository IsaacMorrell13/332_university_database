<?php
include 'db.php';
?>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
    <title>Course Sections</title>
</head>
<body>

<h1>Course Sections</h1>

<form method="GET">
    Course Number:
    <input type="text" name="course_no">

    <input type="submit" value="Search">
</form>

<?php

if (isset($_GET['course_no'])) {

    $course_no = $_GET['course_no'];

    $sql = "SELECT S.section_no, S.classroom, S.meeting_days,
                S.begin_time, S.end_time, COUNT(E.student_id) AS enrolled_students
            FROM Sections S
            LEFT JOIN Enrollments E
                ON S.course_no = E.course_no
                AND S.section_no = E.section_no
            WHERE S.course_no = ?
            GROUP BY S.section_no";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $course_no);
    $stmt->execute();

    $result = $stmt->get_result();

    echo "<table border='1'>";
    echo "<tr>
            <th>Section</th>
            <th>Classroom</th>
            <th>Days</th>
            <th>Begin</th>
            <th>End</th>
            <th>Enrolled</th>
          </tr>";

    while ($row = $result->fetch_assoc()) {

        echo "<tr>";
        echo "<td>{$row['section_no']}</td>";
        echo "<td>{$row['classroom']}</td>";
        echo "<td>{$row['meeting_days']}</td>";
        echo "<td>{$row['begin_time']}</td>";
        echo "<td>{$row['end_time']}</td>";
        echo "<td>{$row['enrolled_students']}</td>";
        echo "</tr>";
    }

    echo "</table>";
}
?>

</body>
</html>