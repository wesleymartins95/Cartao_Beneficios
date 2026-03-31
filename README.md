# Analise de Receita de Indicadores - Cartão Benefícios


## Visão Geral
Este projeto nasceu na necessidade de corrigir e estruturar indicadores de receita recorrente (MRR,ARR,Churn,Atingimento) que estava inconsistentes e dificultavam a tomada de descisão.
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
- `/src` → scripts SQL e DAX usados para cálculos.
- `/data` → dados brutos e tratados (quando aplicável).
- `/notebooks` → análises exploratórias.
- `/docs` → documentação complementar:
  - `data_dictionary.md` → dicionário de dados.
  - `architecture.md` → arquitetura do pipeline.
  - `business_insights.md` → insights estratégicos.
- `/dashboard` → arquivos do Power BI ou exportações.

## Modelagem dos dados em StarSchema
A Modelagem completa está disponível em [`https://miro.com/app/board/uXjVGpQlsa4=/?share_link_id=957359051559`]

##  Dicionário de Dados
O dicionário completo está disponível em [`docs/dicionario_dados.md`](docs/dicionario_dados.md).

##  Dashboard
Principais visualizações:
- MRR Total vs Meta
- ARR Total
- Distribuição por porte de cliente
- Distribuição por linha de produto
- LTV/CAC por segmento

##  Insights Estratégicos
- Atingimento de metas abaixo de 40% → necessidade de reforço em aquisição.
- SMB domina receita (43%) → foco em fidelização e upsell.
- Produtos equilibrados → falta de um “produto hero” para puxar crescimento.
- Churn zerado → boas práticas de retenção devem ser replicadas.
