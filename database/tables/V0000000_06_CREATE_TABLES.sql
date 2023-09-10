USE FINANCEIRO
GO

IF OBJECT_ID('regras.Recorrencia','U') IS NULL
BEGIN

	CREATE TABLE regras.Recorrencia
	(
		identificacao	VARCHAR(100) NOT NULL PRIMARY KEY,
		qtRecorrencia	INT
	)
	PRINT 'TABELA REGRAS.RECORRENCIA CRIADA COM SUCESSO.'

	INSERT INTO regras.Recorrencia(identificacao,qtRecorrencia)
	VALUES
		('DIÁRIO',1),('SEMANAL',7),('QUINZENAL',15),('MENSAL',1),('ANUAL',1)
END
GO

IF OBJECT_ID('despesa.Despesas','U') IS NULL
BEGIN
	CREATE TABLE despesa.Despesas
	(
		identificacao			VARCHAR(100) NOT NULL PRIMARY KEY,
		agrupador				VARCHAR(100) NOT NULL,
		recorrencia				VARCHAR(100) NULL,
		valorInicial			FLOAT NOT NULL DEFAULT(0.0),
		lancamentoInicial		DATETIME NOT NULL DEFAULT(GETDATE()),
		lancamentoFinal			DATETIME NULL DEFAULT(GETDATE()),
		stFixa					BIT NOT NULL DEFAULT(0),
		qtParcelas				INT NOT NULL DEFAULT(0),
		CONSTRAINT FKDespesas01 FOREIGN KEY (recorrencia) REFERENCES regras.Recorrencia(identificacao) ON UPDATE CASCADE
	)
	PRINT 'TABELA DESPESA.DESPESAS CRIADA COM SUCESSO.'
END
GO

IF OBJECT_ID('movimentacao.Movimentacoes','U') IS NULL
BEGIN
	CREATE TABLE movimentacao.Movimentacoes
	(
		idMovimentacao	INT IDENTITY PRIMARY KEY,
		despesa			VARCHAR(100) NULL,
		receita			VARCHAR(100) NULL,
		valor			FLOAT DEFAULT(0.0),
		lancamento		DATETIME DEFAULT(GETDATE()),
		quitada			BIT DEFAULT(0),
		CONSTRAINT FKMovimentacoes01 FOREIGN KEY (despesa) REFERENCES despesa.Despesas(identificacao) ON DELETE CASCADE ON UPDATE CASCADE
	)
	PRINT 'TABELA MOVIMENTACAO.MOVIMENTACOES CRIADA COM SUCESSO.'
END
GO
