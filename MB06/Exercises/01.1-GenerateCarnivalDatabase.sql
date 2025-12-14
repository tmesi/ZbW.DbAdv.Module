USE master;
GO

-- drop database if exists
BEGIN TRY
	DROP DATABASE Carnival;
END TRY
BEGIN CATCH
-- database can't exist
END CATCH;

-- create new database
CREATE DATABASE Carnival;
GO

USE Carnival;
GO

CREATE TABLE [dbo].[tblMenu]
(
	[MenuId]		[INT]			IDENTITY(1, 1) NOT NULL,
	[MenuName]		[VARCHAR](50)	NULL,
	[ParentMenuId]	[INT]			NULL,
	[SortOrder]		[INT]			NULL,
	[Tooltip]		[VARCHAR](100)	NULL,
	[VisibleText]	[VARCHAR](100)	NULL,
	[WebPage]		[VARCHAR](50)	NULL,
	[FolderName]	[VARCHAR](50)	NULL,
	CONSTRAINT [PK_tblMenu]
		PRIMARY KEY CLUSTERED ([MenuId] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON
			) ON [PRIMARY]
) ON [PRIMARY];
GO
SET ANSI_PADDING OFF;
GO
SET IDENTITY_INSERT [dbo].[tblMenu] ON;
INSERT	[dbo].[tblMenu]
(
	[MenuId],
	[MenuName],
	[ParentMenuId],
	[SortOrder],
	[Tooltip],
	[VisibleText],
	[WebPage],
	[FolderName]
)
VALUES
(1, N'Home page', NULL, 0, N'Carnival home page', N'Carnival home', N'frmIndex', N'home'),
(2, N'Home - about carnival', 1, 10, N'About the 2010 carnival', N'2010 carnival', N'frmCarnival', N'carnival'),
(3, N'Home - photos', 1, 20, N'Photo gallery', N'Photo gallery', N'frmPhotos', N'photos'),
(4, N'Home - fell race', 1, 30, N'Senior and junior fell races', N'Fell races', N'frmFellRace', N'fellrace'),
(5, N'Home - scarecrows', 1, 40, N'Scarecrow competition', N'Scarecrows', N'frmScarecrow', N'scarecrow'),
(6, N'Home - help us', 1, 50, N'Carnival organisation', N'Help us', N'frmHelp', N'help'),
(7, N'About carnival - dates and times', 2, 10, N'Carnival date and times', N'Dates/times', N'frmWhen', N'carnival'),
(8, N'About carnival - on the field', 2, 20, N'Activities on the field', N'On the field', N'frmRec', N'carnival'),
(9, N'About carnival - parade', 2, 30, N'Carnival parade', N'The parade', N'frmParade', N'carnival'),
(10, N'About carnival - where', 2, 40, N'Where the carnival is', N'Where it happens', N'frmWhere', N'carnival'),
(11, N'Photos - parade', 3, 10, N'Photos of the parade', N'Parade', N'frmPhotoParade', N'photos'),
(12, N'Photos - field', 3, 20, N'Photos on the field', N'Rec', N'frmPhotoRec', N'photos'),
(13, N'Photos - other', 3, 30, N'Other photos', N'Other', N'frmPhotoOther', N'photos'),
(14, N'Photos - fell races', 3, 40, N'Fell race photos', N'Fell race', N'frmPhotoFellRace', N'photos'),
(15, N'Photos - scarecrows', 3, 50, N'Scarecrow photos', N'Scarecrows', N'frmScarecrow', N'photos'),
(16, N'Fell race - senior', 4, 10, N'Senior fell race', N'Senior', N'frmFellRaceSenior', N'fellrace'),
(17, N'Fell race - junior', 4, 20, N'Junior fell race', N'Junior', N'frmFellRaceJunior', N'fellrace'),
(18, N'Fell race - results', 4, 30, N'Search fell race results', N'Results', N'frmFellRaceResults', N'fellrace'),
(19, N'Fell race - photos', 4, 40, N'Fell race photos', N'Photos', N'frmFellRacePhotos', N'fellrace'),
(20, N'Scarecrows - 2010 competition', 5, 10, N'The 2010 scarecrow competition', N'2010 competiition', N'frmScarecrowCompetition', N'scarecrow'),
(21, N'Scarecrows - photos', 5, 20, N'Scarecrow photos', N'Photos', N'frmScarecrowPhotos', N'scarecrow'),
(22, N'Scarecrows- previous years', 5, 30, N'Previous year winners and scarecrow competitions', N'Previous years', N'frmScarecrowPrevious', N'scarecrow'),
(23, N'Help us - committee', 6, 10, N'Meet the organisers', N'Who organises it', N'frmHelpCommittee', N'help'),
(24, N'Help us - meetings', 6, 20, N'When we meet', N'When and where we meet', N'frmHelpMeetings', N'help'),
(25, N'Help us - finances', 6, 30, N'Carnival finances', N'Finances', N'frmHelpFinaces', N'help');
SET IDENTITY_INSERT [dbo].[tblMenu] OFF;
/****** Object:  StoredProcedure [dbo].[spMenu]    Script Date: 02/05/2010 16:46:11 ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
