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

INSERT INTO @Telefone (Tipo, Ddd, Numero)
VALUES ('Celular', 11, 987640099), 
	('Residencial', 11, 23341234);

EXEC sp_Clientes
	@Nome = 'Carlinhos Maia',
	@Cpf = '11122233344',
	@Telefones = @Telefone;

-- Adicionando Cliente Restrito

EXEC sp_ClientesRestritos 1;

-- Adicionando Medicamentos

DECLARE @UltimaVenda DATETIME = GETDATE();
DECLARE @DataCadastro DATE = CAST(GETDATE() AS DATE);

EXEC sp_Medicamento 
    @CDB = 'CDB001',
    @Nome = N'Mix_Salgadin',
    @Categoria = 'A',
    @ValorVenda = 12.50,
    @UltimaVenda = @UltimaVenda,
    @DataCadastro = @DataCadastro;

-- Adicionando Principios ativos

DECLARE @UltimaCompra DATETIME = GETDATE();
DECLARE @DataCadastro DATE = CAST(GETDATE() AS DATE);

EXEC sp_PrincipiosAtivos 
    @id = 'AI0001',
    @Nome = N'Espinafre',
    @UltimaCompra = @UltimaCompra,
    @DataCadastro = @DataCadastro;

-- Vendas

DECLARE @ItensVenda tp_VendaItens;
INSERT INTO @ItensVenda (Medicamento, Quantidade, ValorUnitario) VALUES
    ('CDB001', 2, 12.50),
    ('CDB002', 1, 8.90);

EXEC sp_Vendas
    @idCliente = 1,
    @Itens = @ItensVenda;

-- Produções

DECLARE @ItensProducao tp_ProducoesItens;

INSERT INTO @ItensProducao (Principio, QuantidadePrincipio) VALUES
    ('AIO001', 100),
    ('AI0002', 50);

DECLARE @DataProducao DATE = CAST(GETDATE() AS DATE);
DECLARE @Medicamento VARCHAR(13) = 'CDB001';
DECLARE @Quantidade NUMERIC(3) = 150;

EXEC sp_Producoes
    @DataProducao = @DataProducao,
    @Medicamento = @Medicamento,
    @Quantidade = @Quantidade,
    @Itens = @ItensProducao;


SELECT c.Nome, c.CPF, t.Tipo, t.DDD, t.Numero 
FROM Clientes c
JOIN Telefones t
ON c.id = t.idCliente

SELECT * FROM Fornecedores