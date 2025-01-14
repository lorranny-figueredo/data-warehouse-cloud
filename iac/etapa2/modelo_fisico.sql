CREATE SCHEMA IF NOT EXISTS iacschema;

CREATE TABLE IF NOT EXISTS iacschema.dim_cliente 
(
    sk_cliente integer NOT NULL,
    id_cliente integer NOT NULL,
    nome character varying(50) NOT NULL,
    tipo character varying(50),
    CONSTRAINT dim_cliente_pkey PRIMARY KEY (sk_cliente)
);

CREATE TABLE IF NOT EXISTS iacschema.dim_localidade
(
    sk_localidade integer NOT NULL,
    id_localidade integer NOT NULL,
    pais character varying(50) NOT NULL,
    regiao character varying(50) NOT NULL,
    estado character varying(50) NOT NULL,
    cidade character varying(50) NOT NULL,
    CONSTRAINT dim_localidade_pkey PRIMARY KEY (sk_localidade)
);

CREATE TABLE IF NOT EXISTS iacschema.dim_produto
(
    sk_produto integer NOT NULL,
    id_produto integer NOT NULL,
    nome_produto character varying(50) NOT NULL,
    categoria character varying(50) NOT NULL,
    subcategoria character varying(50) NOT NULL,
    CONSTRAINT dim_produto_pkey PRIMARY KEY (sk_produto)
);

CREATE TABLE IF NOT EXISTS iacschema.dim_tempo
(
    sk_tempo integer NOT NULL,
    data_completa date,
    ano integer NOT NULL,
    mes integer NOT NULL,
    dia integer NOT NULL,
    CONSTRAINT dim_tempo_pkey PRIMARY KEY (sk_tempo)
);

CREATE TABLE IF NOT EXISTS iacschema.fato_vendas
(
    sk_produto integer NOT NULL,
    sk_cliente integer NOT NULL,
    sk_localidade integer NOT NULL,
    sk_tempo integer NOT NULL,
    quantidade integer NOT NULL,
    preco_venda numeric(10,2) NOT NULL,
    custo_produto numeric(10,2) NOT NULL,
    receita_vendas numeric(10,2) NOT NULL,
    CONSTRAINT fato_vendas_pkey PRIMARY KEY (sk_produto, sk_cliente, sk_localidade, sk_tempo),
    CONSTRAINT fato_vendas_sk_cliente_fkey FOREIGN KEY (sk_cliente) REFERENCES iacschema.dim_cliente (sk_cliente),
    CONSTRAINT fato_vendas_sk_localidade_fkey FOREIGN KEY (sk_localidade) REFERENCES iacschema.dim_localidade (sk_localidade),
    CONSTRAINT fato_vendas_sk_produto_fkey FOREIGN KEY (sk_produto) REFERENCES iacschema.dim_produto (sk_produto),
    CONSTRAINT fato_vendas_sk_tempo_fkey FOREIGN KEY (sk_tempo) REFERENCES iacschema.dim_tempo (sk_tempo)
);

COPY iacschema.dim_cliente
FROM 's3://iac-fonte-p2-<ID-AWS>/dados/dim_cliente.csv'
IAM_ROLE 'arn:aws:iam::<ID-AWS>:role/RedshiftS3AccessRole'
CSV;

COPY iacschema.dim_localidade
FROM 's3://iac-fonte-p2-<ID-AWS>/dados/dim_localidade.csv'
IAM_ROLE 'arn:aws:iam::<ID-AWS>:role/RedshiftS3AccessRole'
CSV;

COPY iacschema.dim_produto
FROM 's3://iac-fonte-p2-<ID-AWS>/dados/dim_produto.csv'
IAM_ROLE 'arn:aws:iam::<ID-AWS>:role/RedshiftS3AccessRole'
CSV;

COPY iacschema.dim_tempo
FROM 's3://iac-fonte-p2-<ID-AWS>/dados/dim_tempo.csv'
IAM_ROLE 'arn:aws:iam::<ID-AWS>:role/RedshiftS3AccessRole'
CSV;

COPY iacschema.fato_vendas
FROM 's3://iac-fonte-p2-<ID-AWS>/dados/fato_vendas.csv'
IAM_ROLE 'arn:aws:iam::<ID-AWS>:role/RedshiftS3AccessRole'
CSV;
