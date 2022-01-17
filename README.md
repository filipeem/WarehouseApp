# Warehouse-APP

Aplicativo de gerenciamento de galpões, elaborado no programa QueroSerDev 7.

* Ruby 3.0.0

* Rails 6.1.4.1

* Node 16.13.1

## API

### Galpões

#### Listar todos galpões
Requisição:
`GET /api/v1/warehouses`

Resposta:
Status: 200 (OK)
`
[
  {
    "id": 1,
    "name": "Maceió",
    "code": "MCZ",
    "description": "Ótimo galpão numa linda cidade",
    "city": "Maceió",
    "state": "AL",
    "postal_code": "57050-000",
    "total_area": 10000,
    "useful_area": 8000
  }
  {
    "id": 2,
    "name": "Porto Alegre",
    "code": "POA",
    "description": "Galpão mais ao Sul do Brasil",
    "city": "Porto Alegre",
    "state": "RS",
    "postal_code": "90050-000",
    "total_area": 8000,
    "useful_area": 7000
  }
]
`
#### Ver detalhes de um galpão
Requisição:
`GET /api/v1/warehouses/id`

Resposta:
Status: 200 (OK)
`
  {
    "id": 1,
    "name": "Maceió",
    "code": "MCZ",
    "description": "Ótimo galpão numa linda cidade",
    "city": "Maceió",
    "state": "AL",
    "postal_code": "57050-000",
    "total_area": 10000,
    "useful_area": 8000
  }
`
#### Criar um galpão
Requisição:
`POST /api/v1/warehouses`
Parâmetros:
`
{
    "name": "Maceió",
    "code": "MCZ",
    "description": "Ótimo galpão numa linda cidade",
    "address": "Avenida dos Galpões, 1000",
    "city": "Maceió",
    "state": "AL",
    "postal_code": "57050-000",
    "total_area": 10000,
    "useful_area": 8000
}
`

Resposta:
Status: 201 (Criado)
`
{
  "id": 10,
  "name": "Maceió",
  "code": "MCZ",
  "description": "Ótimo galpão numa linda cidade",
  "city": "Maceió",
  "state": "AL",
  "postal_code": "57050-000",
  "total_area": 10000,
  "useful_area": 8000
}
`
* Em caso de erro de validação:
Resposta:
Status: 422
`{[mesagens de erro de validação]}`

### Fornecedores

#### Listar todos fornecedores
Requisição:
`GET /api/v1/suppliers`

Resposta:
Status: 200 (OK)
`
[
  {
    "id": 1,
    "name": "Cerâmicas Geek",
    "corporate_name": "Geek Comercio de Ceramicas LTDA",
    "cnpj": "00.000.000/0002-00",
    "email": "contato@geek.com",
    "address": "Rua das Cerâmicas",
    "city": "São Paulo",
    "state": "SP",
    "phone": "(11)55555.5555"
  }
  {
    "id": 2,
    "name": "Fábrica de Camisas",
    "corporate_name": "Fabrica de Camisas do Paraná S.A.",
    "cnpj": "08.000.000/0001-50",
    "email": "financeiro@camisas.com",
    "address": "Rua das Industrias",
    "city": "Curitiba",
    "state": "PR",
    "phone": "(41)41414.4141"
  }
]
`
#### Ver detalhes de um fornecedor
Requisição:
`GET /api/v1/suppliers/id`
Resposta:
Status: 200 (OK)
`
{
    "id": 1,
    "name": "Cerâmicas Geek",
    "corporate_name": "Geek Comercio de Ceramicas LTDA",
    "cnpj": "00.000.000/0002-00",
    "email": "contato@geek.com",
    "address": "Rua das Cerâmicas",
    "city": "São Paulo",
    "state": "SP",
    "phone": "(11)55555.5555"
  }
`
#### Criar um fornecedor
Requisição:
`POST /api/v1/suppliers`

Parâmetros:
`
{
    "name": "Cerâmicas Geek",
    "corporate_name": "Geek Comercio de Ceramicas LTDA",
    "cnpj": "00.000.000/0002-00",
    "email": "contato@geek.com",
    "address": "Rua das Cerâmicas",
    "city": "São Paulo",
    "state": "SP",
    "phone": "(11)55555.5555"
  }
`

Resposta:
Status: 201 (Criado)
`
{
  "id": 1,
 "name": "Cerâmicas Geek",
    "corporate_name": "Geek Comercio de Ceramicas LTDA",
    "cnpj": "00.000.000/0002-00",
    "email": "contato@geek.com",
    "address": "Rua das Cerâmicas",
    "city": "São Paulo",
    "state": "SP",
    "phone": "(11)55555.5555"
}
`
* Em caso de erro de validação:
Resposta:
Status: 422
`{[mesagens de erro de validação]}`

### Modelo de Produtos

#### Listar todos Modelos de Produtos
Requisição:
`GET /api/v1/product_models`
Resposta:
Status: 200 (OK)
`
[
  {
    "id": 1,
    "name": "Caneca Star Wars",
    "height: "8",
    "width": "5",
    "length": "5",
    "weight": "200",
    "supplier_id": 1,
    "category_id": 1
  }
  {
    "id": 2,
    "name": "Caneca Vingadores",
    "height: "10",
    "width": "6",
    "length": "6",
    "weight": "210",
    "supplier_id": 1,
    "category_id": 1
  }
]
`
### Ver detalhes de um Modelo de Produto
Requisição:
`GET /api/v1/product_models/id`
Resposta:
Status: 200 (OK)
`
{
    "id": 1,
    "name": "Caneca Star Wars",
    "height: "8",
    "width": "5",
    "length": "5",
    "weight": "200",
    "supplier_id": 1,
    "category_id": 1
  }
`
#### Criar um Modelo de Produto
Requisição:
`POST /api/v1/product_models`

Parâmetros:
`
{
    "name": "Caneca Star Wars",
    "height: "8",
    "width": "5",
    "length": "5",
    "weight": "200",
    "supplier_id": 1,
    "category_id": 1
  }
`

Resposta:
Status: 201 (Criado)
`
{
    "id": 1,
    "name": "Caneca Star Wars",
    "height: "8",
    "width": "5",
    "length": "5",
    "weight": "200",
    "supplier_id": 1,
    "category_id": 1
  }
`
* Em caso de erro de validação:
Resposta:
Status: 422
`{[mesagens de erro de validação]}`