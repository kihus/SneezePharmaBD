-- Adicionando Fornecedor
EXEC sp_Fornecedores 
	@Cnpj = '09436256000110', 
	@RazaoSocial = 'faive bai faive', 
	@Pais = 'Brasil',  
	@DataAbertura = '03-20-2008';

-- Adicionando Fornecedor Restrito
EXEC sp_FornecedoresRestritos
	@idFornecedor = 4;

-- Adicionando Compra
DECLARE @ItensDeCompra tp_ComprasItens;

INSERT INTO @ItensDeCompra (idIngrediente, Quantidade, ValorUnitario)
VALUES 
('AI0003', 10, 5.50),
('AI0005', 20, 6.50);

EXEC sp_Compra 6, @Itens = @ItensDeCompra;

-- Adicionando Cliente

DECLARE @Telefone tp_Telefones;

INSERT INTO @Telefone (Tipo, Ddd, Numero)
VALUES ('Celular', 11, 944996633), 
	('Residencial', 11, 24428979),
	('Residencial', 21, 24024422),
	('Celular', 21, 998877669);

EXEC sp_Clientes
	@Nome = 'Tiago Laifer',
	@Cpf = '55544433322',
	@Telefones = @Telefone;

SELECT c.Nome, c.CPF, t.Tipo, t.DDD, t.Numero 
FROM Clientes c
JOIN Telefones t
ON c.id = t.idCliente

SELECT * FROM Fornecedores