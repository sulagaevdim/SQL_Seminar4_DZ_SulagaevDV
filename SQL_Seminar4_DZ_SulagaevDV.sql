/*1.Ранжируйте продукты (по ProductRank) в каждой
категории на основе их общего объема продаж
(TotalSales).*/
SELECT DISTINCT 
p.ProductName,
SUM(Quantity) over (PARTITION by p.ProductName) As TotalSales,
Rank() Over (Order by p.ProductName) as ProductRank
FROM Products p 
Join OrderDetails od ON p.ProductID = od.ProductID 

/*2. Обратимся к таблице Clusters
Рассчитайте среднюю сумму кредита (AvgCreditAmount) для
каждого кластера и месяца, учитывая общую среднюю сумму
кредита за соответствующий месяц (OverallAvgCreditAmount).
*/
with AvgCreditAmount as (SELECT
month,
cluster,
AVG(credit_amount) AS AvgCreditAmount
FROM Clusters
GROUP BY month, cluster)
SELECT *,
AVG(a.AvgCreditAmount) OVER (PARTITION by cluster) as AvgCreditAmount
FROM AvgCreditAmount a


/*3.Сопоставьте совокупную сумму сумм кредита
(CumulativeSum) для каждого кластера, упорядоченную по
месяцам, и сумму кредита в порядке возрастания.
*/
with CumulativeSum as (SELECT month,
cluster,
SUM(credit_amount) OVER (Partition by cluster) as cum
FROm Clusters c)
SELECT month,
cluster,
sum(cum) OVER (partition by cluster) cumulative
FROM CumulativeSum




