/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

/* Create a table animals in vet_clinic database */
CREATE TABLE animals(
   id INT GENERATED ALWAYS AS IDENTITY,
   name VARCHAR (250) NOT NULL,
   date_of_birth DATE NOT NULL,
   escape_attempts  INT NOT NULL,
   neutered BIT NOT NULL,
   weight_kg DECIMAL,
   PRIMARY KEY (ID)
);