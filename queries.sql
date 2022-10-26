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