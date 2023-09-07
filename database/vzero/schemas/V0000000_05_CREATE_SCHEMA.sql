USE FINANCEIRO
GO

CREATE SCHEMA cadastro
GO

CREATE SCHEMA despesa
GO

CREATE SCHEMA receita
GO

CREATE SCHEMA movimentacao
GO

CREATE SCHEMA regras
GO

GRANT EXECUTE ON SCHEMA :: cadastro TO AplicacaoRole
GO
GRANT EXECUTE ON SCHEMA :: despesa TO AplicacaoRole
GO
GRANT EXECUTE ON SCHEMA :: receita TO AplicacaoRole
GO
GRANT EXECUTE ON SCHEMA :: movimentacao TO AplicacaoRole
GO
GRANT EXECUTE ON SCHEMA :: regras TO AplicacaoRole
GO