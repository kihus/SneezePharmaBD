USE SneezePharma
GO

ALTER TABLE Telefones
ADD FOREIGN KEY (idCliente) REFERENCES Clientes (id);

ALTER TABLE ClientesRestritos
ADD FOREIGN KEY (idCliente) REFERENCES Clientes (id);

ALTER TABLE Vendas
ADD FOREIGN KEY (idCliente) REFERENCES Clientes (id)

ALTER TABLE ItensVenda
ADD FOREIGN KEY (idVenda) REFERENCES Vendas (id);

ALTER TABLE ItensVenda
ADD FOREIGN KEY (Medicamento) REFERENCES Medicamentos (CDB);

ALTER TABLE Producoes
ADD FOREIGN KEY (Medicamento) REFERENCES Medicamentos (CDB);

ALTER TABLE ItensProducao
ADD FOREIGN KEY (idProducao) REFERENCES Producoes (id);

ALTER TABLE ItensProducao
ADD FOREIGN KEY (Principio) REFERENCES PrincipiosAtivos (idPA);

ALTER TABLE Compras 
ADD FOREIGN KEY (idFornecedor) REFERENCES Fornecedores (id)

ALTER TABLE ItensCompra
ADD FOREIGN KEY (idCompra) REFERENCES Compras (id);

ALTER TABLE ItensCompra
ADD FOREIGN KEY (Ingrediente) REFERENCES PrincipiosAtivos (idPA);

ALTER TABLE FornecedoresRestritos
ADD FOREIGN KEY (idFornecedor) REFERENCES Fornecedores (id);

ALTER TABLE ClientesRestritos
ADD FOREIGN KEY (idCliente) REFERENCES Clientes (id);