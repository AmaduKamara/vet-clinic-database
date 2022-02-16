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

/* Create a table named owners */
CREATE TABLE species(
   id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   name VARCHAR (250) NOT NULL
);