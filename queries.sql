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