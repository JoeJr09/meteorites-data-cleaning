-- import.sql

-- 1. Criar tabela temporária com todas as colunas do CSV
CREATE TABLE "meteorites_temp" (
    "name" TEXT,
    "id" INTEGER,
    "nametype" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" REAL,
    "long" REAL
);

-- 2. Importar o CSV
.import --csv --skip 1 meteorites.csv meteorites_temp

-- 3. Converter valores vazios para NULL
UPDATE "meteorites_temp" SET "mass" = NULL WHERE "mass" = '';
UPDATE "meteorites_temp" SET "year" = NULL WHERE "year" = '';
UPDATE "meteorites_temp" SET "lat" = NULL WHERE "lat" = '';
UPDATE "meteorites_temp" SET "long" = NULL WHERE "long" = '';

-- 4. Arredondar valores decimais para 2 casas
UPDATE "meteorites_temp" SET "mass" = ROUND("mass", 2);
UPDATE "meteorites_temp" SET "lat" = ROUND("lat", 2);
UPDATE "meteorites_temp" SET "long" = ROUND("long", 2);

-- 5. Remover meteoritos do tipo "Relict"
DELETE FROM "meteorites_temp" WHERE "nametype" = 'Relict';

-- 6. Criar tabela final
CREATE TABLE "meteorites" (
    "id" INTEGER,
    "name" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" REAL,
    "long" REAL,
    PRIMARY KEY("id")
);

-- 7. Inserir dados limpos ordenados, IDs serão gerados automaticamente
INSERT INTO "meteorites" ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long"
FROM "meteorites_temp"
ORDER BY "year", "name";

-- 8. Remover tabela temporária
DROP TABLE "meteorites_temp";
