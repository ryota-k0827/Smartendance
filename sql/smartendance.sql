-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- ホスト: localhost
-- 生成日時: 2021 年 7 月 08 日 17:51
-- サーバのバージョン： 10.4.19-MariaDB
-- PHP のバージョン: 8.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `smartendance`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `attend`
--

CREATE TABLE `attend` (
  `no` int(11) NOT NULL COMMENT '科目No',
  `student_number` int(5) NOT NULL COMMENT '学籍番号',
  `attend_day` date NOT NULL COMMENT '出席日付',
  `attend_time` time NOT NULL COMMENT '出席時間',
  `status` int(1) NOT NULL COMMENT '1→出席,2→出席(遅刻),3→欠席'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- テーブルのデータのダンプ `attend`
--

INSERT INTO `attend` (`no`, `student_number`, `attend_day`, `attend_time`, `status`) VALUES
(6, 90000, '2021-06-26', '14:40:00', 1),
(7, 90000, '2021-06-26', '16:20:01', 1),
(15, 90000, '2021-06-25', '14:40:00', 1);

-- --------------------------------------------------------

--
-- テーブルの構造 `classes`
--

CREATE TABLE `classes` (
  `id` int(3) NOT NULL COMMENT 'id',
  `class_symbol` varchar(10) NOT NULL COMMENT 'クラス記号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='クラス';

--
-- テーブルのデータのダンプ `classes`
--

INSERT INTO `classes` (`id`, `class_symbol`) VALUES
(1, 'IH-13A-115'),
(2, 'IW-13A-120');

-- --------------------------------------------------------

--
-- テーブルの構造 `class_rooms`
--

CREATE TABLE `class_rooms` (
  `id` int(3) NOT NULL COMMENT 'id',
  `class_room` varchar(3) NOT NULL,
  `UUID` varchar(36) NOT NULL COMMENT 'UID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教室';

--
-- テーブルのデータのダンプ `class_rooms`
--

INSERT INTO `class_rooms` (`id`, `class_room`, `UUID`) VALUES
(1, '031', '00000000-ABCD-1234-ABCD-012345678901'),
(2, '032', '00000000-ABCD-1234-ABCD-012345678901'),
(3, '101', '00000000-ABCD-1234-ABCD-012345678901'),
(4, '191', '00000000-ABCD-1234-ABCD-012345678901');

-- --------------------------------------------------------

--
-- テーブルの構造 `class_times`
--

CREATE TABLE `class_times` (
  `times` int(1) NOT NULL COMMENT '時限',
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='授業時間帯';

--
-- テーブルのデータのダンプ `class_times`
--

INSERT INTO `class_times` (`times`, `start_time`, `end_time`) VALUES
(1, '09:30:00', '11:00:00'),
(2, '11:15:00', '12:45:00'),
(3, '13:00:00', '14:30:00'),
(4, '14:40:00', '16:10:00'),
(5, '16:20:00', '17:50:00'),
(6, '18:00:00', '19:30:00');

-- --------------------------------------------------------

--
-- テーブルの構造 `day_of_the_weeks`
--

CREATE TABLE `day_of_the_weeks` (
  `id` int(1) NOT NULL COMMENT 'id',
  `day_of_the_week` char(1) NOT NULL COMMENT '曜日'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='曜日';

--
-- テーブルのデータのダンプ `day_of_the_weeks`
--

INSERT INTO `day_of_the_weeks` (`id`, `day_of_the_week`) VALUES
(1, '月'),
(2, '火'),
(3, '水'),
(4, '木'),
(5, '金'),
(6, '土');

-- --------------------------------------------------------

--
-- テーブルの構造 `instructors`
--

CREATE TABLE `instructors` (
  `id` int(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'id',
  `roma_name` varchar(20) NOT NULL COMMENT '名前（ローマ字）',
  `name` varchar(20) NOT NULL COMMENT '名前（日本語）',
  `password` varchar(10) NOT NULL COMMENT 'パスワード'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教官';

--
-- テーブルのデータのダンプ `instructors`
--

INSERT INTO `instructors` (`id`, `roma_name`, `name`, `password`) VALUES
(06, 'kawashima.tom', '川島智弘', '1234'),
(15, 'kawata.hide', '河田英毅', '1234'),
(20, 'nagamine.hiro', '永峰弘万', '1234'),
(96, 'saito.shin', '齋藤新三', '1234'),
(97, 'yamamoto.yumi', '山本夕美子', '1234'),
(98, 'tanaka.shin', '田中信也', '1234'),
(99, 'yamada.tada', '山田忠明', '1234');

-- --------------------------------------------------------

--
-- テーブルの構造 `in_charge`
--

CREATE TABLE `in_charge` (
  `instructor_id` int(2) UNSIGNED ZEROFILL NOT NULL,
  `class_id` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='担当';

--
-- テーブルのデータのダンプ `in_charge`
--

INSERT INTO `in_charge` (`instructor_id`, `class_id`) VALUES
(15, 1),
(20, 2);

-- --------------------------------------------------------

--
-- テーブルの構造 `students`
--

CREATE TABLE `students` (
  `student_number` int(5) NOT NULL COMMENT '学籍番号',
  `classes_id` int(3) NOT NULL COMMENT '所属クラス',
  `attendance_number` int(2) UNSIGNED ZEROFILL NOT NULL COMMENT '出席番号',
  `name` varchar(20) NOT NULL COMMENT '名前',
  `password` varchar(10) NOT NULL COMMENT 'パスワード'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生';

--
-- テーブルのデータのダンプ `students`
--

INSERT INTO `students` (`student_number`, `classes_id`, `attendance_number`, `name`, `password`) VALUES
(90000, 1, 10, '金丸航大', '0921'),
(90001, 1, 09, '金子凌大', '9999'),
(90002, 1, 11, 'HAL太郎', '1234');

-- --------------------------------------------------------

--
-- テーブルの構造 `subjects`
--

CREATE TABLE `subjects` (
  `id` int(3) NOT NULL COMMENT 'id',
  `subject` varchar(4) NOT NULL COMMENT '科目名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='科目';

--
-- テーブルのデータのダンプ `subjects`
--

INSERT INTO `subjects` (`id`, `subject`) VALUES
(1, 'JV32'),
(2, 'SK31'),
(3, 'IO31'),
(4, 'FX31'),
(5, 'IH31'),
(6, 'BT31'),
(7, 'NT32'),
(8, 'ST31'),
(9, 'FE3S');

-- --------------------------------------------------------

--
-- テーブルの構造 `teaches`
--

CREATE TABLE `teaches` (
  `no` int(11) NOT NULL,
  `day_of_the_week` int(1) NOT NULL COMMENT '曜日',
  `time_id` int(1) NOT NULL COMMENT '時限',
  `classes_id` int(3) NOT NULL COMMENT 'クラス記号',
  `subject_id` int(3) NOT NULL COMMENT '科目名',
  `instructor_id` int(2) UNSIGNED ZEROFILL NOT NULL COMMENT '教官名',
  `class_room_id` int(3) NOT NULL COMMENT '教室番号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='授業';

--
-- テーブルのデータのダンプ `teaches`
--

INSERT INTO `teaches` (`no`, `day_of_the_week`, `time_id`, `classes_id`, `subject_id`, `instructor_id`, `class_room_id`) VALUES
(1, 1, 2, 1, 1, 99, 1),
(2, 1, 3, 1, 1, 99, 1),
(3, 2, 1, 1, 2, 15, 1),
(4, 2, 2, 1, 3, 98, 1),
(5, 2, 3, 1, 4, 15, 1),
(6, 2, 4, 1, 5, 06, 1),
(7, 2, 5, 1, 5, 06, 1),
(8, 3, 1, 1, 5, 06, 3),
(9, 3, 2, 1, 5, 06, 3),
(10, 4, 4, 1, 6, 97, 2),
(11, 4, 5, 1, 7, 15, 4),
(12, 4, 6, 1, 7, 15, 4),
(13, 5, 2, 1, 1, 96, 1),
(14, 5, 3, 1, 8, 96, 1),
(15, 5, 4, 1, 9, 98, 3);

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `attend`
--
ALTER TABLE `attend`
  ADD PRIMARY KEY (`no`,`student_number`,`attend_time`);

--
-- テーブルのインデックス `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `class_rooms`
--
ALTER TABLE `class_rooms`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `class_times`
--
ALTER TABLE `class_times`
  ADD PRIMARY KEY (`times`);

--
-- テーブルのインデックス `day_of_the_weeks`
--
ALTER TABLE `day_of_the_weeks`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `instructors`
--
ALTER TABLE `instructors`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `in_charge`
--
ALTER TABLE `in_charge`
  ADD PRIMARY KEY (`instructor_id`),
  ADD KEY `class_id` (`class_id`);

--
-- テーブルのインデックス `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_number`),
  ADD KEY `classes_id` (`classes_id`);

--
-- テーブルのインデックス `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `teaches`
--
ALTER TABLE `teaches`
  ADD PRIMARY KEY (`no`),
  ADD KEY `day_of_the_week` (`day_of_the_week`),
  ADD KEY `time_id` (`time_id`),
  ADD KEY `classes_id` (`classes_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `instructor_id` (`instructor_id`),
  ADD KEY `class_room_id` (`class_room_id`);

--
-- ダンプしたテーブルの制約
--

--
-- テーブルの制約 `attend`
--
ALTER TABLE `attend`
  ADD CONSTRAINT `attend_ibfk_1` FOREIGN KEY (`no`) REFERENCES `teaches` (`no`) ON UPDATE CASCADE;

--
-- テーブルの制約 `in_charge`
--
ALTER TABLE `in_charge`
  ADD CONSTRAINT `in_charge_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`id`),
  ADD CONSTRAINT `in_charge_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`);

--
-- テーブルの制約 `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`classes_id`) REFERENCES `classes` (`id`);

--
-- テーブルの制約 `teaches`
--
ALTER TABLE `teaches`
  ADD CONSTRAINT `teaches_ibfk_1` FOREIGN KEY (`day_of_the_week`) REFERENCES `day_of_the_weeks` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `teaches_ibfk_2` FOREIGN KEY (`time_id`) REFERENCES `class_times` (`times`) ON UPDATE CASCADE,
  ADD CONSTRAINT `teaches_ibfk_3` FOREIGN KEY (`classes_id`) REFERENCES `classes` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `teaches_ibfk_4` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `teaches_ibfk_5` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `teaches_ibfk_6` FOREIGN KEY (`class_room_id`) REFERENCES `class_rooms` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
