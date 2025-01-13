-- Create tables with public data (No data is inserted)
CREATE TABLE IF NOT EXISTS genders(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    gender varchar NOT NULL UNIQUE,
    primary key(id)
);

CREATE TABLE IF NOT EXISTS states(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1 MAXVALUE 24),
    state varchar NOT NULL,
    primary key(id)
);

CREATE TABLE IF NOT EXISTS municipalities(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1 MAXVALUE 335),
    state_id integer NOT NULL,
    municipality varchar NOT NULL,
    primary key(id)
);

CREATE TABLE IF NOT EXISTS parishes(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1 MAXVALUE 1134),
    municipality_id integer NOT NULL,
    parish varchar NOT NULL,
    primary key(id)
);

CREATE TABLE IF NOT EXISTS countries(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1 MAXVALUE 240),
    country varchar NOT NULL,
    primary key(id)
);

CREATE TABLE IF NOT EXISTS month(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1 MAXVALUE 12),
    month varchar NOT NULL,
    primary key(id)
);