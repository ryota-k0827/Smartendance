<?php
    //swiftから送られてきた値
    $class_room_number = $_GET['class_room'];   //教室番号
    //$userId = $_GET['user_id']; //ユーザID（ローマ字）

    $day_of_the_week = date('w');  //本日の曜日の番号（0〜6）のいずれかを格納
    $date = date('Y-m-d');  //本日の日付を取得
    $time = date('H:i:s');  //現在の時間を取得


    echo $day_of_the_week;
    echo $time;
    //担当教官、クラス記号、科目名、曜日、開始時間、終了時間、クラス記号のidを取得するsql
    $link = mysqli_connect('localhost','root','','smartendance');
    mysqli_set_charset($link,'utf8');
    $data = mysqli_query($link,"SELECT roma_name,class_symbol,subject,teaches.day_of_the_week,start_time,end_time,classes_id,class_rooms.class_room
                                FROM teaches 
                                INNER JOIN instructors
                                ON teaches.instructor_id = instructors.id
                                INNER JOIN day_of_the_weeks
                                ON teaches.day_of_the_week = day_of_the_weeks.id
                                INNER JOIN class_times
                                ON teaches.time_id = class_times.times
                                INNER JOIN classes
                                ON teaches.classes_id = classes.id
                                INNER JOIN subjects
                                ON teaches.subject_id = subjects.id
                                INNER JOIN class_rooms
                                ON teaches.class_room_id = class_rooms.id
                                WHERE teaches.day_of_the_week = ".$day_of_the_week."
                                AND start_time <= '".$time."'
                                AND '".$time."' <= end_time
                                AND class_rooms.class_room = '".$class_room_number."'");

    $record = [];
    $cnt = 0;
    while($row = mysqli_fetch_assoc($data)){
        $record[] = $row;
        $cnt++;
    }

    var_dump($record);
    if($record != null){
        //欠席している生徒の出席番号と名前を取り出すsql
        $data1 = mysqli_query($link,"SELECT * FROM students WHERE NOT EXISTS (SELECT * FROM attend WHERE students.student_number = attend.student_number AND attend_day = '".$date."')");
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

        //クラスの人数を取り出すsql
        $data2 = mysqli_query($link,"SELECT COUNT(*) FROM students WHERE classes_id =".$record[0]['classes_id']);
        $record2 = [];
        while($row = mysqli_fetch_assoc($data2)){
            $record2[] = $row;
        }

        $ary_data = array(
            'classRoomNumber' => $class_room_number,    //教室番号
            'classSymbol' => $record[0]['class_symbol'],    //クラス記号
            'subject' => $record[0]['subject'], //科目名
            'number_of_attendees' => $cnt,  //出席者の人数
            'class_size' =>  $record2[0]["COUNT(*)"],   //クラスの人数
            'absenteeNumber' => $absenteeNumber,    //欠席者の出席（２次元配列）
            'absenteeName' => $absenteeName //欠席者の名前（２次元配列）
        );
    }else{
        $ary_data = array(
            'result' => 'この教室では授業がありません。'
        );
    }
    
    // 配列をjson_encode関数でJSON形式に変換します。
    echo json_encode($ary_data, JSON_UNESCAPED_UNICODE);
    mysqli_close($link);
?>