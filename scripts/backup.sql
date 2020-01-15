-- Backup script which regenerates the database

-- DROP ALL TABLES FIRST
  DROP VIEW IF EXISTS vw_damaged;
  DROP VIEW IF EXISTS vw_thisyear;
  DROP TABLE IF EXISTS trips;
  DROP TABLE IF EXISTS isFor;
  DROP TABLE IF EXISTS accepts;
  DROP TABLE IF EXISTS Vehicles;
  DROP TABLE IF EXISTS VehicleTypes;
  DROP TABLE IF EXISTS transactions;
  DROP TABLE IF EXISTS status;
  DROP TABLE IF EXISTS Users;
  DROP TABLE IF EXISTS stations;
  DROP TABLE IF EXISTS insurance;
  DROP TABLE IF EXISTS unlimited;
  DROP TABLE IF EXISTS limited;
  DROP TABLE IF EXISTS plans;
--

-- CREATE ALL TABLES
  CREATE TABLE plans
  (
      name VARCHAR(128) PRIMARY KEY,
      price numeric(8,2) CONSTRAINT positive_price CHECK (price > 0)
  );

  CREATE TABLE limited
  (
      name VARCHAR(128) PRIMARY KEY,
      maxTrips INTEGER NOT NULL CONSTRAINT positive_trips CHECK (maxTrips > 0),
      FOREIGN KEY(name) REFERENCES plans(name)
  );

  CREATE TABLE unlimited
  (
      name VARCHAR(128) PRIMARY KEY,
      duration INTEGER NOT NULL CONSTRAINT positive_duration CHECK (duration > 0),
      FOREIGN KEY(name) REFERENCES plans(name)
  );

  CREATE TABLE insurance
  (
      name VARCHAR(128) PRIMARY KEY,
      coverage INTEGER NOT NULL CONSTRAINT positive_coverage CHECK (coverage > 0),
      duration INTEGER NOT NULL CONSTRAINT positive_duration CHECK (duration > 0),
      FOREIGN KEY(name) REFERENCES plans(name)
  );

  CREATE TABLE stations
  (
    sid INTEGER PRIMARY KEY,
    name VARCHAR,
    long FLOAT,
    lat FLOAT
  );

  CREATE TABLE Users
  (
    userID SERIAL PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    age INT,
    email VARCHAR(50)
  );

  CREATE TABLE VehicleTypes
  (
    vType VARCHAR PRIMARY KEY
  );

  CREATE TABLE Vehicles
  (
    serialNb SERIAL PRIMARY KEY,
    make VARCHAR,
    model VARCHAR,
    veh_state VARCHAR,
    capacity int,
    vType VARCHAR,
    FOREIGN KEY (vType) REFERENCES VehicleTypes(vType)
  );

  CREATE TABLE trips
  (
    s_time TIMESTAMP NOT NULL,
    e_time TIMESTAMP,
    userID INT NOT NULL,
    startsAt INT,
    endsAt INT,
    serialNB INT,
    vType VARCHAR,
    FOREIGN KEY (startsAt) REFERENCES stations(sid),
    FOREIGN KEY (endsAt) REFERENCES stations(sid),
    FOREIGN KEY (userID) REFERENCES users(userid),
    FOREIGN KEY (serialNB) REFERENCES vehicles(serialnb) ON DELETE CASCADE,
    FOREIGN KEY (vType) REFERENCES vehicletypes(vType),
    PRIMARY KEY (s_time, userID)
  );


CREATE TABLE status 
(
    statID SERIAL PRIMARY KEY, 
    name VARCHAR(128)
);

CREATE TABLE transactions
(
    tranID SERIAL PRIMARY KEY, 
    userID INTEGER,
    name VARCHAR(128),
    status INTEGER NOT NULL,   
    date timestamp NOT NULL CONSTRAINT past_date CHECK (date <= NOW()::timestamp),
    subtotal numeric(8,2) NOT NULL CONSTRAINT positive_subtotal CHECK (subtotal >= 0),
    FOREIGN KEY(userID) REFERENCES users(userID),
    FOREIGN KEY(name) REFERENCES plans(name),
    FOREIGN KEY(status) REFERENCES status(statID)
);

  CREATE TABLE accepts
  (
    stationID INT PRIMARY KEY,
    vType VARCHAR,
    capacity INT,
    FOREIGN KEY (stationID) REFERENCES Stations(sid),
      FOREIGN KEY (vType) REFERENCES VehicleTypes(vType)
  );


  CREATE TABLE isFor
  (
    name VARCHAR,
    vType VARCHAR,
    FOREIGN KEY (name) REFERENCES plans(name),
    FOREIGN KEY (vType) REFERENCES vehicleTypes(vType),
    PRIMARY KEY (name, vType)
  );

--

-- CREATE VIEW
  CREATE VIEW vw_Damaged AS
  SELECT * FROM Vehicles WHERE veh_state='damaged';
  
  CREATE VIEW vw_thisyear AS
  SELECT * FROM transactions WHERE date > '2019-01-01 08:00:00';
--

INSERT INTO VehicleTypes(vType)
VALUES
  ('bike'),
  ('electric bike'),
  ('regular car'),
  ('luxury car');



