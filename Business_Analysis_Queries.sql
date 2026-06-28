SELECT COUNT(*) FROM freight_rates;
SELECT COUNT(*) FROM wh_capacities;
SHOW DATABASES;
SELECT DATABASE();

SHOW TABLES;

SELECT * FROM order_list LIMIT 5;
SELECT * FROM products_per_plant LIMIT 5;
SELECT * FROM wh_costs LIMIT 5;
SELECT * FROM wh_capacities LIMIT 5;
SELECT * FROM plant_ports LIMIT 5;
SELECT * FROM vmi_customers LIMIT 5;

DESCRIBE products_per_plant;
DESCRIBE wh_costs;
DESCRIBE wh_capacities;
DESCRIBE plant_ports;
DESCRIBE vmi_customers;
DESCRIBE freight_rates;


ALTER TABLE products_per_plant
RENAME COLUMN `ï»¿Plant_Code` TO Plant_Code;

ALTER TABLE wh_costs
RENAME COLUMN `ï»¿WH` TO WH;

ALTER TABLE plant_ports
RENAME COLUMN `ï»¿Plant_Code` TO Plant_Code;

ALTER TABLE vmi_customers
RENAME COLUMN `ï»¿Plant_Code` TO Plant_Code;

SELECT COUNT(*) AS Total_Orders
FROM order_list;

SELECT SUM(Unit_quantity) AS Total_Units_Shipped
FROM order_list;

SELECT ROUND(SUM(Weight),2) AS Total_Shipment_Weight
FROM order_list;

SELECT
ROUND(
100.0 * SUM(CASE WHEN Ship_Late_Day_count > 0 THEN 1 ELSE 0 END)
/
COUNT(*)
,2) AS Late_Shipment_Percentage
FROM order_list;

SELECT
Product_ID,
SUM(Unit_quantity) AS Units_Sold
FROM order_list
GROUP BY Product_ID
ORDER BY Units_Sold DESC
LIMIT 10;

SELECT
Plant_Code,
COUNT(*) AS Orders_Count
FROM order_list
GROUP BY Plant_Code
ORDER BY Orders_Count DESC;



/* real business-analysis query*/
SELECT
    Carrier,
    COUNT(*) AS Total_Shipments,
    ROUND(AVG(Ship_Late_Day_count),2) AS Avg_Delay_Days
FROM order_list
GROUP BY Carrier
ORDER BY Total_Shipments DESC;

SELECT
    Service_Level,
    COUNT(*) AS Orders_Count,
    ROUND(AVG(Weight),2) AS Avg_Weight
FROM order_list
GROUP BY Service_Level
ORDER BY Orders_Count DESC;

SELECT
    Product_ID,
    SUM(Unit_quantity) AS Total_Units
FROM order_list
GROUP BY Product_ID
ORDER BY Total_Units DESC
LIMIT 10;

SELECT
    Origin_Port,
    COUNT(*) AS Shipments
FROM order_list
GROUP BY Origin_Port
ORDER BY Shipments DESC
LIMIT 10;

/*KPI 1: Total Shipment Weight by Plant*/
SELECT
    Plant_Code,
    ROUND(SUM(Weight),2) AS Total_Weight
FROM order_list
GROUP BY Plant_Code
ORDER BY Total_Weight DESC;

SELECT
    Service_Level,
    ROUND(AVG(Weight),2) AS Avg_Weight
FROM order_list
GROUP BY Service_Level;

SELECT
    COUNT(*) AS Late_Shipments
FROM order_list
WHERE Ship_Late_Day_count > 0;

SELECT
    ROUND(AVG(TPT),2) AS Avg_Transit_Days
FROM order_list;