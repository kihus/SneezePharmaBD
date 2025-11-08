INSERT INTO Clientes(Nome, CPF, DataCadastro) 
VALUES ('Yuri Alberto', '22233344410', '12-25-2021'),
('Roberto Carlos', '5559990202', '08-24-2022'),
('Memphis Depay', '89012345699', '09-09-2009'),
('Hugo Souza', '98765432190', '12-12-2012'),
('Max Verstappen', '22887766112', GETDATE());

SELECT * FROM Clientes

INSERT INTO Telefones (Tipo, DDD, Numero, idCliente)
VALUES ('Celular', '11', '988761234', 1);
