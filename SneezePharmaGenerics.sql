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
VALUES (7892840823221, 'Fofura', 'A', 199.90, GETDATE()),
(7892449722341, 'Dipirona', 'B', 34.90, GETDATE()),
(7891334323224, 'Dramau', 'I', 387.50, GETDATE()),
(7891334383235, 'Vitamina de A a Z', 'V', 67.50, GETDATE()),
(7891334345390, 'Anti-Java', 'V', 29.90, GETDATE());

INSERT INTO PrincipiosAtivos (Nome, DataCadastro)
VALUES ('Aminaftona', GETDATE()),
('Acebrofilina', GETDATE()),
('Femprocumona', GETDATE()),
('Fluconazol', GETDATE()),
('Felodipino', GETDATE());

INSERT INTO Compras (DataCompra, idFornecedor)
VALUES (GETDATE(), 2), 
(GETDATE(), 3), 
(GETDATE(), 5), 
(GETDATE(), 1), 
(GETDATE(), 6); 

INSERT INTO ItensCompra (idCompra, Ingrediente, Quantidade, ValorUnitario)
VALUES (1, 'AI0001', 10, 25.50), 
(2, 'AI0003', 30, 43.99), 
(3, 'AI0002', 50, 15.99), 
(4, 'AI0005', 99, 159.99), 
(5, 'AI0004', 20, 32.00);

INSERT INTO Producoes (DataProducao, Medicamento, Quantidade) 
VALUES (GETDATE(), 7892840823221, 10), 
(GETDATE(), 7892449722341, 5),
(GETDATE(), 7891334323224, 43),
(GETDATE(), 7891334383235, 79),
(GETDATE(), 7891334345390, 99);

INSERT INTO ItensProducao(idProducao, Principio, QuantidadePrincipio) 
VALUES (1, 'AI0001', 100),
(2, 'AI0002', 250),
(3, 'AI0003', 39),
(4, 'AI0004', 27),
(5, 'AI0005', 17);

INSERT INTO Vendas (DataVenda, idCliente)
VALUES (GETDATE(), 4);

INSERT INTO ItensVenda (idVenda, Medicamento, Quantidade, ValorUnitario)
VALUES (1, 7892840823221, 20, 100.90),
(1, 7891334323224, 40, 90.90),
(1, 7891334345390, 70, 27.90);

SELECT * FROM Vendas