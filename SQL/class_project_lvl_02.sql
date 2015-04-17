-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 15, 2015 at 08:08 PM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `class_project`
--
CREATE DATABASE IF NOT EXISTS `class_project` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `class_project`;

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE IF NOT EXISTS `notes` (
`notes_id` int(11) NOT NULL,
  `project` int(11) DEFAULT NULL,
  `member` int(11) DEFAULT NULL,
  `message` varchar(140) DEFAULT NULL,
  `tags` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
`pr_id` int(11) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `description` varchar(10000) DEFAULT NULL,
  `file_01` varchar(100) DEFAULT NULL,
  `file_02` varchar(100) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE IF NOT EXISTS `tasks` (
`t_id` int(11) NOT NULL,
  `message` varchar(1000) DEFAULT NULL,
  `deadline_day` date DEFAULT NULL,
  `deadline_time` time DEFAULT NULL,
  `assignee` int(11) DEFAULT NULL,
  `project` int(11) DEFAULT NULL,
  `time_assigned` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('incomplete','on-going','done') DEFAULT 'incomplete'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `team_project`
--

CREATE TABLE IF NOT EXISTS `team_project` (
`tp_id` int(11) NOT NULL,
  `member` int(11) NOT NULL,
  `project` int(11) NOT NULL,
  `clearance` enum('owner','regular','Instructor') NOT NULL DEFAULT 'regular'
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;



-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`user_id` int(11) NOT NULL,
  `first_name` varchar(25) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `pass_key` varchar(40) DEFAULT NULL,
  `authority` enum('Admin User','Standard User','Instructor') DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `user_name`, `pass_key`, `authority`) VALUES
(1, 'Carl', 'Yao', 'carl.yao', 'carl', 'Admin User'),
(2, 'David', 'Kafui', 'david.kafui', 'student', 'Standard User'),
(3, 'Teacher', 'One', 'teacher.one', 'teacher', 'Instructor'),
(4, 'Student', 'One', 'student.one', 'student', 'Standard User'),
(5, 'Student', 'Two', 'student.two', 'student', 'Standard User'),
(6, 'Student', 'Three', 'student.three', 'student', 'Standard User'),
(7, 'Student', 'Four', 'student.four', 'student', 'Standard User');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
 ADD PRIMARY KEY (`notes_id`), ADD KEY `project` (`project`), ADD KEY `member` (`member`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
 ADD PRIMARY KEY (`pr_id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
 ADD PRIMARY KEY (`t_id`), ADD KEY `tasks_ibfk_2` (`project`), ADD KEY `assignee` (`assignee`);

--
-- Indexes for table `team_project`
--
ALTER TABLE `team_project`
 ADD PRIMARY KEY (`tp_id`), ADD KEY `member` (`member`), ADD KEY `team_project_ibfk_2_idx` (`project`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
MODIFY `notes_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
MODIFY `pr_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
MODIFY `t_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `team_project`
--
ALTER TABLE `team_project`
MODIFY `tp_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `notes`
--
ALTER TABLE `notes`
ADD CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`project`) REFERENCES `projects` (`pr_id`),
ADD CONSTRAINT `notes_ibfk_2` FOREIGN KEY (`member`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`assignee`) REFERENCES `users` (`user_id`),
ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`project`) REFERENCES `projects` (`pr_id`);

--
-- Constraints for table `team_project`
--
ALTER TABLE `team_project`
ADD CONSTRAINT `team_project_ibfk_1` FOREIGN KEY (`member`) REFERENCES `users` (`user_id`),
ADD CONSTRAINT `team_project_ibfk_2` FOREIGN KEY (`project`) REFERENCES `projects` (`pr_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
