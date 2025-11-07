CREATE TRIGGER trg_Vendas_CheckCliente
ON Vendas
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Clientes c ON c.CPF = i.CPF
        LEFT JOIN ClientesRestritos cr ON cr.idCliente = c.id
        WHERE c.StatusCliente = 0 OR cr.idCliente IS NOT NULL
    )
    BEGIN
        RAISERROR('Cliente bloqueado ou inativo não pode realizar venda.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
    ELSE
    BEGIN
        INSERT INTO Vendas (DataVenda, CPF, ValorTotal)
        SELECT DataVenda, CPF, ValorTotal FROM inserted;
    END
END;
GO

CREATE TRIGGER trg_Compras_CheckFornecedor
ON Compras
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Fornecedores f ON f.Cnpj = i.Fornecedor
        LEFT JOIN FornecedoresRestritos fr ON fr.idFornecedor = f.id
        WHERE f.Situacao = 0 OR fr.idFornecedor IS NOT NULL
    )
    BEGIN
        RAISERROR('Fornecedor bloqueado ou inativo não pode comprar.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
    ELSE
    BEGIN
        INSERT INTO Compras (DateCompra, Fornecedor, ValorTotal)
        SELECT DateCompra, Fornecedor, ValorTotal FROM inserted;
    END
END

CREATE TRIGGER trg_ItensVenda_Limite
ON ItensVenda
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT idVenda
        FROM ItensVenda
        GROUP BY idVenda
        HAVING COUNT(*) > 3
    )
    BEGIN
        RAISERROR('Não pode vender mais de 3 itens por venda.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END

CREATE TRIGGER trg_ItensCompra_Limite
ON ItensCompra
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT idCompra
        FROM ItensCompra
        GROUP BY idCompra
        HAVING COUNT(*) > 3
    )
    BEGIN
        RAISERROR('Não pode comprar mais de 3 itens por compra.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END

CREATE TRIGGER trg_PreventDelete_Clientes
ON Clientes
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('DELETE não permitido.', 16, 1);
    ROLLBACK TRANSACTION;
END
