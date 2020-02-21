-- Generated by Oracle SQL Developer Data Modeler 18.3.0.268.1156
--   at:        2019-06-20 18:34:28 CEST
--   site:      SQL Server 2012
--   type:      SQL Server 2012

USE master;
DROP DATABASE IF EXISTS Projekt;
GO

CREATE DATABASE Projekt;
GO

USE Projekt;
GO



while(exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_TYPE='FOREIGN KEY'))
begin
	declare @sql nvarchar(2000)
	SELECT TOP 1 @sql=('ALTER TABLE ' + TABLE_SCHEMA + '.[' + TABLE_NAME
	+ '] DROP CONSTRAINT [' + CONSTRAINT_NAME + ']')
	FROM information_schema.table_constraints
	WHERE CONSTRAINT_TYPE = 'FOREIGN KEY'
	exec (@sql)
end


drop table if exists ci�arowy, dealer, dodatkowe_wyposa�enie, istnieje_w_profilu, klient, marka, model, osobowy, ci�arowy, posiada, posiada_wyposa�enie_dod, samoch�d, silnik, sprzeda�e, samoch�d_w_ofercie_dealera, marka, cie�arowy_model_fk;



CREATE TABLE ci�arowy (
    id          INTEGER NOT NULL UNIQUE,
    �adowno��   INTEGER NOT NULL
)

go

ALTER TABLE Ci�arowy ADD constraint ci�arowy_pk PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE dealer (
    nazwa   VARCHAR(20) NOT NULL,
    adres   VARCHAR(60) NOT NULL UNIQUE
)

go

ALTER TABLE Dealer ADD constraint dealer_pk PRIMARY KEY CLUSTERED (nazwa)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE dodatkowe_wyposa�enie (
    nazwa_wyposa�enia   VARCHAR(40) NOT NULL
)

go

ALTER TABLE Dodatkowe_wyposa�enie ADD constraint dodatkowe_wyposa�enie_pk PRIMARY KEY CLUSTERED (nazwa_wyposa�enia)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE istnieje_w_profilu (
    dealer_nazwa   VARCHAR(20) NOT NULL,
    model_id       INTEGER NOT NULL
)

go

