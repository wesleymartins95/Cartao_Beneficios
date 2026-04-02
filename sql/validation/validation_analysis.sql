-- Essa query é a verdade absoluta dos dados resultado como sua "fonte da verdade"
SELECT
    d.mes_ano_label,
    COUNT(DISTINCT f.sk_empresa)        AS empresas_ativas,
    COUNT(DISTINCT f.sk_colaborador)    AS colaboradores_ativos,
    COUNT(*)                            AS total_transacoes,
    SUM(f.valor_brl)                    AS mrr_realizado,
    SUM(f.valor_brl) * 12              AS arr_projetado,
    AVG(f.valor_brl)                    AS ticket_medio
FROM FACT_TRANSACAO f
JOIN DIM_DATA d             ON f.sk_data   = d.sk_data
JOIN DIM_STATUS_TRANSACAO s ON f.sk_status = s.sk_status
WHERE s.is_aprovada = 1
GROUP BY d.mes_ano_label
ORDER BY d.mes_ano_label;
GO

-- 
SELECT SUM(f.valor_brl), e.porte
FROM FACT_TRANSACAO f
left join DIM_EMPRESA e ON f.sk_empresa = e.sk_empresa
left join DIM_STATUS_TRANSACAO s ON f.sk_status = s.sk_status
WHERE status_transacao = 'Aprovada'
GROUP BY e.porte

SELECT SUM(f.valor_brl) as mmr, p.linha
FROM FACT_TRANSACAO f
LEFT JOIN DIM_PRODUTO p ON f.sk_produto = p.sk_produto
left join DIM_STATUS_TRANSACAO s ON f.sk_status = s.sk_status
WHERE status_transacao = 'Aprovada'
group by p.linha
go

WITH total_por_linha AS (
    SELECT 
        p.linha,
        SUM(f.valor_brl) AS mmr_linha
    FROM dbo.FACT_TRANSACAO f
    JOIN dbo.DIM_PRODUTO p ON f.sk_produto = p.sk_produto
    JOIN dbo.DIM_STATUS_TRANSACAO s ON f.sk_status = s.sk_status
    WHERE s.is_aprovada = 1
    GROUP BY p.linha
),
total_por_produto AS (
    SELECT 
        p.linha,
        SUM(f.valor_brl) AS mmr_produto
    FROM dbo.FACT_TRANSACAO f
    JOIN dbo.DIM_PRODUTO p ON f.sk_produto = p.sk_produto
    JOIN dbo.DIM_STATUS_TRANSACAO s ON f.sk_status = s.sk_status
    WHERE s.is_aprovada = 1
    GROUP BY p.linha
)
SELECT 
    tp.linha,
    tp.mmr_produto,
    tp.mmr_produto / (tpl.mmr_linha * 1.10) AS atingimento_pct
FROM total_por_produto tp
JOIN total_por_linha tpl ON tp.linha = tpl.linha;

SELECT mes_ref, mrr_total_brl, meta_mrr_brl, atingimento_pct
FROM dbo.vw_kpis_executivos
ORDER BY mes_ref DESC;

SELECT
    e.empresa_id,
    e.razao_social,
    e.porte,
    e.gestor_cs,
    e.mrr_brl                               AS mrr_contratado,
    -- Colaboradores ativos na dimensão
    COUNT(DISTINCT c.colaborador_id)        AS total_colaboradores,
    -- Colaboradores que realmente transacionaram
    COUNT(DISTINCT f.sk_colaborador)        AS colaboradores_que_gastaram,
    -- Valor real gasto pelas transações
    COALESCE(SUM(f.valor_brl), 0)          AS gmv_realizado,
    -- Colaboradores sem nenhuma transação aprovada
    COUNT(DISTINCT c.colaborador_id)
        - COUNT(DISTINCT f.sk_colaborador)  AS colaboradores_sem_gasto,
    -- % de colaboradores inativos
    CAST(
        100.0 * (
            COUNT(DISTINCT c.colaborador_id)
            - COUNT(DISTINCT f.sk_colaborador)
        )
        / NULLIF(COUNT(DISTINCT c.colaborador_id), 0)
    AS DECIMAL(5,1))                        AS pct_colaboradores_inativos,
    -- Índice de aproveitamento
    CAST(
        100.0 * COALESCE(SUM(f.valor_brl), 0)
        / NULLIF(e.mrr_brl, 0)
    AS DECIMAL(5,1))                        AS indice_aproveitamento_pct
FROM dbo.DIM_EMPRESA e
JOIN dbo.DIM_COLABORADOR c
    ON e.empresa_id = c.empresa_id
LEFT JOIN dbo.FACT_TRANSACAO f
    ON  f.sk_colaborador = c.sk_colaborador
LEFT JOIN dbo.DIM_STATUS_TRANSACAO s
    ON  f.sk_status = s.sk_status
    AND s.is_aprovada = 1
LEFT JOIN dbo.DIM_DATA d
    ON  f.sk_data = d.sk_data
    AND d.mes_ano_label = FORMAT(DATEADD(MONTH,-1,GETDATE()),'yyyy-MM')
WHERE e.status_cliente      = 'Ativo'
  AND c.status_colaborador  = 'Ativo'
GROUP BY
    e.empresa_id, e.razao_social,
    e.porte, e.gestor_cs, e.mrr_brl
ORDER BY indice_aproveitamento_pct ASC;