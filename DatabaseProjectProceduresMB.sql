/*Mason Buller*/
/*SQL Server*/
/*Stored Procedures*/

use MusicArtistMCB;


/*Procedure 1*/
IF EXISTS (SELECT name FROM sysobjects
		WHERE name = 'SongInformationProc' AND type = 'P')
	DROP PROCEDURE SongInformationProc
GO
CREATE PROCEDURE SongInformationProc
AS
BEGIN
SELECT Artists.ArtistName, Labels.LabelName, Albums.AlbumName, Songs.SongName, CONVERT(varchar, ReleaseDate, 107) AS 'SongReleaseDate', concat(Duration/60, ':', Duration%60) AS 'Duration'
FROM Labels JOIN Artists ON Labels.LabelID=Artists.ArtistID
JOIN Songs ON Artists.ArtistID=Songs.ArtistID
JOIN Albums ON Songs.AlbumID=Albums.AlbumID
ORDER BY Artists.ArtistName;
END;
GO

EXEC SongInformationProc;
/*ArtistName                                         LabelName                                          AlbumName                                                              SongName                       SongReleaseDate                Duration
-------------------------------------------------- -------------------------------------------------- ---------------------------------------------------------------------- ------------------------------ ------------------------------ -------------------------
Adele                                              Republic Records                                   21                                                                     Someone Like You               Aug 09, 2011                   4:5
Ariana Grande                                      Colombia Records                                   Sweetener                                                              God is a Woman                 Jul 13, 2018                   3:17
Benny Blanco                                       Motown Records                                     Friends Keep Secrets                                                   Eastside                       Jul 12, 2018                   2:53
Billie Eilish                                      Capitol Records                                    Happier Than Ever                                                      My Future                      Jul 30, 2020                   3:28
Bruno Mars                                         Warner Records                                     24k Magic                                                              Thats What I Like              Jan 30, 2017                   3:26
Demi Lovato                                        Atlantic Records                                   Dancing with the Devil                                                 Met Him Last Night             Apr 13, 2021                   3:24
Dua Lipa                                           RCA Records                                        Future Nostalgia                                                       Levitating                     Aug 28, 2018                   3:23
Florida Georgia Line                               Legacy Recordings                                  Anything Goes                                                          Dirt                           Jul 08, 2014                   3:50
H.E.R.                                             Alamo Records                                      Back of my Mind                                                        Damage                         Oct 21, 2020                   3:43
Harry Styles                                       Big Machine Records                                Fine Line                                                              Lights Up                      Oct 11, 2019                   2:52
Justin Bieber                                      Interscope Records                                 Purpose                                                                Sorry                          Oct 22, 2015                   3:20
Justin Bieber                                      Interscope Records                                 Purpose                                                                Love Yourself                  Nov 09, 2015                   3:53
Lewis Capaldi                                      Island Records                                     Divinely Uninspired to a Hellish Extent                                Bruises                        Mar 30, 2017                   3:38
Mariah Carey                                       Epic Records                                       Emotions                                                               Cant Let Go                    Oct 23, 1991                   4:27
Michael Jackson                                    Def Jam Recordings                                 Thriller                                                               Beat It                        Feb 14, 1983                   4:18
Michael Jackson                                    Def Jam Recordings                                 Thriller                                                               Billie Jean                    Jan 02, 1983                   4:54
Olivia Rodrigo                                     Downtown Records                                   Sour                                                                   Good 4 U                       May 14, 2021                   2:58

(17 rows affected)*/



/*Procedure 2*/
IF EXISTS (SELECT name FROM sysobjects
		WHERE name = 'SongReleaseDateProc' AND type = 'P')
	DROP PROCEDURE SongReleaseDateProc
GO
CREATE PROCEDURE SongReleaseDateProc
	@ReleaseDate varchar(20) OUTPUT,
	@SongName varchar(20)
AS
BEGIN
SELECT @ReleaseDate = convert(varchar, ReleaseDate, 107)
FROM Songs
WHERE @SongName = SongName
PRINT @SongName + ' was released on ' + @ReleaseDate;
END
GO

DECLARE @MyReleaseDate varchar(10);
exec SongReleaseDateProc @MyReleaseDate OUTPUT, @SongName = 'Eastside';
/*Eastside was released on Jul 12, 2018*/

DECLARE @MyReleaseDate2 varchar(10);
exec SongReleaseDateProc @MyReleaseDate2 OUTPUT, @SongName = 'Lights Up';
/*Lights Up was released on Oct 11, 2019*/

