/* Database schema to keep the structure of entire database. */

/* 
Create a table named animals with the following columns:
  id: integer
  name: string
  date_of_birth: date
  escape_attempts: integer
  neutered: boolean
  weight_kg: decimal
*/

CREATE TABLE animals (
  id integer generated by default as identity primary key,
  name varchar(50),
  date_of_birth date,
  escape_attempts integer,
  neutered boolean,
  weight_kg numeric
);

/*
    Add a column species of type string to your animals table.
*/

alter table animals add column species varchar(50);

/*
  Create a table named owners with the following columns:
    id: integer (set it as autoincremented PRIMARY KEY)
    full_name: string
    age: integer
*/
create table owners (
  id int generated by default as identity primary key,
  full_name varchar(50),
  age smallint
);

/*
  Create a table named species with the following columns:
    id: integer (set it as autoincremented PRIMARY KEY)
    name: string
*/

create table species (
  id int generated by default as identity,
  name varchar(50),
  primary key(id)
);

/*
  Modify animals table:
    Make sure that id is set as autoincremented PRIMARY KEY
    Remove column species
    Add column species_id which is a foreign key referencing species table
    Add column owner_id which is a foreign key referencing the owners table
*/

-- Remove Species
alter table animals drop column species;

-- Add column species_id which is a foreign key referencing species table
alter table animals add column species_id int;
alter table animals add constraint fk_species_id foreign key(species_id) references species(id) on delete cascade;

-- Add column owner_id which is a foreign key referencing the owners table
alter table animals add column owner_id int;
alter table animals add constraint fk_owner_id foreign key(owner_id) references owners(id) on delete cascade;

/*
  Create a table named vets with the following columns:
    id: integer (set it as autoincremented PRIMARY KEY)
    name: string
    age: integer
    date_of_graduation: date
*/

create table vets (
  id int generated by default as identity primary key,
  name varchar(100),
  age smallint,
  date_of_graduation date
);

/*
  There is a many-to-many relationship between the tables species and vets: a vet 
  can specialize in multiple species, and a species can have multiple vets specialized in it. 
  Create a "join table" called specializations to handle this relationship.
*/

create table specializations (
  vet_id int not null,
  species_id int not null,
  constraint fk_vets foreign key(vet_id) references vets(id) on delete cascade,
  constraint fk_species foreign key(species_id) references species(id) on delete cascade
);

/*
  There is a many-to-many relationship between the tables animals and vets:
  an animal can visit multiple vets and one vet can be visited by multiple animals.
  Create a "join table" called visits to handle this relationship, it should also keep
  track of the date of the visit.
*/

create table visits (
  animal_id int not null,
  vet_id int not null,
  last_visit data DATE DEFAULT CURRENT_DATE,
  constrain fk_animal_id foreign key(animal_id) references animals(id),
  constrain fk_vet_id foreign key(vet_id) references vets(id)
);
