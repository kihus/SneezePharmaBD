USE SneezePharma;
GO

-- Fornecedores

CREATE OR ALTER PROCEDURE sp_Fornecedores
	@Cnpj VARCHAR(14),
	@RazaoSocial NVARCHAR(50),
	@Pais NVARCHAR(20),
	@DataAbertura DATE
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Fornecedores (Cnpj, RazaoSocial, Pais, DataAbertura, DataCadastro)
	VALUES (@Cnpj, @RazaoSocial, @Pais, @DataAbertura, GETDATE());

	PRINT ('Fornecedor Adicionado');
END
GO

-- Fornecedor Restrito

CREATE OR ALTER PROCEDURE sp_FornecedoresRestritos
	@idFornecedor INT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY	
		INSERT INTO FornecedoresRestritos (idFornecedor)
		VALUES (@idFornecedor);

		PRINT 'Fornecedor Adicionado a lista de Restritos';
	END TRY

	BEGIN CATCH 
		PRINT 'Erro: Não foi possível adicionar o fornecedor.';
		PRINT 'Erro original: ' + ERROR_MESSAGE();
	END CATCH
END
GO

-- Compra

CREATE TYPE tp_ComprasItens AS TABLE (
	idIngrediente VARCHAR (6),
	Quantidade NUMERIC (4,0),
	ValorUnitario DECIMAL (5,2)
);
GO

CREATE OR ALTER PROCEDURE sp_Compra
	@idFornecedor INT,
	@Itens tp_ComprasItens READONLY
AS
BEGIN
	DECLARE @idCompra INT, @idCompraItem INT 

	INSERT INTO Compras(DataCompra, idFornecedor)
	VALUES (GETDATE(), @idFornecedor)

	SET @idCompra = SCOPE_IDENTITY();

	INSERT INTO ItensCompra (idCompra, Ingrediente, Quantidade, ValorUnitario)
	SELECT @idCompra, idIngrediente, Quantidade, ValorUnitario
	FROM @Itens

	UPDATE Fornecedores
	SET UltimoFornecimento = GETDATE()
	WHERE id = @idFornecedor
END
GO

-- Telefone

CREATE TYPE tp_Telefones AS TABLE (
	Tipo VARCHAR(15) NOT NULL,
	Ddd NUMERIC (2) NOT NULL,
	Numero NUMERIC (9) NOT NULL
);
GO

CREATE OR ALTER PROCEDURE sp_Telefones
	@idClientes INT,
	@TelefonesCli tp_Telefones READONLY

AS
BEGIN
	BEGIN TRY
		INSERT INTO Telefones (Tipo, DDD, Numero, idCliente)
		SELECT Tipo, Ddd, Numero, @idClientes
		FROM @TelefonesCli

		PRINT 'Telefone(s) Adicionado(s)!';
	END TRY
	BEGIN CATCH
		PRINT 'Erro: Não foi possível adicionar o telefone';
		PRINT 'Erro: ' + ERROR_MESSAGE();
	END CATCH
END
GO

-- Clientes

CREATE OR ALTER PROCEDURE sp_Clientes
	@Nome VARCHAR(50),
	@Cpf VARCHAR(11),
	@Telefones tp_Telefones READONLY
	
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @idCliente INT

	BEGIN TRY
		INSERT INTO Clientes (Nome, Cpf, DataCadastro)
		VALUES (@Nome, @Cpf, GETDATE());

		SET @idCliente = SCOPE_IDENTITY();

		-- Adicionando Telefones
		EXEC sp_Telefones 
			@idCliente, 
			@Telefones;

		PRINT 'Cliente Adicionado!';
	END TRY

	BEGIN CATCH 
		PRINT 'Erro: Não foi possível adicionar o cliente';
		PRINT 'Erro: ' + ERROR_MESSAGE();
	END CATCH 
END
GO