ALTER TABLE istnieje_w_profilu ADD constraint istnieje_w_profilu_pk PRIMARY KEY CLUSTERED (Dealer_nazwa, Model_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE klient (
    id            INTEGER IDENTITY(1, 1) NOT NULL,
    imi�          VARCHAR(30) NOT NULL CONSTRAINT ck_imie CHECK (imi� LIKE '[A-Z]%'),
    nazwisko      VARCHAR(30) NOT NULL CONSTRAINT ck_nazw CHECK (nazwisko LIKE '[A-Z]%'),
    nr_telefonu   VARCHAR(9) UNIQUE NOT NULL CONSTRAINT ck_nr_len CHECK (DATALENGTH([nr_telefonu]) = 9)
)

go

ALTER TABLE Klient ADD constraint klient_pk PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE marka (
    nazwa     VARCHAR(30) NOT NULL,
    rok_za�   INTEGER
)

go

ALTER TABLE Marka ADD constraint marka_pk PRIMARY KEY CLUSTERED (nazwa)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE model (
    id                 INTEGER IDENTITY(1, 1) NOT NULL,
    nazwa              VARCHAR(30) NOT NULL,
    rok_wprowadzenia   INTEGER NOT NULL,
    model_id         INTEGER,
    marka_nazwa        VARCHAR(30) NOT NULL
)

go 

    


CREATE unique nonclustered index model__idx ON model ( model_id )
WHERE model_id IS NOT NULL

ALTER TABLE Model ADD constraint model_pk PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE osobowy (
    id                 INTEGER NOT NULL UNIQUE,
    poj_baga�nika INTEGER,
    liczba_pasa�er�w   INTEGER NOT NULL
)

go

ALTER TABLE Osobowy ADD constraint osobowy_pk PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE posiada (
    model_id     INTEGER NOT NULL,
    silnik_eid   INTEGER NOT NULL
)

go

ALTER TABLE posiada ADD constraint posiada_pk PRIMARY KEY CLUSTERED (Silnik_eid, Model_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE "posiada_wyposa�enie_dod" (
    samoch�d_vin                              VARCHAR(17) NOT NULL,
    dodatkowe_wyposa�enie_nazwa_wyposa�enia   VARCHAR(40) NOT NULL
)

go

ALTER TABLE "posiada_wyposa�enie_dod" ADD constraint posiada_wyposa�enie_dod_pk PRIMARY KEY CLUSTERED (Samoch�d_VIN, Dodatkowe_wyposa�enie_nazwa_wyposa�enia)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE samoch�d (
    vin                VARCHAR(17) NOT NULL CONSTRAINT ck_vin_len CHECK (DATALENGTH([vin]) = 17),
    przebieg           INTEGER NOT NULL,
    rodzaj_skrzyni     VARCHAR(30) NOT NULL,
    kraj_pochodzenia   VARCHAR(15),
    rok_produkcji      INTEGER NOT NULL,
    model_id           INTEGER NOT NULL,
    silnik_eid         INTEGER NOT NULL
)

go

ALTER TABLE Samoch�d ADD constraint samoch�d_pk PRIMARY KEY CLUSTERED (VIN)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE samoch�d_w_ofercie_dealera
(
    samoch�d_vin   VARCHAR(17) NOT NULL,
    dealer_nazwa   VARCHAR(20) NOT NULL
)
go

ALTER TABLE samoch�d_w_ofercie_dealera ADD constraint samoch�d_w_ofercie_dealera_pk PRIMARY KEY CLUSTERED (Samoch�d_VIN)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )


CREATE TABLE silnik (
    eid         INTEGER IDENTITY(1, 1) NOT NULL,
    parametry   VARCHAR(40) NOT NULL,
    paliwo      VARCHAR(15) NOT NULL
)

go

ALTER TABLE Silnik ADD constraint silnik_pk PRIMARY KEY CLUSTERED (eid)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

CREATE TABLE sprzeda�e (
    data           datetime NOT NULL,
    cena           INTEGER NOT NULL,
    samoch�d_vin   VARCHAR(17) NOT NULL,
    dealer_nazwa   VARCHAR(20) NOT NULL,
    klient_id      INTEGER NOT NULL
)

go

ALTER TABLE Sprzeda�e ADD constraint sprzeda�e_pk PRIMARY KEY CLUSTERED (Samoch�d_VIN, Dealer_nazwa, Klient_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )

ALTER TABLE Ci�arowy
    ADD CONSTRAINT ci�arowy_model_fk FOREIGN KEY ( id )
        REFERENCES model ( id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE istnieje_w_profilu
    ADD CONSTRAINT istnieje_w_profilu_dealer_fk FOREIGN KEY ( dealer_nazwa )
        REFERENCES dealer ( nazwa )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE istnieje_w_profilu
    ADD CONSTRAINT istnieje_w_profilu_model_fk FOREIGN KEY ( model_id )
        REFERENCES model ( id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Model
    ADD CONSTRAINT model_marka_fk FOREIGN KEY ( marka_nazwa )
        REFERENCES marka ( nazwa )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Model
    ADD CONSTRAINT model_model_fk FOREIGN KEY ( model_id )
        REFERENCES model ( id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Osobowy
    ADD CONSTRAINT osobowy_model_fk FOREIGN KEY ( id )
        REFERENCES model ( id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE posiada
    ADD CONSTRAINT posiada_model_fk FOREIGN KEY ( model_id )
        REFERENCES model ( id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE posiada
    ADD CONSTRAINT posiada_silnik_fk FOREIGN KEY ( silnik_eid )
        REFERENCES silnik ( eid )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE "posiada_wyposa�enie_dod" ADD constraint posiada_wyposa�enie_dod_dodatkowe_wyposa�enie_fk FOREIGN KEY 
    ( 
     Dodatkowe_wyposa�enie_nazwa_wyposa�enia
    ) 
    REFERENCES Dodatkowe_wyposa�enie 
    ( 
     nazwa_wyposa�enia 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE "posiada_wyposa�enie_dod" ADD constraint posiada_wyposa�enie_dod_samoch�d_fk FOREIGN KEY 
    ( 
     Samoch�d_VIN
    ) 
    REFERENCES Samoch�d 
    ( 
     VIN 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE no action


ALTER TABLE Samoch�d
    ADD CONSTRAINT samoch�d_model_fk FOREIGN KEY ( model_id )
        REFERENCES model ( id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Samoch�d
    ADD CONSTRAINT samoch�d_silnik_fk FOREIGN KEY ( silnik_eid )
        REFERENCES silnik ( eid )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE samoch�d_w_ofercie_dealera
    ADD CONSTRAINT samoch�d_w_ofercie_dealera_dealer_fk FOREIGN KEY ( dealer_nazwa )
        REFERENCES dealer ( nazwa )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE samoch�d_w_ofercie_dealera
    ADD CONSTRAINT samoch�d_w_ofercie_dealera_samoch�d_fk FOREIGN KEY ( samoch�d_vin )
        REFERENCES samoch�d ( vin )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Sprzeda�e
    ADD CONSTRAINT sprzeda�e_dealer_fk FOREIGN KEY ( dealer_nazwa )
        REFERENCES dealer ( nazwa )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Sprzeda�e
    ADD CONSTRAINT sprzeda�e_klient_fk FOREIGN KEY ( klient_id )
        REFERENCES klient ( id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Sprzeda�e
    ADD CONSTRAINT sprzeda�e_samoch�d_fk FOREIGN KEY ( samoch�d_vin )
        REFERENCES samoch�d ( vin )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Ci�arowy
    ADD CONSTRAINT ci�arowy_model_1_fk FOREIGN KEY ( id )
        REFERENCES model ( id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE istnieje_w_profilu
    ADD CONSTRAINT istnieje_w_profilu_dealer_1__fk FOREIGN KEY ( dealer_nazwa )
        REFERENCES dealer ( nazwa )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE istnieje_w_profilu
    ADD CONSTRAINT istnieje_w_profilu_model_1_fk FOREIGN KEY ( model_id )
        REFERENCES model ( id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Model
    ADD CONSTRAINT model_marka_1_fk FOREIGN KEY ( marka_nazwa )
        REFERENCES marka ( nazwa )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Model
    ADD CONSTRAINT model_model__1_fk FOREIGN KEY ( model_id )
        REFERENCES model ( id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Osobowy
    ADD CONSTRAINT osobowy_model_1_fk FOREIGN KEY ( id )
        REFERENCES model ( id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE posiada
    ADD CONSTRAINT posiada_model_1_fk FOREIGN KEY ( model_id )
        REFERENCES model ( id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE posiada
    ADD CONSTRAINT posiada_silnik_1_fk FOREIGN KEY ( silnik_eid )
        REFERENCES silnik ( eid )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE "posiada_wyposa�enie_dod" ADD constraint posiada_wyposa�enie_dod_dodatkowe_wyposa�enie_1_fk FOREIGN KEY 
    ( 
     Dodatkowe_wyposa�enie_nazwa_wyposa�enia
    ) 
    REFERENCES Dodatkowe_wyposa�enie 
    ( 
     nazwa_wyposa�enia 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE "posiada_wyposa�enie_dod" ADD constraint posiada_wyposa�enie_dod_samoch�d_1_fk FOREIGN KEY 
    ( 
     Samoch�d_VIN
    ) 
    REFERENCES Samoch�d 
    ( 
     VIN 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Samoch�d
    ADD CONSTRAINT samoch�d_model_1_fk FOREIGN KEY ( model_id )
        REFERENCES model ( id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Samoch�d
    ADD CONSTRAINT samoch�d_silnik_1_fk FOREIGN KEY ( silnik_eid )
        REFERENCES silnik ( eid )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Sprzeda�e
    ADD CONSTRAINT sprzeda�e_dealer_1_fk FOREIGN KEY ( dealer_nazwa )
        REFERENCES dealer ( nazwa )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Sprzeda�e
    ADD CONSTRAINT sprzeda�e_klient_1_fk FOREIGN KEY ( klient_id )
        REFERENCES klient ( id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Sprzeda�e
    ADD CONSTRAINT sprzeda�e_samoch�d_1_fk FOREIGN KEY ( samoch�d_vin )
        REFERENCES samoch�d ( vin )
ON DELETE NO ACTION 
    ON UPDATE no action

INSERT INTO marka VALUES
('Alfa Romeo', 1910), ('BMW', 1916), ('Renault', 1899), ('Ford', 1903), ('Audi', 1909), ('Volkswagen', 1937), ('Aston Martin', 1914), ('Koenigsegg', 1994), ('KTM', 1934), ('Peugeot', 1810)

INSERT INTO klient VALUES
('Marian', 'Kop', '722234554'),
('Anna', 'Waza', '332887354'),
('Jan', 'Gzdyl', '997997135'),
('Marianna', 'Pietruszka', '445135723'),
('Grzegorz', 'D�b', '354243111'),
('Katarzyna', 'Ole�nicka', '776623661'),
('Robert', 'Zbych', '123123121'),
('Sebastian', 'Pado�ek', '224343243'),
('Robert', 'J�wiak', '777666555'),
('W�odzimierz', 'Suchy', '443232888')

INSERT INTO dealer VALUES
('PP Auto Komis', 'ul. �niadeckich 12, Warszawa'),
('Rozecki Auto Komis', 'ul. Kolejowa 33, Warszawa'),
('KR Cars', 'ul. Grunwaldzka 5, Pozna�'),
('Luxury Cars', 'ul. Weso�a 1, Lublin'),
('J�zefiak Komis', 'ul. Podg�rna 14, Krak�w'),
('Jupiter Sport Cars', 'ul. Jasna 34, Krak�w'),
('Auta U�ywane ��d�', 'ul. Warzywna 2, ��d�'),
('Kasperski Komis', 'ul. Prosta 15, ��d�'),
('RT Auto Komis', 'ul. Groteskowa 49, Gorz�w Wielkopolski'),
('HTR', 'ul. Jaroszewskiego 1, Szczecin')

INSERT INTO dodatkowe_wyposa�enie VALUES
('podgrzewane fotele'),
('tarcze ceramiczne'),
('przyciemniane szyby'),
('nawigacja'),
('nag�o�nienie BOSE'),
('aktywne zawieszenie'),
('skr�tna tylna o�'),
('kube�kowe fotele'),
('wydech Akrapovic'),
('gwintowane zawieszenie')

INSERT INTO silnik VALUES
('1.4 l, 120 km, 150 Nm', 'benzyna'),
('5.0 l, 1160 km, 1280 Nm', 'benzyna'),
('2.0 l, 240 km, 310 Nm', 'benzyna'),
('2.6 l, 310 km, 340 Nm', 'benzyna'),
('1.6 l 130 km, 150 Nm', 'benzyna'),
('1.8 l, 142 km, 190 Nm', 'benzyna'),
('2.0 l, 140 km, 330 Nm', 'diesel'),
('2.2 l, 230 km, 405 Nm', 'diesel'),
('2.2 l, 230 km, 405 Nm', 'diesel'),
('4.0 l, 320 km, 515 Nm', 'diesel'),
('2.2 l, 215 km, 405 Nm', 'diesel')

INSERT INTO model VALUES
('Agera R', 2011, null, 'Koenigsegg'),
('Agera RS', 2015, 1, 'Koenigsegg'),
('Passat', 1996, null, 'Volkswagen'),
('Passat', 2005, 7, 'Volkswagen'),
('Passat', 2010, 4, 'Volkswagen'),
('Passat', 2014, 5, 'Volkswagen'),
('Passat', 2000, 3, 'Volkswagen'),
('X-Bow', 2008, null, 'KTM'),
('Laguna', 2001, null, 'Renault'),
('Laguna', 2007, 9, 'Renault'),
('Crafter', 2000, null, 'Volkswagen')


INSERT INTO samoch�d VALUES
('JH4KA7570PC005842', 70400, 'automat', 'Niemcy', 2012, 2, 2),
('PH4KA7570PC009872', 35034, 'automat', 'Niemcy', 2015, 8, 3),
('P4GTA7570PC009571', 279000, 'manualna', 'Niemcy', 2016, 6, 7),
('B4HF27570PC543571', 365000, 'manualna', 'Niemcy', 2017, 6, 7),
('F2XTA7570PC009654', 209300, 'automat', 'Niemcy', 2018, 6, 7),
('K8GTA7570PC002345', 223000, 'manualna', 'Niemcy', 2019, 6, 10),
('FV4KA7570PG109812', 60034, 'automat', 'Niemcy', 2011, 1, 2),
('SH4KA7570PC009272', 210034, 'manualna', 'Niemcy', 2015, 10, 6),
('GX21A7570PC009292', 370034, 'manualna', 'Niemcy', 2006, 9, 5),
('PX21A7570PC009452', 390034, 'automat', 'Niemcy', 2005, 9, 5),
('TY21A7570PC009678', 0, 'manualna', 'Niemcy', 2019, 11, 7)

INSERT INTO posiada_wyposa�enie_dod VALUES
('FV4KA7570PG109812', 'kube�kowe fotele'),
('FV4KA7570PG109812', 'tarcze ceramiczne'),
('PH4KA7570PC009872', 'nag�o�nienie BOSE'),
('PH4KA7570PC009872', 'tarcze ceramiczne'),
('PH4KA7570PC009872', 'wydech Akrapovic'),
('PH4KA7570PC009872', 'aktywne zawieszenie'),
('SH4KA7570PC009272', 'gwintowane zawieszenie'),
('SH4KA7570PC009272', 'nag�o�nienie BOSE'),
('SH4KA7570PC009272', 'przyciemniane szyby'),
('TY21A7570PC009678', 'skr�tna tylna o�')

INSERT INTO ci�arowy VALUES
(11, 2)


INSERT INTO osobowy VALUES
(7, 520, 5), (6, 550, 5), (5, 480, 5), (4, 480, 5), (3, 510, 5),
(1, 60, 2), (2, 62, 2),
(8, 20, 2),
(9, 505, 5), (10, 530, 5)

INSERT INTO posiada VALUES
(9, 5), (2, 2), (6, 7), (1, 2), (6, 10), (8, 3), (10, 6), (11, 7)

INSERT INTO istnieje_w_profilu VALUES
('J�zefiak Komis', 6),
('Jupiter Sport Cars', 1),
('Jupiter Sport Cars', 2),
('Jupiter Sport Cars', 8),
('RT Auto Komis', 9),
('RT Auto Komis', 10),
('RT Auto Komis', 11)

INSERT INTO samoch�d_w_ofercie_dealera VALUES
('F2XTA7570PC009654', 'J�zefiak Komis'),
('GX21A7570PC009292', 'RT Auto Komis'),
('JH4KA7570PC005842', 'Jupiter Sport Cars'),
('PH4KA7570PC009872', 'Jupiter Sport Cars'),
('K8GTA7570PC002345', 'J�zefiak Komis'),
('P4GTA7570PC009571', 'J�zefiak Komis'),
('B4HF27570PC543571', 'J�zefiak Komis'),
('FV4KA7570PG109812', 'Jupiter Sport Cars'),
('PX21A7570PC009452', 'RT Auto Komis'),
('SH4KA7570PC009272', 'RT Auto Komis'),
('TY21A7570PC009678', 'RT Auto Komis')


-- WYZWALACZE --

drop trigger if exists tr_spr_typ1;
GO
CREATE TRIGGER tr_spr_typ1
ON ci�arowy
after INSERT, UPDATE
AS
  if exists(select O.id from osobowy O
  join ci�arowy C on C.id = O.id)
  begin
    rollback
    RAISERROR ('Samoch�d nie mo�e by� r�wnocze�nie ci�arowy i osobowy', 16, 1);;
    end
GO


drop trigger if exists tr_spr_typ2;
GO
CREATE TRIGGER tr_spr_typ2
ON osobowy
after INSERT, UPDATE
AS
  if exists(select O.id from osobowy O
  join ci�arowy C on C.id = O.id)
  begin
    rollback
    RAISERROR ('Samoch�d nie mo�e by� r�wnocze�nie ci�arowy i osobowy', 16, 1);;
    end
GO

drop trigger if exists tr_en_check;
GO

CREATE TRIGGER tr_en_check
ON samoch�d
after INSERT, UPDATE
AS
  if exists (Select * from samoch�d S
Where not exists(
                    Select 1
                    From posiada P
                    Where P.model_id = S.model_id
                        And P.silnik_eid = S.silnik_eid))
  begin
    rollback
    RAISERROR ('Samoch�d nie mo�e posiada� silnika niezwi�zanego ze swoim modelem.', 16, 2);;
    end
GO

-- INSERT INTO ci�arowy VALUES (5, 1)

-- INSERT INTO samoch�d VALUES ('JH4KA7570FC005842', 70400, 'automat', 'Niemcy', 2012, 2, 3)


-- WIDOK --

drop view if exists komisyWarszawa
GO

create view komisyWarszawa(nazwa)
AS ( Select nazwa from dealer
    where adres LIKE '%Warszawa%');
GO
Select * from komisyWarszawa


-- PROCEDURY --

drop procedure if exists rok_za�_marki
GO

create procedure rok_za�_marki
    @marka VARCHAR(20),
    @rok INT OUTPUT
AS
begin
    select @rok = rok_za�
    from marka
    where nazwa = @marka
END;
GO

DECLARE @nazw VARCHAR(20);

EXEC rok_za�_marki
     'BMW',
     @nazw OUTPUT;
PRINT @nazw;



DROP procedure if exists dodajMarke;
Go
CREATE procedure dodajMarke(@nazwa VARCHAR(20), @rok_za� INT)  as
  BEGIN
     Insert into marka VALUES (@nazwa, @rok_za�)
     Print 'Dodano mark�' + @nazwa
  end
GO
EXEC dodajMarke 'SsangYong', 1954



DROP procedure if exists usunMarke;
Go
CREATE procedure usunMarke(@nazwa VARCHAR(20))  as
  BEGIN
     delete from marka where nazwa = @nazwa
     Print 'Usuni�to mark� ' + @nazwa
  end
GO
EXEC usunMarke 'SsangYong'



DROP procedure if exists zmienPojemnoscBagaznika;
Go
CREATE procedure zmienPojemnoscBagaznika(@id INT, @nowa_poj INT)  as
  BEGIN
    Declare @nazwa VARCHAR(20)
     Select @nazwa = nazwa from model where id = @id
     update osobowy set poj_baga�nika = @nowa_poj where id = @id
     Print 'Zmieniono pojemno�� baga�nika samochodu ' + @nazwa
  END
GO
EXEC zmienPojemnoscBagaznika 9, 507



DROP procedure if exists sprzedajSamochod
GO
CREATE procedure sprzedajSamochod(@cena INT, @VIN VARCHAR(17), @nazwa_dealera VARCHAR(40), @id_klienta INT) as
BEGIN
    INSERT INTO sprzeda�e VALUES (GETDATE(), @cena, @VIN, @nazwa_dealera, @id_klienta)
    delete from samoch�d_w_ofercie_dealera where samoch�d_vin = @VIN

    Declare @id_modelu INT
    Select @id_modelu = model_id from samoch�d where vin = @VIN

    Declare @liczba INT
    Select @liczba = count(S.vin) from samoch�d S
    inner join samoch�d_w_ofercie_dealera O on S.vin = O.samoch�d_vin
    where S.model_id = @id_modelu and O.dealer_nazwa = @nazwa_dealera

    if @liczba = 0
    begin
         delete from istnieje_w_profilu where dealer_nazwa = @nazwa_dealera and model_id = @id_modelu
         Print 'Usuni�to model z profilu dealera ' + @nazwa_dealera
        end
    PRINT 'Zarejestrowano sprzeda�'
END
GO
EXEC sprzedajSamochod 830000, JH4KA7570PC005842, 'Jupiter Sport Cars', 3
EXEC sprzedajSamochod 17000, GX21A7570PC009292, 'RT Auto Komis', 6
EXEC sprzedajSamochod 210000, PH4KA7570PC009872, 'Jupiter Sport Cars', 1
EXEC sprzedajSamochod 20000, K8GTA7570PC002345, 'J�zefiak Komis', 2
EXEC sprzedajSamochod 20000, F2XTA7570PC009654, 'J�zefiak Komis', 4
EXEC sprzedajSamochod 34000, P4GTA7570PC009571, 'J�zefiak Komis', 5
EXEC sprzedajSamochod 62000, B4HF27570PC543571, 'J�zefiak Komis', 7
EXEC sprzedajSamochod 52000, PX21A7570PC009452, 'RT Auto Komis', 8
EXEC sprzedajSamochod 42000, TY21A7570PC009678, 'RT Auto Komis', 9
EXEC sprzedajSamochod 80000, SH4KA7570PC009272, 'RT Auto Komis', 10


-- FUNKCJE --

Drop function if exists lacznyDochodZeSprzedazy
GO
Create function lacznyDochodZeSprzedazy() Returns INT as
BEGIN
Return(Select SUM(cena) from sprzeda�e);
END;
GO
Select dbo.lacznyDochodZeSprzedazy() as '��czny_przych�d_sieci_komis�w';


drop function if exists samochodyZAutomatemLubManualna
GO
Create function samochodyZAutomatemLubManualna(@typ_skrzyni VARCHAR(15)) Returns table as
Return Select * from samoch�d where rodzaj_skrzyni = @typ_skrzyni;
GO
Select * from dbo.samochodyZAutomatemLubManualna('automat');


Select * from samoch�d_w_ofercie_dealera
Select * from istnieje_w_profilu
Select * from sprzeda�e
--Select * from posiada
--Select * from ci�arowy
Select * from samoch�d
Select * from model
--Select * from osobowy
--Select * from marka
--Select * from silnik
--Select * from dodatkowe_wyposa�enie
--Select * from dealer
--Select * from klient
--Select * from posiada_wyposa�enie_dod

