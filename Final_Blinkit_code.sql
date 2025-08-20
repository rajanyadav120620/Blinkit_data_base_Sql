
SELECT * FROM Blinkit2
/* To Count the total number of column  */
SELECT COUNT(*) FROM Blinkit2
/* Data clean */
UPDATE Blinkit2
SET Item_Fat_Content =
CASE 
WHEN Item_Fat_Content IN ('LF','low fat') THEN 'Low Fat'
WHEN Item_Fat_Content ='reg' THEN 'Regular'
ELSE Item_Fat_Content
END
/* To check value updata or not*/
/*Method 1*/
SELECT * FROM Blinkit2
/*Method 2*/
SELECT DISTINCT(Item_Fat_Content) FROM Blinkit2
/* Find the total sale*/
SELECT SUM(Sales) AS Total_Sales FROM Blinkit2
/*To remove the decimal value*/
SELECT CAST(SUM(Sales)/ 1000000 As DECIMAL(10,2)) AS Total_Sales_Millions FROM Blinkit2

/* To find the averge value*/
SELECT AVG(Sales) AS Avg_Sales FROM Blinkit2
/* To find the averge value in decimal , 
1.Note we did not divide any number because it easy or simple number.
2.  if i want to show number after decimal then used 2,3,4 ac to our need */
SELECT CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales FROM Blinkit2
/* To count the number of item */
SELECT COUNT(*) AS No_Of_Item FROM Blinkit2

/*Used conditionwhere*/
SELECT CAST(SUM(Sales)/ 1000000 As DECIMAL(10,2)) AS Total_Sales_Millions FROM Blinkit2
/*WHERE Item_Fat_Content = 'low Fat' or */
WHERE Outlet_Establishment_Year = 2022;
/* To count the number of item and where condition */
SELECT COUNT(*) AS No_Of_Item FROM Blinkit2
WHERE  Outlet_Establishment_Year = 2022;

/* Average Rating*/
SELECT AVG(Rating) AS Avg_Rating FROM Blinkit2
SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating FROM Blinkit2
WHERE  Outlet_Establishment_Year = 2022;

/*Second Pagge*/
/*Note: when uesd any aggrigation like(sum,avg,min,max etc) and any column and used group by*/
SELECT Item_Fat_Content,SUM(Sales) AS Total_Sales
FROM Blinkit2
GROUP BY Item_Fat_Content
/* order by desc*/
SELECT Item_Fat_Content,SUM(Sales) AS Total_Sales
FROM Blinkit2
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC

/* REMOVE NUMBER DECIMAL*/
SELECT Item_Fat_Content,CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM Blinkit2
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC
/*Do Every thing Togethere*/
SELECT Item_Fat_Content,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
       COUNT(*) AS No_Of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM Blinkit2
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC
/* To represent every thing together used where condition*/
SELECT Item_Fat_Content,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
       COUNT(*) AS No_Of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM Blinkit2
WHERE Outlet_Establishment_Year =2020
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC

/* To represent every thing together used DIVIDE BY 1000*/
SELECT Item_Fat_Content,
       CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousand,
       CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
       COUNT(*) AS No_Of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM Blinkit2
WHERE Outlet_Establishment_Year =2020
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_Thousand DESC
/* To find Item type*/
SELECT Item_Type,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
       COUNT(*) AS No_Of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM Blinkit2
WHERE Outlet_Establishment_Year =2020
GROUP BY Item_Type
ORDER BY Total_Sales DESC

/* find in top 5 item*/
SELECT Top 5 Item_Type,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
       COUNT(*) AS No_Of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM Blinkit2
WHERE Outlet_Establishment_Year =2020
GROUP BY Item_Type
ORDER BY Total_Sales DESC


/*Fat Content by Outlet for Total Sales*/
SELECT Top 5 Outlet_Location_Type,Item_Fat_Content,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
       COUNT(*) AS No_Of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM Blinkit2
GROUP BY Outlet_Location_Type,Item_Fat_Content
ORDER BY Total_Sales DESC

/*1  */
SELECT Outlet_Location_Type,Item_Fat_Content,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
from Blinkit2
GROUP BY Outlet_Location_Type,Item_Fat_Content
ORDER BY Total_Sales ASC

