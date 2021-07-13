<?php
    $class_room_number = $_GET['class_room']; //swiftから送られてきた値
    $userId = $_GET['user_id'];
    $classes_id = $_GET['class_id'];

    $day_of_the_week = date('w');  //本日の曜日の番号（0〜6）のいずれかを格納
    $date = date('Y/m/d');
    $time = date('H:i:s');  //現在の時間を取得

    //sql
    $link = mysqli_connect('localhost','root','','smartendance');
    mysqli_set_charset($link,'utf8');
    $data = mysqli_query($link,"SELECT *
                                FROM teaches 
                                INNER JOIN class_rooms 
                                ON teaches.class_room_id = class_rooms.id 
                                INNER JOIN subjects 
                                ON teaches.subject_id = subjects.id 
                                INNER JOIN class_times 
                                ON teaches.time_id = class_times.times 
                                INNER JOIN classes
                                ON teaches.classes_id = classes.id
                                INNER JOIN attend
                                ON teaches.no = attend.no
                                WHERE class_room = ".$class_room_number."
                                AND classes_id = '".$classes_id."'
                                AND start_time <= '".$time."'
                                AND '".$time."' <= end_time");

    $record = [];
    $cnt = 0;
    while($row = mysqli_fetch_assoc($data)){
        $record[] = $row;
        $cnt++;
    }

    var_dump($record);

    $data1 = mysqli_query($link,"SELECT * FROM
                                students 
                                WHERE
                                NOT EXISTS (
                                    SELECT
                                    *
                                    FROM
                                    attend
                                    WHERE
                                    students.student_number = attend.student_number
                                )");
    $record1 = [];
    while($row = mysqli_fetch_assoc($data1)){
        $record1[] = $row;
    }

    $absenteeNumber = [];
    $absenteeName = [];
    $index = 0;
    foreach($record1 as $val){
        $absenteeNumber[] = $record1[$index]['attendance_number'];
        $absenteeName[] = $record1[$index]['name'];
        $index++;
    }

    $data2 = mysqli_query($link,"SELECT COUNT(*) FROM students WHERE classes_id =".$classes_id);
    $record2 = [];
    while($row = mysqli_fetch_assoc($data2)){
        $record2[] = $row;
    }

    var_dump($record2);
    $ary_data = array(
        'classRoomNumber' => $class_room_number,
        'classSymbol' => $record[0]['class_symbol'],
        'subject' => $record[0]['subject'],
        'number_of_attendees' => $cnt,
        'class_size' =>  $record2[0]["COUNT(*)"],
        'absenteeNumber' => $absenteeNumber,
        'absenteeName' => $absenteeName
    );

    // 配列をjson_encode関数でJSON形式に変換します。
    echo json_encode($ary_data, JSON_UNESCAPED_UNICODE);
    mysqli_close($link);
?>