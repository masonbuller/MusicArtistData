/*Mason Buller*/
/*SQL Server*/

USE MusicArtistMCB;

/*Incorporates AND, OR, NOT, BETWEEN*/
IF OBJECT_ID('Between1980_vw') IS NULL
BEGIN
EXEC
('CREATE VIEW Between1980_vw
AS
SELECT SongName, ReleaseDate
FROM Songs
WHERE ReleaseDate BETWEEN ''1980-01-01'' AND ''2010-12-31''
ORDER BY ReleaseDate asc;')
END
GO

SELECT * FROM Between1980_vw;

/*SongName                       ReleaseDate
------------------------------ -----------
Billie Jean                    1983-01-02
Beat It                        1983-02-14
Cant Let Go                    1991-10-23

(3 rows affected)*/


/*Incorporates one aggregate function, group by, and having*/
IF OBJECT_ID('MoreThanOne_vw') IS NULL
BEGIN
EXEC
('CREATE VIEW MoreThanOne_vw
AS
SELECT COUNT(Artists.LabelID) AS ''TotalArtists'', LabelName
FROM Artists JOIN Labels ON Artists.LabelID=Labels.LabelID
GROUP BY Labels.LabelName 
HAVING COUNT(Artists.LabelID) > 1;')
END
GO

SELECT * FROM MoreThanOne_vw;

/*TotalArtists LabelName
------------ --------------------------------------------------
2            Atlantic Records
2            Interscope Records

(2 rows affected)*/


/*Incorporates an INNER join*/
IF OBJECT_ID('TotalSongTime_vw') IS NULL
BEGIN
EXEC
('CREATE VIEW TotalSongTime_vw
AS
SELECT concat(SUM(Duration / 60), '':'', SUM(Duration % 60)) AS ''TotalTime'', Artists.ArtistName
FROM Songs JOIN Artists ON Songs.ArtistID=Artists.ArtistID
GROUP BY ArtistName;')
END
GO

SELECT * FROM TotalSongTime_vw;

/*TotalTime                 ArtistName
------------------------- --------------------------------------------------
4:5                       Adele
3:17                      Ariana Grande
2:53                      Benny Blanco
3:28                      Billie Eilish
3:26                      Bruno Mars
3:24                      Demi Lovato
3:23                      Dua Lipa
3:50                      Florida Georgia Line
3:43                      H.E.R.
2:52                      Harry Styles
6:73                      Justin Bieber
3:38                      Lewis Capaldi
4:27                      Mariah Carey
8:72                      Michael Jackson
2:58                      Olivia Rodrigo

(15 rows affected)*/


/*Incorporates an OUTER join*/
IF OBJECT_ID('LabelNoArtist_vw') IS NULL
BEGIN
EXEC
('CREATE VIEW LabelNoArtist_vw
AS
SELECT Labels.LabelID, Labels.LabelName, Artists.ArtistName
FROM Labels LEFT OUTER JOIN Artists ON Labels.LabelID = Artists.LabelID
WHERE ArtistName IS NULL;')
END
GO

SELECT * FROM LabelNoArtist_vw;
/*LabelID     LabelName                                          ArtistName
----------- -------------------------------------------------- --------------------------------------------------
14          Motown Records                                     NULL
15          Alamo Records                                      NULL

(2 rows affected)*/


/*Incorporates a subquery*/
IF OBJECT_ID('ArtistID2_vw') IS NULL
BEGIN
EXEC
('CREATE VIEW ArtistID2_vw
AS
SELECT LabelName
FROM Labels
WHERE LabelID IN
	(SELECT LabelID
	 FROM Artists
	 WHERE ArtistID = 2);')
END
GO

SELECT * FROM ArtistID2_vw;

/*LabelName
--------------------------------------------------
Island Records

(1 row affected)*/