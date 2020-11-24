-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 24 Nov 2020 pada 05.34
-- Versi server: 10.3.16-MariaDB
-- Versi PHP: 7.3.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id15100838_absenudacoding`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_absent`
--

CREATE TABLE `tb_absent` (
  `id_absent` int(11) NOT NULL,
  `check_in` datetime DEFAULT NULL,
  `check_out` datetime DEFAULT NULL,
  `date_today` date NOT NULL,
  `place` varchar(125) NOT NULL,
  `check_in_by` int(11) DEFAULT NULL,
  `check_out_by` int(11) DEFAULT NULL,
  `jam_kerja` time NOT NULL DEFAULT '00:00:00',
  `lang_loc` varchar(100) NOT NULL,
  `long_loc` varchar(100) NOT NULL,
  `alamat` text DEFAULT NULL,
  `status` varchar(120) DEFAULT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_absent`
--

INSERT INTO `tb_absent` (`id_absent`, `check_in`, `check_out`, `date_today`, `place`, `check_in_by`, `check_out_by`, `jam_kerja`, `lang_loc`, `long_loc`, `alamat`, `status`, `id_user`) VALUES
(100, '2020-11-07 14:59:51', '2020-11-07 14:59:53', '2020-11-07', 'Solok', 9, 9, '08:00:00', '37.319935', '-122.0127867', '', '', 4),
(98, '2020-11-07 14:53:42', '2020-11-07 14:53:53', '2020-11-07', 'Solok', 9, 9, '08:00:00', '37.319935', '-122.0127867', '', '', 2),
(124, '2020-11-12 17:46:18', '2020-11-12 17:46:31', '2020-11-11', 'Solok', 9, 9, '08:00:00', '37.319935', '-122.0127867', '', '', 1),
(95, '2020-10-21 07:00:00', '2020-10-21 10:20:00', '2020-10-22', 'Solok', 9, 9, '08:00:00', '', '', '', '', 9),
(96, '2020-10-22 09:00:00', '2020-10-22 15:29:00', '2020-10-22', 'Solok', 9, 9, '08:00:00', '-6.222885', '106.8202051', '', '', 9),
(97, '2020-10-22 09:43:16', '2020-10-22 09:44:51', '2020-10-22', 'Solok', 9, 9, '08:00:00', '-7.086304', '110.9176349', '', '', 3),
(125, '2020-11-12 18:01:27', '2020-11-12 18:01:37', '2020-11-12', '9, Jl. Diponegoro No.Rt. 2, Rw. 7, Jogoloyo, Kec. Wonosalam, Kabupaten Demak, Jawa Tengah 59571, Indonesia', 9, 9, '08:00:00', '-6.9011817', '110.6357117', '', '', 1),
(126, '2020-11-13 06:15:32', '2020-11-13 06:15:43', '2020-11-13', 'Kabupaten Demak', 9, 9, '08:00:00', '-6.9011817', '110.6357117', NULL, NULL, 1),
(127, '2020-11-13 07:39:47', '2020-11-13 07:40:01', '2020-11-13', 'Kabupaten Demak', 16, 16, '08:00:00', '-6.9011817', '110.6357117', NULL, NULL, 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_role`
--

CREATE TABLE `tb_role` (
  `id_role` int(11) NOT NULL,
  `name_role` varchar(150) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_role`
--

INSERT INTO `tb_role` (`id_role`, `name_role`) VALUES
(1, 'Web Developer'),
(2, 'CEO'),
(3, 'Admin'),
(4, 'Staff');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_user`
--

CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL,
  `fullname_user` varchar(150) NOT NULL,
  `email_user` varchar(150) NOT NULL,
  `phone_user` varchar(50) NOT NULL,
  `photo_user` text DEFAULT NULL,
  `username_user` varchar(150) NOT NULL,
  `password_user` text NOT NULL,
  `id_role` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_user`
--

INSERT INTO `tb_user` (`id_user`, `fullname_user`, `email_user`, `phone_user`, `photo_user`, `username_user`, `password_user`, `id_role`) VALUES
(1, 'Sample', 'riskiadi@gmail.com', '089717182882', 'purple-background-images-48.jpg', 'riskiadi', '4297f44b13955235245b2497399d7a93', 2),
(2, 'Rizki Syaputra', 'rizki@udacoding.com', '0823462781937', 'rizki.jpg', 'rizkisyaputra', '4297f44b13955235245b2497399d7a93', 2),
(3, 'Muhammad Ihsan AlJundi', 'ihsan@udacoding.com', '08238237917491', 'ihsan.jpeg', 'ihsan', '4297f44b13955235245b2497399d7a93', 1),
(4, 'Siddiq', 'siddiq@gmail.com', '08228279189', 'dadik.jpg', 'admin', '4297f44b13955235245b2497399d7a93', 3),
(5, 'Imrotul Nurul Jannah', 'nurul@udacoding.com', '0823823812791', 'sample.png', 'Imrotul', '123123', 1),
(6, 'Yusmi Putra', 'yusmi@gmail.com', '082382381279', 'daput.jpg', 'Yusmi Putra', '123123', 1),
(9, 'RIZKI ADI SAPUTRA', 'riskiadi@gmail.comgmail.com', '089717182882', 'ded.jpg', 'riskiadi', '2ebdabc4b69285dac92af6fbfc88be67', 3),
(16, 'Alkalynx', 'alka@gmail.com', '083838299929', 'sample.png', 'alka', '3ab2d0087e0493ec9a9e782974b41876', 3),
(17, 'Rizal', 'rizal@gmail.com', '123123', 'sample.png', 'rizal', '4297f44b13955235245b2497399d7a93', 3);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tb_absent`
--
ALTER TABLE `tb_absent`
  ADD PRIMARY KEY (`id_absent`),
  ADD KEY `check_in_by` (`check_in_by`),
  ADD KEY `check_out_by` (`check_out_by`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `tb_role`
--
ALTER TABLE `tb_role`
  ADD PRIMARY KEY (`id_role`);

--
-- Indeks untuk tabel `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `id_role` (`id_role`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tb_absent`
--
ALTER TABLE `tb_absent`
  MODIFY `id_absent` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- AUTO_INCREMENT untuk tabel `tb_role`
--
ALTER TABLE `tb_role`
  MODIFY `id_role` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
