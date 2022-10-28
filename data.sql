/* Insert the following data:
  Animal: His name is Agumon. He was born on Feb 3rd, 2020, and currently weighs 10.23kg. He was neutered and he has never tried to escape.
  Animal: Her name is Gabumon. She was born on Nov 15th, 2018, and currently weighs 8kg. She is neutered and she has tried to escape 2 times.
  Animal: His name is Pikachu. He was born on Jan 7th, 2021, and currently weighs 15.04kg. He was not neutered and he has tried to escape once.
  Animal: Her name is Devimon. She was born on May 12th, 2017, and currently weighs 11kg. She is neutered and she has tried to escape 5 times.
*/

-- We can add the single data like below again and again

insert into animals 
  (name, date_of_birth, escape_attempts, neutered, weight_kg) values
  ('Agumon', '03-FEB-2020', 0, TRUE, 10.23)
;


-- We can add the multiple data or entry by using list of tuples method

insert into animals 
  (name, date_of_birth, escape_attempts, neutered, weight_kg) values
  ('Gabumon', '15-NOV-2018', 2, TRUE, 8),
  ('Pikachu', '07-JAN-2021', 1, FALSE, 15.04),
  ('Devimon', '12-MAY-2017', 5, TRUE, 11)
;

/*
  Insert the following data:
  Animal: His name is Charmander. He was born on Feb 8th, 2020, and currently weighs -11kg. He is not neutered and he has never tried to escape.
  Animal: Her name is Plantmon. She was born on Nov 15th, 2021, and currently weighs -5.7kg. She is neutered and she has tried to escape 2 times.
  Animal: His name is Squirtle. He was born on Apr 2nd, 1993, and currently weighs -12.13kg. He was not neutered and he has tried to escape 3 times.
  Animal: His name is Angemon. He was born on Jun 12th, 2005, and currently weighs -45kg. He is neutered and he has tried to escape once.
  Animal: His name is Boarmon. He was born on Jun 7th, 2005, and currently weighs 20.4kg. He is neutered and he has tried to escape 7 times.
  Animal: Her name is Blossom. She was born on Oct 13th, 1998, and currently weighs 17kg. She is neutered and she has tried to escape 3 times.
  Animal: His name is Ditto. He was born on May 14th, 2022, and currently weighs 22kg. He is neutered and he has tried to escape 4 times.
*/ 

insert into animals
  (name, date_of_birth, escape_attempts, neutered, weight_kg) values
  ('Charmander', '08-FEB-2020', 0, false, -11),
  ('Plantmon', '15-NOV-2021', 2, true, -5.7),
  ('Squirtle', '02-APR-1993', 3, false, -12.13),
  ('Angemon', '12-JUN-2005', 1, true, -45),
  ('Boarmon', '07-JUN-2005', 7, true, 20.4),
  ('Blossom', '13-OCT-1998', 3, true, 17),
  ('Ditto', '14-MAY-2022', 4, true, 22)
;

/* 
  Insert the following data into the owners table:
    Sam Smith 34 years old.
    Jennifer Orwell 19 years old.
    Bob 45 years old.
    Melody Pond 77 years old.
    Dean Winchester 14 years old.
    Jodie Whittaker 38 years old.
*/

insert into owners 
  (full_name, age) values
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38)
;

/*
  Insert the following data into the species table:
    Pokemon
    Digimon
*/

insert into species (name) values ('Pokemon'), ('Digimon');

/*
  Modify your inserted animals so it includes the species_id value:
    If the name ends in "mon" it will be Digimon
    All other animals are Pokemon
*/

update animals set species_id = 2 where name like '%mon';
update animals set species_id = 1 where name not like '%mon';

/*
  Modify your inserted animals to include owner information (owner_id):
    Sam Smith owns Agumon.
    Jennifer Orwell owns Gabumon and Pikachu.
    Bob owns Devimon and Plantmon.
    Melody Pond owns Charmander, Squirtle, and Blossom.
    Dean Winchester owns Angemon and Boarmon.
*/
update animals set owner_id = (select id from owners where full_name like 'Sam Smith') where name like 'Agu%';
update animals set owner_id = (select id from owners where full_name like '%well') where name like 'Gabu%' or name like 'Pika%';
update animals set owner_id = (select id from owners where full_name like 'Bob') where name like 'Devi%' or name like 'Plan%';
update animals set owner_id = (select id from owners where full_name like 'Mel%') where name in ('Charmander', 'Squirtle', 'Blossom');
update animals set owner_id = (select id from owners where full_name like 'Dean%') where name in ('Angemon', 'Boarmon');

/*
  Insert the following data for vets:
    Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
    Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
    Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
    Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
*/

insert into vets 
  (name, age, date_of_graduation) values
  ('William Tatcher', 45, '23-APR-2000'),
  ('Maisy Smith', 26, '17-JAN-2019'),
  ('Stephanie Mendez', 64, '04-MAY-1981'),
  ('Jack Harkness', 38, '08-JUN-2008')
;

/*
  Insert the following data for specialties:
    Vet William Tatcher is specialized in Pokemon.
    Vet Stephanie Mendez is specialized in Digimon and Pokemon.
    Vet Jack Harkness is specialized in Digimon.
*/

insert into specializations
  (vet_id, species_id) values
  (1, 1),
  (3, 2),
  (3, 1),
  (4, 2)
;

/* 
  Insert the following data for visits:
    Agumon: 1, Gabumon: 2, Pikachu: 3, 
    Devimon: 4, Charmander: 5, Plantmon: 6, 
    Squirtle: 7, Angemon: 8, Boarmon: 9, Blossom: 10

    William Tatcher: 1, Maisy Smith: 2, 
    Stephanie Mendez: 3, Jack Harkness: 4
*/

insert into visits
  (animal_id, vet_id, last_visit) values
  (1, 1, '24-MAY-2020'),
  (1, 3, '22-JUL-2020'),
  (2, 4, '02-FEB-2021'),
  (3, 2, '05-JAN-2020'),
  (3, 2, '08-MAR-2020'),
  (3, 2, '14-MAY-2020'),
  (4, 3, '04-MAY-2021'),
  (5, 4, '24-FEB-2021'),
  (6, 2, '21-DEC-2019'),
  (6, 1, '10-AUG-2020'),
  (6, 2, '07-APR-2021'),
  (7, 3, '29-SEP-2019'),
  (8, 4, '03-OCT-2020'),
  (8, 4, '04-NOV-2020'),
  (9, 2, '24-JAN-2019'),
  (9, 2, '15-MAY-2019'),
  (9, 2, '27-FEB-2020'),
  (9, 2, '03-AUG-2020'),
  (10, 3, '24-MAY-2020'),
  (10, 1, '11-JAN-2021')
;

