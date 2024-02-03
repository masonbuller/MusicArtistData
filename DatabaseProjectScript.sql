/*Mason Buller*/
/*SQL Server*/

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'MusicArtistMCB')
BEGIN
	DROP DATABASE MusicArtistMCB;
END;
CREATE DATABASE MusicArtistMCB;
GO

USE MusicArtistMCB;

IF OBJECT_ID(N'dbo.Albums', N'U') IS NOT NULL
	DROP TABLE [dbo].[Albums];
CREATE TABLE Albums (
AlbumID int IDENTITY(1, 1) NOT NULL,
AlbumName varchar(70) NOT NULL,
CONSTRAINT pkAlbums PRIMARY KEY(AlbumID) );

IF OBJECT_ID(N'dbo.Labels', N'U') IS NOT NULL
	DROP TABLE [dbo].[Labels];
CREATE TABLE Labels (
LabelID int IDENTITY(1, 1) NOT NULL,
LabelName varchar(50) NOT NULL,
LabelStreet varchar(50) NOT NULL,
LabelCity varchar(25) NOT NULL,
LabelState varchar(2) NOT NULL,
LabelZip varchar(5) NOT NULL,
LabelPhone varchar(14) NOT NULL,
CONSTRAINT pkLabels PRIMARY KEY(LabelID) );

IF OBJECT_ID(N'dbo.Artists', N'U') IS NOT NULL
	DROP TABLE [dbo].[Artists];
CREATE TABLE Artists (
ArtistID int IDENTITY(1, 1) NOT NULL,
ArtistName varchar(50) NOT NULL,
LabelID int NOT NULL,
CONSTRAINT pkArtists PRIMARY KEY(ArtistID),
CONSTRAINT fkArtists FOREIGN KEY(LabelID) REFERENCES Labels(LabelID) );

IF OBJECT_ID(N'dbo.Songs', N'U') IS NOT NULL
	DROP TABLE [dbo].[Songs];
CREATE TABLE Songs (
SongID int IDENTITY(1, 1) NOT NULL,
AlbumID int NOT NULL,
ArtistID int NOT NULL,
SongName varchar(30) NOT NULL,
ReleaseDate date NOT NULL,
Duration int NOT NULL,
CONSTRAINT pkSongs PRIMARY KEY(SongID, AlbumID, ArtistID),
CONSTRAINT fkAlbumID FOREIGN KEY(AlbumID) REFERENCES Albums(AlbumID),
CONSTRAINT fkArtistID FOREIGN KEY(ArtistID) REFERENCES Artists(ArtistID) );

INSERT INTO Labels(LabelName, LabelStreet, LabelCity, LabelState, LabelZip, LabelPhone)
VALUES('Interscope Records', '2220 Colorado Ave', 'Santa Monica', 'CA', '90404', '(310) 865-1000'),
('Atlantic Records', '1633 Broadway', 'New York City', 'NY', '10019', '(212) 275-4952'),
('Colombia Records', '550 Madison Ave', 'New York City', 'NY', '10022', '(212) 833-8000'),
('RCA Records', '1201 Demonbreun St', 'Nashville', 'TN', '37203', '(615) 301-4300'),
('Legacy Recordings', '94 Cherry Valley', 'West Hempstead', 'NY', '11552', '(212) 822-4105'),
('Republic Records', '320 E 52nd St', 'New York City', 'NY', '10022', '(310) 865-4000'),
('Warner Records', '777 S Santa Fe Ave', 'Los Angeles', 'CA', '90021', '(818) 953-2600'),
('Epic Records', '2100 Colorado Blvd', 'Santa Monica', 'CA', '90404', '(310) 449-2100'),
('Island Records', '1755 Broadway', 'New York City', 'NY', '10019', '(310) 865-4000'),
('Capitol Records', '1750 Vine St', 'Los Angeles', 'CA', '90028', '(323) 462-6252'),
('Big Machine Records', '1219 16th Ave S', 'Nashville', 'TN', '37212', '(615) 324-7777'),
('Downtown Records', '485 Broadway Fl 3', 'New York City', 'NY', '10013', '(212) 625-2980'),
('Def Jam Recordings', '1755 Broadway', 'New York City', 'NY', '10019', '(310) 865-4000'),
('Motown Records', '1755 Broadway Fl 6', 'New York City', 'NY', '10019', '(212) 373-0750'),
('Alamo Records', '345 7th Ave', 'New York City', 'NY', '10001', '(646) 343-9634');


INSERT INTO Albums(AlbumName)
VALUES('21'),
('Fine Line'),
('Sour'),
('Happier Than Ever'),
('24k Magic'),
('Back of my Mind'),
('Thriller'),
('Sweetener'),
('Future Nostalgia'),
('Emotions'),
('Dancing with the Devil'),
('Divinely Uninspired to a Hellish Extent'),
('Anything Goes'),
('Friends Keep Secrets'),
('Purpose');

INSERT INTO Artists(ArtistName, LabelID)
VALUES('Justin Bieber', 13),
('Demi Lovato', 9),
('Ariana Grande', 6),
('Dua Lipa', 7),
('Florida Georgia Line', 11),
('Adele', 1),
('Bruno Mars', 3),
('Mariah Carey', 8),
('Lewis Capaldi', 10),
('Billie Eilish', 2),
('Harry Styles', 1),
('Olivia Rodrigo', 2),
('Michael Jackson', 5),
('Benny Blanco', 12), 
('H.E.R.', 4);

INSERT INTO Songs(AlbumID, ArtistID, SongName, ReleaseDate, Duration)
VALUES
(11, 2, 'Met Him Last Night', '2021-04-13', '204'),
(7, 13, 'Billie Jean', '1983-01-02', '294'),
(1, 6, 'Someone Like You', '2011-08-09', '245'),
(14, 14, 'Eastside', '2018-07-12', '173'),
(12, 9, 'Bruises', '2017-03-30', '218'),
(8, 3, 'God is a Woman', '2018-07-13', '197'),
(7, 13, 'Beat It', '1983-02-14', '258'),
(2, 11, 'Lights Up', '2019-10-11', '172'),
(10, 8, 'Cant Let Go', '1991-10-23', '267'),
(15, 1, 'Sorry', '2015-10-22', '200'),
(3, 12, 'Good 4 U', '2021-05-14', '178'),
(5, 7,'Thats What I Like', '2017-01-30', '206'),
(6, 15, 'Damage', '2020-10-21', '223'),
(13, 5, 'Dirt', '2014-07-08', '230'),
(15, 1, 'Love Yourself', '2015-11-09', '233'),
(4, 10, 'My Future', '2020-07-30', '208'),
(9, 4, 'Levitating', '2018-08-28', '203');

