# Avaliação de Risco Relativo de Clientes Bancários

> Automatização da análise de solicitações de crédito do banco "Super Caja" utilizando análise de dados, cálculo de risco relativo e score de crédito para classificar clientes conforme a probabilidade de inadimplência. O objetivo é aumentar a eficiência, precisão e rapidez na avaliação, integrando métricas de atraso nos pagamentos para apoiar decisões e reduzir riscos financeiros.

## Funcionalidades Principais

- Processamento e preparação de bases de dados bancários
- Análise exploratória de dados (EDA) com visualizações e estatísticas
- Otimização e padronização de queries SQL para BigQuery
- Cálculo de risco relativo e criação de score de crédito
- Geração de relatórios e dashboards no Looker Studio
- Pipeline automatizado em Python (Jupyter Notebook)

## Resultados e Conclusões

O projeto resultou em um pipeline robusto para análise de crédito, com queries SQL otimizadas, score de risco relativo e visualizações claras para tomada de decisão. A automação proporcionou maior agilidade e precisão na avaliação de clientes, reduzindo riscos e facilitando a manutenção futura do código.

## Tecnologias Utilizadas

- Google BigQuery (SQL)
- Looker Studio
- Python (Jupyter Notebook, pandas, scikit-learn, matplotlib, seaborn)

## Como Executar

1. Clone o repositório:

```
git clone https://github.com/vitoriapguimaraes/Python_SQL-RegressaoLogistica_DadosBancarios.git
```

2. Instale as dependências Python:

```
pip install -r requirements.txt
```

(ou instale manualmente: pandas, scikit-learn, matplotlib, seaborn) 3. Execute o notebook principal:

```
jupyter notebook scripts/main.ipynb
```

4. Para executar as queries SQL, utilize o ambiente do Google BigQuery.

## Como Usar

- As queries SQL otimizadas estão em `scripts/optimized_consults_sql/`.
- Execute o notebook para processar, analisar e modelar os dados.
- Visualize os resultados e gráficos gerados em `results/`.

## Estrutura de Diretórios

```
Python_SQL-RegressaoLogistica_DadosBancarios/
├── dataset/                     # Dados brutos e processados
├── results/                     # Resultados, gráficos e relatórios
├── scripts/
│   ├── main.ipynb               # Notebook principal do projeto
│   ├── consults_sql/            # Queries SQL originais
│   └── optimized_consults_sql/  # Queries SQL otimizadas
└── README.md
```

## Status

- ✅ Concluído

> Veja as [issues abertas](https://github.com/vitoriapguimaraes/Python_SQL-RegressaoLogistica_DadosBancarios/issues) para sugestões de melhorias e próximos passos.

## Mais Sobre Mim

Acesse os arquivos disponíveis na [Pasta Documentos](https://github.com/vitoriapguimaraes/vitoriapguimaraes/tree/main/DOCUMENTOS) para mais informações sobre minhas qualificações e certificações.
