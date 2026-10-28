/*
============================================================
LISTÃO DE LINGUAGEM SQL
Aluno: Fernando Engi Morais
Banco de dados: TSQL2012
LINK DO GITHUB QUE VERSIONEI OS CÓDIGOS CASO TENHA INTERESSE EM OLHAR MEUS ESTUDOS E PROJETOS: https://github.com/Fernando-Engi/List-oAtvSQL
============================================================
*/


/*
============================================================
EXERCÍCIOS SOBRE JUNÇÃO
============================================================

Utilizando as tabelas de Pedidos (Sales.Orders),
Clientes (Sales.Customers), Empregados (HR.Employees) e
Empresa de Entrega (Sales.Shippers), desenvolver as seguintes
consultas:
*/


-- QUESTÃO 1
-- Retornar os apelidos número do pedido (orderid), data do pedido (orderdate), nome do contato
-- (contactname) e o país (country).

-- RESPOSTA:
SELECT t1.orderid AS NumPedido, t1.orderdate AS DataPedido, t2.contactname As NomeContato, t2.country AS País
FROM Sales.Orders AS t1

INNER JOIN Sales.Customers AS t2 ON
t1.custid = t2.custid

GO


-- QUESTÃO 2
-- Retornar os apelidos data do pedido (orderdate), nome do contato (contactname), nome completo
-- do empregado (firstname/lastname) e país do empregado (country), onde o país do empregado
-- seja Inglaterra.

-- RESPOSTA:
SELECT t1.orderdate AS dataPedido, t2.contactname AS NomeContato, t3.firstname AS Nome, t3.lastname AS Sobrenome,t2.country AS Pais

FROM sales.Orders AS t1

INNER JOIN Sales.Customers AS T2 
ON t1.custid = t2.custid

INNER JOIN HR.Employees AS t3
ON t1.empid = t3.empid

WHERE t2.country = 'UK'

GO


-- QUESTÃO 3
-- Retornar os apelidos número do pedido (orderid), data do pedido (orderdate), nome do contato do
-- cliente (contactname), nome completo do empregado (firstname/lastname) e país do cliente
-- (country), onde o país do cliente seja Brasil, ordernado pela data do pedido mais recente.

-- RESPOSTA:
SELECT t1.orderid AS NumPedido, t1.orderdate AS DataPedido, t2.contactname AS Contato, t3.firstname AS Nome, t3.lastname AS Sobrenome, t2.country AS País

FROM sales.orders AS t1

INNER JOIN Sales.Customers AS t2 
ON t1.custid = t2.custid

INNER JOIN HR.Employees AS t3
ON t1.empid = t3.empid

WHERE t2.country = 'Brazil'

ORDER BY DataPedido DESC

GO


-- QUESTÃO 4
-- Retornar os apelidos número do pedido (orderid), data do pedido (orderdate), nome do contato
-- (contactname), nome completo do empregado (firstname/lastname), país do empregado (country)
-- e nome da empresa de entrega, onde o país do empregado seja Estados Unidos e a empresa de
-- entrega seja Shipper ETYNR ou Shipper GVSUA. Ordene pelo número do pedido.

-- RESPOSTA:
SELECT t1.orderid AS NumPedido, t1.orderdate AS DtPedido, t3.firstname AS nome, t3.lastname AS Sobrenome, t3.country, t4.companyname AS NomeEmp

FROM sales.orders AS t1

INNER JOIN Sales.Customers AS t2 
ON t1.custid = t2.custid 

INNER JOIN HR.Employees AS t3
ON t1.empid = t3.empid

INNER JOIN sales.Shippers AS t4
ON t1.shipperid = t4.shipperid

WHERE t3.country = 'USA'
AND (t4.companyname = 'Shipper ETYNR' OR t4.companyname = 'Shipper GVSUA')

ORDER BY NumPedido

GO


/*
------------------------------------------------------------
Adicionando as tabelas Detalhes de Pedidos (Sales.OrderDetails),
Produtos (Production.Products), Fornecedores (Production.Suppliers)
e Categorias (Production.Categories), desenvolver as seguintes
consultas:
------------------------------------------------------------
*/


-- QUESTÃO 5
-- Retorne todas informações de nome do produto e o nome da categoria, onde esta seja Beverages e
-- o preço do produto (unitprice) seja menor que 30, ordenado pelo preço de forma descendente.

-- RESPOSTA:

