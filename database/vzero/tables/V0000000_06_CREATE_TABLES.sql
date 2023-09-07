USE FINANCEIRO
GO

CREATE TABLE regras.Recorrencia
(
	identificacao	VARCHAR(100) NOT NULL PRIMARY KEY,
	qtRecorrencia	INT
)
GO

INSERT INTO regras.Recorrencia(identificacao,qtRecorrencia)
VALUES
	('DIÁRIO',1),('SEMANAL',7),('QUINZENAL',15),('MENSAL',1),('ANUAL',1)
GO

CREATE TABLE despesa.Despesas
(
	identificacao			VARCHAR(100) NOT NULL PRIMARY KEY,
	agrupador				VARCHAR(100) NOT NULL,
	recorrencia				VARCHAR(100) NULL,
	valorInicial			FLOAT NOT NULL DEFAULT(0.0),
	lancamentoInicial		DATETIME NOT NULL DEFAULT(GETDATE()),
	lancamentoFinal			DATETIME NULL DEFAULT(GETDATE()),
	stFixa					BIT NOT NULL DEFAULT(0),
	qtParcelas				INT NOT NULL DEFAULT(0)
)
GO

ALTER TABLE despesa.Despesas
	WITH NOCHECK ADD CONSTRAINT FKDespesas01 FOREIGN KEY (recorrencia) REFERENCES regras.Recorrencia(identificacao) ON UPDATE CASCADE
GO

CREATE TABLE movimentacao.Movimentacoes
(
	idMovimentacao	INT IDENTITY PRIMARY KEY,
	despesa			VARCHAR(100) NULL,
	receita			VARCHAR(100) NULL,
	valor			FLOAT DEFAULT(0.0),
	lancamento		DATETIME DEFAULT(GETDATE()),
	quitada			BIT DEFAULT(0)
)
GO

ALTER TABLE movimentacao.Movimentacoes
	WITH NOCHECK ADD CONSTRAINT FKMovimentacoes01 FOREIGN KEY (despesa) REFERENCES despesa.Despesas(identificacao) ON DELETE CASCADE ON UPDATE CASCADE
GO
