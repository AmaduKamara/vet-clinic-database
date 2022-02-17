/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '01-01-2016' AND '12-31-2019';
SELECT name FROM animals WHERE (neutered = 1 AND escape_attempts < 3);
SELECT date_of_birth FROM animals WHERE (name <> 'Agumon' OR name = 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 1;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE (weight_kg >= 10.4 && weight_kg <= 17.3);

/* Begin a transaction */
BEGIN;

/* setting the species column to unspecified */
UPDATE animals SET species = 'unspecified';

/* Rollback to revert to previous state */
ROLLBACK;

/*  setting the species column to digimon  */
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';


/*  setting the species column to pokemon where species is null  */
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

/* Commit the transaction. */
COMMIT;

/* Begin a transaction */
BEGIN;

/* Inside a transaction delete all records in the animals table */
DELETE FROM animals;

/* Rollback to revert to previous state */
ROLLBACK;

/* Begin a transaction */
BEGIN;

/* Delete all animals born after Jan 1st, 2022 */
DELETE FROM animals WHERE date_of_birth > '01-01-2022';

/* Create a savepoint for the transaction. */
SAVEPOINT SP1;

/* Update all animals' weight to be their weight multiplied by -1. */
UPDATE animals SET weight_kg = weight_kg * -1;

/* Rollback to the savepoint */
ROLLBACK TO SP1;

/* Update all animals' weights that are negative to be their weight multiplied by -1. */
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

/* Commit transaction */
COMMIT;

/* Write queries to answer the following questions */
/* How many animals are there? */
SELECT COUNT(name) FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(name) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT MAX(escape_attempts) FROM animals;
SELECT COUNT(name) FROM animals WHERE neutered = '0';
SELECT COUNT(name) FROM animals WHERE neutered = '1';

/* What is the minimum and maximum weight of each type of animal? */
SELECT MIN(weight_kg) FROM animals GROUP BY species; 
SELECT MAX(weight_kg) FROM animals GROUP BY species; 

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '01-01-1990' AND '12-31-2000'  GROUP BY species;


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