INSERT INTO stations(sid,name,lat,long) VALUES
	(7030,'de Bordeaux / Marie-Anne',45.53340912723174,-73.57065707445145),
	(6141,'de Bordeaux / Rachel',45.53227,-73.56828),
	(6100,'Mackay / de Maisonneuve',45.49659,-73.57851),
	(6064,'Métro Peel (de Maisonneuve / Stanley)',45.50038,-73.57507),
	(6730,'35e avenue / Beaubien',45.570081,-73.573047),
	(6396,'Métro Pie-IX (Pierre-de-Coubertin / Pie-IX)',45.55421375524564,-73.55155974626541),
	(6108,'Logan / Fullum',45.528448693514136,-73.55108499526978),
	(6114,'Métro Papineau (Cartier / Ste-Catherine)',45.52353,-73.55199),
	(6223,'du Mont-Royal / du Parc',45.517,-73.589),
	(6233,'Bernard / Jeanne-Mance',45.5242864769531,-73.60497325658798),
	(6043,'Square Victoria (Viger / du Square-Victoria)',45.50206,-73.56295),
	(6041,'St-Jacques / Gauvin',45.500674,-73.561082),
	(6397,'Marché Maisonneuve',45.55321884238814,-73.53978216648102),
	(6007,'de l''Hôtel-de-Ville / Ste-Catherine',45.511672575337855,-73.56204181909561),
	(6073,'de Maisonneuve / Aylmer',45.50501,-73.57069),
	(6027,'de Maisonneuve / Mansfield (ouest)',45.502053864057466,-73.57346534729004),
	(6107,'St-Mathieu /Ste-Catherine',45.493718,-73.579186),
	(6137,'Gauthier / Papineau',45.52969260094507,-73.56740087270737),
	(6138,'Gauthier / de Lorimier',45.53167355364312,-73.56541335582732),
	(6095,'Chomedey / de Maisonneuve',45.491800276787224,-73.58400642871855),
	(6005,'de la Cathédrale / René-Lévesque',45.49923714985484,-73.56944203376769),
	(6072,'Metcalfe / de Maisonneuve',45.50171494932855,-73.57413053512573),
	(6012,'Métro St-Laurent (de Maisonneuve / St-Laurent)',45.51066,-73.56497),
	(6710,'Georges-Baril / Fleury',45.55837563499052,-73.65884408354759),
	(7005,'Marquette / Fleury',45.56735205736566,-73.65378744900227),
	(6191,'St-Zotique / Clark',45.531401,-73.612674),
	(6262,'de la Roche /  de Bellechasse',45.537159225331315,-73.59747648239136),
	(6061,'McGill College / Ste-Catherine',45.50192926069952,-73.57145100831985),
	(4000,'Jeanne-d''Arc / Ontario',45.54945734212034,-73.54164898395538),
	(6700,'de la Salle / Ste-Catherine',45.54996328646854,-73.53443384170531),
	(7083,'Parc de Bullion (de Bullion / Prince-Arthur)',45.515604257816335,-73.57213497161865),
	(7043,'Ernest-Gendreau / du Mont-Royal',45.549713734001415,-73.56384828686714),
	(6361,'Molson / Beaubien',45.54968589617967,-73.59115451574326),
	(6278,'Louis-Hébert / St-Zotique',45.55001,-73.59576),
	(6248,'St-Dominique / Rachel',45.518593,-73.581566),
	(6184,'Métro Mont-Royal (Rivard / du Mont-Royal)',45.524673,-73.58255),
	(7019,'Casgrain / St-Viateur',45.52751292628879,-73.59879076480864),
	(7026,'Maguire / Henri-Julien',45.527041096087785,-73.59347056655677),
	(6218,'Prince-Arthur / St-Urbain',45.51258740220925,-73.57373893260956),
	(6015,'BAnQ (Berri / de Maisonneuve)',45.515299,-73.561273),
	(6152,'Chabot / du Mont-Royal',45.53418509490266,-73.57358872890472),
	(6197,'de Bordeaux / Masson',45.53898439552301,-73.5824453830719),
	(6335,'du Rosaire / St-Hubert',45.54467,-73.621581),
	(6261,'Louis Hémon / Rosemont',45.54459855947176,-73.58822286128998),
	(6254,'Boyer / Bélanger',45.54006,-73.60897),
	(6280,'Fairmount / St-Dominique',45.524504989237535,-73.59414249658585),
	(6227,'de l''Esplanade / Laurier',45.521116220989526,-73.59478354454039),
	(6060,'Stanley / du Docteur-Penfield',45.50252519241664,-73.5803371667862),
	(6159,'Ann / William',45.495894391754916,-73.5600972175598),
	(6748,'Young / Wellington',45.49282530947313,-73.55797827243805),
	(6129,'de Bordeaux / Sherbrooke',45.52997069129102,-73.56305301189423),
	(6106,'Papineau / René-Lévesque',45.52114,-73.54926),
	(6147,'Calixa-Lavallée / Sherbrooke',45.52479,-73.56545),
	(6154,'Marquette / du Mont-Royal',45.53229,-73.57544),
	(6364,'de Chambly / Rachel',45.54991069359101,-73.55826258659361),
	(6163,'Marquette / Laurier',45.53543,-73.5822),
	(6272,'de Bordeaux / St-Zotique',45.546539011777845,-73.59866470098495),
	(6267,'Chabot / Beaubien',45.544375546398065,-73.59564453363419),
	(6411,'Clark / Prince-Arthur',45.5133025720765,-73.57296109199524),
	(6153,'Cartier / Marie-Anne',45.532674,-73.571776),
	(6089,'Henri-Julien / du Carmel',45.527839413108,-73.59482109546661),
	(7062,'William / Robert-Bourassa',45.49716534003792,-73.55933010578154),
	(6087,'Notre-Dame / de la Montagne',45.49302901258371,-73.56481790542603),
	(6720,'Ontario / Viau',45.5594818,-73.535496),
	(6209,'Milton / Clark',45.51254135285248,-73.57067719101906),
	(6070,'Milton / University',45.5064484,-73.57634872),
	(6062,'Drummond / Ste-Catherine',45.49863930330429,-73.57422709465027),
	(6031,'St-Antoine / St-François-Xavier',45.50454228987185,-73.55916380882263),
	(6200,'Maguire / St-Laurent',45.524628485592636,-73.5958108305931),
	(6750,'Frontenac / du Mont-Royal',45.53927089395617,-73.56837183237076),
	(7029,'Cartier / Masson',45.5380207402854,-73.58352363109587),
	(6083,'Square Phillips',45.50373771539475,-73.56810629367828),
	(6407,'Charlevoix / Lionel-Groulx',45.48392802,-73.57731164),
	(6250,'Marché Jean-Talon (Henri-Julien / Jean-Talon)',45.53678525128436,-73.6148879583925),
	(6237,'Gilford / de Lanaudière',45.53200800170645,-73.58044445514679),
	(6155,'Garnier / du Mont-Royal',45.53092,-73.57674),
	(6729,'St-André / Ste-Catherine',45.516426545782224,-73.5581123828888),
	(6085,'Notre-Dame / Peel',45.4952,-73.56328),
	(6046,'Métro Bonaventure (de la Gauchetière / Mansfield)',45.49871,-73.56671),
	(6247,'St-Dominique / St-Zotique',45.53228145673193,-73.61099146306515),
	(6908,'de Bellechasse / de St-Vallier',45.53334868400571,-73.60113568603992),
	(6196,'Villeneuve / St-Laurent',45.52134173413233,-73.58941912651062),
	(6210,'Métro Sauvé (Berri / Sauvé)',45.550692068419764,-73.65636706352234),
	(7006,'Clark / Fleury',45.54764847825576,-73.6655656993389),
	(6014,'St-Denis / Maisonneuve',45.514357,-73.561506),
	(6026,'de la Commune / Place Jacques-Cartier',45.50761009451047,-73.55183601379395),
	(6241,'Hutchison / Fairmount',45.51951505168392,-73.59851717948914),
	(6157,'de la Roche / du Mont-Royal',45.52875779392618,-73.57867956161499),
	(6232,'Hutchison / Van Horne',45.525021229212776,-73.61073732376099),
	(7028,'de Gaspé / St-Viateur',45.52774827884841,-73.59743893146515),
	(6230,'Waverly / St-Viateur',45.5238561444472,-73.60012650489807),
	(6246,'Métro Outremont (Wiseman / Van Horne)',45.52027053865367,-73.61484915018082),
	(7078,'Hochelaga / Chapleau',45.53445294687473,-73.55965197086334),
	(6103,'Lespérance / de Rouen',45.538799,-73.552496),
	(6402,'Square Sir-Georges-Etienne-Cartier / Ste-Émilie',45.47266800851548,-73.585389778018),
	(10002,'Métro Charlevoix (Centre / Charlevoix)',45.47822787309145,-73.56965124607086),
	(6268,'Chambord / Beaubien',45.539932183126695,-73.59934329986572),
	(6336,'Faillon / St-Hubert',45.54297175887712,-73.61793905496597),
	(6410,'Métro Crémazie (Crémazie / Lajeunesse)',45.54640752148169,-73.63842844963074),
	(6412,'Complexe sportif Claude-Robillard',45.553262,-73.638615),
	(6025,'Notre-Dame / St-Gabriel',45.50714391928411,-73.55511903762817),
	(6177,'St-Hubert / Duluth',45.522557610252086,-73.57440948486328),
	(6176,'de Mentana / Rachel',45.524963239803235,-73.57555881142616),
	(6110,'Poupart / Ste-Catherine',45.52903307037075,-73.54634821414948),
	(6002,'Darling / Ste-Catherine',45.54046008168309,-73.54030251502991),
	(6259,'Dandurand / de Lorimier',45.540881,-73.584157),
	(6082,'5e avenue / Rosemont',45.54990048023633,-73.58308374881744),
	(6174,'Roy / St-Denis',45.51908,-73.5727),
	(6202,'Ste-Famille / Sherbrooke',45.51007154847701,-73.57075229287146),
	(6217,'Vallières / St-Laurent',45.518967223320054,-73.5836161673069),
	(7084,'McTavish / Sherbrooke',45.502812816508936,-73.57602417469025),
	(6131,'Fullum / Sherbrooke',45.533924,-73.562425),
	(6216,'Parc Jeanne Mance (monument à sir George-Étienne Cartier)',45.51496,-73.58503),
	(6381,'Omer-Lavallée / du Midway',45.5457759528664,-73.56217458844185),
	(6047,'University / Prince-Arthur',45.507401678946415,-73.57844352722168),
	(6156,'Marie-Anne / de la Roche',45.52775814390426,-73.57618510723114),
	(7033,'Aylmer / Prince-Arthur',45.508566869474386,-73.57769787311554),
	(6193,'de l''Esplanade / Fairmount',45.521495,-73.596758),
	(6211,'Roy / St-Laurent',45.515616239398405,-73.57580825686453),
	(6160,'Garnier / St-Joseph',45.5329774553515,-73.58122229576111),
	(6023,'de la Commune / Berri',45.51086,-73.54983),
	(6190,'Pontiac / Gilford',45.527009334270645,-73.58576595783234),
	(6188,'de Mentana / Marie-Anne',45.526026565221414,-73.57785880565643),
	(6926,'Marie-Anne / St-Hubert',45.5246829812827,-73.5788968205452),
	(6221,'du Mont-Royal / Clark',45.51941,-73.58685),
	(6143,'Rachel / de Brébeuf',45.52689,-73.57264),
	(6098,'Bishop / Ste-Catherine',45.49642,-73.57616),
	(6029,'Bel Air / St-Antoine',45.482779,-73.58452544),
	(7055,'Greene / Workman',45.48118440698601,-73.5793487727642),
	(6231,'Jeanne-Mance / St-Viateur',45.52289367861361,-73.60181629657745),
	(6220,'Laval / Duluth',45.519216236873945,-73.57718020677567),
	(6213,'Duluth / St-Laurent',45.51687640567004,-73.57946008443832),
	(6307,'Laval / Rachel',45.52017845247635,-73.57942387461662),
	(6117,'Robin / de la Visitation',45.520889767299096,-73.55922147631645),
	(6120,'Métro Frontenac (Ontario / du Havre)',45.5336609,-73.5521968),
	(6112,'Montcalm / de Maisonneuve',45.51909220007164,-73.55784952640533),
	(7027,'Terrasse Guindon / Fullum',45.537114135456825,-73.56913894414902),
	(6059,'Mansfield / René-Lévesque',45.50023084419879,-73.56939375400543),
	(6032,'Métro Place-d''Armes (Viger / St-Urbain)',45.50623,-73.55976),
	(6274,'de la Roche / St-Joseph',45.531164,-73.583695),
	(6195,'de Bullion / St-Joseph',45.5240365462478,-73.59014332294464),
	(6182,'de Bullion / du Mont-Royal',45.521484558655224,-73.58498007059097),
	(6102,'Lincoln / du Fort',45.493034,-73.583836),
	(7076,'Tupper / du Fort',45.49122961531575,-73.58078241348267),
	(6255,'Boyer / St-Zotique',45.53848,-73.60556),
	(6929,'St-André / St-Grégoire',45.531411853692525,-73.59174862504005),
	(6158,'Gilford / de Brébeuf',45.53081622781595,-73.58162596821785),
	(6049,'Queen / Wellington',45.49760527699099,-73.55534970760345),
	(6744,'Hamilton / Jolicoeur',45.456355,-73.597557),
	(6181,'Clark / Rachel',45.5173538,-73.58212888),
	(6067,'de Maisonneuve / Robert-Bourassa',45.503475,-73.572103),
	(6004,'Hôtel-de-Ville (du Champs-de-Mars / Gosford)',45.50918810659251,-73.55457991361618),
	(6048,'Queen / Ottawa',45.4979738,-73.55614096),
	(6039,'McGill / des Récollets',45.500779,-73.558826),
	(6910,'Boyer / Beaubien',45.537041,-73.602026),
	(6277,'Louis-Hébert / de Bellechasse',45.546695977916166,-73.58873784542084),
	(6266,'Louis-Hébert / Beaubien',45.548130019984676,-73.59193503856659),
	(6105,'Plessis / René-Lévesque',45.51937252291976,-73.55195805430411),
	(6907,'Boyer / Rosemont',45.534136,-73.595478),
	(6119,'Dorion / Ontario',45.52697,-73.558021),
	(7080,'du President-Kennedy / Robert Bourassa',45.504407470403315,-73.57254266738892),
	(6214,'Square St-Louis (du Square St-Louis / Laval)',45.516090801970655,-73.5701286792755),
	(6111,'Parthenais / Ste-Catherine',45.52620038317685,-73.54926645755768),
	(6118,'de Champlain / Ontario',45.52504753729988,-73.56003552675247),
	(6150,'Messier / du Mont-Royal',45.53711414,-73.5710031),
	(7040,'St-Urbain / Beaubien',45.52951033828327,-73.61067965626717),
	(6020,'Sanguinet / Ontario',45.51472630632029,-73.56548577547073),
	(6058,'Cypress / Peel',45.49932551028458,-73.57176750898361),
	(6334,'Lajeunesse / Jarry',45.54371190262865,-73.62828433513641),
	(6093,'Atwater / Sherbrooke',45.4912258547597,-73.58763009309769),
	(6013,'Sanguinet / de Maisonneuve',45.51340553558378,-73.56259435415267),
	(6134,'Gascon / Rachel',45.537964,-73.562643),
	(6199,'St-Viateur / St-Laurent',45.52593073022709,-73.59883904457092),
	(6092,'Crescent / René-Lévesque',45.49606,-73.57348),
	(6738,'Union / René-Lévesque',45.50235036136798,-73.56658279895781),
	(6902,'Beaudry / Ontario',45.52155597078072,-73.56226444244385),
	(6011,'St-André / St-Antoine',45.51411452790017,-73.55264469981194),
	(6173,'Berri / Cherrier',45.51908844137639,-73.56950908899307),
	(6052,'de la Commune / King',45.49751503379366,-73.55257093906403),
	(6260,'Dandurand / Papineau',45.538699774322616,-73.58622193336485),
	(6383,'Bourbonnière / du Mont-Royal',45.55357073967113,-73.56049418449402),
	(6388,'d''Orléans / Hochelaga',45.550669352823476,-73.54903580853716),
	(7020,'St-Germain / Hochelaga',45.5436987529516,-73.55367332696915),
	(7049,'Ottawa / St-Thomas',45.49068727002885,-73.56253802776337),
	(6169,'Boyer / du Mont-Royal',45.527432126380575,-73.57991673052311),
	(6901,'Gare d''autocars de Montréal (Berri / Ontario)',45.51679206656395,-73.56423854827881),
	(6428,'Berlioz / de l''Île des Soeurs',45.45998577640931,-73.54395568370819),
	(6380,'Parc J.-Arthur-Champagne (de Chambly / du Mont-Royal)',45.551584,-73.561916),
	(6712,'LaSalle / Crawford',45.43791380065227,-73.58274042606354),
	(6309,'4e avenue / de Verdun',45.4568844514464,-73.57260704040527),
	(6142,'Calixa-Lavallée / Rachel',45.527794785525096,-73.57193917036057),
	(6126,'Rouen / Fullum',45.53217,-73.55859),
	(6148,'Émile-Duployé / Sherbrooke',45.52729,-73.56463),
	(6179,'Duluth / St-Denis',45.52060423232697,-73.57598394155502),
	(7037,'Prince-Arthur / Ste-Famille',45.5116382139746,-73.57463479042053),
	(6733,'de Maisonneuve/ Mansfield (est)',45.50229396413971,-73.57321858406067),
	(6206,'Prince-Arthur / du Parc',45.51059,-73.57547),
	(7031,'Berri / Rachel',45.5228780183634,-73.57749536633492),
	(6225,'Villeneuve / St-Urbain',45.520188,-73.590559),
	(6313,'Palm / St-Remi',45.470303,-73.589848),
	(6368,'10e avenue / Masson',45.55031640880025,-73.57335805892944);

 
  /*UPDATE vehicles SET capacity = 2 WHERE serialNb = 4;*/

  ALTER TABLE ONLY Vehicles ALTER COLUMN capacity SET DEFAULT 5;
  ALTER TABLE ONLY Vehicles ALTER COLUMN vtype SET DEFAULT 'regular car';

  INSERT INTO vehicles (make, model,capacity) 
  VALUES
  ('Jeep', 'Grand Cherokee',7),
  ('Mercedes-Benz', 'CL-Class',2),
  ('Volkswagen', 'Golf',4),
  ('Honda', 'Prelude',2),
  ('Chevrolet', 'Tahoe', 7),
  ('Ford', 'Explorer',7),
  ('GMC', 'Savana',7),
  ('Ford', 'Expedition',7);

  INSERT INTO vehicles(make,model,capacity,vtype)
  VALUES
  ('Mazda', 'RX-7',2, 'luxury car'),
  ('Dodge', 'Challenger',2, 'luxury car'),
  ('Ford', 'Mustang',2, 'luxury car'),
  ('Ford', 'Mustang',2, 'luxury car'),
  ('Cube','Speedster',1, 'bike'),
  ('Scott', 'Runner', 1, 'bike'),
  ('Tesla', '1.5', 1, 'electric bike');

  INSERT INTO vehicles(make,model,vtype)
  VALUES
  ('Bentley', 'Continental GTC','luxury car'),
  ('Mercedes-Benz', 'CLS-Class','luxury car');

  INSERT INTO vehicles (make, model) 
  VALUES
    ('Mazda', 'Mazda3'),
    ('Volkswagen', 'Jetta'),
    ('Honda', 'Fit'),
    ('Ford', 'Excursion'),
    ('Infiniti', 'M'),
    ('Alfa Romeo', '164'),
    ('Dodge', 'Charger'),
    ('Dodge', 'Dakota'),
    ('Mercury', 'Grand Marquis'),
    ('GMC', '1500'),
    ('GMC', 'Savana 3500'),
    ('Bentley', 'Continental Flying Spur'),
    ('Chevrolet', 'Tracker'),
    ('Saab', '9-5'),
    ('Pontiac', 'Vibe'),
    ('Hyundai', 'Sonata'),
    ('Oldsmobile', 'Achieva'),
    ('Saab', '9000'),
    ('Volvo', '960'),
    ('Hyundai', 'Tucson'),
    ('Toyota', 'Sienna'),
    ('Mercury', 'Villager'),
    ('Chevrolet', 'Colorado'),
    ('Mitsubishi', 'Chariot'),
    ('BMW', 'X5'),
    ('Buick', 'LaCrosse'),
    ('Honda', 'Fit'),
    ('GMC', 'Safari'),
    ('Toyota', 'Corolla'),
    ('Mitsubishi', 'Truck'),
    ('Dodge', 'Ram 1500'),
    ('Kia', 'Rio'),
    ('Hyundai', 'Sonata'),
    ('Audi', 'A4'),
    ('Bentley', 'Arnage'),
    ('Mercury', 'Cougar');

  /*
  UPDATE Vehicles
  SET    capacity = 5 WHERE;
  */

  /*
  UPDATE Vehicles
  SET    vType = 'regular cars';
  */

  UPDATE Vehicles
  SET    veh_state = 'good shape';

  -- Script to insert random users ( 150 users )
  INSERT INTO Users (userID, firstName, lastName, age, email)
  VALUES
    (DEFAULT, 'Lucina', 'Garnall', 53, 'lgarnall0@yahoo.co.jp'),
    (DEFAULT, 'Milty', 'Remmers', 83, 'mremmers1@storify.com'),
    (DEFAULT, 'Chev', 'Nattriss', 57, 'cnattriss2@jalbum.net'),
    (DEFAULT, 'Nolana', 'Warboys', 62, 'nwarboys3@reverbnation.com'),
    (DEFAULT, 'Teirtza', 'Hundall', 64, 'thundall4@amazonaws.com'),
    (DEFAULT, 'Aldridge', 'Wimp', 62, 'awimp5@ebay.com'),
    (DEFAULT, 'Beulah', 'Gingles', 31, 'bgingles6@loc.gov'),
    (DEFAULT, 'Tessy', 'Hellwing', 14, 'thellwing7@ox.ac.uk'),
    (DEFAULT, 'Gibb', 'Abbet', 65, 'gabbet8@ebay.co.uk'),
    (DEFAULT, 'Imojean', 'Bastiman', 67, 'ibastiman9@istockphoto.com'),
    (DEFAULT, 'Honey', 'Gilmartin', 26, 'hgilmartina@disqus.com'),
    (DEFAULT, 'Leonardo', 'Casterton', 76, 'lcastertonb@edublogs.org'),
    (DEFAULT, 'Bianka', 'Gebbe', 26, 'bgebbec@sitemeter.com'),
    (DEFAULT, 'Kai', 'Petasch', 55, 'kpetaschd@merriam-webster.com'),
    (DEFAULT, 'Anette', 'Sweetnam', 76, 'asweetname@stanford.edu'),
    (DEFAULT, 'Laney', 'Depke', 17, 'ldepkef@who.int'),
    (DEFAULT, 'Gayel', 'Van Weedenburg', 78, 'gvanweedenburgg@hud.gov'),
    (DEFAULT, 'Reinhard', 'Dodgson', 14, 'rdodgsonh@list-manage.com'),
    (DEFAULT, 'Rennie', 'McKissack', 73, 'rmckissacki@seesaa.net'),
    (DEFAULT, 'Kelly', 'Berriman', 45, 'kberrimanj@edublogs.org'),
    (DEFAULT, 'Humfried', 'Watt', 66, 'hwattk@last.fm'),
    (DEFAULT, 'Pammi', 'Franceschino', 36, 'pfranceschinol@instagram.com'),
    (DEFAULT, 'Hale', 'Kidgell', 83, 'hkidgellm@marketwatch.com'),
    (DEFAULT, 'Curr', 'Endle', 64, 'cendlen@adobe.com'),
    (DEFAULT, 'Deedee', 'Ferrarotti', 83, 'dferrarottio@hibu.com'),
    (DEFAULT, 'Ulric', 'Astbury', 43, 'uastburyp@51.la'),
    (DEFAULT, 'Leigha', 'Shervington', 82, 'lshervingtonq@sbwire.com'),
    (DEFAULT, 'Ashlan', 'Pree', 29, 'apreer@admin.ch'),
    (DEFAULT, 'Si', 'Feaks', 13, 'sfeakss@europa.eu'),
    (DEFAULT, 'Molli', 'Izchaki', 73, 'mizchakit@ca.gov'),
    (DEFAULT, 'Christoforo', 'Rubinsztein', 64, 'crubinszteinu@wisc.edu'),
    (DEFAULT, 'Tristan', 'Puckrin', 39, 'tpuckrinv@mail.ru'),
    (DEFAULT, 'Corie', 'Hallums', 77, 'challumsw@hostgator.com'),
    (DEFAULT, 'Grannie', 'Guthrie', 36, 'gguthriex@patch.com'),
    (DEFAULT, 'Renelle', 'Lawrenceson', 29, 'rlawrencesony@facebook.com'),
    (DEFAULT, 'Gae', 'Moret', 24, 'gmoretz@hexun.com'),
    (DEFAULT, 'Odelle', 'Pavy', 56, 'opavy10@arstechnica.com'),
    (DEFAULT, 'Kessiah', 'Iamittii', 80, 'kiamittii11@about.com'),
    (DEFAULT, 'Aleksandr', 'Armin', 12, 'aarmin12@bravesites.com'),
    (DEFAULT, 'Bobbee', 'Tire', 62, 'btire13@ow.ly'),
    (DEFAULT, 'Ileana', 'Callacher', 32, 'icallacher14@oaic.gov.au'),
    (DEFAULT, 'Walden', 'Daniely', 39, 'wdaniely15@wordpress.org'),
    (DEFAULT, 'Ilyssa', 'McGrath', 78, 'imcgrath16@telegraph.co.uk'),
    (DEFAULT, 'Fulton', 'Handasyde', 49, 'fhandasyde17@auda.org.au'),
    (DEFAULT, 'Kim', 'Saill', 50, 'ksaill18@dagondesign.com'),
    (DEFAULT, 'Moss', 'Aplin', 59, 'maplin19@spiegel.de'),
    (DEFAULT, 'Lincoln', 'Gerran', 15, 'lgerran1a@telegraph.co.uk'),
    (DEFAULT, 'Ali', 'Lesser', 75, 'alesser1b@guardian.co.uk'),
    (DEFAULT, 'Erny', 'Lankford', 41, 'elankford1c@unesco.org'),
    (DEFAULT, 'Rusty', 'Hanshaw', 28, 'rhanshaw1d@ca.gov'),
    (DEFAULT, 'Beatriz', 'McKnish', 84, 'bmcknish1e@kickstarter.com'),
    (DEFAULT, 'Kitty', 'Craske', 61, 'kcraske1f@163.com'),
    (DEFAULT, 'Cassey', 'Dominicacci', 82, 'cdominicacci1g@google.co.uk'),
    (DEFAULT, 'Hilario', 'Wallege', 34, 'hwallege1h@dell.com'),
    (DEFAULT, 'Wilfred', 'Witter', 69, 'wwitter1i@dropbox.com'),
    (DEFAULT, 'Bride', 'Marquot', 23, 'bmarquot1j@dedecms.com'),
    (DEFAULT, 'Clarissa', 'Hatchman', 81, 'chatchman1k@fastcompany.com'),
    (DEFAULT, 'Micah', 'Worland', 13, 'mworland1l@mlb.com'),
    (DEFAULT, 'Lorine', 'Solley', 50, 'lsolley1m@unesco.org'),
    (DEFAULT, 'Xenia', 'Meni', 60, 'xmeni1n@pcworld.com'),
    (DEFAULT, 'Morganne', 'Stilliard', 65, 'mstilliard1o@comsenz.com'),
    (DEFAULT, 'Gregorio', 'Donat', 50, 'gdonat1p@tuttocitta.it'),
    (DEFAULT, 'Adiana', 'Martusewicz', 41, 'amartusewicz1q@yandex.ru'),
    (DEFAULT, 'Phylys', 'Zaniolini', 10, 'pzaniolini1r@nytimes.com'),
    (DEFAULT, 'Elvera', 'Tait', 74, 'etait1s@mapy.cz'),
    (DEFAULT, 'Duane', 'Corbert', 85, 'dcorbert1t@cam.ac.uk'),
    (DEFAULT, 'Reta', 'De la Feld', 21, 'rdelafeld1u@last.fm'),
    (DEFAULT, 'Andra', 'Schoenleiter', 42, 'aschoenleiter1v@narod.ru'),
    (DEFAULT, 'Leroy', 'Buzine', 53, 'lbuzine1w@ibm.com'),
    (DEFAULT, 'Baillie', 'Gludor', 83, 'bgludor1x@miibeian.gov.cn'),
    (DEFAULT, 'Lisetta', 'Broadhurst', 14, 'lbroadhurst1y@free.fr'),
    (DEFAULT, 'Sharon', 'Bownde', 33, 'sbownde1z@hatena.ne.jp'),
    (DEFAULT, 'Gregorius', 'Conrath', 49, 'gconrath20@ycombinator.com'),
    (DEFAULT, 'Susanetta', 'Jeanneau', 18, 'sjeanneau21@livejournal.com'),
    (DEFAULT, 'Oliver', 'Creevy', 49, 'ocreevy22@moonfruit.com'),
    (DEFAULT, 'Tab', 'Shimman', 27, 'tshimman23@sogou.com'),
    (DEFAULT, 'Anjela', 'Hamilton', 18, 'ahamilton24@xinhuanet.com'),
    (DEFAULT, 'Rafi', 'MacLaig', 28, 'rmaclaig25@deviantart.com'),
    (DEFAULT, 'Megan', 'Burgwyn', 14, 'mburgwyn26@irs.gov'),
    (DEFAULT, 'Tybi', 'Veal', 33, 'tveal27@pagesperso-orange.fr'),
    (DEFAULT, 'Carie', 'Zmitrovich', 59, 'czmitrovich28@printfriendly.com'),
    (DEFAULT, 'Zondra', 'Bullen', 67, 'zbullen29@chronoengine.com'),
    (DEFAULT, 'Nichols', 'Hinrichsen', 61, 'nhinrichsen2a@nbcnews.com'),
    (DEFAULT, 'Jilly', 'Jestico', 63, 'jjestico2b@addthis.com'),
    (DEFAULT, 'Amalea', 'Bowcher', 23, 'abowcher2c@uiuc.edu'),
    (DEFAULT, 'Elayne', 'Kollasch', 82, 'ekollasch2d@slate.com'),
    (DEFAULT, 'Charlena', 'Ritchie', 42, 'critchie2e@etsy.com'),
    (DEFAULT, 'Barthel', 'Ennew', 46, 'bennew2f@soup.io'),
    (DEFAULT, 'Delila', 'Haysman', 21, 'dhaysman2g@army.mil'),
    (DEFAULT, 'Piggy', 'Jovicic', 50, 'pjovicic2h@vistaprint.com'),
    (DEFAULT, 'Towney', 'Clinkard', 34, 'tclinkard2i@google.com.au'),
    (DEFAULT, 'Lorie', 'Sentinella', 51, 'lsentinella2j@webmd.com'),
    (DEFAULT, 'Jarvis', 'Beadon', 41, 'jbeadon2k@weebly.com'),
    (DEFAULT, 'Forrester', 'Rosenblum', 42, 'frosenblum2l@opera.com'),
    (DEFAULT, 'Nonna', 'Pollitt', 74, 'npollitt2m@craigslist.org'),
    (DEFAULT, 'Stuart', 'Emberton', 29, 'semberton2n@pinterest.com'),
    (DEFAULT, 'Theodore', 'Marushak', 32, 'tmarushak2o@myspace.com'),
    (DEFAULT, 'Kesley', 'Kingsnod', 53, 'kkingsnod2p@tripadvisor.com'),
    (DEFAULT, 'Dulcinea', 'Measey', 58, 'dmeasey2q@vk.com'),
    (DEFAULT, 'Emelia', 'Crichton', 82, 'ecrichton2r@ehow.com'),
    (DEFAULT, 'Waite', 'Carmo', 59, 'wcarmo2s@businesswire.com'),
    (DEFAULT, 'Ania', 'Dene', 60, 'adene2t@hugedomains.com'),
    (DEFAULT, 'Haskel', 'Ondrich', 73, 'hondrich2u@yahoo.com'),
    (DEFAULT, 'Wernher', 'Soreau', 11, 'wsoreau2v@wufoo.com'),
    (DEFAULT, 'Jacinthe', 'Feldon', 67, 'jfeldon2w@goodreads.com'),
    (DEFAULT, 'Byrle', 'MacDirmid', 66, 'bmacdirmid2x@boston.com'),
    (DEFAULT, 'Sam', 'Renzini', 46, 'srenzini2y@nymag.com'),
    (DEFAULT, 'Hermina', 'Bussens', 11, 'hbussens2z@w3.org'),
    (DEFAULT, 'Trudey', 'Beattie', 13, 'tbeattie30@vimeo.com'),
    (DEFAULT, 'Mar', 'McElree', 37, 'mmcelree31@cnn.com'),
    (DEFAULT, 'Ninnette', 'Skate', 34, 'nskate32@instagram.com'),
    (DEFAULT, 'Gideon', 'Bryning', 22, 'gbryning33@a8.net'),
    (DEFAULT, 'Moina', 'Zecchinii', 71, 'mzecchinii34@deviantart.com'),
    (DEFAULT, 'Leo', 'Karet', 82, 'lkaret35@theguardian.com'),
    (DEFAULT, 'Lindsey', 'Brambell', 54, 'lbrambell36@ft.com'),
    (DEFAULT, 'Dorie', 'Rasmus', 39, 'drasmus37@hud.gov'),
    (DEFAULT, 'Gerhard', 'Vowells', 31, 'gvowells38@cmu.edu'),
    (DEFAULT, 'Denni', 'Guerrieri', 25, 'dguerrieri39@diigo.com'),
    (DEFAULT, 'Sonnie', 'Brimmacombe', 23, 'sbrimmacombe3a@addthis.com'),
    (DEFAULT, 'Lissy', 'Cotterill', 34, 'lcotterill3b@narod.ru'),
    (DEFAULT, 'Charity', 'Beneix', 74, 'cbeneix3c@amazon.com'),
    (DEFAULT, 'Gael', 'Baggaley', 55, 'gbaggaley3d@illinois.edu'),
    (DEFAULT, 'Marietta', 'Speller', 30, 'mspeller3e@fotki.com'),
    (DEFAULT, 'Ezekiel', 'Rankin', 34, 'erankin3f@loc.gov'),
    (DEFAULT, 'Marci', 'Aylwin', 23, 'maylwin3g@dmoz.org'),
    (DEFAULT, 'Bryon', 'Cruse', 30, 'bcruse3h@time.com'),
    (DEFAULT, 'Niko', 'Rosenblum', 70, 'nrosenblum3i@chron.com'),
    (DEFAULT, 'Charita', 'Tetlow', 29, 'ctetlow3j@disqus.com'),
    (DEFAULT, 'Bertina', 'Jacobs', 47, 'bjacobs3k@java.com'),
    (DEFAULT, 'Patti', 'Prester', 19, 'pprester3l@cornell.edu'),
    (DEFAULT, 'Alain', 'Iremonger', 22, 'airemonger3m@irs.gov'),
    (DEFAULT, 'Lock', 'Klaes', 64, 'lklaes3n@google.nl'),
    (DEFAULT, 'Anne', 'Scurrer', 20, 'ascurrer3o@barnesandnoble.com'),
    (DEFAULT, 'Debbie', 'Quincee', 78, 'dquincee3p@topsy.com'),
    (DEFAULT, 'Killie', 'Berriball', 44, 'kberriball3q@studiopress.com'),
    (DEFAULT, 'Dori', 'Tween', 20, 'dtween3r@pcworld.com'),
    (DEFAULT, 'Aubine', 'Lints', 18, 'alints3s@wsj.com'),
    (DEFAULT, 'Ban', 'McKellen', 53, 'bmckellen3t@shinystat.com'),
    (DEFAULT, 'Everard', 'Stubs', 73, 'estubs3u@naver.com'),
    (DEFAULT, 'Dari', 'Steed', 81, 'dsteed3v@hubpages.com'),
    (DEFAULT, 'Ardyce', 'Howroyd', 82, 'ahowroyd3w@storify.com'),
    (DEFAULT, 'Emmy', 'Christophe', 25, 'echristophe3x@gizmodo.com'),
    (DEFAULT, 'Andres', 'Castletine', 52, 'acastletine3y@cafepress.com'),
    (DEFAULT, 'Clarabelle', 'Liversley', 33, 'cliversley3z@comcast.net'),
    (DEFAULT, 'Gifford', 'Phateplace', 13, 'gphateplace40@usatoday.com'),
    (DEFAULT, 'Luce', 'Unger', 39, 'lunger41@networkadvertising.org'),
    (DEFAULT, 'Sholom', 'Clayill', 41, 'sclayill42@taobao.com'),
    (DEFAULT, 'Felicdad', 'Dallimare', 41, 'fdallimare43@weather.com'),
    (DEFAULT, 'Nathalia', 'Trunkfield', 47, 'ntrunkfield44@cisco.com'),
    (DEFAULT, 'Bobbye', 'Goodliff', 65, 'bgoodliff45@skype.com');

  INSERT INTO plans
  VALUES 
    ('1-day biking', 7.99),
    ('1-day biking+ (inc. electric bikes)', 9.99),
    ('1-day car rental', 24.99),
    ('3-days biking', 14.99),
    ('3-days biking+ (inc. electric bikes)', 19.99),
    ('3-days car rental', 49.99),
    ('3-days combo (inc. all bikes and cars)', 59.99),
    ('7-days biking', 24.99),
    ('7-days biking+', 29.99),
    ('7-days car rental', 59.99),
    ('7-days combo (inc. all bikes and cars)', 69.99),
    ('1-trip biking', 2.99),
    ('1-trip biking+ (electric bikes)', 3.99),
    ('2-trips biking', 3.99),
    ('2-trips biking+ (electric bikes)', 5.99),
    ('10-trips biking', 19.99),
    ('10-trips biking+ (electric bikes)', 29.99),
    ('1-month biking', 39.99),
    ('1-month biking+ (electric bikes)', 49.99),
    ('1-month car rental', 99.99),
    ('1-month combo (inc. all bikes and cars)', 119.99),
    ('1-month biking - Reduced fare', 29.99),
    ('1-month biking+ (electric bikes) - Reduced fare', 39.99),
    ('1-month car rental - Reduced fare', 79.99),
    ('1-month combo (inc. all bikes and cars) - Reduced fare', 99.99),
    ('All year biking', 399.99),
    ('All year biking+', 499.99),
    ('All year car rental', 999.99),
    ('All year combo (inc. all bikes and cars)', 1199.99),
    ('All year biking - Reduced fare', 299.99),
    ('All year biking+ (electric bikes) - Reduced fare', 399.99),
    ('All year car rental - Reduced fare', 799.99),
    ('All year combo (inc. all bikes and cars) - Reduced fare', 999.99),
    ('1-day coverage - regular cars', 9.99),
    ('3-days coverage - regular cars', 19.99),
    ('7-days coverage - regular cars', 39.99),
    ('1-month coverage - regular cars', 79.99),
    ('1-year coverage - regular cars', 799.99),
    ('1-day coverage - luxury cars', 19.99),
    ('3-days coverage - luxury cars', 29.99),
    ('7-days coverage - luxury cars', 49.99),
    ('1-month coverage - luxury cars', 99.99),
    ('1-year coverage - luxury cars', 999.99);

  INSERT INTO limited VALUES 
    ('1-trip biking', 1),
    ('1-trip biking+ (electric bikes)', 1),
    ('2-trips biking', 2),
    ('2-trips biking+ (electric bikes)', 2),
    ('10-trips biking', 10),
    ('10-trips biking+ (electric bikes)', 10);

  INSERT INTO unlimited VALUES 
    ('1-day biking', 1),
    ('1-day biking+ (inc. electric bikes)', 1),
    ('1-day car rental', 1),
    ('3-days biking', 3),
    ('3-days biking+ (inc. electric bikes)', 3),
    ('3-days car rental', 3),
    ('3-days combo (inc. all bikes and cars)', 3),
    ('7-days biking', 7),
    ('7-days biking+', 7),
    ('7-days car rental', 7),
    ('7-days combo (inc. all bikes and cars)', 7),
    ('1-month biking', 30),
    ('1-month biking+ (electric bikes)', 30),
    ('1-month car rental', 30),
    ('1-month combo (inc. all bikes and cars)', 30),
    ('1-month biking - Reduced fare', 30),
    ('1-month biking+ (electric bikes) - Reduced fare', 30),
    ('1-month car rental - Reduced fare', 30),
    ('1-month combo (inc. all bikes and cars) - Reduced fare', 30),
    ('All year biking', 365),
    ('All year biking+', 365),
    ('All year car rental', 365),
    ('All year combo (inc. all bikes and cars)', 365),
    ('All year biking - Reduced fare', 365),
    ('All year biking+ (electric bikes) - Reduced fare', 365),
    ('All year car rental - Reduced fare', 365),
    ('All year combo (inc. all bikes and cars) - Reduced fare', 365);

  INSERT INTO insurance
  VALUES
    ('1-day coverage - regular cars', 10000, 1),
    ('3-days coverage - regular cars', 30000, 3),
    ('7-days coverage - regular cars', 100000, 7),
    ('1-month coverage - regular cars', 1000000, 30),
    ('1-year coverage - regular cars', 3000000, 365),
    ('1-day coverage - luxury cars', 30000, 1),
    ('3-days coverage - luxury cars', 100000, 3),
    ('7-days coverage - luxury cars', 1000000, 7),
    ('1-month coverage - luxury cars', 5000000, 30),
    ('1-year coverage - luxury cars', 50000000, 365);

