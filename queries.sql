/*
  Find all animals whose name ends in "mon".
  List the name of all animals born between 2016 and 2019.
  List the name of all animals that are neutered and have less than 3 escape attempts.
  List the date of birth of all animals named either "Agumon" or "Pikachu".
  List name and escape attempts of animals that weigh more than 10.5kg
  Find all animals that are neutered.
  Find all animals not named Gabumon.
  Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
*/

-- Find all animals whose name ends in "mon".
select * from animals where name like '%mon';

-- List the name of all animals born between 2016 and 2019.
select name from animals where
date_of_birth >= '2016/01/01' 
and 
date_of_birth <= '2019/01/01';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
select name from animals where neutered is true and escape_attempts < 3;

-- Alternate way for above query
select name from animals where neutered=true and escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
select date_of_birth from animals where name like 'Agumon' or name like 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
select name from animals where weight_kg > 10.5;

-- Find all animals that are neutered.
select * from animals where neutered is true;

-- Find all animals not named Gabumon.
select * from animals where name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
select * from animals where weight_kg between 10.4 and 17.3;

/*
  Inside a transaction update the animals table by setting the species column to unspecified. 
  Verify that change was made. Then roll back the change and verify that the species columns 
  went back to the state before the transaction.
*/

begin;
update animals set species = 'unspecified';
select * from animals;
rollback;

/*
  Inside a transaction:
  Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
  Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
  Commit the transaction.
  Verify that change was made and persists after commit.
*/

begin;
update animals set species = 'digimon' where name like '%mon';
select * from animals;
update animals set species = 'pokemon' where name not like '%mon';
select * from animals;
commit;
select * from animals;

/*
  Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
  After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)
*/

begin;
delete from animals;
select * from animals;
rollback;
select * from animals;

/*
  Inside a transaction:
  Delete all animals born after Jan 1st, 2022.
  Create a savepoint for the transaction.
  Update all animals' weight to be their weight multiplied by -1.
  Rollback to the savepoint
  Update all animals' weights that are negative to be their weight multiplied by -1.
  Commit transaction
*/

begin;
delete from animals where date_of_birth > '01-JAN-2022';
savepoint label_1;
update animals set weight_kg = weight_kg * -1;
select * from animals;
rollback to label_1;
select * from animals;
update animals set weight_kg = weight_kg * -1 where weight_kg < 0;
select * from animals;
commit;
select * from animals;

-- How many animals are there?
select count(*) from animals;

-- How many animals have never tried to escape?
select count(*) from animals where escape_attempts = 0;

-- What is the average weight of animals?
select avg(weight_kg) as average_weight from animals;

-- Who escapes the most, neutered or not neutered animals?
select neutered, sum(escape_attempts) from animals group by neutered;

-- What is the minimum and maximum weight of each type of animal?
select min(weight_kg) as "minimum_animals_weight (kg)", max(weight_kg) as "maximum_animals_weight (kg)", species from animals group by species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
select avg(escape_attempts) as "Average of Escaped Animal Per Species", species as "Type" from animals where date_of_birth between '01-JAN-1990' and '01-01-2000' group by species;

-- What animals belong to Melody Pond?
select animal.name as "Animal Name", owner.full_name as "Owner Name" from animals animal join owners owner on owner.id = animal.owner_id where owner.full_name like 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
select animal.name as "Animal Name", type.name as "Species Type" from animals animal join species type on animal.species_id = type.id where type.name like 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
select owner.full_name as "Owner", animal.name as "Owned" from animals animal right join owners owner on animal.owner_id = owner.id;

-- How many animals are there per species?
select type.name as "Type", count(animal.*) as "Total Animals" from animals animal right join species type on animal.species_id = type.id group by type.name;

-- List all Digimon owned by Jennifer Orwell.
select animal.name as "Animal Name", type.name as "Type of Animal" from animals animal join species type on animal.species_id = type.id join owners owner on animal.owner_id = owner.id where owner.full_name like 'Jennifer Orwell' and type.name like 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
select animal.name as "Animal", owner.full_name from animals animal left join owners owner on animal.owner_id = owner.id where owner.full_name like 'Dean Winchester' and animal.escape_attempts=0;

-- Who owns the most animals?
select owner.full_name as "Owner Name", count(animal.*) as "Total Owned (Animals)" from animals animal left join owners owner on animal.owner_id = owner.id group by owner.full_name order by "Total Owned (Animals)" desc limit 1;

-- Who was the last animal seen by William Tatcher?
select vet.name as "Vet Name", animal.name as "Animal Name", visit.last_visit as "Last Visit (date)" from animals animal join visits visit on animal.id = visit.animal_id join vets vet on vet.id = visit.vet_id where vet.name like 'William%' order by visit.last_visit desc limit 1;

-- How many different animals did Stephanie Mendez see?
select count(visit.animal_id) as "Total Animal Saw (By Stephanie Mendez)" from animals animal join visits visit on animal.id = visit.animal_id join vets vet on vet.id = visit.vet_id where vet.name like 'Stephanie%' group by vet.name;

-- List all vets and their specialties, including vets with no specialties.
select vet.name as "Vet Name", type.name as "Specialize In" from vets vet left join specializations skill on skill.vet_id = vet.id left join species type on type.id = skill.species_id order by vet.name asc;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
select animal.name as "Animal Name", vet.name as "Vet Name", visit.last_visit as "Last Visited" from animals animal join visits visit on visit.animal_id = animal.id join vets vet on vet.id = visit.vet_id where vet.name like 'Stephanie%' and visit.last_visit between '01-APR-2020' and '30-AUG-2020' order by animal.name asc;

-- What animal has the most visits to vets?
select animal.name as "Animal Name", count(visit.animal_id) as "Visited Time", vet.name as "Vet's Name" from animals animal join visits visit on visit.animal_id = animal.id join vets vet on vet.id = visit.vet_id group by ("Animal Name", "Vet's Name") order by "Visited Time" desc limit 1;

-- Who was Maisy Smith's first visit?
select animal.name as "Animal Name", visit.last_visit as "First Visited (to Maisy Smith)" from animals animal join visits visit on visit.animal_id = animal.id join vets vet on vet.id = visit.vet_id where vet.name like 'Maisy%' order by visit.last_visit asc limit 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
select animal.name as "Animal's Name", type.name as "Type of Animal", animal.date_of_birth as "Date Of Birth", animal.weight_kg as "Weight (Kg)", vet.name as "Specialist Vet's Name", vet.age as "Age of Vet", vet.date_of_graduation as "Graduation Date", visit.last_visit as "Animal's Recent Visit" from animals animal join species type on animal.species_id = type.id join visits visit on visit.animal_id = animal.id join vets vet on vet.id = visit.vet_id order by "Animal's Recent Visit" desc limit 1;

-- How many visits were with a vet that did not specialize in that animal's species?

