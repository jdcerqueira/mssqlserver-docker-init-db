USE FINANCEIRO
GO

IF OBJECT_ID('despesa.uspIncluirDespesa','P') IS NOT NULL
	DROP PROCEDURE despesa.uspIncluirDespesa
GO

IF OBJECT_ID('movimentacao.uspIncluirMovimentacaoDespesa','P') IS NOT NULL
	DROP PROCEDURE movimentacao.uspIncluirMovimentacaoDespesa
GO

IF OBJECT_ID('despesa.uspBuscaDespesa','P') IS NOT NULL
	DROP PROCEDURE despesa.uspBuscaDespesa
GO

IF OBJECT_ID('despesa.uspListaDespesasGeral','P') IS NOT NULL
	DROP PROCEDURE despesa.uspListaDespesasGeral
GO


CREATE PROCEDURE despesa.uspIncluirDespesa
	@identificacao		VARCHAR(100),
	@agrupador			VARCHAR(100),
	@recorrencia		VARCHAR(100),
	@valorInicial		FLOAT,
	@lancamentoInicial	DATETIME,
	@lancamentoFinal	DATETIME = NULL,
	@stFixa				BIT = 0,
	@qtParcelas			INT = 0
AS
BEGIN
	SET NOCOUNT ON

	INSERT INTO despesa.Despesas
		(identificacao,agrupador,recorrencia,valorInicial,lancamentoInicial,lancamentoFinal,stFixa,qtParcelas)
	VALUES
		(@identificacao,@agrupador,@recorrencia,@valorInicial,@lancamentoInicial,@lancamentoFinal,@stFixa,@qtParcelas)

	SET NOCOUNT OFF
END
GO

PRINT 'PROCEDURE despesa.uspIncluirDespesa CRIADA COM SUCESSO.'
GO  

CREATE PROCEDURE movimentacao.uspIncluirMovimentacaoDespesa
	@identificacao	VARCHAR(100),
	@valor			FLOAT,
	@lancamento		DATETIME = GETDATE,
	@quitada		BIT = 0
AS
BEGIN
	SET NOCOUNT ON

	INSERT INTO movimentacao.Movimentacoes
		(despesa,lancamento,valor,quitada)
	VALUES
		(@identificacao,@lancamento,@valor,@quitada)

	SET NOCOUNT OFF
END
GO
PRINT 'PROCEDURE movimentacao.uspIncluirMovimentacaoDespesa CRIADA COM SUCESSO.'
GO  

CREATE PROCEDURE despesa.uspBuscaDespesa
	@identificacao VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON

	SELECT 
		D.identificacao,
		D.agrupador,
		D.recorrencia,
		D.valorInicial,
		D.lancamentoInicial,
		ISNULL(D.lancamentoFinal,CONVERT(DATE,GETDATE())) lancamentoFinal,
		D.stFixa,
		D.qtParcelas,
		MAX(M.lancamento) ultimoLancamento,
		R.qtRecorrencia
	FROM despesa.Despesas D
		INNER JOIN movimentacao.Movimentacoes M
			ON M.despesa = D.identificacao
		LEFT JOIN regras.Recorrencia R
			ON R.identificacao = D.recorrencia
	WHERE
		D.identificacao = @identificacao
	GROUP BY
		D.identificacao,
		D.agrupador,
		D.recorrencia,
		D.valorInicial,
		D.lancamentoInicial,
		D.lancamentoFinal,
		D.stFixa,
		D.qtParcelas,
		R.qtRecorrencia

	SET NOCOUNT OFF
END
GO
PRINT 'PROCEDURE despesa.uspBuscaDespesa CRIADA COM SUCESSO.'
GO  

CREATE PROCEDURE despesa.uspListaDespesasGeral
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @dtHrAtual	DATETIME = GETDATE()

	SELECT
		D.identificacao, D.agrupador, D.recorrencia,
		D.valorInicial, D.lancamentoInicial, D.lancamentoFinal, 
		D.stFixa, D.qtParcelas, MAX(M.lancamento) ultimoLancamento, R.qtRecorrencia
	FROM despesa.Despesas D
		INNER JOIN movimentacao.Movimentacoes M ON M.despesa = D.identificacao
		LEFT JOIN regras.Recorrencia R ON R.identificacao = D.recorrencia
	GROUP BY
		D.identificacao, D.agrupador, D.recorrencia,
		D.valorInicial, D.lancamentoInicial, D.lancamentoFinal, 
		D.stFixa, D.qtParcelas, R.qtRecorrencia

	SET NOCOUNT OFF
END
GO
PRINT 'PROCEDURE despesa.uspListaDespesasGeral CRIADA COM SUCESSO.'
GO  