INSERT INTO status VALUES 
  (1, 'Pending'),
  (2, 'Completed'),
  (3, 'Cancelled');

INSERT INTO transactions(tranID,userID,name,status,date,subtotal) VALUES
 (1,3,'1-day biking+ (inc. electric bikes)',2,'2014-12-13 07:28:04',435.08)
,(2,123,'10-trips biking',1,'2017-03-30 08:01:22',733.65)
,(3,115,'1-month car rental',2,'2013-04-29 06:54:40',552.43)
,(4,26,'All year car rental',3,'2016-10-11 08:44:00',54.07)
,(5,70,'1-day car rental',3,'2013-10-24 07:56:29',572.13)
,(6,125,'1-month car rental',1,'2016-06-09 08:38:56',872.87)
,(7,150,'3-days car rental',2,'2018-11-21 07:46:29',637.22)
,(8,133,'7-days car rental',2,'2018-12-23 08:37:31',212.13)
,(9,44,'1-month biking',1,'2018-02-07 07:59:24',35.09)
,(10,18,'1-month coverage - luxury cars',2,'2018-07-16 08:37:41',916.85)
,(11,88,'1-month biking - Reduced fare',2,'2013-03-14 07:04:14',998.44)
,(12,68,'7-days combo (inc. all bikes and cars)',3,'2013-06-10 07:36:34',392.05)
,(13,4,'1-day coverage - regular cars',1,'2015-09-01 08:55:48',506.91)
,(14,79,'7-days coverage - regular cars',1,'2016-11-09 08:34:01',193.61)
,(15,81,'1-month biking+ (electric bikes) - Reduced fare',3,'2014-07-20 08:18:10',329.75)
,(16,52,'1-month combo (inc. all bikes and cars)',2,'2018-12-18 07:08:58',371.09)
,(17,79,'7-days biking',3,'2016-09-24 06:02:57',164.86)
,(18,64,'1-day coverage - luxury cars',1,'2015-12-20 08:07:18',70.24)
,(19,20,'All year car rental',3,'2016-04-21 06:55:25',781.81)
,(20,137,'3-days combo (inc. all bikes and cars)',3,'2018-10-28 06:48:31',1010.40)
,(21,15,'1-year coverage - regular cars',1,'2015-11-11 07:11:57',284.12)
,(22,115,'1-month biking - Reduced fare',2,'2014-10-24 06:16:39',128.51)
,(23,29,'1-month combo (inc. all bikes and cars)',3,'2013-05-09 06:44:10',956.23)
,(24,46,'1-month biking - Reduced fare',1,'2017-12-23 08:30:16',888.24)
,(25,75,'1-month car rental - Reduced fare',2,'2014-12-07 07:36:49',152.84)
,(26,24,'1-month combo (inc. all bikes and cars) - Reduced fare',2,'2016-04-03 08:06:21',593.50)
,(27,139,'10-trips biking+ (electric bikes)',1,'2015-03-21 08:19:21',590.01)
,(28,71,'1-month biking+ (electric bikes) - Reduced fare',1,'2013-08-03 06:23:08',1012.38)
,(29,121,'2-trips biking+ (electric bikes)',1,'2015-08-22 06:44:20',490.53)
,(30,130,'All year biking+ (electric bikes) - Reduced fare',1,'2013-10-04 08:28:25',845.17)
,(31,120,'1-month biking+ (electric bikes) - Reduced fare',1,'2014-11-09 07:39:51',868.71)
,(32,15,'10-trips biking',1,'2015-10-17 08:11:04',81.98)
,(33,92,'1-month coverage - luxury cars',2,'2017-01-12 06:37:25',874.68)
,(34,72,'2-trips biking+ (electric bikes)',2,'2015-01-06 07:56:28',257.22)
,(35,81,'3-days car rental',1,'2015-03-20 07:52:23',385.71)
,(36,11,'1-day coverage - regular cars',2,'2017-10-02 08:39:07',575.81)
,(37,64,'1-year coverage - regular cars',3,'2013-04-04 07:09:26',775.77)
,(38,29,'3-days combo (inc. all bikes and cars)',1,'2014-05-09 08:49:26',54.49)
,(39,99,'All year biking - Reduced fare',3,'2013-10-09 08:42:02',125.23)
,(40,10,'All year biking - Reduced fare',3,'2019-01-05 07:25:55',279.75)
,(41,133,'1-day biking+ (inc. electric bikes)',2,'2018-01-22 08:12:18',676.35)
,(42,18,'1-trip biking',3,'2018-07-30 06:09:08',357.13)
,(43,143,'All year car rental',2,'2014-03-17 08:14:38',488.54)
,(44,44,'1-trip biking+ (electric bikes)',2,'2016-02-03 08:28:32',735.27)
,(45,6,'3-days combo (inc. all bikes and cars)',1,'2018-07-03 08:25:38',407.30)
,(46,21,'All year biking',1,'2017-02-21 07:00:30',89.00)
,(47,18,'1-trip biking',2,'2016-04-22 07:00:58',305.42)
,(48,145,'3-days coverage - luxury cars',2,'2013-07-14 07:51:25',489.69)
,(49,129,'1-month combo (inc. all bikes and cars)',3,'2019-01-31 06:19:50',272.93)
,(50,121,'All year biking',2,'2016-04-19 07:28:11',967.52)
,(51,130,'10-trips biking+ (electric bikes)',2,'2014-05-02 08:17:58',977.16)
,(52,45,'1-year coverage - luxury cars',3,'2014-04-01 07:35:29',959.78)
,(53,138,'1-month biking - Reduced fare',3,'2015-10-23 06:50:20',756.12)
,(54,114,'All year combo (inc. all bikes and cars)',1,'2019-02-03 07:08:32',363.61)
,(55,111,'1-month coverage - regular cars',2,'2017-10-24 06:26:51',382.85)
,(56,16,'10-trips biking+ (electric bikes)',2,'2015-05-03 06:48:51',182.19)
,(57,58,'1-month biking',1,'2016-08-15 07:25:56',595.72)
,(58,82,'1-month car rental',2,'2014-01-15 07:00:36',422.82)
,(59,32,'7-days combo (inc. all bikes and cars)',1,'2014-04-14 06:33:30',946.91)
,(60,129,'All year combo (inc. all bikes and cars) - Reduced fare',1,'2013-03-14 06:25:26',717.33)
,(61,60,'All year car rental - Reduced fare',2,'2016-07-18 07:38:40',810.92)
,(62,94,'7-days biking+',3,'2018-12-03 06:05:08',472.66)
,(63,130,'3-days biking',3,'2016-07-20 08:40:49',314.26)
,(64,17,'1-year coverage - regular cars',1,'2017-03-08 07:02:44',497.75)
,(65,20,'1-day car rental',2,'2016-11-28 08:27:36',810.24)
,(66,63,'3-days coverage - luxury cars',3,'2018-02-06 07:05:23',406.05)
,(67,118,'3-days combo (inc. all bikes and cars)',1,'2015-04-30 07:28:32',408.08)
,(68,106,'3-days biking',2,'2018-09-02 07:55:18',467.72)
,(69,44,'7-days car rental',2,'2018-02-01 07:54:30',68.19)
,(70,82,'1-month car rental',3,'2016-04-25 06:08:24',427.13)
,(71,111,'1-day biking',2,'2018-09-03 08:00:15',255.73)
,(72,107,'1-month coverage - regular cars',1,'2013-08-31 06:04:55',447.64)
,(73,139,'3-days car rental',2,'2018-03-24 08:53:35',977.93)
,(74,106,'7-days car rental',3,'2014-07-08 08:10:48',273.28)
,(75,63,'7-days coverage - luxury cars',1,'2014-01-22 08:02:55',860.08)
,(76,90,'All year biking+',1,'2016-09-27 07:54:12',775.07)
,(77,16,'1-month combo (inc. all bikes and cars)',1,'2016-02-27 08:03:11',396.09)
,(78,11,'3-days biking+ (inc. electric bikes)',2,'2013-12-06 08:37:52',785.96)
,(79,70,'1-month biking+ (electric bikes) - Reduced fare',2,'2013-07-12 06:08:45',566.07)
,(80,146,'7-days biking+',2,'2017-11-10 08:54:30',923.62)
,(81,78,'3-days biking',3,'2018-02-18 07:11:49',84.03)
,(82,59,'1-month biking+ (electric bikes)',1,'2018-07-03 08:29:38',492.85)
,(83,140,'1-month coverage - luxury cars',1,'2014-10-29 08:14:51',826.63)
,(84,104,'2-trips biking+ (electric bikes)',3,'2014-05-12 06:24:55',481.45)
,(85,101,'All year biking',1,'2013-08-22 08:36:15',719.60)
,(86,10,'1-month biking - Reduced fare',3,'2013-04-16 07:52:50',685.43)
,(87,72,'1-day coverage - luxury cars',3,'2017-12-19 06:40:19',1007.53)
,(88,111,'10-trips biking+ (electric bikes)',3,'2018-10-03 08:23:20',583.31)
,(89,39,'1-day coverage - luxury cars',2,'2018-08-25 07:14:01',404.52)
,(90,54,'10-trips biking',3,'2017-07-10 07:42:48',328.27)
,(91,118,'7-days biking',3,'2016-12-03 07:46:13',886.97)
,(92,12,'1-month car rental - Reduced fare',1,'2016-02-17 08:36:05',132.98)
,(93,137,'1-month biking+ (electric bikes) - Reduced fare',1,'2016-12-02 08:38:14',624.75)
,(94,109,'3-days coverage - regular cars',3,'2013-06-25 08:03:39',1020.38)
,(95,53,'1-trip biking+ (electric bikes)',1,'2019-02-18 08:28:14',804.00)
,(96,58,'1-month car rental',2,'2014-01-12 06:57:23',927.43)
,(97,108,'1-month combo (inc. all bikes and cars)',2,'2014-06-13 06:07:01',434.50)
,(98,136,'3-days combo (inc. all bikes and cars)',2,'2014-05-26 07:21:07',143.85)
,(99,52,'10-trips biking+ (electric bikes)',3,'2015-06-19 08:37:19',988.58)
,(100,113,'3-days car rental',3,'2018-02-08 07:35:02',99.87)
,(101,120,'3-days car rental',2,'2016-09-06 07:25:14',229.47)
,(102,114,'3-days biking',3,'2015-09-07 07:26:23',281.35)
,(103,6,'3-days car rental',1,'2016-03-19 08:48:11',466.83)
,(104,4,'1-day car rental',2,'2013-07-05 06:03:35',135.43)
,(105,52,'1-month biking+ (electric bikes)',2,'2014-12-09 07:01:11',850.88)
,(106,53,'3-days coverage - luxury cars',3,'2017-12-07 06:15:12',961.71)
,(107,142,'7-days combo (inc. all bikes and cars)',3,'2018-11-28 07:00:59',76.19)
,(108,34,'10-trips biking',2,'2015-09-06 07:51:22',81.75)
,(109,132,'3-days combo (inc. all bikes and cars)',2,'2016-01-31 07:45:36',918.75)
,(110,107,'2-trips biking+ (electric bikes)',2,'2018-07-21 08:30:38',801.32)
,(111,141,'1-month car rental - Reduced fare',1,'2014-07-07 08:25:57',548.46)
,(112,111,'1-month biking',2,'2016-04-13 06:52:37',475.90)
,(113,100,'3-days biking',1,'2013-05-29 07:25:49',231.99)
,(114,130,'1-month car rental',3,'2013-11-25 07:43:42',149.36)
,(115,49,'3-days car rental',1,'2014-06-23 06:06:21',322.51)
,(116,84,'All year biking',1,'2016-06-29 06:41:16',939.76)
,(117,114,'7-days coverage - regular cars',3,'2013-06-26 07:32:28',791.82)
,(118,86,'1-day biking+ (inc. electric bikes)',3,'2013-06-14 07:30:31',416.20)
,(119,49,'1-month coverage - luxury cars',1,'2016-10-04 08:19:35',733.98)
,(120,91,'1-trip biking',3,'2018-04-28 08:47:16',358.15)
,(121,88,'1-year coverage - regular cars',3,'2014-01-08 06:21:22',506.72)
,(122,109,'3-days coverage - regular cars',1,'2015-03-03 06:49:39',366.51)
,(123,11,'All year combo (inc. all bikes and cars) - Reduced fare',2,'2015-12-25 06:01:49',495.73)
,(124,96,'1-month car rental',2,'2013-08-01 07:02:27',46.71)
,(125,77,'All year car rental',1,'2014-07-25 07:58:16',918.89)
,(126,25,'All year biking+',3,'2018-05-22 06:48:55',792.83)
,(127,15,'1-day biking',3,'2014-08-10 08:25:53',930.84)
,(128,79,'1-month coverage - luxury cars',3,'2017-09-11 07:06:28',341.37)
,(129,123,'All year biking',3,'2017-11-08 07:58:44',355.82)
,(130,113,'7-days car rental',3,'2014-05-27 07:14:59',150.17)
,(131,20,'1-month combo (inc. all bikes and cars)',2,'2017-09-22 08:47:43',248.91)
,(132,130,'1-trip biking+ (electric bikes)',2,'2017-06-04 06:29:52',596.79)
,(133,131,'1-month car rental - Reduced fare',2,'2016-12-26 07:01:14',755.29)
,(134,4,'1-trip biking+ (electric bikes)',1,'2016-02-01 06:44:55',928.38)
,(135,128,'10-trips biking+ (electric bikes)',2,'2013-04-07 07:01:29',266.78)
,(136,10,'1-day coverage - luxury cars',1,'2014-05-12 06:35:05',667.75)
,(137,81,'3-days coverage - regular cars',2,'2018-11-16 08:15:27',38.16)
,(138,92,'3-days coverage - luxury cars',2,'2015-12-02 06:23:23',766.93)
,(139,87,'2-trips biking',1,'2018-10-25 06:28:13',366.52)
,(140,85,'3-days biking+ (inc. electric bikes)',3,'2018-04-08 08:42:04',566.29)
,(141,104,'All year biking+',2,'2018-06-10 06:33:50',310.41)
,(142,98,'All year car rental',1,'2014-07-10 08:14:22',575.15)
,(143,102,'All year biking+',2,'2014-06-19 08:08:20',156.21)
,(144,140,'All year biking+',3,'2013-07-27 07:09:30',136.04)
,(145,103,'7-days coverage - regular cars',2,'2018-11-02 07:58:49',364.44)
,(146,12,'1-month biking',3,'2017-12-28 07:01:13',211.25)
,(147,13,'1-month car rental',1,'2013-05-11 08:12:51',253.22)
,(148,130,'2-trips biking',2,'2013-05-17 07:48:19',266.57)
,(149,7,'1-day coverage - luxury cars',3,'2015-03-10 07:43:07',919.37)
,(150,57,'7-days biking+',1,'2017-07-26 06:53:47',594.66)
,(151,3,'3-days biking+ (inc. electric bikes)',1,'2017-05-03 06:46:44',279.75)
,(152,3,'3-days combo (inc. all bikes and cars)',1,'2017-01-07 06:51:53',406.77)
,(153,3,'3-days combo (inc. all bikes and cars)',2,'2017-06-23 08:09:17',31.10)
,(154,3,'7-days biking',1,'2017-06-05 08:20:24',207.03)
,(155,3,'1-month car rental',2,'2013-10-25 06:37:06',46.35)
,(156,3,'10-trips biking',2,'2014-08-07 06:47:07',276.17)
,(157,3,'1-month car rental - Reduced fare',2,'2018-11-09 08:09:45',177.08)
,(158,3,'3-days biking',1,'2017-04-02 06:44:39',655.80)
,(159,3,'All year combo (inc. all bikes and cars) - Reduced fare',1,'2017-12-07 06:21:36',543.72)
,(160,3,'7-days car rental',2,'2013-05-26 08:26:02',981.26)
,(161,3,'All year combo (inc. all bikes and cars)',2,'2014-02-05 07:58:40',810.52)
,(162,3,'7-days biking',1,'2013-08-16 07:51:43',414.73)
,(163,3,'3-days coverage - luxury cars',3,'2013-03-03 07:16:51',1018.59)
,(164,3,'1-day coverage - regular cars',1,'2018-07-19 06:28:47',644.24)
,(165,3,'7-days biking',1,'2018-06-23 06:33:44',491.96)
,(166,3,'1-day biking+ (inc. electric bikes)',3,'2018-09-25 07:05:11',604.83)
,(167,3,'1-month combo (inc. all bikes and cars) - Reduced fare',3,'2014-03-13 07:43:05',398.81)
,(168,3,'1-month biking',2,'2017-06-02 08:42:47',123.00)
,(169,3,'1-day car rental',3,'2017-12-22 07:10:57',167.26)
,(170,3,'7-days coverage - luxury cars',1,'2018-06-12 06:56:40',971.60)
,(171,3,'10-trips biking',2,'2015-04-19 06:15:44',712.24)
,(172,3,'1-year coverage - regular cars',2,'2015-03-19 08:35:40',386.18)
,(173,3,'3-days biking+ (inc. electric bikes)',2,'2014-11-01 08:50:03',122.12)
,(174,3,'1-month car rental - Reduced fare',2,'2018-02-02 08:49:08',799.84)
,(175,3,'All year biking+ (electric bikes) - Reduced fare',1,'2018-02-08 08:32:33',326.69)
,(176,3,'3-days coverage - regular cars',3,'2013-11-11 06:38:26',843.30)
,(177,3,'1-month biking',1,'2017-09-26 07:59:17',273.33)
,(178,3,'3-days combo (inc. all bikes and cars)',3,'2017-05-30 07:27:52',802.08)
,(179,3,'1-day car rental',3,'2017-09-17 07:00:24',177.98)
,(180,3,'1-month combo (inc. all bikes and cars) - Reduced fare',2,'2018-06-27 07:29:52',70.84)
,(181,3,'1-month coverage - regular cars',3,'2014-11-03 08:56:33',598.82)
,(182,3,'1-month car rental',2,'2014-08-21 07:01:44',373.31)
,(183,3,'3-days coverage - regular cars',2,'2018-12-12 08:50:56',962.87)
,(184,3,'3-days coverage - regular cars',2,'2013-08-09 07:16:52',879.99)
,(185,3,'1-month combo (inc. all bikes and cars)',2,'2017-04-21 08:48:11',1021.92)
,(186,3,'7-days car rental',1,'2015-07-08 06:03:02',937.32)
,(187,3,'7-days car rental',3,'2018-09-27 07:59:11',739.34)
,(188,3,'All year biking - Reduced fare',3,'2014-03-25 07:31:44',82.76)
,(189,3,'7-days coverage - luxury cars',1,'2017-02-11 07:52:09',733.66)
,(190,3,'1-day biking+ (inc. electric bikes)',2,'2018-07-25 07:38:25',849.66)
,(191,3,'1-trip biking',1,'2017-05-28 07:44:25',498.94)
,(192,3,'3-days coverage - luxury cars',2,'2017-05-30 08:51:23',630.95)
,(193,3,'All year biking+ (electric bikes) - Reduced fare',3,'2015-08-20 06:57:25',762.43)
,(194,3,'All year car rental',1,'2015-04-01 06:49:00',467.13)
,(195,3,'3-days coverage - luxury cars',3,'2015-09-03 06:37:04',53.98)
,(196,3,'1-month car rental - Reduced fare',2,'2016-03-13 07:09:05',1025.52)
,(197,3,'1-trip biking+ (electric bikes)',1,'2017-07-08 07:56:02',581.63)
,(198,3,'7-days biking',3,'2015-04-02 06:42:33',546.17)
,(199,3,'1-year coverage - regular cars',2,'2015-06-18 07:21:14',1017.23)
,(200,3,'3-days combo (inc. all bikes and cars)',3,'2018-03-11 06:53:56',1024.40)
,(201,3,'1-month biking+ (electric bikes)',3,'2017-10-29 07:29:21',683.80)
,(202,3,'All year combo (inc. all bikes and cars) - Reduced fare',1,'2018-10-23 08:05:30',89.93)
,(203,3,'3-days car rental',1,'2014-01-31 08:06:40',742.23)
,(204,3,'1-month coverage - regular cars',1,'2018-05-08 06:58:46',712.35)
,(205,3,'1-day biking+ (inc. electric bikes)',2,'2017-08-01 07:55:35',343.36)
,(206,3,'1-day biking+ (inc. electric bikes)',2,'2015-02-23 07:27:50',128.42)
,(207,3,'7-days biking',1,'2018-12-04 07:29:26',839.91)
,(208,3,'1-month car rental - Reduced fare',1,'2014-10-05 08:01:29',939.33)
,(209,3,'1-day biking+ (inc. electric bikes)',2,'2014-10-01 06:29:42',240.65)
,(210,3,'1-trip biking',1,'2015-09-12 06:38:40',686.49)
,(211,3,'All year car rental - Reduced fare',3,'2015-05-12 07:45:23',289.83)
,(212,3,'3-days combo (inc. all bikes and cars)',3,'2014-01-03 07:10:31',982.17)
,(213,3,'3-days coverage - luxury cars',2,'2014-12-18 06:32:43',226.17)
,(214,3,'7-days coverage - luxury cars',3,'2018-09-07 07:35:26',371.20)
,(215,3,'All year combo (inc. all bikes and cars) - Reduced fare',3,'2013-09-26 07:25:40',224.67)
,(216,3,'2-trips biking+ (electric bikes)',3,'2016-03-17 06:49:42',39.31)
,(217,3,'1-month coverage - regular cars',2,'2017-11-30 07:31:57',266.64)
,(218,3,'1-trip biking+ (electric bikes)',3,'2018-06-12 08:54:27',593.13)
,(219,3,'All year combo (inc. all bikes and cars)',1,'2015-06-02 08:08:18',181.91)
,(220,3,'7-days biking+',2,'2019-01-18 07:42:54',829.53)
,(221,3,'1-month coverage - regular cars',2,'2014-09-20 06:38:43',533.52)
,(222,3,'10-trips biking',3,'2018-11-24 06:16:01',425.48)
,(223,3,'1-month combo (inc. all bikes and cars) - Reduced fare',3,'2014-09-26 07:25:00',988.82)
,(224,3,'7-days biking+',3,'2015-11-21 08:23:55',132.98)
,(225,3,'1-month car rental - Reduced fare',2,'2015-01-14 06:35:16',669.80)
,(226,3,'All year car rental',2,'2017-12-03 08:41:36',500.23)
,(227,3,'10-trips biking+ (electric bikes)',1,'2017-07-05 06:47:23',475.35)
,(228,3,'1-day biking+ (inc. electric bikes)',3,'2018-05-22 07:01:48',586.44)
,(229,3,'3-days coverage - luxury cars',3,'2016-08-10 06:47:37',502.26)
,(230,3,'1-month combo (inc. all bikes and cars) - Reduced fare',2,'2014-10-30 08:26:21',142.43)
,(231,3,'7-days coverage - luxury cars',1,'2016-05-18 08:21:45',893.99)
,(232,3,'1-month combo (inc. all bikes and cars)',3,'2015-10-26 07:57:22',424.49)
,(233,3,'1-day coverage - regular cars',3,'2016-09-28 07:05:47',854.16)
,(234,3,'7-days biking+',3,'2016-09-02 07:54:31',151.84)
,(235,3,'1-month car rental',1,'2014-05-11 06:46:29',266.34)
,(236,3,'3-days combo (inc. all bikes and cars)',3,'2018-03-17 06:30:53',144.72)
,(237,3,'10-trips biking',3,'2017-04-15 08:38:08',657.28)
,(238,3,'1-month car rental',3,'2014-09-25 06:50:53',255.06)
,(239,3,'1-month coverage - regular cars',3,'2015-12-10 08:11:17',873.49)
,(240,3,'1-day biking+ (inc. electric bikes)',3,'2014-09-30 07:06:38',267.15)
,(241,3,'2-trips biking+ (electric bikes)',3,'2017-12-18 06:31:35',262.30)
,(242,3,'1-trip biking+ (electric bikes)',2,'2017-09-20 06:45:57',272.20)
,(243,3,'1-day biking',1,'2014-04-14 06:42:26',760.41)
,(244,3,'1-year coverage - regular cars',2,'2015-06-23 07:24:32',456.87)
,(245,3,'3-days combo (inc. all bikes and cars)',1,'2018-05-20 08:34:03',703.12)
,(246,3,'3-days coverage - luxury cars',3,'2014-03-14 06:17:56',468.52)
,(247,3,'1-month biking',1,'2016-06-17 08:22:57',434.18)
,(248,3,'All year car rental',3,'2016-09-20 08:14:24',283.69)
,(249,3,'1-month biking+ (electric bikes) - Reduced fare',2,'2014-08-08 07:01:07',683.36)
,(250,3,'1-day biking',2,'2013-09-03 06:59:16',394.84)
,(251,3,'7-days biking+',2,'2018-09-11 07:42:13',901.77)
,(252,3,'3-days car rental',1,'2013-05-21 07:32:59',803.86)
,(253,3,'3-days coverage - regular cars',2,'2013-08-07 08:13:11',222.03)
,(254,3,'1-month car rental',1,'2017-11-29 07:40:41',759.49)
,(255,3,'1-day biking',3,'2018-05-19 08:13:51',815.04)
,(256,3,'All year car rental',3,'2015-04-06 06:29:28',966.15)
,(257,3,'7-days biking+',3,'2018-08-11 06:35:07',221.03)
,(258,3,'3-days coverage - regular cars',2,'2015-01-05 08:30:39',520.14)
,(259,3,'3-days biking',3,'2013-09-13 08:46:03',769.10)
,(260,3,'1-month biking+ (electric bikes)',1,'2013-12-05 08:29:39',568.16)
,(261,3,'2-trips biking',1,'2017-08-09 06:14:45',697.96)
,(262,3,'1-day coverage - luxury cars',2,'2018-05-24 07:13:02',435.82)
,(263,3,'1-month car rental - Reduced fare',3,'2014-11-13 06:13:47',734.49)
,(264,3,'1-month biking+ (electric bikes)',3,'2016-01-01 07:54:04',119.02)
,(265,3,'1-month biking+ (electric bikes)',3,'2014-09-14 08:22:02',66.01)
,(266,3,'7-days coverage - luxury cars',2,'2018-11-04 07:11:02',777.10)
,(267,3,'1-month car rental - Reduced fare',3,'2014-09-30 07:06:32',194.82)
,(268,3,'1-year coverage - regular cars',2,'2014-06-27 07:30:52',500.14)
,(269,3,'All year biking - Reduced fare',2,'2014-02-02 08:55:24',636.17)
,(270,3,'All year biking - Reduced fare',2,'2018-05-10 06:30:03',756.94)
,(271,3,'7-days car rental',3,'2017-09-21 07:11:10',808.28)
,(272,3,'1-year coverage - luxury cars',2,'2016-12-24 06:08:21',758.64)
,(273,3,'2-trips biking',3,'2017-03-07 07:27:03',467.55)
,(274,3,'1-day coverage - luxury cars',2,'2016-11-16 06:57:40',515.11)
,(275,3,'1-year coverage - regular cars',3,'2017-09-14 07:53:48',314.77)
,(276,3,'10-trips biking+ (electric bikes)',1,'2017-06-20 08:57:49',716.35)
,(277,3,'All year biking',3,'2017-06-02 07:03:42',797.81)
,(278,3,'1-year coverage - regular cars',3,'2016-01-13 07:43:19',165.87)
,(279,3,'7-days combo (inc. all bikes and cars)',1,'2015-03-02 06:29:54',970.27)
,(280,3,'All year biking+ (electric bikes) - Reduced fare',2,'2015-06-11 06:22:12',332.28)
,(281,3,'1-day car rental',3,'2014-07-08 07:44:32',548.51)
,(282,3,'2-trips biking',2,'2015-08-23 06:05:42',501.50)
,(283,3,'1-month combo (inc. all bikes and cars) - Reduced fare',2,'2014-12-18 08:56:43',1005.44)
,(284,3,'1-month combo (inc. all bikes and cars)',2,'2014-01-19 08:30:37',917.71)
,(285,3,'1-month car rental - Reduced fare',2,'2017-07-31 07:43:02',819.11)
,(286,3,'1-month coverage - regular cars',2,'2016-03-13 07:40:59',433.76)
,(287,3,'All year biking',2,'2014-01-23 07:07:19',477.91)
,(288,3,'1-month coverage - regular cars',1,'2014-03-01 07:44:23',370.11)
,(289,3,'3-days biking',1,'2014-02-02 07:24:03',858.56)
,(290,3,'3-days combo (inc. all bikes and cars)',1,'2018-02-18 06:49:16',150.60)
,(291,3,'10-trips biking',3,'2013-09-03 06:50:05',415.77)
,(292,3,'10-trips biking',1,'2016-11-10 08:44:54',566.12)
,(293,3,'3-days biking+ (inc. electric bikes)',3,'2014-10-02 08:13:13',734.72)
,(294,3,'10-trips biking',2,'2016-01-25 07:02:39',267.46)
,(295,3,'1-day biking+ (inc. electric bikes)',1,'2014-01-06 07:43:10',334.54)
,(296,3,'1-month biking+ (electric bikes) - Reduced fare',1,'2018-05-18 08:58:47',933.42)
,(297,3,'All year biking+',3,'2016-07-18 08:19:52',809.97)
,(298,3,'1-day coverage - regular cars',2,'2017-09-21 08:02:31',960.19)
,(299,3,'3-days biking+ (inc. electric bikes)',3,'2017-04-19 07:57:46',50.48)
,(300,3,'1-year coverage - luxury cars',3,'2018-11-23 07:40:30',1007.56);



