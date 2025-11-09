USE SneezePharma
GO

INSERT INTO Clientes(Nome, CPF, DataCadastro) 
VALUES ('Yuri Alberto', '22233344410', '12-25-2021'),
('Roberto Carlos', '5559990202', '08-24-2022'),
('Memphis Depay', '89012345699', '09-09-2009'),
('Hugo Souza', '98765432190', '12-12-2012'),
('Max Verstappen', '22887766112', GETDATE());

INSERT INTO ClientesRestritos 
VALUES (2);

--SELECT * FROM Medicamentos

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

/*SELECT c.Nome, t.Tipo, t.DDD, t.Numero
FROM Clientes c
JOIN Telefones t
ON c.id = t.idCliente*/

INSERT INTO Fornecedores (Cnpj, RazaoSocial, Pais, DataAbertura, DataCadastro)
VALUES ('22272076000109', 'Heinz Brasil', 'Brazil', '03-04-2005', GETDATE()),
('33272276000199', 'Drogaria Brasil', 'Brazil', '05-05-2005', GETDATE()),
('44272476000109', 'Drogas LTDA', 'Brazil', '03-03-2020', GETDATE()),
('55272576000109', 'Ervas Boas Corp.', 'Brazil', '12-20-2022', GETDATE()),
('66272376000109', 'Drogaria Corinthias', 'Brazil', '09-05-2012', GETDATE()),
('77272876000109', 'Industrias Wayne', 'Brazil', '10-30-2000', GETDATE());

INSERT INTO FornecedoresRestritos 
VALUES (4);

INSERT INTO Medicamentos (CDB, Nome, Categoria, ValorVenda, DataCadastro)
VALUES ('7892840823221', 'Fofura', 'A', 199.90, GETDATE()),
('7892449722341', 'Dipirona', 'B', 34.90, GETDATE()),
('7891334323224', 'Dramau', 'I', 387.50, GETDATE()),
('7891334323224', 'Vitamina de A a Z', 'V', 67.50, GETDATE());

