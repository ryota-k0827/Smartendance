<?php
    //swiftのログインボタンが押された時
    if(isset($_GET['login'])){
        //swiftから送られてきた値
        $userId = $_GET['userId'];
        $password = $_GET['password'];

        //空白チェック
        if($userId != null && $password != null){   //入力されている場合
            //ユーザIDが数値かどうか
            if(preg_match('/^[0-9]+$/', $userId)){
                $sql = "SELECT * FROM students WHERE student_number = ".$userId." AND password = '".$password."'";
            }else{
                $sql = "SELECT * FROM instructors WHERE roma_name = '".$userId."' AND password = '".$password."'";
            }
            //sql
            $link = mysqli_connect('localhost','root','','smartendance');
            mysqli_set_charset($link,'utf8');
            $data = mysqli_query($link,$sql);
            mysqli_close($link);

            $record = mysqli_fetch_assoc($data);    //sqlから取り出した値を$recordに格納

            //入力されたuserIdとpasswordが一致したかどうか
            if($record != null){    //一致した場合
                //ユーザが学生か教官かどうか
                if(preg_match('/^[0-9]+$/', $userId)){  //学生の場合
                    $user_data = array(
                        'userId'=>$userId,
                        'name'=>$record['name'],
                        'type'=>'student',
                        'classId'=>$record['classes_id']
                    );
                }else{  //教官の場合
                    $user_data = array(
                        'userId'=>$userId,
                        'name'=>$record['name'],
                        'type'=>'instructor'
                    );
                }
                echo json_encode($user_data, JSON_UNESCAPED_UNICODE);
            }else{  //一致しなかった場合
                return;
            }
        }else{  //入力されていない場合
            return;
        }
    }

    require_once './tpl/login.php';