GO


-- QUESTÃO 5
-- Retorne os apelidos, nome do produto (productname), nome da empresa de entrega
-- (companyname) e a quantidade do produto (qty), quando essa ultrapassar 100 unidades. Ordene
-- pelo nome do produto ascendente e quantidade de forma descendente.

-- RESPOSTA:


GO


-- QUESTÃO 5
-- Retorne os apelidos, nome do contato do cliente (contactname), nome do produto (productname),
-- quantidade do produto (qty), data do pedido (orderdate) e cidade do fornecedor (city), onde
-- a data do pedido seja todo o mês de julho de 2006, a quantidade de produtos seja maior ou igual a
-- 20 e menor que 60, o nome do produto inicie por Product A ou Product G, o nome da cidade do
-- fornecedor seja Stockholm, Sydney, Sandvika ou Ravenna. Ordene pelo número do empregado
-- (empid) de forma descendente.

-- RESPOSTA:


GO


/*
============================================================
EXERCÍCIOS SOBRE AGREGAÇÃO
============================================================

Baseado no modelo, desenvolva as seguintes queries, colocando
nomes apropriados (SIGNIFICATIVOS) para todas as colunas
(se uma questão for baseada na anterior, copie a query que foi
feita e faça alterações sobre ela, mantendo uma consulta por
questão).
*/


-- QUESTÃO 1
-- Liste os pedidos entregues para a cidade de Resende, Brasil.

-- RESPOSTA:


GO


-- QUESTÃO 2
-- Encontre os pedidos entregues para as capitais dos estados brasileiros.

-- RESPOSTA:


GO


-- QUESTÃO 3
-- Traga somente a quantidade de pedidos realizados para entrega na região SUDESTE do Brasil.

-- RESPOSTA:


GO


-- QUESTÃO 4
-- Adicione a query anterior a soma dos valores dos fretes, o menor e maior frete pago e a
-- média do valor de frete.

-- RESPOSTA:


GO


-- QUESTÃO 5
-- Traga apenas a soma dos preços dos itens de produtos entregues para o país Brasil ?

-- RESPOSTA:


GO


-- QUESTÃO 6
-- Observe que o valor pago em um item de pedido é calculado pelo valor unitário do produto
-- na data do pedido, multiplicado pela sua quantidade comprada. Ajuste assim a soma obtida
-- anteriormente para encontrar o correto valor pago para os pedidos.

-- RESPOSTA:


GO


-- QUESTÃO 7
-- Ainda no ajuste dos mesmos os valores, observe que cada item de pedido pode ter um índice
-- de desconto (discount, onde 0.25 representa 25% de desconto) que será aplicado no valor
-- total de cada item. Desta forma, faça um novo ajuste na soma dos valores, com o desconto
-- fornecido.

-- RESPOSTA:


GO


-- QUESTÃO 8
-- Agora com os valores devidamente acertados, faça um agrupamento de forma a obter os valores
-- por estados (Some MANUALMENTE as quantidades obtidas e verifique se é a mesma encontrada na
-- query anterior).

-- RESPOSTA:


GO


-- QUESTÃO 8
-- Adicione a cidade de cada estado deixando o resultado ordenado pelo estado, seguidamente da
-- cidade (Some MANUALMENTE as quantidades encontradas por cidades de cada estado e verifique
-- se são as mesmas encontradas na query anterior referente ao estado).

-- RESPOSTA:


GO


-- QUESTÃO 8
-- Adicione os endereços dos clientes que realizaram estes pedidos, permanecendo a mesma
-- ordenação anterior (Some MANUALMENTE as quantidades obtidas por endereço da cidade e
-- verifique se são as mesmas encontradas na query anterior referente a cidade) .

-- RESPOSTA:


GO


-- QUESTÃO 8
-- Limite o resultado anterior, gerando apenas as somas dos valores superiores a 6.068,19.

-- RESPOSTA:


GO


-- QUESTÃO 8
-- Gere uma lista das das categorias de produtos, descrições dos produtos e a soma de quantidades
-- vendidas, limitando os resultados apenas onde a soma das quantidades esteja entre 200 e 660.
-- Ordene pela soma das quantidades.

-- RESPOSTA:


GO


-- QUESTÃO 8
-- Liste os número de pedidos onde ao menos um dos produtos comprados tenha sido fornecido por
-- Singapura.

-- RESPOSTA:


GO