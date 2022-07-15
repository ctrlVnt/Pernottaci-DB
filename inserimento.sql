insert into ospite(email, nome, cognome, passkey, foto_carta_id)
values ('barbaviilpresidente228@gmail.com', 'Richad', 'Ventu', 'sonochadtuco', null);

insert into ospite(email, nome, cognome, passkey, foto_carta_id)
values ('pincopallino@gmail.com', 'Pippo', 'Paolo', 'abc1234', null);

insert into ospite(email, nome, cognome, passkey, foto_carta_id)
values ('cosmokun@gmail.com', 'Cosmo', 'Kun', 'cosmokun', null);

insert into ospite(email, nome, cognome, passkey, foto_carta_id)
values ('barsik@gmail.com', 'Bars', 'Tuko', 'tubo1234catodico', null);

insert into ospite(email, nome, cognome, passkey, foto_carta_id)
values ('zaka@gmail.com', 'Zaka', 'Sapessi', 'sappzak567', null);

insert into ospite(email, nome, cognome, passkey, foto_carta_id)
values ('mariahu@gmail.com', 'Maria', 'Haha', 'alosalut', null);

insert into host(email_ospite, badge, tasso_cancellazione, rating_medio_host)
values('barbaviilpresidente228@gmail.com', TRUE, 0.0, 5.0);

insert into host(email_ospite, badge, tasso_cancellazione, rating_medio_host)
values('mariahu@gmail.com', TRUE, 0.1, 4.9);


insert into alloggio(
	nome_campanello,
	email_owner,
	check_in,
	check_out,
	n_letti,
	costo_pulizia,
	paese,
	citta,
	via_piazza,
	cap,
	provincia,
	descrizione,
	prezzo_notte_persona,
	tipologia,
	numero_recensioni
)
values (
	'RiVu',
	'barbaviilpresidente228@gmail.com',
	'2022-01-01 9:00:00',
	'2022-02-01 11:00:00',
	3,
	125,
	'francia',
	'chambry',
	'via chambry de france',
	100100,
	'chambry',
	'Prenditi una pausa e rilassati in questo piccolo e accogliente monolocale. Si trova nel centro medievale di LAON. A 700 m dal municipio . 5 minuti a piedi per la nostra splendida cattedrale. Situato vicino al supermercato a 200 m, gastronomia, panetteria, ristoranti, bar a 300 m.',
	33,
	'appartamento',
	100
);

insert into alloggio(
	rating_medio,
	nome_campanello,
	email_owner,
	check_in,
	check_out,
	n_letti,
	costo_pulizia,
	paese,
	citta,
	via_piazza,
	cap,
	provincia,
	descrizione,
	prezzo_notte_persona,
	tipologia,
	numero_recensioni
)
values (
	5.0,
	'RiVu',
	'barbaviilpresidente228@gmail.com',
	'2022-01-01 9:00:00',
	'2022-02-01 11:00:00',
	3,
	125,
	'italia',
	'milano',
	'corso giulio cesare',
	100101,
	'milano',
	'Milano è una citta molto frenetica, quindi vi servira un posto tranquillo...',
	33,
	'appartamento',
	100
);

insert into alloggio(
	rating_medio,
	nome_campanello,
	email_owner,
	check_in,
	check_out,
	n_letti,
	costo_pulizia,
	paese,
	citta,
	via_piazza,
	cap,
	provincia,
	descrizione,
	prezzo_notte_persona,
	tipologia,
	numero_recensioni
)
values (
	4.5,
	'Riccardo V',
	'barbaviilpresidente228@gmail.com',
	'2022-01-01 8:00:00',
	'2022-02-01 9:00:00',
	2,
	50,
	'romania',
	'bucuresti',
	'strada mihai viteaz',
	100001,
	'bucuresti',
	'Bucuresti è  una citta d''avanguardia! Adatta a fare business!',
	40,
	'appartamento',
	76
);

insert into alloggio(
	rating_medio,
	nome_campanello,
	email_owner,
	check_in,
	check_out,
	n_letti,
	costo_pulizia,
	paese,
	citta,
	via_piazza,
	cap,
	provincia,
	descrizione,
	prezzo_notte_persona,
	tipologia,
	numero_recensioni
)
values (
	4.5,
	'Maria Rossi',
	'mariahu@gmail.com',
	'8:00:00',
	'9:00:00',
	2,
	50,
	'germania',
	'dortmund',
	'strasse otto fon bissmark',
	100001,
	'dortmund',
	'Dortmund è  una citta d''avanguardia! Adatta a fare business!',
	40,
	'appartamento',
	76
);


insert into prenotazione(
	uuid_alloggio,
	email_ospite,
	data_arrivo,
	data_partenza,
	numero_ospiti
)
values(
	'2e426415-f2fa-4671-919a-5d5698571aef',
	'barbaviilpresidente228@gmail.com',
	'2022-08-1',
	'2022-09-12',
	1
);

insert into nominativo(
	uuid_prenotazione,
	email_ospite
)
values (
	'e9b6a99f-08d3-4142-9cd5-17b40b6c080a',
	'barsik@gmail.com'
);

ALTER TABLE recensione_host
RENAME COLUMN testo TO testo_host;

