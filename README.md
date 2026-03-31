# Analise de Receita de Indicadores - Cartão Benefícios


## Visão Geral
Este projeto nasceu na necessidade de corrigir e estruturar indicadores de receita recorrente (MRR,ARR,Churn,Atingimento) que estava inconsistentes e dificultavam a tomada de descisão.
O mercado costuma trabalhar com dados inflados ou acumulados, o que gera decisões equivocadas sobre metas, investimentos e expansão.
O objetivo central foi criar um *Dashboard Executivo Confiável*, capaz de responder ás principais perguntas de negócio: 
 - Qual é a receita recorrente mensal atual?
 - Estamos atingindo nossas metas de crescimento?
 - Quais segmentos e produtos sustentam nossa receita?
 - Estamos retendo clientes de forma eficiente?
 - Onde devemos concentrar esforços para escalar?
  
## Objetivos do Projeto
- Calcular corretamente MRR e ARR.
- Validar métricas de atingimento de metas e churn.
- Construir visualizações estratégicas em Power BI.
- Gerar insights diferenciados para apoiar decisões executivas.
  
##  Estrutura do Repositório
- `/sql` → scripts SQL.
- `/data_raw` → dados brutos.
- `/docs` → documentação complementar:
  - `modelagem_dimensional.pdf` → Relacionamneto de Tabelas.
  - `dicionario_dados.md` → dicionário de dados.
  - `arquitetura_projeto.md` → arquitetura do pipeline.
  - `business_insights.md` → insights estratégicos.
- `/dashboard` → arquivos do Power BI ou exportações.

## Modelagem dos dados em StarSchema
A Modelagem completa está disponível em (https://miro.com/app/board/uXjVGpQlsa4=/?share_link_id=957359051559)

##  Dicionário de Dados
O dicionário completo está disponível em [`docs/dicionario_dados.md`](docs/dicionario_dados.md).

##  Dashboard
Principais visualizações:
- MRR Total vs Meta
- ARR Total
- Taxa de Churn
- Distribuição por porte de cliente
- Distribuição por linha de produto
- LTV/CAC por segmento

##  Insights Estratégicos
- Atingimento de metas abaixo de 40% | Estratégia: necessidade de reforço em aquisição e upsell.
- SMB domina receita (43%) | Estratégia: foco em fidelização e descisão executiva ( saiba mais no link de insights abaixo)
- Produtos equilibrados | Estratégia: falta de um “produto hero” para puxar crescimento.
- Churn zerado | Estratégia: boas práticas de retenção devem ser replicadas.
- Linha de produtos equilibradas | Estratégia: criar ou definir um produto "carro-chefe".
Insights com mais detalhes dísponivel em [`docs/insights_negocio.md`](docs/insights_negocio.md)
