-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 03, 2015 at 09:02 PM
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
) ;
-- ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`pr_id`, `title`, `description`, `file_01`, `file_02`, `date_created`) VALUES
(1, 'Competitive Strategy', 'Complete assignment 1 as a group (10 questions)', NULL, NULL, '2015-02-02 17:53:45'),
(2, 'Text and Meaning', ' present chapter 1 to the class on Tuesday', NULL, NULL, '2015-02-02 17:53:45'),
(3, 'Design', 'create a library experience for students of Adesua Ye', NULL, NULL, '2015-02-17 15:50:43'),
(4, 'Social Theory', 'Analyse the differences between the three waves of feminism (5 pages)', NULL, NULL, '2015-02-17 15:52:18'),
(5, 'Software Engineering final group work', 'work on FundAct with 4 others', NULL, NULL, '2015-02-28 15:44:44'),
(6, 'Social Research Methods final project work', 'Boring things to do with boring guys', NULL, NULL, '2015-02-28 16:05:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `projects`
-- --
-- ALTER TABLE `projects`
--  ADD PRIMARY KEY (`pr_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `projects`
--
-- ALTER TABLE `projects`
-- MODIFY `pr_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
