drop table if exists utilisateur CASCADE;
drop table if exists suivi CASCADE;
drop table if exists amis CASCADE;
drop table if exists playlist CASCADE;
drop table if exists groupe CASCADE;
drop table if exists morceaux CASCADE;
drop table if exists composer CASCADE;
drop table if exists genre CASCADE;
drop table if exists sous_genre_de CASCADE;
drop table if exists avis CASCADE;
drop table if exists concert_passe CASCADE;
drop table if exists lieu CASCADE;
drop table if exists participe CASCADE;
drop table if exists video_photo CASCADE;
drop table if exists tag CASCADE;
drop table if exists concert_a_venir CASCADE;

CREATE TABLE utilisateur (
  id_utilisateur integer PRIMARY KEY,
  nom VARCHAR(50) NOT NULL ,
  prenom VARCHAR(50) NOT NULL,
  type_utilisateur VARCHAR(50) NOT NULL,
  nb_abonne integer,
  nb_abonnement integer,
  commentaire TEXT
);


CREATE TABLE suivi(
    id_utilisateur integer,
    id_suivi integer,
    PRIMARY KEY (id_utilisateur,id_suivi),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE amis(
    id_utilisateur1 integer, id_utilisateur2 integer,
    PRIMARY KEY (id_utilisateur1, id_utilisateur2),
    FOREIGN KEY (id_utilisateur1) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (id_utilisateur2) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE abonne{
    id_utilisateur integer,
    id_abonne integer PRIMARY KEY,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
};

CREATE TABLE playlist(
    id_playlist integer PRIMARY KEY,
    id_utilisateur integer, nom TEXT,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE groupe(
    id_groupe integer PRIMARY KEY,
    nom VARCHAR(50)
);
CREATE TABLE genre(
    id_genre integer PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);
CREATE TABLE morceaux (
    numero integer PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    id_groupe integer,
    id_genre integer,
    FOREIGN KEY (id_groupe) REFERENCES groupe(id_groupe),
    FOREIGN KEY (id_genre) REFERENCES genre(id_genre)
);
CREATE TABLE composer(
    id_morceaux integer, id_playlist integer,
    PRIMARY KEY (id_morceaux, id_playlist),
    FOREIGN KEY (id_morceaux) REFERENCES morceaux(numero),
    FOREIGN KEY (id_playlist) REFERENCES playlist(id_playlist)
);
CREATE TABLE sous_genre_de(
    id_genre integer,
    id_sous_genre_de integer,
    PRIMARY KEY (id_genre,id_sous_genre_de),
    FOREIGN KEY (id_genre) REFERENCES genre(id_genre)
);
CREATE TABLE avis(
    id_avis integer PRIMARY KEY,
    id_groupe integer,
    id_utilisateur integer,
    note integer NOT NULL,
    commentaire TEXT,
    FOREIGN KEY (id_groupe) REFERENCES groupe(id_groupe),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);
CREATE TABLE cause(
    id_cause integer PRIMARY KEY,
    nom VARCHAR(50)
);
CREATE TABLE lieu(
    id_lieu integer PRIMARY KEY,
    adresse TEXT NOT NULL,
    ville VARCHAR(50) NOT NULL
);
CREATE TABLE concert_passe(
    id_concert_passe integer PRIMARY KEY,
    nb_participant integer,
    date_concert date,
    id_lieu integer,
    FOREIGN KEY (id_lieu) REFERENCES lieu(id_lieu)
);
CREATE TABLE video_photo(
    id_publication integer PRIMARY KEY
);
CREATE TABLE tag (
    id integer,
    id_playlist integer,
    id_morceaux integer,
    id_video integer,
    id_avis integer,
    id_lieu integer,
    id_groupe integer,
    id_utilisateur integer,
    PRIMARY KEY (id),
    FOREIGN KEY (id_playlist) REFERENCES playlist(id_playlist),
    FOREIGN KEY (id_morceaux) REFERENCES morceaux(numero),
    FOREIGN KEY (id_video) REFERENCES video_photo(id_publication),
    FOREIGN KEY (id_avis) REFERENCES avis(id_avis),
    FOREIGN KEY (id_lieu) REFERENCES lieu(id_lieu)
);

CREATE TABLE participe (
    id_utilisateur integer,
    id_concert_passe integer,
    PRIMARY KEY (id_utilisateur,id_concert_passe),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (id_concert_passe) REFERENCES concert_passe(id_concert_passe)
);

CREATE TABLE concert_a_venir(
    id integer PRIMARY KEY,
    nb_place_dispo integer,
    prix integer NOT NULL,
    date_concert date NOT NULL,
    id_cause integer,
    possibilite_enfant boolean,
    volontaire integer,
    espace_exterieur boolean,
    interesse integer,
    annonce integer,
    organise integer,
    id_lieu integer,
    FOREIGN KEY (id_lieu) REFERENCES lieu(id_lieu),
    FOREIGN KEY (volontaire) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (interesse) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (annonce) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (organise) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (id_cause) REFERENCES cause(id_cause) 
);

-- remplissage des tables

\COPY utilisateur FROM 'CSV/utilisateur.csv' WITH (FORMAT CSV,HEADER);
\COPY suivi FROM 'CSV/suivi.csv' WITH (FORMAT CSV,HEADER);
\COPY amis FROM 'CSV/ami.csv' WITH (FORMAT CSV,HEADER);
\COPY abonne FROM 'CSV/abonne.csv' WITH (FORMAT CSV,HEADER);
\COPY playlist FROM 'CSV/playlist.csv' WITH (FORMAT CSV,HEADER);
\COPY groupe FROM 'CSV/groupe.csv' WITH (FORMAT CSV,HEADER);
\COPY genre FROM 'CSV/genre.csv' WITH (FORMAT CSV,HEADER);
\COPY morceaux FROM 'CSV/morceau.csv' WITH (FORMAT CSV,HEADER);
\COPY composer FROM 'CSV/composer.csv' WITH (FORMAT CSV,HEADER);
\COPY sous_genre_de FROM 'CSV/sous_genre_de.csv' WITH (FORMAT CSV,HEADER);
\COPY avis FROM 'CSV/avis.csv' WITH (FORMAT CSV,HEADER);
\COPY lieu FROM 'CSV/lieu.csv' WITH (FORMAT CSV,HEADER);
\COPY concert_passe FROM 'CSV/concert_passe.csv' WITH (FORMAT CSV,HEADER);
\COPY video_photo FROM 'CSV/video_photo.csv' WITH (FORMAT CSV,HEADER);
\COPY tag FROM 'CSV/tag.csv' WITH (FORMAT CSV,HEADER);
\COPY participe FROM 'CSV/participe.csv' WITH (FORMAT CSV,HEADER);
\COPY cause FROM 'CSV/cause.csv' WITH (FORMAT CSV,HEADER);
\COPY concert_a_venir FROM 'CSV/concert_a_venir.csv' WITH (FORMAT CSV,HEADER);