CREATE DATABASE ParagonTech;
USE ParagonTech;

CREATE TABLE Empresa(
idEmpresa INT PRIMARY KEY auto_increment,
fkEndereco INT,
razaoSocial VARCHAR(45),
cnpj VARCHAR(14),
nome VARCHAR(45),
email VARCHAR(80),
senha VARCHAR(45),
	FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEndereco)
);

CREATE TABLE TotenMedidas(
idDataHora DATETIME PRIMARY KEY,
fkToten INT,
cpuUso DOUBLE,
ramUso DOUBLE,
discoUso DOUBLE,
internetUso DOUBLE,
	FOREIGN KEY(fkToten) REFERENCES Toten(idToten)
);

CREATE TABLE Endereco(
idEndereco INT PRIMARY KEY auto_increment,
cep VARCHAR(8),
numero int,
nomeRua VARCHAR(45),
complemento Varchar(45),
bairro varchar(45),
cidade varchar(45)
);

CREATE TABLE Toten(
idToten INT PRIMARY KEY auto_increment,
Ativo BOOLEAN,
soTotal VARCHAR(45),
cpuTotal DOUBLE,
ramTotal DOUBLE,
discoTotal DOUBLE,
fkEmpresa INT,
	FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Temp(
idTemp int primary key auto_increment,
tempMedida int
);

CREATE TABLE medidaEmpresa(
fkEmpresa int,
fkTemp int,
medidaNome varchar(45),
	FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
    FOREIGN KEY (fkTemp) REFERENCES Temp (idTemp)
);

INSERT INTO Empresa (fkEndereco, nome) values
	(1, "Teste01");

SELECT * FROM Empresa JOIN Endereco as end 
	ON fkEndereco = idEndereco
	JOIN medidasEmpresas
    on Empresa.fkEmpresa = end.idEmpresa
    join Toten as t
    on Empresa.fkEmpresa = t.idEmpresa;
    
    SELECT Empresa.razaoSocial, Empresa.nome, Endereco.cep, TotenMedidas.cpuUso
FROM Empresa
JOIN Endereco ON Empresa.fkEndereco = Endereco.idEndereco
LEFT JOIN Toten ON Empresa.idEmpresa = Toten.fkEmpresa
LEFT JOIN TotenMedidas ON Toten.idToten = TotenMedidas.fkToten
WHERE Empresa.nome = "Teste01";

SELECT Empresa.razaoSocial, Toten.cpuTotal, Toten.ramTotal
FROM Empresa
JOIN Toten ON Empresa.idEmpresa = Toten.fkEmpresa
WHERE Toten.Ativo = 1;

SELECT Empresa.razaoSocial, medidaEmpresa.medidaNome, Temp.tempMedida
FROM Empresa
JOIN medidaEmpresa ON Empresa.idEmpresa = medidaEmpresa.fkEmpresa
JOIN Temp ON medidaEmpresa.fkTemp = Temp.idTemp
WHERE Temp.idTemp BETWEEN 'data_inicial' AND 'data_final';

SELECT Empresa.razaoSocial, TotenMedidas.cpuUso, TotenMedidas.idDataHora
FROM Empresa
JOIN Toten ON Empresa.idEmpresa = Toten.fkEmpresa
JOIN TotenMedidas ON Toten.idToten = TotenMedidas.fkToten
WHERE Empresa.nome = "Teste01" AND TotenMedidas.idDataHora BETWEEN 'data_inicial' AND 'data_final';

    

    
