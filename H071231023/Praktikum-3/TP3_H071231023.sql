-- CREATE DATABASE rifky;

-- USE rifky;

-- CREATE TABLE dosen(
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
--     nama varchar(100) NOT NULL,
--     NID char(10) NOT NULL UNIQUE
-- );

-- show tables

CREATE TABLE mahasiswa(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nama varchar(100) NOT NULL,
    NID char(10) NOT NULL UNIQUE,
    nilai float NOT NULL,
    tanggal date NOT NULL,
    keterangan text,
    pembingbing_id INT,
    FOREIGN KEY(pembingbing_id) REFERENCES dosen(id)
);

show databases;
show tables;

DESCRIBE mahasiswa;

alter table dosen
add

DROP TABLE mahasiswa;