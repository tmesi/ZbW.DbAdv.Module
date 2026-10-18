USE master
GO

IF EXISTS(select * from sys.databases where name='Playground')
DROP DATABASE Playground
GO

CREATE DATABASE Playground
GO

use Playground
go

if exists (select * from dbo.sysobjects where id =object_id(N'[dbo].[FK_Contact_Person]') and OBJECTPROPERTY(id,
N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Contact] DROP CONSTRAINT FK_Contact_Person 
GO

if exists (select * from dbo.sysobjects where id =
object_id(N'[dbo].[GetContacts]') and OBJECTPROPERTY(id, N'IsProcedure') =1)
drop procedure [dbo].[GetContacts]
GO

if exists (select * from dbo.sysobjects where id =
object_id(N'[dbo].[InsertPerson]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[InsertPerson]
GO

if exists (select * from dbo.sysobjects where id =
object_id(N'[dbo].[Contact]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
drop table [dbo].[Contact] 
GO

if exists (select * from dbo.sysobjects where id =
object_id(N'[dbo].[Person]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
drop table [dbo].[Person] 
GO

CREATE TABLE [dbo].[Contact] (
  [ID] [int] IDENTITY (1, 1) NOT NULL ,
  [FirstName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
  [Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
  [NickName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
  [EMail] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
  [Phone] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
  [PersonID] [int] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Person] (
  [ID] [int] IDENTITY (1, 1) NOT NULL ,
  [FirstName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
  [Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Contact] WITH NOCHECK ADD
  CONSTRAINT [PK_Contact] PRIMARY KEY  CLUSTERED
  (
    [ID]
  )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Person] WITH NOCHECK ADD
  CONSTRAINT [PK_Person] PRIMARY KEY  CLUSTERED
  (
    [ID]
  )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Contact] ADD
  CONSTRAINT [FK_Contact_Person] FOREIGN KEY
  (
    [PersonID]
  ) REFERENCES [dbo].[Person] (
    [ID]
  ) ON DELETE CASCADE
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE GetContacts
  @Name varchar(50) = null  -- Eingangsparameter 
AS
  SELECT     ID, FirstName, Name, NickName, EMail, Phone
  FROM       Contact
  WHERE     (Name LIKE (@Name+'%') )
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO

CREATE PROCEDURE InsertPerson
  @FirstName nvarchar(50) = '',
  @Name nvarchar(50) = '',
  @ID bigint OUTPUT -- zugewiesener Schlüssel 
AS
  INSERT INTO Person (FirstName, Name)
  VALUES (@FirstName, @Name)
  SELECT @ID = @@IDENTITY -- Schlüssel des neuen Datansatzes zurückgeben 
GO 
SET QUOTED_IDENTIFIER OFF 
GO 
SET ANSI_NULLS ON 
GO


insert into Person (FirstName, Name) values ('Thomas','Kehl')
insert into Person (FirstName, Name) values ('Franz','Meier')
insert into Person (FirstName, Name) values ('Karl','Enzler')
insert into Person (FirstName, Name) values ('Max','Müller')

insert into Contact (FirstName, Name, NickName, EMail, Phone, PersonID) values ('Max', 'Müller', 'Mäx', 'm.mueller@gmx.ch', '0715643478', @@IDENTITY)