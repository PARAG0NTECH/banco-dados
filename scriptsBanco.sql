CREATE DATABASE ParagonTech;
USE ParagonTech;

CREATE TABLE Empresa(
idEmpresa INT PRIMARY KEY,
fkEndereco INT,
razaoSocial VARCHAR(45),
CNPJ VARCHAR(14),
nome VARCHAR(45),
email VARCHAR(80),
senha VARCHAR(45),
	FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEndereco)
);

CREATE TABLE TotenMedidas(
idDataHora DATETIME PRIMARY KEY,
fkToten INT,
CPU DOUBLE,
RAM DOUBLE,
Disco DOUBLE,
Internet DOUBLE,
	FOREIGN KEY(fkToten) REFERENCES Toten(idToten)
);

CREATE TABLE Endereco(
idEndereco INT PRIMARY KEY,
CEP VARCHAR(8),
Numero VARCHAR(8)
);

CREATE TABLE Toten(
idToten INT PRIMARY KEY,
Ativo BOOLEAN,
SO VARCHAR(45),
CPU VARCHAR(45),
RAM DOUBLE,
Disco DOUBLE,
fkEmpresa INT,
	FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
);