drop TABLE Users;
drop TABLE Accepts;

-- Users (userID, firstName, lastName, email)
CREATE TABLE Users (
	userID SERIAL PRIMARY KEY,
	firstName VARCHAR(50),
	lastName VARCHAR(50),
	email VARCHAR(50)
);

-- accepts (stationID, vType, capacity)
CREATE TABLE accepts(
	stationID INT PRIMARY KEY,
	vType VARCHAR,
	capacity INT,
	FOREIGN KEY (stationID) REFERENCES Stations(sid),
    FOREIGN KEY (vType) REFERENCES VehicleTypes(vType)
);

-- Script to insert random users ( 150 users )

	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Danni', 'Rabbe', 'drabbe0@people.com.cn');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Hunfredo', 'Sedgefield', 'hsedgefield1@hostgator.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Iggie', 'Czyz', 'iczyz2@zimbio.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Isidora', 'Boas', 'iboas3@domainmarket.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Fletcher', 'De Laci', 'fdelaci4@disqus.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Maison', 'Gissing', 'mgissing5@webnode.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Margret', 'Siburn', 'msiburn6@spiegel.de');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Wilburt', 'Mundell', 'wmundell7@archive.org');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Charmain', 'Paulig', 'cpaulig8@php.net');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Farah', 'Leavy', 'fleavy9@blogspot.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Cissiee', 'Houdhury', 'choudhurya@jugem.jp');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Stephanie', 'Cuchey', 'scucheyb@taobao.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Neel', 'Jenman', 'njenmanc@furl.net');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Kele', 'Gallanders', 'kgallandersd@google.fr');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Ninetta', 'Surridge', 'nsurridgee@senate.gov');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Marsiella', 'Tendahl', 'mtendahlf@dedecms.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Gladi', 'Normanvill', 'gnormanvillg@nyu.edu');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Sandro', 'Munns', 'smunnsh@phoca.cz');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Clem', 'O''Finan', 'cofinani@infoseek.co.jp');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Odelia', 'Hender', 'ohenderj@bloglovin.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Bili', 'Fenemore', 'bfenemorek@amazon.co.uk');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Marcelle', 'Whetnell', 'mwhetnelll@yale.edu');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Laurence', 'Springall', 'lspringallm@123-reg.co.uk');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Jeannie', 'Spurr', 'jspurrn@state.tx.us');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Clarice', 'Youhill', 'cyouhillo@mozilla.org');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Maddie', 'Spehr', 'mspehrp@list-manage.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Amerigo', 'Corless', 'acorlessq@bing.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Chlo', 'Eldon', 'celdonr@skyrock.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Emylee', 'Stancer', 'estancers@dailymotion.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Claudius', 'Kairns', 'ckairnst@example.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Obediah', 'Kingsland', 'okingslandu@comsenz.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Rowen', 'Keymar', 'rkeymarv@about.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Randa', 'Scolland', 'rscollandw@merriam-webster.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Sergio', 'Honnicott', 'shonnicottx@unesco.org');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Hester', 'Bartoszek', 'hbartoszeky@pcworld.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Carny', 'Halwell', 'chalwellz@tuttocitta.it');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Mallory', 'Alty', 'malty10@elpais.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Gerda', 'Sholl', 'gsholl11@example.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Theo', 'Runcieman', 'truncieman12@cbc.ca');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Darrin', 'Batrick', 'dbatrick13@who.int');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Corbett', 'Blackeby', 'cblackeby14@cloudflare.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Mart', 'Elwin', 'melwin15@geocities.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Kenyon', 'Overington', 'koverington16@chronoengine.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Sile', 'Simonutti', 'ssimonutti17@go.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Ragnar', 'Berrigan', 'rberrigan18@dagondesign.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Ambur', 'Wix', 'awix19@samsung.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Ignacio', 'Boyfield', 'iboyfield1a@flickr.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Antonin', 'Weddeburn', 'aweddeburn1b@whitehouse.gov');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Edin', 'Atlay', 'eatlay1c@cisco.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Lorne', 'Cudbertson', 'lcudbertson1d@rambler.ru');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Mickey', 'Speenden', 'mspeenden1e@plala.or.jp');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Alison', 'Risbie', 'arisbie1f@meetup.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Siana', 'Foulcher', 'sfoulcher1g@symantec.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Levey', 'Gieves', 'lgieves1h@macromedia.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Berget', 'Kingescot', 'bkingescot1i@who.int');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Laurel', 'Iglesiaz', 'liglesiaz1j@gov.uk');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Desdemona', 'Eglin', 'deglin1k@tmall.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Sergei', 'Scholz', 'sscholz1l@etsy.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Florian', 'Cotillard', 'fcotillard1m@sciencedaily.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Salvador', 'Plunket', 'splunket1n@epa.gov');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Krisha', 'Arghent', 'karghent1o@free.fr');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Giraud', 'Fairebrother', 'gfairebrother1p@whitehouse.gov');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Lilyan', 'Worham', 'lworham1q@biblegateway.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Lyndell', 'Cracker', 'lcracker1r@macromedia.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Herta', 'Daws', 'hdaws1s@free.fr');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Gaye', 'Turland', 'gturland1t@devhub.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Alessandro', 'Marciskewski', 'amarciskewski1u@google.fr');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Angel', 'Perkis', 'aperkis1v@dedecms.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Griffie', 'Stean', 'gstean1w@canalblog.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Conrade', 'Nurcombe', 'cnurcombe1x@ebay.co.uk');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Issi', 'Balducci', 'ibalducci1y@tuttocitta.it');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Feodora', 'Kirckman', 'fkirckman1z@ft.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Wilburt', 'De Vaan', 'wdevaan20@prnewswire.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Doyle', 'Tolossi', 'dtolossi21@economist.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Lemar', 'Manoelli', 'lmanoelli22@reddit.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Merrily', 'Scolts', 'mscolts23@soundcloud.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Granger', 'Keating', 'gkeating24@ox.ac.uk');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Fernande', 'Davidove', 'fdavidove25@bizjournals.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Marcella', 'Shirer', 'mshirer26@unesco.org');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Winfield', 'Melliard', 'wmelliard27@blog.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Parker', 'Sarll', 'psarll28@fastcompany.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Jenny', 'Eade', 'jeade29@ifeng.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Norma', 'Harby', 'nharby2a@whitehouse.gov');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Ermin', 'Petow', 'epetow2b@feedburner.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Stewart', 'De Few', 'sdefew2c@yahoo.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Iormina', 'Obray', 'iobray2d@qq.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Kare', 'Giacomini', 'kgiacomini2e@cafepress.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Gherardo', 'Glaisner', 'gglaisner2f@wikipedia.org');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Franni', 'Grafhom', 'fgrafhom2g@mediafire.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Galvan', 'Candlin', 'gcandlin2h@mayoclinic.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Elsa', 'Josskoviz', 'ejosskoviz2i@dell.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Maribeth', 'Tombling', 'mtombling2j@amazon.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Teirtza', 'Bulcock', 'tbulcock2k@issuu.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Kerk', 'D''Antuoni', 'kdantuoni2l@mlb.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Blondell', 'Fairall', 'bfairall2m@si.edu');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Mag', 'Wakeling', 'mwakeling2n@prweb.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Emlyn', 'Gunter', 'egunter2o@cnbc.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Lisle', 'Keighley', 'lkeighley2p@is.gd');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Moise', 'Hyslop', 'mhyslop2q@ucoz.ru');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Correy', 'Fey', 'cfey2r@blogger.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Micky', 'Okenfold', 'mokenfold2s@omniture.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Liza', 'Fortune', 'lfortune2t@taobao.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Jim', 'Hallyburton', 'jhallyburton2u@icio.us');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Kippie', 'Scottesmoor', 'kscottesmoor2v@photobucket.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Genevieve', 'Blumson', 'gblumson2w@walmart.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Vanna', 'Attryde', 'vattryde2x@goo.gl');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Nita', 'Dwerryhouse', 'ndwerryhouse2y@sphinn.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Coralyn', 'Lerner', 'clerner2z@wix.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'John', 'Ebbett', 'jebbett30@scientificamerican.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Richmond', 'Filyushkin', 'rfilyushkin31@blogspot.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Aron', 'Tuddall', 'atuddall32@dropbox.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Lila', 'Shorten', 'lshorten33@go.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Jervis', 'Brickdale', 'jbrickdale34@amazon.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Torey', 'Maior', 'tmaior35@psu.edu');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Lena', 'Blodg', 'lblodg36@hugedomains.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Cordell', 'Giorio', 'cgiorio37@disqus.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Victor', 'Stainton', 'vstainton38@mapquest.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Ignacio', 'Lebreton', 'ilebreton39@bloomberg.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Rustie', 'Dudderidge', 'rdudderidge3a@psu.edu');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Meggy', 'Schankelborg', 'mschankelborg3b@admin.ch');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Ondrea', 'Fairlaw', 'ofairlaw3c@springer.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Giulio', 'Leavy', 'gleavy3d@usnews.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Astra', 'Gingedale', 'agingedale3e@who.int');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Adolf', 'Dawltrey', 'adawltrey3f@1688.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Nora', 'D''Onise', 'ndonise3g@sogou.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Merry', 'Malamore', 'mmalamore3h@fastcompany.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Julieta', 'Goch', 'jgoch3i@google.com.hk');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Genovera', 'Paulton', 'gpaulton3j@gov.uk');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Kaiser', 'Gorman', 'kgorman3k@nationalgeographic.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Shirlene', 'Baus', 'sbaus3l@storify.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Casie', 'Cattel', 'ccattel3m@unesco.org');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Tansy', 'Kolakovic', 'tkolakovic3n@de.vu');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Faye', 'Dible', 'fdible3o@indiatimes.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Romain', 'Lynas', 'rlynas3p@homestead.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Kevon', 'Every', 'kevery3q@princeton.edu');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Celina', 'Gori', 'cgori3r@uiuc.edu');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Nettle', 'Bullant', 'nbullant3s@facebook.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Vale', 'Fedoronko', 'vfedoronko3t@soup.io');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Donnie', 'McCurtain', 'dmccurtain3u@uiuc.edu');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Tracee', 'Durdle', 'tdurdle3v@ebay.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Jennilee', 'Domengue', 'jdomengue3w@weibo.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Leisha', 'Regler', 'lregler3x@geocities.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Gayle', 'Pridden', 'gpridden3y@photobucket.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Kareem', 'Jarred', 'kjarred3z@slate.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Cherey', 'Candwell', 'ccandwell40@cornell.edu');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Raina', 'Shark', 'rshark41@oakley.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Noe', 'Forkan', 'nforkan42@plala.or.jp');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Kylie', 'McNeice', 'kmcneice43@arizona.edu');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Royall', 'MacCaull', 'rmaccaull44@indiegogo.com');
	insert into Users (userID, firstName, lastName, email) values (DEFAULT, 'Corty', 'Du Hamel', 'cduhamel45@lycos.com');


