drop table if exists ospite;
create table ospite (
    email varchar(320) not null, -- 64 characters for local part + @ + 255 for domain name
    nome varchar(16) not null,
    cognome varchar(16) not null,
    passkey varchar(32) not null,
    foto_carta_id bytea,
    constraint OSPITE_PK primary key(email)
);

drop table if exists host;
-- create extension if not exists "uuid-host"; -- Universally unique identifier, used to generate unique identifiers
create table host (
    -- uuid_host uuid DEFAULT uuid_generate_v4(),
    email_ospite varchar(320) not null,
    badge boolean not null,
    tasso_cancellazione decimal(5, 2) not null,
    rating_medio_host decimal(3, 2) not null,
    constraint HOST_PK primary key(email_ospite),
    -- constraint HOST_PK primary key(uuid_host),
    constraint HOST_FK_OSPITE foreign key(email_ospite) references ospite(email) on delete cascade,
    check(tasso_cancellazione between 0 and 100),
    check(rating_medio_host between 0 and 5)
);

drop table if exists alloggio;
create type tipo_alloggio as enum ('stanza privata', 'stanza condivisa', 'appartamento');
create extension if not exists "uuid-ossp"; -- Universally unique identifier, used to generate unique identifiers
create table alloggio (
    uuid_alloggio uuid DEFAULT uuid_generate_v4(),
    rating_medio decimal(3, 2) not null default 0,
    nome_campanello varchar(64) not null,
    nome_alloggio varchar(32) not null default 'alloggio generico',
    email_owner varchar(320) not null,
    check_in timestamp not null,
    check_out timestamp not null,
    n_letti decimal(2) not null,
    costo_pulizia decimal(6,2) not null,
    paese varchar(16) not null,
    citta varchar(32) not null,
    via_piazza varchar(32) not null,
    cap decimal(10) not null,
    provincia varchar(32) not null,
    descrizione text,
    prezzo_notte_persona decimal(7,2) not null,
    tipologia tipo_alloggio not null,
    numero_recensioni int not null default 0,
    constraint ALLOGGIO_PK primary key(uuid_alloggio),
    constraint ALLOGGIO_FK_OSPITE foreign key(email_owner) references host(email_ospite) on delete cascade,
    check(numero_recensioni >= 0)
);

drop table if exists prenotazioni;
create type stato as enum ('accettata', 'rifiutata', 'in corso');
create table prenotazione (
    uuid_prenotazione uuid DEFAULT uuid_generate_v4() unique,
    uuid_alloggio uuid not null,
    email_ospite varchar(320) not null,
    data_arrivo date not null,
    data_partenza date not null check (data_arrivo < data_partenza),
    stato_prenotazione stato not null default 'in corso',
    numero_ospiti decimal(2) not null default 0,
    constraint PRENOTAZIONE_PK primary key(uuid_prenotazione),
    constraint PRENOTAZIONE_FK_ALLOGGIO foreign key(uuid_alloggio) references alloggio(uuid_alloggio),
    constraint PRENOTAZIONE_FK_OSPITE foreign key(email_ospite) references ospite(email)
);

drop table if exists recensione;
create table recensione (
    email_ospite varchar(320) not null,
    uuid_prenotazione uuid not null,
    visibilita boolean not null default FALSE,
    data_recensione timestamp not null default CURRENT_TIMESTAMP unique,
    constraint RECENSIONE_PK primary key(data_recensione, uuid_prenotazione),
    constraint RECENSIONE_FK_OSPITE foreign key(email_ospite) references ospite(email),
    constraint RECENSIONE_FK_PRENOTAZIONE foreign key(uuid_prenotazione) references prenotazione(uuid_prenotazione)
);

drop table if exists recensione_ospite;
create table recensione_ospite (
    data_recensione_ospite timestamp not null,
    uuid_prenotazione uuid not null,
    testo_host text,
    testo_alloggio text,
    punteggio_posizione decimal(1) not null check (punteggio_posizione between 0 and 5),
    punteggio_qualita_prezzo decimal(1) not null check (punteggio_qualita_prezzo between 0 and 5),
    punteggio_comunicazione decimal(1) not null check (punteggio_comunicazione between 0 and 5),
    punteggio_pulizia decimal(1) not null check (punteggio_pulizia between 0 and 5),
    constraint RECENSIONE_OSPITE_PK primary key(data_recensione_ospite, uuid_prenotazione),
    constraint RECENSIONE_OSPITE_FK_RECENSIONE foreign key(uuid_prenotazione, data_recensione_ospite) references recensione(uuid_prenotazione, data_recensione)
);

-- MODIFICATO
drop table if exists recensione_host;
create table recensione_host (
    data_recensione_host timestamp not null,
    uuid_prenotazione uuid not null,
    testo_ospite text,
    constraint RECENSIONE_HOST_PK primary key(data_recensione_host, uuid_prenotazione),
    constraint RECENSIONE_HOST_FK_RECENSIONE foreign key(uuid_prenotazione, data_recensione_host) references recensione(uuid_prenotazione, data_recensione)
);

drop table if exists foto;
create table foto (
    uuid_alloggio uuid not null,
    nome_file varchar(64) not null,
    foto_alloggio bytea not null,
    constraint FOTO_PK primary key(uuid_alloggio, nome_file),
    constraint FOTO_FK_ALLOGGIO foreign key(uuid_alloggio) references alloggio(uuid_alloggio) on delete cascade
);

