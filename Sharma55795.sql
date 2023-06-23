USE Final234

SELECT PRODUCTS.PRODUCT_ID, PRODUCTS.PRODUCT_NAME, SUPPLIERS.COMPANY_NAME, DATEPART(year,s.ORDER_DATE) AS[ORDER_YEAR],
CASE 
WHEN s.QUARTER = 'Q1' THEN CAST(s.TOTAL_SALE AS DECIMAL(7,2))
     ELSE 0
END AS Q1,
CASE 
WHEN s.QUARTER = 'Q2' THEN CAST(s.TOTAL_SALE AS DECIMAL(7,2))
     ELSE 0
END AS Q2,
CASE 
WHEN s.QUARTER = 'Q3' THEN CAST(s.TOTAL_SALE AS DECIMAL(7,2))
     ELSE 0
END AS Q3,
CASE 
WHEN s.QUARTER = 'Q4' THEN CAST(s.TOTAL_SALE AS DECIMAL(7,2))
     ELSE 0
END AS Q4
FROM PRODUCTS
INNER JOIN SUPPLIERS ON PRODUCTS.SUPPLIER_ID = SUPPLIERS.SUPPLIER_ID
INNER JOIN 
(SELECT ORDERS.ORDER_DATE, ORDER_DETAILS.PRODUCT_ID, ORDER_DETAILS.ORDER_ID,ORDER_DETAILS.UNIT_PRICE,ORDER_DETAILS.QUANTITY,ORDER_DETAILS.DISCOUNT, 
(SELECT CASE DATEPART(QUARTER, ORDERS.ORDER_DATE)WHEN 1 THEN'Q4'WHEN 2 THEN'Q1'WHEN 3 THEN'Q2'WHEN 4 THEN'Q3' END AS FINANCIAL_QUARTER) AS QUARTER,
(ORDER_DETAILS.UNIT_PRICE * ORDER_DETAILS.QUANTITY - (ORDER_DETAILS.UNIT_PRICE * ORDER_DETAILS.QUANTITY *ORDER_DETAILS.DISCOUNT)) AS TOTAL_SALE
FROM ORDERS
INNER JOIN ORDER_DETAILS ON ORDERS.ORDER_ID = ORDER_DETAILS.ORDER_ID) s ON s.PRODUCT_ID = PRODUCTS.PRODUCT_ID
WHERE s.PRODUCT_ID = 2


  