INSERT INTO accepts(stationID, vType, capacity)
VALUES
  (6274,'luxury car',50),
  (6047,'regular car',35),
  (6126,'luxury car',32),
  (6232,'luxury car',43),
  (6004,'regular car',36),
  (6191,'regular car',48),
  (6156,'luxury car',37),
  (6182,'electric bike',41),
  (7033,'luxury car',34),
  (6197,'luxury car',48),
  (6334,'electric bike',22),
  (6267,'luxury car',22),
  (6152,'bike',8),
  (6193,'luxury car',26),
  (7080,'luxury car',30),
  (4000,'electric bike',14),
  (6221,'bike',24),
  (6142,'regular car',30),
  (6902,'luxury car',44),
  (6026,'regular car',41),
  (7019,'regular car',26),
  (6396,'electric bike',32),
  (6176,'regular car',47),
  (6012,'luxury car',45),
  (6154,'regular car',50),
  (6364,'luxury car',29),
  (6005,'luxury car',13),
  (6901,'electric bike',30),
  (6908,'regular car',10),
  (6259,'bike',5),
  (6118,'luxury car',20),
  (6277,'electric bike',39),
  (7030,'regular car',32),
  (6143,'luxury car',17),
  (6250,'regular car',36),
  (6158,'bike',25),
  (6428,'regular car',13),
  (6181,'regular car',26),
  (6102,'luxury car',47),
  (6108,'electric bike',43),
  (6138,'electric bike',16),
  (6411,'bike',23),
  (6272,'regular car',24),
  (6712,'electric bike',12),
  (6082,'electric bike',13),
  (6157,'luxury car',49),
  (6381,'luxury car',35),
  (6027,'regular car',15),
  (6730,'luxury car',10),
  (7020,'electric bike',45),
  (6910,'luxury car',36),
  (6388,'bike',27),
  (6112,'regular car',10),
  (6733,'luxury car',20),
  (6049,'electric bike',35),
  (7005,'bike',16),
  (6093,'bike',46),
  (6700,'electric bike',38),
  (6248,'regular car',40),
  (6218,'electric bike',41),
  (6048,'regular car',34),
  (7040,'bike',36),
  (6111,'electric bike',14),
  (6023,'bike',45),
  (6105,'regular car',25),
  (6072,'luxury car',43),
  (6114,'regular car',44),
  (6179,'luxury car',19),
  (6015,'electric bike',35),
  (6159,'luxury car',14),
  (7055,'bike',6),
  (6196,'luxury car',24),
  (6230,'electric bike',6),
  (7028,'luxury car',18),
  (6190,'bike',17),
  (6184,'bike',31),
  (7037,'bike',12),
  (6227,'regular car',43),
  (6013,'regular car',12),
  (6103,'luxury car',21),
  (6402,'regular car',13),
  (6043,'electric bike',9),
  (6087,'bike',32),
  (6260,'electric bike',31),
  (6160,'bike',23),
  (6336,'electric bike',17),
  (6070,'bike',49),
  (6309,'regular car',29),
  (6254,'electric bike',9),
  (7084,'electric bike',8),
  (6089,'electric bike',16),
  (6266,'bike',17),
  (6929,'luxury car',18),
  (6147,'luxury car',43),
  (6062,'regular car',47),
  (6117,'bike',29),
  (6225,'luxury car',28),
  (7006,'electric bike',22),
  (6110,'luxury car',8),
  (6064,'regular car',39),
  (6278,'regular car',19),
  (6223,'bike',43),
  (6729,'regular car',27),
  (6129,'bike',15),
  (6025,'luxury car',11),
  (6002,'bike',12),
  (6231,'electric bike',13),
  (6407,'electric bike',31),
  (6748,'electric bike',22),
  (6246,'electric bike',31),
  (6380,'regular car',40),
  (6153,'bike',36),
  (6134,'regular car',43),
  (6247,'bike',36),
  (6137,'electric bike',46),
  (6173,'luxury car',7),
  (6211,'regular car',21),
  (6361,'electric bike',43),
  (6052,'luxury car',13),
  (6280,'bike',15),
  (6307,'luxury car',50),
  (6202,'regular car',44),
  (6744,'luxury car',48),
  (6209,'bike',31),
  (7049,'regular car',34),
  (6141,'regular car',19),
  (6031,'regular car',50),
  (6106,'regular car',42),
  (6060,'luxury car',40),
  (6067,'regular car',5),
  (6020,'regular car',42),
  (6119,'electric bike',39),
  (7078,'electric bike',13),
  (6195,'luxury car',16),
  (7031,'bike',43);



  DO $$
    DECLARE
      carCount INTEGER := 0;
      bikeCount INTEGER := 0;
      randomStartTime TIMESTAMP;
      randomEndTime TIMESTAMP;
      randomUID INT;
      randomStartsAt INT;
      randomEndsAt INT;
      randomSerialNb INT;
      randomType VARCHAR;
      tempTime TIMESTAMP;

    BEGIN
      <<generate>>
      LOOP
        randomStartTime = TIMESTAMP
          '2014-01-01 20:00:00' + random() * (TIMESTAMP '2019-01-01 00:00:00' - TIMESTAMP '2014-01-01 20:00:00');
        randomEndTime := randomStartTime + random() * (randomStartTime + '14 days' - randomStartTime);
        tempTime := randomStartTime;
        randomStartTime := least(randomStartTime, randomEndTime);
        randomEndTime := greatest(tempTime, randomEndTime);

        SELECT userid INTO randomUID FROM users ORDER BY random() limit 1;
        SELECT sid INTO randomStartsAt FROM stations ORDER BY random() limit 1;
        SELECT sid INTO randomEndsAt FROM stations ORDER BY random() limit 1;

        IF carCount > bikeCount
        THEN
          randomType = 'bike';
          bikeCount := bikeCount + 1;
        ELSE
          randomType = 'regular car';
          carCount := carCount + 1;
        END IF;

        SELECT serialnb INTO randomSerialNb FROM vehicles WHERE vType = randomType ORDER BY random() limit 1;
        INSERT INTO trips VALUES(randomStartTime, randomEndTime, randomUID, randomStartsAt, randomEndsAt, randomSerialNb, randomType);
        EXIT generate WHEN (carCount + bikeCount) >= 100;
      END LOOP;
    END;
    $$;