drop table if exists telefono;
create table telefono (
    numero char(13) not null,
    email_ospite varchar(320) not null,
    constraint TELEFONO_PK primary key(numero, email_ospite),
    constraint TELEFONO_FK_OSPITE foreign key(email_ospite) references ospite(email) on delete cascade,
    constraint CHECK_NUMERO check (numero not like '%[^0-9]%')
);

drop table if exists lista_preferiti;
create table lista_preferiti (
    data_creazione timestamp not null default CURRENT_TIMESTAMP unique,
    nome_viaggio varchar(64) not null,
    email_ospite varchar(320) not null,
    constraint LISTA_PREFERITI_PK primary key(data_creazione, email_ospite),
    constraint LISTA_PREFERITI_FK_OSPITE foreign key(email_ospite) references ospite(email) on delete cascade
);

drop table if exists cancellazione;
create table cancellazione (
    uuid_prenotazione uuid not null,
    email_ospite varchar(320) not null,
    motivo_cancellazione text,
    constraint CANCELLAZIONE_PK primary key(uuid_prenotazione, email_ospite),
    constraint CANCELLAZIONE_FK_OSPITE foreign key(email_ospite) references ospite(email),
    constraint CANCELLAZIONE_FK_PRENOTAZIONE foreign key(uuid_prenotazione) references prenotazione(uuid_prenotazione)
);

drop table if exists acquisto;
create type metodo_p as enum ('carta di credito/debito', 'Xpay');
create table acquisto (
    uuid_prenotazione uuid not null,
    email_ospite varchar(320) not null,
    metodo_pagamento metodo_p not null,
    constraint ACQUISTO_PK primary key(uuid_prenotazione, email_ospite),
    constraint ACQUISTO_FK_OSPITE foreign key(email_ospite) references ospite(email),
    constraint ACQUISTO_FK_PRENOTAZIONE foreign key(uuid_prenotazione) references prenotazione(uuid_prenotazione)
);

drop table if exists servizi;
create type servizio_alloggio as enum ('bagno', 'doccia', 'wifi', 'bidet', 'acqua calda', 'shampoo', 'phon', 'biancheria', 'tv', 'aria condizionata', 'camino', 'riscaldamento', 'allarme antiincedio', 'estintore', 'kit pronto socorso', 'piscina', 'cucina', 'vasca', 'parcheggio gratuito', 'all-inclusive');
create table servizi (
    nome_servizio servizio_alloggio not null,
    constraint SERVIZI_PK primary key(nome_servizio)
);

drop table if exists offerta_servizio;
create table offerta_servizio (
    uuid_alloggio uuid not null,
    servizio servizio_alloggio not null,
    constraint OFFERTA_SERVIZIO_PK primary key(uuid_alloggio, servizio),
    constraint OFFERTA_SERVIZIO_FK_ALLOGGIO foreign key(uuid_alloggio) references alloggio(uuid_alloggio),
    constraint OFFERTA_SERVIZIO_FK_SERVIZIO foreign key(servizio) references servizi(nome_servizio)
);

drop table if exists nominativo;
create table nominativo (
    uuid_prenotazione uuid not null,
    email_ospite varchar(320) not null,
    constraint NOMINATIVO_PK primary key(uuid_prenotazione, email_ospite),
    constraint NOMINATIVO_FK_PRENOTAZIONE foreign key(uuid_prenotazione) references prenotazione(uuid_prenotazione),
    constraint NOMINATIVO_FK_OSPITE foreign key(email_ospite) references ospite(email) on delete cascade
);

drop table if exists composizione;
create table composizione (
    uuid_alloggio uuid not null,
    email_ospite_lista_preferiti varchar(320) not null,
    data_creazione_lista_preferiti timestamp not null,
    constraint COMPOSIZIONE_PK primary key(uuid_alloggio, email_ospite_lista_preferiti, data_creazione_lista_preferiti),
    constraint COMPOSIZIONE_FK_LISTA_PREFERITI_1 foreign key(email_ospite_lista_preferiti, data_creazione_lista_preferiti) references lista_preferiti(email_ospite, data_creazione) on delete cascade,
    constraint COMPOSIZIONE_FK_ALLOGGIO foreign key(uuid_alloggio) references alloggio(uuid_alloggio) on delete set null
);


drop table if exists commento;
create table commento(
    uuid_prenotazione uuid not null,
    data_recensione timestamp not null,
    email_utente varchar(320) not null, -- perche' abbiamo accorpato la relazione 1-1 tra COMMENTO e OSPITE tramite SCRIVE
    data_commento timestamp not null default CURRENT_TIMESTAMP,
    testo text not null,
    constraint COMMENTO_PK primary key(uuid_prenotazione, data_commento, data_recensione),
    constraint COMMENTO_FK_OSPITE foreign key(email_utente) references ospite(email),
    constraint COMMENTO_FK_RECENSIONE_2 foreign key(uuid_prenotazione, data_recensione) references recensione(uuid_prenotazione, data_recensione)
);

insert into foto(
	uuid_alloggio,
	nome_file,
	foto_alloggio
)
values(
	'3383277a-1cb5-4bdc-bc39-36420cc33c0a',
	'alloggio_chambry_rivu_01',
	bytea('/Users/borist/Documents/wallpapers/manuel-venturini-_l3RkmuIX-8-unsplash.jpg')
);

insert into foto(
	uuid_alloggio,
	nome_file,
	foto_alloggio
)
values(
	'6101df72-fb83-4466-bb33-69cfa799004f',
	'alloggio_dortmundi_mariarossi_01',
	bytea('/Users/borist/Documents/wallpapers/manuel-venturini-_l3RkmuIX-8-unsplash.jpg')
);

