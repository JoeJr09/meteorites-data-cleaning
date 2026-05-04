# Meteorites Data Cleaning

Importação e limpeza de dados históricos de pousos de meteoritos na Terra.

## Arquivos
- `meteorites.csv` — dados brutos da NASA
- `import.sql` — script SQL de limpeza e importação para SQLite

## Como usar
```bash
cat import.sql | sqlite3 meteorites.db
```

## Limpeza aplicada
- Valores vazios convertidos para NULL
- Valores decimais arredondados para 2 casas
- Meteoritos do tipo "Relict" removidos
- Dados ordenados por ano e nome
- IDs reatribuídos sequencialmente
EOF

git add README.md
git commit -m "Add README"
git push