--

INSERT INTO trips VALUES
  ('2015-03-05 13:20:00', '2015-03-08 11:03:08', 14, 6049, 6163, 11, 'bike'),
  ('2015-03-05 13:20:01', '2015-03-08 11:03:08', 14, 6049, 6227, 9, 'bike'),
  ('2015-03-05 13:20:02', '2015-03-08 11:03:08', 14, 6049, 6213, 9, 'bike'),
  ('2015-03-05 13:20:03', '2015-03-08 11:03:08', 14, 6049, 6259, 9, 'bike'),
  ('2015-03-05 13:20:04', '2015-03-08 11:03:08', 12, 6163, 6049, 11, 'bike'),
  ('2015-03-05 13:20:05', '2015-03-08 11:03:08', 12, 6227, 6049, 9, 'bike'),
  ('2015-03-05 13:20:06', '2015-03-08 11:03:08', 12, 6213, 6049, 9, 'bike'),
  ('2015-03-05 13:20:07', '2015-03-08 11:03:08', 12, 6259, 6049, 9, 'bike'),
  ('2015-03-05 13:20:08', '2015-03-08 11:03:08', 11, 6163, 6049, 11, 'bike'),
  ('2015-03-05 13:20:09', '2015-03-08 11:03:08', 11, 6335, 6049, 9, 'bike'),
  ('2015-03-05 13:20:10', '2015-03-08 11:03:08', 11, 6213, 6049, 9, 'bike'),
  ('2015-03-05 13:20:11', '2015-03-08 11:03:08', 11, 6049, 6361, 9, 'bike'),
  ('2015-03-05 13:20:12', '2015-03-08 11:03:08', 11, 6049, 6248, 11, 'bike'),
  ('2015-03-05 13:20:13', '2015-03-08 11:03:08', 11, 6227, 6248, 9, 'bike'),
  ('2015-03-05 13:20:14', '2015-03-08 11:03:08', 11, 6227, 6248, 9, 'bike'),
  ('2015-03-05 13:20:15', '2015-03-08 11:03:08', 11, 6227, 7083, 9, 'bike');


