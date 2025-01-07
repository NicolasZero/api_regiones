-- Creates the tables necessary for the operation of the system
CREATE SCHEMA regions;

create table regions.achievements_base (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    status_id integer NOT NULL DEFAULT 1,
    created_on date DEFAULT CURRENT_DATE,
    created_by integer NOT NULL,
    date date NOT NULL,
    hour time NOT NULL,
    action_id integer NOT NULL,
    activity_id integer NOT NULL,
    management_unit_id integer NOT NULL,
    state_id integer NOT NULL,
    municipality_id integer NOT NULL,
    parish_id integer NOT NULL,
    observation text,
    previously_scheduled boolean NOT NULL DEFAULT false,
    observation_schedule text,
    primary key(id)
);

create table regions.achievements_others (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    achievements_id integer NOT NULL UNIQUE,
    place_id integer NOT NULL,
    place_other varchar,
    n_womans integer NOT NULL DEFAULT 0,
    n_man integer NOT NULL DEFAULT 0,
    n_unspecified integer,
    responsible varchar NOT NULL,
    phone_number varchar(100),
    primary key(id)
);

create table regions.achievements_victim_traff (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    achievements_id integer NOT NULL UNIQUE,
    country_id integer NOT NULL,
    gender_id integer NOT NULL,
    age integer NOT NULL,
    collection_method varchar NOT NULL,
    received varchar NOT NULL DEFAULT '',
    primary key(id)
);

create table regions.achievements_telephone_service (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    achievements_id integer NOT NULL UNIQUE,
    type_telephone_service_id integer NOT NULL,
    great_mission varchar NOT NULL,
    primary key(id)
);

create table regions.achievements_g_violence (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    achievements_id integer NOT NULL UNIQUE,
    age_range_id integer NOT NULL,
    type_weapon_id integer NOT NULL,
    type_femicide_id integer NOT NULL,
    killer_status_id integer NOT NULL,
    primary key(id)
);

-- achievements_base
create table regions.users (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    worker_id integer NOT NULL UNIQUE,
    username varchar(100) NOT NULL UNIQUE,
    password varchar NOT NULL,
    role_id integer NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    created date DEFAULT CURRENT_DATE,
    primary key(id)
);

CREATE TABLE regions.type_action(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    type_action varchar(100) NOT NULL UNIQUE,
    primary key(id)
);

CREATE TABLE regions.type_activity(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    type_action_id integer NOT NULL,
    type_activity varchar(100) NOT NULL UNIQUE,
    primary key(id)
);

CREATE TABLE regions.status(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    status varchar(100) NOT NULL UNIQUE,
    primary key(id)
);

CREATE TABLE regions.management_unit(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    management_unit varchar(100) NOT NULL UNIQUE,
    primary key(id)
);

-- achievements_others
CREATE TABLE regions.place(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    place varchar(100) NOT NULL UNIQUE,
    primary key(id)
);

-- achievements_victim_traff


-- achievements_telephone_service
CREATE TABLE regions.type_telephone_service(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    type_telephone_service varchar(100) NOT NULL UNIQUE,
    primary key(id)
);

-- achievements_g_violence
create table regions.age_range(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    age_range varchar(100) NOT NULL UNIQUE,
    primary key(id)
);

create table regions.type_weapon(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    type_weapon varchar(100) NOT NULL UNIQUE,
    primary key(id)
);

create table regions.type_femicide(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    type_femicide varchar(100) NOT NULL UNIQUE,
    primary key(id)
);

create table regions.killer_status(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    killer_status varchar(100) NOT NULL UNIQUE,
    primary key(id)
);

-- user
CREATE TABLE regions.roles(
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    role varchar(100) NOT NULL UNIQUE,
    primary key(id)
);

-- achievements_base
ALTER TABLE regions.achievements_base ADD CONSTRAINT fk_achievements_base_created_by FOREIGN KEY (created_by) references regions.users(id);

ALTER TABLE regions.achievements_base ADD CONSTRAINT fk_achievements_base_status_id FOREIGN KEY (status_id) references regions.status(id);

ALTER TABLE regions.achievements_base ADD CONSTRAINT fk_achievements_base_action_id FOREIGN KEY (action_id) references regions.type_action(id);

ALTER TABLE regions.achievements_base ADD CONSTRAINT fk_achievements_base_activity_id FOREIGN KEY (activity_id) references regions.type_activity(id);