/*2*/
select Outlet_Location_Type,
       ISNULL([Low Fat], 0) AS Low_Fat,
       ISNULL([Regular],0) AS Regular

FROM
(
select Outlet_Location_Type,Item_Fat_Content,
       CAST(SUM(Sales) As DECIMAL(10,2)) As Total_Sales
       FROM Blinkit2
       GROUP BY Outlet_Location_Type,Item_Fat_Content
)AS SourceTable
PIVOT
(
SUM(Total_Sales)
FOR Item_Fat_Content IN ([Low Fat],[Regular])
)
AS PivotTable
ORDER BY Outlet_Location_Type;

/*3 Start here now*/
--Total Salesas Outlet Estalement
--1
select Outlet_Establishment_Year,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
from Blinkit2
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC
--2
select Outlet_Establishment_Year,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
         CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
         Count(*) As no_of_Items,
        CAST( Avg(Rating) AS DECIMAL(10,2)) AS Avg_Rating
from Blinkit2
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC
--3
select Outlet_Establishment_Year,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
         CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
         Count(*) As no_of_Items,
        CAST( Avg(Rating) AS DECIMAL(10,2)) AS Avg_Rating
from Blinkit2
GROUP BY Outlet_Establishment_Year
ORDER BY Total_Sales DESC
-- Find the percentage
--1

select Outlet_Size,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST((SUM(Sales) * 100.0 /SUM(SUM(Sales)) OVER()) AS DECIMAL (10,2)) AS Sales_Percentage
       --  CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
        -- Count(*) As no_of_Items,
       -- CAST( Avg(Rating) AS DECIMAL(10,2)) AS Avg_Rating
from Blinkit2
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC
--2 Seles of OUTlet locations

select Outlet_Location_Type,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
         CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
         Count(*) As no_of_Items,
        CAST( Avg(Rating) AS DECIMAL(10,2)) AS Avg_Rating
from Blinkit2
GROUP BY  Outlet_Location_Type
ORDER BY Total_Sales DESC
--3 Seles of OUTlet locations percentage
select Outlet_Location_Type,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
         CAST((SUM(Sales) * 100.0 /SUM(SUM(Sales)) OVER()) AS DECIMAL (10,2)) AS Sales_Percentage,
         CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
         Count(*) As no_of_Items,
        CAST( Avg(Rating) AS DECIMAL(10,2)) AS Avg_Rating
from Blinkit2
GROUP BY  Outlet_Location_Type
ORDER BY Total_Sales DESC


--4A Seles of OUTlet locations percentage with filter
select Outlet_Location_Type,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
         CAST((SUM(Sales) * 100.0 /SUM(SUM(Sales)) OVER()) AS DECIMAL (10,2)) AS Sales_Percentage,
         CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
         Count(*) As no_of_Items,
        CAST( Avg(Rating) AS DECIMAL(10,2)) AS Avg_Rating
from Blinkit2
where Outlet_Establishment_Year =2022
GROUP BY  Outlet_Location_Type
ORDER BY Total_Sales DESC
--4B Seles of OUTlet locations percentage with filter
select Outlet_Location_Type,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
         CAST((SUM(Sales) * 100.0 /SUM(SUM(Sales)) OVER()) AS DECIMAL (10,2)) AS Sales_Percentage,
         CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
         Count(*) As no_of_Items,
        CAST( Avg(Rating) AS DECIMAL(10,2)) AS Avg_Rating
from Blinkit2
where Outlet_Establishment_Year =2020
GROUP BY  Outlet_Location_Type
ORDER BY Total_Sales DESC
-- Find the all matric
select Outlet_Type,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
         CAST((SUM(Sales) * 100.0 /SUM(SUM(Sales)) OVER()) AS DECIMAL (10,2)) AS Sales_Percentage,
         CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
         Count(*) As no_of_Items,
        CAST( Avg(Rating) AS DECIMAL(10,2)) AS Avg_Rating
from Blinkit2
where Outlet_Establishment_Year =2020
GROUP BY  Outlet_Type
ORDER BY Total_Sales DESC