--Populate isFor table
INSERT INTO isFor VALUES
	('1-day biking', 'bike'),
	('1-day biking+ (inc. electric bikes)', 'electric bike'),
	('1-day car rental', 'regular car'),
	('1-day car rental', 'luxury car'),
	('3-days biking', 'bike'),
	('3-days biking+ (inc. electric bikes)', 'electric bike'),
	('3-days biking+ (inc. electric bikes)', 'bike'),
	('3-days car rental', 'regular car'),
	('3-days car rental', 'luxury car'),
	('3-days combo (inc. all bikes and cars)', 'bike'),
  ('3-days combo (inc. all bikes and cars)', 'electric bike'),
  ('3-days combo (inc. all bikes and cars)', 'regular car'),
	('3-days combo (inc. all bikes and cars)', 'luxury car'),
	('7-days biking', 'bike'),
	('7-days biking+', 'bike'),
	('7-days biking+', 'electric bike'),
	('7-days car rental', 'regular car'),
	('7-days car rental', 'luxury car'),
	('7-days combo (inc. all bikes and cars)', 'bike'),
	('7-days combo (inc. all bikes and cars)', 'electric bike'),
	('7-days combo (inc. all bikes and cars)', 'regular car'),
	('7-days combo (inc. all bikes and cars)', 'luxury car'),
  ('1-trip biking', 'bike'),
	('1-trip biking+ (electric bikes)', 'bike'),
	('1-trip biking+ (electric bikes)', 'electric bike'),
	('2-trips biking', 'bike'),
	('2-trips biking+ (electric bikes)', 'bike'),
	('2-trips biking+ (electric bikes)', 'electric bike'),
	('10-trips biking', 'bike'),
	('10-trips biking+ (electric bikes)', 'bike'),
	('10-trips biking+ (electric bikes)', 'electric bike'),
	('1-month biking', 'bike'),
	('1-month biking+ (electric bikes)', 'electric bike'),
	('1-month biking+ (electric bikes)', 'bike'),
	('1-month car rental', 'regular car'),
  ('1-month car rental', 'luxury car'),
	('1-month combo (inc. all bikes and cars)', 'bike'),
	('1-month combo (inc. all bikes and cars)', 'electric bike'),
	('1-month combo (inc. all bikes and cars)', 'regular car'),
	('1-month combo (inc. all bikes and cars)', 'luxury car'),
	('1-month biking - Reduced fare', 'bike'),
	('1-month biking+ (electric bikes) - Reduced fare', 'bike'),
  ('1-month biking+ (electric bikes) - Reduced fare', 'electric bike'),
	('1-month car rental - Reduced fare', 'regular car'),
	('1-month car rental - Reduced fare', 'luxury car'),
  ('1-month combo (inc. all bikes and cars) - Reduced fare', 'bike'),
  ('1-month combo (inc. all bikes and cars) - Reduced fare', 'electric bike'),
  ('1-month combo (inc. all bikes and cars) - Reduced fare', 'regular car'),
  ('1-month combo (inc. all bikes and cars) - Reduced fare', 'luxury car'),
	('All year biking', 'bike'),
	('All year biking+', 'bike'),
	('All year biking+', 'electric bike'),
	('All year car rental', 'luxury car'),
	('All year car rental', 'regular car'),
	('All year combo (inc. all bikes and cars)', 'bike'),
	('All year combo (inc. all bikes and cars)', 'electric bike'),
	('All year combo (inc. all bikes and cars)', 'regular car'),
	('All year combo (inc. all bikes and cars)', 'luxury car'),
	('All year biking - Reduced fare', 'bike'),
	('All year biking+ (electric bikes) - Reduced fare', 'bike'),
  ('All year biking+ (electric bikes) - Reduced fare', 'electric bike'),
	('All year car rental - Reduced fare', 'regular car'),
  ('All year car rental - Reduced fare', 'luxury car'),
	('All year combo (inc. all bikes and cars) - Reduced fare', 'bike'),
	('All year combo (inc. all bikes and cars) - Reduced fare', 'electric bike'),
	('All year combo (inc. all bikes and cars) - Reduced fare', 'regular car'),
	('All year combo (inc. all bikes and cars) - Reduced fare', 'luxury car'),
	('1-day coverage - regular cars', 'regular car'),
	('3-days coverage - regular cars', 'regular car'),
	('7-days coverage - regular cars', 'regular car'),
	('1-month coverage - regular cars', 'regular car'),
	('1-year coverage - regular cars', 'regular car'),
	('1-day coverage - luxury cars', 'luxury car'),
	('3-days coverage - luxury cars', 'luxury car'),
	('7-days coverage - luxury cars', 'luxury car'),
	('1-month coverage - luxury cars', 'luxury car'),
	('1-year coverage - luxury cars', 'luxury car');
