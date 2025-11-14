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

-- Clientes Restritos

CREATE OR ALTER PROCEDURE sp_ClientesRestritos
	@idCliente INT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY	
		INSERT INTO ClientesRestritos (idCliente)
		VALUES (@idCliente);

		PRINT 'Cliente Adicionado à lista de Restritos';
	END TRY

	BEGIN CATCH 
		PRINT 'Erro: Não foi possível adicionar o cliente.';
		PRINT 'Erro original: ' + ERROR_MESSAGE();
	END CATCH
END
GO

-- Medicamento

CREATE OR ALTER PROCEDURE sp_Medicamento
    @CDB VARCHAR(13),
    @Nome NVARCHAR(40),
    @Categoria CHAR(1),
    @ValorVenda DECIMAL(4,2),
    @UltimaVenda DATETIME,
    @DataCadastro DATE
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        INSERT INTO Medicamentos(CDB, Nome, Categoria, ValorVenda, UltimaVenda, DataCadastro)
        VALUES (@CDB, @Nome, @Categoria, @ValorVenda, @UltimaVenda, @DataCadastro);

        PRINT 'Medicamento Adicionado!';
    END TRY
    BEGIN CATCH
        PRINT 'Erro: Não foi possível adicionar o medicamento.';
        PRINT 'Erro original: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

-- Principios Ativos

CREATE OR ALTER PROCEDURE sp_PrincipiosAtivos
    @id VARCHAR(6),
    @Nome NVARCHAR(20),
    @UltimaCompra DATETIME,
    @DataCadastro DATE
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        INSERT INTO PrincipiosAtivos (id, Nome, UltimaCompra, DataCadastro, Situacao)
        VALUES (@id, @Nome, @UltimaCompra, @DataCadastro, 1);

        PRINT 'Princípio Ativo Adicionado!';
    END TRY
    BEGIN CATCH
        PRINT 'Erro: Não foi possível adicionar o princípio ativo.';
        PRINT 'Erro original: ' + ERROR_MESSAGE();
    END CATCH
END;
GO


-- Venda

CREATE TYPE tp_VendaItens AS TABLE (
    Medicamento VARCHAR(13),
    Quantidade NUMERIC(3),
    ValorUnitario NUMERIC(6,2)
);
GO

CREATE OR ALTER PROCEDURE sp_Vendas
    @idCliente INT,
    @Itens tp_VendaItens READONLY
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @idVenda INT;

    BEGIN TRY
        INSERT INTO Vendas (DataVenda, idCliente)
        VALUES (CAST(GETDATE() AS DATE), @idCliente);

        SET @idVenda = SCOPE_IDENTITY();

        INSERT INTO ItensVenda (idVenda, Medicamento, Quantidade, ValorUnitario)
        SELECT @idVenda, Medicamento, Quantidade, ValorUnitario
        FROM @Itens;

        PRINT 'Venda registrada com sucesso!';
    END TRY
    BEGIN CATCH
        PRINT 'Erro: Não foi possível registrar a venda.';
        PRINT 'Erro original: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
-- Producoes

CREATE TYPE tp_ProducoesItens AS TABLE (
    Principio VARCHAR(6),
    QuantidadePrincipio NUMERIC(4)
);
GO

CREATE OR ALTER PROCEDURE sp_Producoes
    @DataProducao DATE,
    @Medicamento VARCHAR(13),
    @Quantidade NUMERIC(3),
    @Itens tp_ProducoesItens READONLY
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @idProducao INT;

    BEGIN TRY
        INSERT INTO Producoes (DataProducao, Medicamento, Quantidade)
        VALUES (@DataProducao, @Medicamento, @Quantidade);

        SET @idProducao = SCOPE_IDENTITY();

        INSERT INTO ItensProducao (idProducao, Principio, QuantidadePrincipio)
        SELECT @idProducao, Principio, QuantidadePrincipio
        FROM @Itens;

        PRINT 'Produção registrada com sucesso!';
    END TRY
    BEGIN CATCH
        PRINT 'Erro: Não foi possível registrar a produção.';
        PRINT 'Erro original: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
