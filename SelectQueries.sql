/*Mason Buller*/
/*SQL Server*/
/*Database Project: Select Queries*/

use MusicArtistMCB;

/*AND*/
/*Q1: Which songs are longer than 3 minutes and were released after 2018?*/
SELECT SongName, ReleaseDate, Duration
FROM Songs
WHERE Duration > '180' AND ReleaseDate > '2018-12-31';
/*SongName                       ReleaseDate Duration
------------------------------ ----------- -----------
Met Him Last Night             2021-04-13  204
Damage                         2020-10-21  223
My Future                      2020-07-30  208

(3 rows affected)*/

/*OR*/
/*Q2: Which songs were released before 2010 or after 2020?*/
SELECT SongName, ReleaseDate
FROM Songs
WHERE ReleaseDate < '2010-01-01' OR ReleaseDate > '2020-12-31'
ORDER BY ReleaseDate asc;
/*SongName                       ReleaseDate
------------------------------ -----------
Billie Jean                    1983-01-02
Beat It                        1983-02-14
Cant Let Go                    1991-10-23
Met Him Last Night             2021-04-13
Good 4 U                       2021-05-14

(5 rows affected)*/

/*BETWEEN*/
/*Q3: Which songs were released between 1980 and 2010?*/
SELECT SongName, ReleaseDate
FROM Songs
WHERE ReleaseDate BETWEEN '1980-01-01' AND '2010-12-31'
ORDER BY ReleaseDate asc;
/*SongName                       ReleaseDate
------------------------------ -----------
Billie Jean                    1983-01-02
Beat It                        1983-02-14
Cant Let Go                    1991-10-23

(3 rows affected)*/

/*TOP Values with a calculated field*/
/*Q4: What are the top 5 artists with the most total duration time?*/
SELECT TOP 5 concat(SUM(Duration / 60), ':', SUM(Duration % 60)) AS 'TotalTime', Artists.ArtistName
FROM Songs JOIN Artists ON Songs.ArtistID=Artists.ArtistID
GROUP BY ArtistName
ORDER BY TotalTime desc;
/*TotalTime                 ArtistName
------------------------- --------------------------------------------------
8:72                      Michael Jackson
6:73                      Justin Bieber
4:5                       Adele
4:27                      Mariah Carey
3:50                      Florida Georgia Line

(5 rows affected)*/

/*Calculated Field with Group By and Having*/
/*Q5: Which labels have more than one artist?*/
SELECT COUNT(Artists.LabelID) AS 'TotalArtists', LabelName
FROM Artists JOIN Labels ON Artists.LabelID=Labels.LabelID
GROUP BY Labels.LabelName HAVING COUNT(Artists.LabelID) > 1;
/*TotalArtists LabelName
------------ --------------------------------------------------
2            Atlantic Records
2            Interscope Records

(2 rows affected)*/

/*NOT*/
/*Q6: What are all the artists not from Colombia Records?*/
SELECT *
FROM Artists
WHERE NOT LabelID = 2;
/*ArtistID    ArtistName                                         LabelID
----------- -------------------------------------------------- -----------
1           Justin Bieber                                      13
2           Demi Lovato                                        9
3           Ariana Grande                                      6
4           Dua Lipa                                           7
5           Florida Georgia Line                               11
6           Adele                                              1
7           Bruno Mars                                         3
8           Mariah Carey                                       8
9           Lewis Capaldi                                      10
11          Harry Styles                                       1
13          Michael Jackson                                    5
14          Benny Blanco                                       12
15          H.E.R.                                             4

(13 rows affected)*/

/*Outer Join*/
/*Q7: Which labels don't have any artists?*/
SELECT Labels.LabelID, Labels.LabelName, Artists.ArtistName
FROM Labels LEFT OUTER JOIN Artists ON Labels.LabelID = Artists.LabelID
WHERE ArtistName IS NULL;
/*LabelID     LabelName                                          ArtistName
----------- -------------------------------------------------- --------------------------------------------------
14          Motown Records                                     NULL
15          Alamo Records                                      NULL

(2 rows affected)*/

/*Subquery*/
/*Q8: What is the label name for the artist with the ID 2?*/
SELECT LabelName
FROM Labels 
WHERE LabelID IN
	(SELECT LabelID
	 FROM Artists
	 WHERE ArtistID = 2);
/*LabelName
--------------------------------------------------
Island Records

(1 row affected)*/