ALTER TABLE recensione_host
RENAME COLUMN testo_host TO testo_ospite;

insert into recensione(
	email_ospite,
	uuid_prenotazione
)
values(
	'cosmokun@gmail.com',
	'6916265f-5700-4b33-bfb6-b26d34ec698f'
);

insert into recensione(
	email_ospite,
	uuid_prenotazione
)
values(
	'barbaviilpresidente228@gmail.com',
	'6916265f-5700-4b33-bfb6-b26d34ec698f'
);

insert into recensione_ospite(
	data_recensione_ospite,
	uuid_prenotazione,
	testo_host,
	testo_alloggio,
	punteggio_posizione,
	punteggio_qualita_prezzo,
	punteggio_comunicazione,
	punteggio_pulizia
)
values(
	'2022-06-15 15:47:34.9802450',
	'6916265f-5700-4b33-bfb6-b26d34ec698f',
	'Riccardo Lei e'' molto gentile ed educato, grazie mille!',
	'Alloggio molto pulito, comodo e ben servito.',
	4.9,
	5,
	5,
	4.3
);

insert into recensione_host(
	data_recensione_host,
	uuid_prenotazione,
	testo_ospite
)
values(
	'2022-06-15 16:03:50.648796',
	'6916265f-5700-4b33-bfb6-b26d34ec698f',
	'Ospite tranquillo e molto educato! Welcome!'
);

alter type metodo_p add value 'carta di credito/debito' before 'carata di credito/debito';

insert into acquisto(
	uuid_prenotazione,
	email_ospite,
	metodo_pagamento
)
values(
	'6916265f-5700-4b33-bfb6-b26d34ec698f',
	'cosmokun@gmail.com',
	'carta di credito/debito'
);

insert into servizi(nome_servizio)
values ('acqua calda'), ('wifi'), ('aria condizionata'), ('camino'), ('piscina');

insert into offerta_servizio(
	uuid_alloggio,
	servizio
)
values
(
	'2e426415-f2fa-4671-919a-5d5698571aef',
	'wifi'
),
(
	'2e426415-f2fa-4671-919a-5d5698571aef',
	'acqua calda'
),
(
	'6101df72-fb83-4466-bb33-69cfa799004f',
	'camino'
),
(
	'6101df72-fb83-4466-bb33-69cfa799004f',
	'aria condizionata'
),
(
	'6101df72-fb83-4466-bb33-69cfa799004f',
	'wifi'
),
(
	'3383277a-1cb5-4bdc-bc39-36420cc33c0a',
	'acqua calda'
),
(
	'3383277a-1cb5-4bdc-bc39-36420cc33c0a',
	'piscina'
);

insert into telefono(
	email_ospite,
	numero
)
values(
	'barbaviilpresidente228@gmail.com',
	'+391234567890'
),
(
	'barsik@gmail.com',
	'+399876543210'
),
( 
	'cosmokun@gmail.com',
	'+447724923877'
),
(
	'mariahu@gmail.com',
	'+316624288976'
),
(
	'pincopallino@gmail.com',
	'+217878378875'
),
(
	'zaka@gmail.com',
	'+397747555423'
);


insert into commento(
	uuid_prenotazione,
	data_recensione,
	email_utente,
	testo
)
values(
	'6916265f-5700-4b33-bfb6-b26d34ec698f',
	'2022-06-15 16:03:50.648796',
	'cosmokun@gmail.com',
	'Sarebbe possibile portare un animale nell''alloggio?' 
);

insert into commento(
	uuid_prenotazione,
	data_recensione,
	email_utente,
	testo
)
values
(
	'6916265f-5700-4b33-bfb6-b26d34ec698f',
	'2022-06-15 16:03:50.648796',
	'barbaviilpresidente228@gmail.com',
	'Certamente, ma dovra'' versare una capparra pari al 10% del costo del soggiorno'
);

insert into commento(
	uuid_prenotazione,
	data_recensione,
	email_utente,
	testo
)
values
(
	'6916265f-5700-4b33-bfb6-b26d34ec698f',
	'2022-06-15 16:03:50.648796',
	'cosmokun@gmail.com',
	'Grazie mille per la disponibilita''!'  
);

insert into lista_preferiti(
	nome_viaggio,
	email_ospite
)
values(
	'vacanza italia-germania autunno 2022',
	'pincopallino@gmail.com'
);

insert into composizione(
	uuid_alloggio,
	email_ospite_lista_preferiti,
	data_creazione_lista_preferiti
)
values(
	'3383277a-1cb5-4bdc-bc39-36420cc33c0a',
	'pincopallino@gmail.com',
	'2022-06-15 17:23:10.723415'
),
(
	'6101df72-fb83-4466-bb33-69cfa799004f',
	'pincopallino@gmail.com',
	'2022-06-15 17:23:10.723415'
);

insert into cancellazione(
	uuid_prenotazione,
	email_ospite,
	motivo_cancellazione
)
values(
	'fdff030e-cbde-44e8-bbe8-349f618bc8dd',
	'mariahu@gmail.com',
	'alloggio in ristrutturazione'
);

UPDATE prenotazione
SET stato_prenotazione = 'accettata'
WHERE uuid_prenotazione='6916265f-5700-4b33-bfb6-b26d34ec698f';
