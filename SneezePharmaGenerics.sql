USE SneezePharma
GO

INSERT INTO Clientes(Nome, CPF, DataCadastro) 
VALUES ('Yuri Alberto', '22233344410', '12-25-2021'),
('Roberto Carlos', '5559990202', '08-24-2022'),
('Memphis Depay', '89012345699', '09-09-2009'),
('Hugo Souza', '98765432190', '12-12-2012'),
('Max Verstappen', '22887766112', GETDATE());

SELECT * FROM Fornecedores

INSERT INTO Telefones (Tipo, DDD, Numero, idCliente)
VALUES ('Celular', '11', '988761234', 1),
('Residencial', '11', '24428224', 1),
('Celular', '21', '989890099', 2),
('Celular', '18', '990099111', 2),
('Residencial', '13', '23329009', 2),
('Residencial', '21', '944987609', 3),
('Celular', '16', '987651234', 4),
('Celular', '16', '998835432', 4),
('Residencial', '12', '20244321', 5);

SELECT c.Nome, t.Tipo, t.DDD, t.Numero
FROM Clientes c
JOIN Telefones t
ON c.id = t.idCliente

INSERT INTO Fornecedores (Cnpj, RazaoSocial, Pais, DataAbertura, DataCadastro)
VALUES ('22272076000109', 'Heinz Brasil', 'Brazil', '03-04-2005', GETDATE()); 