ALTER TABLE regions.achievements_base ADD CONSTRAINT fk_achievements_base_state_id FOREIGN KEY (state_id) references public.states(id);

ALTER TABLE regions.achievements_base ADD CONSTRAINT fk_achievements_base_municipality_id FOREIGN KEY (municipality_id) references public.municipalities(id);

ALTER TABLE regions.achievements_base ADD CONSTRAINT fk_achievements_base_parish_id FOREIGN KEY (parish_id) references public.parishes(id);

-- achievements_others
ALTER TABLE regions.achievements_others ADD CONSTRAINT fk_achievements_others_base_id FOREIGN KEY (achievements_id) references regions.achievements_base(id);

ALTER TABLE regions.achievements_others ADD CONSTRAINT fk_achievements_others_place_id FOREIGN KEY (place_id) references regions.place(id);

-- achievements_victim_traff
ALTER TABLE regions.achievements_victim_traff ADD CONSTRAINT fk_achievements_victim_traff_base_id FOREIGN KEY (achievements_id) references regions.achievements_base(id);

ALTER TABLE regions.achievements_victim_traff ADD CONSTRAINT fk_achievements_victim_traff_country_id FOREIGN KEY (country_id) references public.countries(id);

ALTER TABLE regions.achievements_victim_traff ADD CONSTRAINT fk_achievements_victim_traff_gender_id FOREIGN KEY (gender_id) references public.genders(id);

-- achievements_telephone_service
ALTER TABLE regions.achievements_telephone_service ADD CONSTRAINT fk_achievements_telephone_service_base_id FOREIGN KEY (achievements_id) references regions.achievements_base(id);

-- achievements_g_violence
ALTER TABLE regions.achievements_g_violence ADD CONSTRAINT fk_achievements_g_violence_base_id FOREIGN KEY (achievements_id) references regions.achievements_base(id);

ALTER TABLE regions.achievements_g_violence ADD CONSTRAINT fk_achievements_g_violence_age_range_id FOREIGN KEY (age_range_id) references regions.age_range(id);

ALTER TABLE regions.achievements_g_violence ADD CONSTRAINT fk_achievements_g_violence_type_weapon_id FOREIGN KEY (type_weapon_id) references regions.type_weapon(id);

ALTER TABLE regions.achievements_g_violence ADD CONSTRAINT fk_achievements_g_violence_type_femicide_id FOREIGN KEY (type_femicide_id) references regions.type_femicide(id);

ALTER TABLE regions.achievements_g_violence ADD CONSTRAINT fk_achievements_g_violence_killer_status_id FOREIGN KEY (killer_status_id) references regions.killer_status(id);

-- users
ALTER TABLE regions.users ADD CONSTRAINT fk_users_worker_id FOREIGN KEY (worker_id) references general.workers(id);

ALTER TABLE regions.users ADD CONSTRAINT fk_users_role_id FOREIGN KEY (role_id) references regions.roles(id);

-- type_activity
ALTER TABLE regions.type_activity ADD CONSTRAINT fk_type_activity_type_action_id FOREIGN KEY (type_action_id) references regions.type_action(id);

-- ---------- unite mobile ---------- --
create table regions.social_day_achievements (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    created_by integer NOT NULL,
    created_on date DEFAULT CURRENT_DATE,
    status_id integer NOT NULL DEFAULT 2,
    date date NOT NULL DEFAULT CURRENT_DATE,
    hour time NOT NULL DEFAULT CURRENT_TIME,
    num_mobile_units integer NOT NULL,
    num_ultrasounds integer NOT NULL,
    logistical_support varchar NOT NULL,
    responsible varchar NOT NULL,
    state_id integer NOT NULL,
    municipality_id integer NOT NULL,
    parish_id integer NOT NULL,
    place varchar NOT NULL,
    approximate integer NOT NULL,
    observation1 text,
    observation2 text,
    primary key(id)
);

create table regions.social_day_service_types (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    social_day_id integer NOT NULL,
    service_type_id integer NOT NULL,
    service_subtype_id integer DEFAULT 0,
    age_range_id integer NOT NULL,
    n_mans integer NOT NULL DEFAULT 0,
    n_womans integer NOT NULL DEFAULT 0,
    primary key(id)
);

create table regions.social_day_disability (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    social_day_id integer NOT NULL,
    service_type_id integer NOT NULL,
    service_subtype_id integer DEFAULT 0,
    disability_id integer NOT NULL,
    age_range_id integer NOT NULL,
    n_mans integer NOT NULL DEFAULT 0,
    n_womans integer NOT NULL DEFAULT 0,
    primary key(id)
);

