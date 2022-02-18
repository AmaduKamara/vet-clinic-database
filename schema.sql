/* Create a database vet_clinic  */
CREATE DATABASE vet_clinic;

/* Database schema to keep the structure of entire database. */
/* Create a table animals in vet_clinic database */
CREATE TABLE animals(
   id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   name VARCHAR (250) NOT NULL,
   date_of_birth DATE NOT NULL,
   escape_attempts  INT NOT NULL,
   neutered BIT NOT NULL,
   weight_kg DECIMAL
);

/* Alter the animal table and add species column */
ALTER TABLE animals ADD species VARCHAR(250);

/* Create a table named owners */
CREATE TABLE owners(
   id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   full_name VARCHAR (250) NOT NULL,
   age INT NOT NULL
);

/* Create a table named species */
CREATE TABLE species(
   id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   name VARCHAR (250) NOT NULL
);

/* Modify animals table */
ALTER TABLE animals ADD PRIMARY KEY (id);

/* Remove column species */
ALTER TABLE animals DROP COLUMN species;

/* Add column species_id which is a foreign key referencing species table */
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);

/* Add column owner_id which is a foreign key referencing the owners table */
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);

/* CREATING A NEW TABLE - vets */
CREATE TABLE vets(
   id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   name VARCHAR (250) NOT NULL,
   age  INT NOT NULL,
   date_of_graduation DATE NOT NULL
);

/* Create specializations table */
CREATE TABLE specializations(
  vets_id integer NOT NULL,
  species_id integer NOT NULL,
  FOREIGN KEY (vets_id) REFERENCES vets (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

/* Create visits table */
CREATE TABLE visits(
  vets_id integer NOT NULL,
  animals_id integer NOT NULL,
  date_of_visit date,
  FOREIGN KEY (vets_id) REFERENCES vets (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (animals_id) REFERENCES animals (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

