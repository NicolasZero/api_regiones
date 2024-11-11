-- Creates the tables necessary for the operation of the system
CREATE SCHEMA regions;

create table regions.achievements (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    responsible_id integer NOT NULL,
    type_action_id integer NOT NULL,
    type_activity_id integer NOT NULL,
    type_telephone_service_id integer NOT NULL,
    date date NOT NULL,
    hour time NOT NULL,
    state_id integer NOT NULL,
    municipality_id integer NOT NULL,
    parish_id integer NOT NULL,
    place_id integer NOT NULL,
    place_other varchar(100),
    n_womans integer,
    n_man integer,
    n_unspecified integer,
    phone_number varchar(100),
    opservation varchar(100),
    status_id integer NOT NULL DEFAULT 1,
    country_id integer NOT NULL DEFAULT 1,
    created date DEFAULT CURRENT_DATE,
    updated date
);

create table regions.users (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    worker_id integer NOT NULL UNIQUE,
    username varchar(100) NOT NULL UNIQUE,
    password varchar NOT NULL,
    role_id integer NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    created date DEFAULT CURRENT_DATE,
    updated date
);

CREATE TABLE regions.roles(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    role varchar(100) NOT NULL UNIQUE
);

CREATE TABLE regions.type_action(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    type_action varchar(100) NOT NULL UNIQUE
);

CREATE TABLE regions.type_activity(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    type_activity varchar(100) NOT NULL UNIQUE
);

CREATE TABLE regions.type_telephone_service(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    type_telephone_service varchar(100) NOT NULL UNIQUE
);

CREATE TABLE regions.place(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    place varchar(100) NOT NULL UNIQUE
);

CREATE TABLE regions.status(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    status varchar(100) NOT NULL UNIQUE
);


ALTER TABLE regions.achievements ADD CONSTRAINT fk_achievements_worker_id FOREIGN KEY (responsible_id) references regions.users(id);

ALTER TABLE regions.users ADD CONSTRAINT fk_users_worker_id FOREIGN KEY (worker_id) references general.workers(id);

ALTER TABLE regions.users ADD CONSTRAINT fk_users_role_id FOREIGN KEY (role_id) references regions.roles(id);