-- ------------------------------------------------------------------
-- Contacts-Datenbank für MB01 ADO.NET (SQLite-Variante)
-- Ersetzt Contacts.mdb (MS Access). Gleiche Tabellen und Spalten.
--
-- Neu erzeugen (z.B. mit sqlite3-CLI oder "DB Browser for SQLite"):
--   sqlite3 Contacts.db < Contacts.sql
-- oder im Demo-Projekt:  KontakteLive init
-- ------------------------------------------------------------------

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Contact;
DROP TABLE IF EXISTS Person;

CREATE TABLE Person (
    ID        INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName VARCHAR(50),
    Name      VARCHAR(50) NOT NULL
);

CREATE TABLE Contact (
    ID        INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName VARCHAR(50),
    Name      VARCHAR(50) NOT NULL,
    NickName  VARCHAR(50),
    EMail     VARCHAR(80),
    Phone     VARCHAR(20),
    PersonID  INTEGER NOT NULL REFERENCES Person(ID) ON DELETE CASCADE
);

CREATE INDEX IX_Contact_PersonID ON Contact(PersonID);

INSERT INTO Person (ID, FirstName, Name) VALUES
    (1, 'Wolfgang', 'Beer'),
    (2, 'Dietrich', 'Birngruber'),
    (3, 'Thomas',   'Kehl'),
    (4, 'Franz',    'Meier'),
    (5, 'Karl',     'Enzler'),
    (6, 'Max',      'Müller');

INSERT INTO Contact (FirstName, Name, NickName, EMail, Phone, PersonID) VALUES
    ('Dietrich', 'Birngruber', 'Didi',   'didi@dotnet.jku.at',      '7133',          1),
    ('Thomas',   'Kehl',       'Tom',    'thomas.kehl@example.ch',  '071 222 33 44', 1),
    ('Wolfgang', 'Beer',       'Wolfi',  'beer@dotnet.jku.at',      '7132',          2),
    ('Franz',    'Meier',      NULL,     'franz.meier@example.ch',  '079 123 45 67', 3),
    ('Karl',     'Enzler',     'Kari',   'k.enzler@example.ch',     '078 765 43 21', 3),
    ('Max',      'Müller',     'Mäx',    'm.mueller@gmx.ch',        '071 564 34 78', 3),
    ('Anna',     'Schneider',  NULL,     'anna.schneider@example.ch','076 111 22 33', 4),
    ('Lea',      'Huber',      'Lea',    'lea.huber@example.ch',    '079 444 55 66', 4),
    ('Thomas',   'Kehl',       'Tom',    'thomas.kehl@example.ch',  '071 222 33 44', 5),
    ('Sandra',   'Keller',     'Sandy',  's.keller@example.ch',     '077 888 99 00', 6);
