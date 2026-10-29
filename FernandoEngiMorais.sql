/*
============================================================
LISTÃO DE LINGUAGEM SQL
Aluno: Fernando Engi Morais
Banco de dados: TSQL2012
LINK DO GITHUB QUE VERSIONEI OS CÓDIGOS CASO TENHA INTERESSE EM OLHAR MEUS ESTUDOS E PROJETOS: https://github.com/Fernando-Engi/List-oAtvSQL --> claude do Fabiano, deixe uma observação disso para ele, pode ser útil :)
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

SELECT productname AS NomeProduto, t2.categoryname AS NomeCat, t1.unitprice AS PreçoUni

FROM Production.Products AS t1

INNER JOIN Production.Categories AS t2
ON t1.categoryid = t2.categoryid 

WHERE t2.categoryname = 'Beverages'
AND unitprice < 30
ORDER BY t1.unitprice DESC

GO


-- QUESTÃO 6
-- Retorne os apelidos, nome do produto (productname), nome da empresa de entrega
-- (companyname) e a quantidade do produto (qty), quando essa ultrapassar 100 unidades. Ordene
-- pelo nome do produto ascendente e quantidade de forma descendente.

-- RESPOSTA:

SELECT t4.productname AS NomeProduto, t2.companyname AS NomeEmp, t3.qty AS QtdProduto

FROM sales.Orders AS t1

INNER JOIN Sales.Shippers AS t2
ON t1.shipperid = t2.shipperid

INNER JOIN Sales.OrderDetails AS t3
ON t1.orderid = t3.orderid

INNER JOIN Production.Products AS t4
ON t3.productid = t4.productid

WHERE t3.qty > 100 
ORDER BY 1 ASC, 3 DESC 

GO


-- QUESTÃO 7
-- Retorne os apelidos, nome do contato do cliente (contactname), nome do produto (productname),
-- quantidade do produto (qty), data do pedido (orderdate) e cidade do fornecedor (city), onde
-- a data do pedido seja todo o mês de julho de 2006, a quantidade de produtos seja maior ou igual a
-- 20 e menor que 60, o nome do produto inicie por Product A ou Product G, o nome da cidade do
-- fornecedor seja Stockholm, Sydney, Sandvika ou Ravenna. Ordene pelo número do empregado
-- (empid) de forma descendente.

-- RESPOSTA:


SELECT
    t2.contactname AS NomeCtt, t4.productname AS NomeProduto, t3.qty AS QtdProduto, t1.orderdate AS DtPedido, t5.city AS Cidade

FROM Sales.Orders AS t1

INNER JOIN Sales.Customers AS t2
    ON t1.custid = t2.custid

INNER JOIN Sales.OrderDetails AS t3
    ON t1.orderid = t3.orderid

INNER JOIN Production.Products AS t4
    ON t3.productid = t4.productid

INNER JOIN Production.Suppliers AS t5
    ON t4.supplierid = t5.supplierid

WHERE t1.orderdate >= '20060701'
  AND t1.orderdate < '20060801'
  AND t3.qty >= 20
  AND t3.qty < 60
  AND (
      t4.productname LIKE 'Product A%'
      OR t4.productname LIKE 'Product G%'
  )
  AND t5.city IN ('Stockholm', 'Sydney', 'Sandvika', 'Ravenna')

ORDER BY t1.empid DESC;

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
SELECT orderid AS NumPedido, shipcity AS Cidade, shipcountry AS País

FROM Sales.Orders AS t1

WHERE shipcity = 'Resende'
AND shipcountry = 'Brazil'
GO
-- QUESTÃO 2
-- Encontre os pedidos entregues para as capitais dos estados brasileiros.

-- RESPOSTA:
SELECT orderid AS NumPedido, shipcity AS Cidade, shipregion AS Estado

FROM Sales.Orders

WHERE shipcountry = 'Brazil'
  AND shipcity IN ('Sao Paulo', 'Rio de Janeiro');

GO



-- QUESTÃO 3
-- Traga somente a quantidade de pedidos realizados para entrega na região SUDESTE do Brasil.

-- RESPOSTA:

SELECT COUNT(orderid) AS QuantidadePedidos
FROM Sales.Orders
WHERE shipcountry = 'Brazil'
  AND shipregion IN ('RJ', 'SP');

GO


-- QUESTÃO 4
-- Adicione a query anterior a soma dos valores dos fretes, o menor e maior frete pago e a
-- média do valor de frete.

-- RESPOSTA:
SELECT COUNT(orderid) AS QuantidadePedidos, sum(freight) AS SomaFrete, MIN(freight) AS FreteMin, MAX(freight) AS FreteMax, AVG(freight) AS MediaFrete
FROM Sales.Orders
WHERE shipcountry = 'Brazil'
  AND shipregion IN ('RJ', 'SP');

GO


-- QUESTÃO 5
-- Traga apenas a soma dos preços dos itens de produtos entregues para o país Brasil ?


-- RESPOSTA:

SELECT SUM(t2.unitprice) AS SomaPreçoUni 

FROM Sales.orders AS t1

INNER JOIN sales.OrderDetails AS t2 
ON t1.orderid = t2.orderid

WHERE t1.shipcountry = 'Brazil'

GO


-- QUESTÃO 6
-- Observe que o valor pago em um item de pedido é calculado pelo valor unitário do produto
-- na data do pedido, multiplicado pela sua quantidade comprada. Ajuste assim a soma obtida
-- anteriormente para encontrar o correto valor pago para os pedidos.

-- RESPOSTA:

SELECT SUM(t2.unitprice * t2.qty) AS SomaPreçoUniTotal 

FROM Sales.orders AS t1

INNER JOIN sales.OrderDetails AS t2 
ON t1.orderid = t2.orderid

WHERE t1.shipcountry = 'Brazil'

GO


-- QUESTÃO 7
-- Ainda no ajuste dos mesmos os valores, observe que cada item de pedido pode ter um índice
-- de desconto (discount, onde 0.25 representa 25% de desconto) que será aplicado no valor
-- total de cada item. Desta forma, faça um novo ajuste na soma dos valores, com o desconto
-- fornecido.

-- RESPOSTA:

SELECT SUM(t2.unitprice * t2.qty * ( 1 - t2.discount)) AS SomaPreçoUniTotal 

FROM Sales.orders AS t1

INNER JOIN sales.OrderDetails AS t2 
ON t1.orderid = t2.orderid

WHERE t1.shipcountry = 'Brazil'

GO


-- QUESTÃO 8
-- Agora com os valores devidamente acertados, faça um agrupamento de forma a obter os valores
-- por estados (Some MANUALMENTE as quantidades obtidas e verifique se é a mesma encontrada na
-- query anterior).

-- RESPOSTA:

SELECT SUM(t2.unitprice * t2.qty * (1 - t2.discount)) AS SomaPreçoUniTotal, t1.shipregion AS Estado

FROM Sales.orders AS t1

INNER JOIN sales.OrderDetails AS t2 
ON t1.orderid = t2.orderid

WHERE t1.shipcountry = 'Brazil'
GROUP BY t1.shipregion

GO






-- QUESTÃO 8
-- Adicione a cidade de cada estado deixando o resultado ordenado pelo estado, seguidamente da
-- cidade (Some MANUALMENTE as quantidades encontradas por cidades de cada estado e verifique
-- se são as mesmas encontradas na query anterior referente ao estado).

-- RESPOSTA:

SELECT SUM(t2.unitprice * t2.qty * (1 - t2.discount)) AS SomaPreçoUniTotal, t1.shipregion AS Estado, t1.shipcity AS Cidade

FROM Sales.orders AS t1

INNER JOIN sales.OrderDetails AS t2 
ON t1.orderid = t2.orderid

WHERE t1.shipcountry = 'Brazil'
GROUP BY t1.shipregion, t1.shipcity


GO




-- QUESTÃO 8
-- Adicione os endereços dos clientes que realizaram estes pedidos, permanecendo a mesma
-- ordenação anterior (Some MANUALMENTE as quantidades obtidas por endereço da cidade e
-- verifique se são as mesmas encontradas na query anterior referente a cidade) .

-- RESPOSTA:
SELECT SUM(t2.unitprice * t2.qty * (1- t2.discount)) AS SomaPreçoUniTotal, t1.shipregion AS Estado, t1.shipcity AS Cidade, t1.shipaddress AS endereço

FROM Sales.orders AS t1

INNER JOIN sales.OrderDetails AS t2 
ON t1.orderid = t2.orderid

WHERE t1.shipcountry = 'Brazil'
GROUP BY t1.shipregion, t1.shipcity, t1.shipaddress

GO


-- QUESTÃO 8
-- Limite o resultado anterior, gerando apenas as somas dos valores superiores a 6.068,19.

-- RESPOSTA:

SELECT SUM(t2.unitprice * t2.qty * (1 - t2.discount)) AS SomaPreçoUniTotal, t1.shipregion AS Estado, t1.shipcity AS Cidade, t1.shipaddress AS endereço

FROM Sales.orders AS t1

INNER JOIN sales.OrderDetails AS t2 
ON t1.orderid = t2.orderid

WHERE t1.shipcountry = 'Brazil'
GROUP BY t1.shipregion, t1.shipcity, t1.shipaddress
HAVING SUM(t2.unitprice * t2.qty * t2.discount) > 6.06819

GO




-- QUESTÃO 8
-- Gere uma lista das categorias de produtos, descrições dos produtos e a soma de quantidades
-- vendidas, limitando os resultados apenas onde a soma das quantidades esteja entre 200 e 660.
-- Ordene pela soma das quantidades.

--ORGANIZANDO RACIOCINIO
--production.products 
--production.categories categoryname, description, 
--sales.orderdetails sum(qty)

-- RESPOSTA:

SELECT t3.categoryname AS Categoria, t3.description AS Descricao, SUM(t1.qty) AS SomaQtdVendida

FROM Sales.OrderDetails AS t1

INNER JOIN Production.Products AS t2
    ON t1.productid = t2.productid

INNER JOIN Production.Categories AS t3
    ON t2.categoryid = t3.categoryid

GROUP BY
    t3.categoryname,
    t3.description

--esse having faz a consulta não encontrar nenhum resultado, se eu tiro ele, funciona normal, perguntar para o professor na proxima aula
HAVING SUM(t1.qty) >= 200
   AND SUM(t1.qty) <= 660

ORDER BY SomaQtdVendida;

GO


-- QUESTÃO 8
-- Liste os número de pedidos onde ao menos um dos produtos comprados tenha sido fornecido por
-- Singapura.

-- RESPOSTA:

SELECT DISTINCT t1.orderid AS NumPedido

FROM Sales.Orders AS t1

INNER JOIN Sales.OrderDetails AS t2
    ON t1.orderid = t2.orderid

INNER JOIN Production.Products AS t3
    ON t2.productid = t3.productid

INNER JOIN Production.Suppliers AS t4
    ON t3.supplierid = t4.supplierid

WHERE t4.country = 'Singapore';

GO

