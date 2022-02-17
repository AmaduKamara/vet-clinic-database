/* Populate database with sample data. */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '02-03-2020', 0, '1', 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '11-15-2018', 2, '1', 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '01-07-2021', 1, '0', 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '05-12-2017', 5, '1', 11);

/* Add more data into animals taable */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '02-08-2020', 0, '0', 11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '11-15-2022', 2, '1', 5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '04-02-1993', 3, '0', 12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '06-12-2005', 1, '1', -54);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '06-07-2005', 7, '1', 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '10-13-1998', 3, '1', 17);

/* Insert data into the owners table: */
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

/* Insert data into the species table */
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

/* Modify inserted animals so it includes the species_id value */
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';

/* Modify your inserted animals to include owner information (owner_id) */
-- Sam Smith owns Agumon.
UPDATE animals SET owner_id = (SELECT id from owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
-- Bob owns Devimon and Plantmon.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');

/* Write queries (using JOIN) to answer the following questions */
-- What animals belong to Melody Pond?
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name='Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals JOIN species ON animals.species_id=species.id WHERE species_id=1;

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT animals.name, full_name FROM owners LEFT JOIN animals ON animals.owner_id=owners.id;

-- How many animals are there per species?
SELECT species.name, COUNT(*) from animals JOIN species ON animals.species_id=species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.* FROM animals LEFT JOIN owners ON animals.owner_id = owners.id LEFT JOIN species ON animals.species_id = species.id 
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.* FROM animals LEFT JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name) AS total FROM owners LEFT JOIN animals ON animals.owner_id=owners.id 
GROUP BY owners.full_name ORDER BY total DESC LIMIT 1;

-- NOT PART OF THE REQUIREMENT - FOR REFERENCE
-- Returns all owners and animals total they own
SELECT owners.full_name, COUNT(animals.name) AS total FROM owners LEFT JOIN animals ON animals.owner_id=owners.id 
GROUP BY owners.full_name;