create table regions.social_day_ethnicity (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    social_day_id integer NOT NULL,
    service_type_id integer NOT NULL,
    service_subtype_id integer DEFAULT 0,
    ethnicity_id integer NOT NULL,
    age_range_id integer NOT NULL,
    n_mans integer NOT NULL DEFAULT 0,
    n_womans integer NOT NULL DEFAULT 0,
    primary key(id)
);

create table regions.service_subtypes (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    service_type_id integer NOT NULL,
    subtype varchar NOT NULL,
    primary key(id)
);

create table regions.service_types (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    service_type varchar NOT NULL,
    primary key(id)
);

create table regions.disabilitys (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    disability varchar NOT NULL,
    primary key(id)
);

create table regions.ethnicities (
    id integer NOT NULL UNIQUE GENERATED ALWAYS AS IDENTITY (START WITH 1),
    ethnicity varchar NOT NULL,
    primary key(id)
);


-- -- for development it is not necessary to create the indexes -- -- -- --


-- social_day_achievements
ALTER TABLE regions.social_day_achievements ADD CONSTRAINT fk_social_day_created_by FOREIGN KEY (created_by) references regions.users(id);

ALTER TABLE regions.social_day_achievements ADD CONSTRAINT fk_social_day_status_id FOREIGN KEY (status_id) references regions.status(id);

ALTER TABLE regions.social_day_achievements ADD CONSTRAINT fk_social_day_state_id FOREIGN KEY (state_id) references public.states(id);

ALTER TABLE regions.social_day_achievements ADD CONSTRAINT fk_social_day_municipality_id FOREIGN KEY (municipality_id) references public.municipalities(id);

ALTER TABLE regions.social_day_achievements ADD CONSTRAINT fk_social_day_parish_id FOREIGN KEY (parish_id) references public.parishes(id);

-- social_day_service_types
ALTER TABLE regions.social_day_service_types ADD CONSTRAINT fk_social_day_service_types_social_day_id FOREIGN KEY (social_day_id) references regions.social_day_achievements(id);

ALTER TABLE regions.social_day_service_types ADD CONSTRAINT fk_social_day_service_types_service_type_id FOREIGN KEY (service_type_id) references regions.service_types(id);

ALTER TABLE regions.social_day_service_types ADD CONSTRAINT fk_social_day_service_types_service_subtype_id FOREIGN KEY (service_subtype_id) references regions.service_subtypes(id);

ALTER TABLE regions.social_day_service_types ADD CONSTRAINT fk_social_day_service_types_age_range_id FOREIGN KEY (age_range_id) references regions.age_range(id);

-- social_day_disability
ALTER TABLE regions.social_day_disability ADD CONSTRAINT fk_social_day_disability_social_day_id FOREIGN KEY (social_day_id) references regions.social_day_achievements(id);

ALTER TABLE regions.social_day_disability ADD CONSTRAINT fk_social_day_disability_disability_id FOREIGN KEY (disability_id) references regions.disabilitys(id);

ALTER TABLE regions.social_day_disability ADD CONSTRAINT fk_social_day_disability_age_range_id FOREIGN KEY (age_range_id) references regions.age_range(id);

ALTER TABLE regions.social_day_disability ADD CONSTRAINT fk_social_day_disability_service_type_id FOREIGN KEY (service_type_id) references regions.service_types(id);

-- social_day_ethnicity
ALTER TABLE regions.social_day_ethnicity ADD CONSTRAINT fk_social_day_ethnicity_social_day_id FOREIGN KEY (social_day_id) references regions.social_day_achievements(id);

ALTER TABLE regions.social_day_ethnicity ADD CONSTRAINT fk_social_day_ethnicity_ethnicity_id FOREIGN KEY (ethnicity_id) references regions.ethnicities(id);

ALTER TABLE regions.social_day_ethnicity ADD CONSTRAINT fk_social_day_ethnicity_age_range_id FOREIGN KEY (age_range_id) references regions.age_range(id);

ALTER TABLE regions.social_day_ethnicity ADD CONSTRAINT fk_social_day_ethnicity_service_type_id FOREIGN KEY (service_type_id) references regions.service_types(id);

-- service_subtypes
ALTER TABLE regions.service_subtypes ADD CONSTRAINT fk_service_subtypes_service_type_id FOREIGN KEY (service_type_id) references regions.service_types(id);