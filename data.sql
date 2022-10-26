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

-- Insert more data 

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