DROP TABLE MTK_CUSTOMER_AIM_TAB;

CREATE TABLE MTK_CUSTOMER_AIM_TAB 
(
   CUSTOMER_ID                        VARCHAR2(20)        NOT NULL,
   NAME                               VARCHAR2(100)       NOT NULL
);
   
SELECT 'INSERT INTO MTK_CUSTOMER_AIM_TAB (CUSTOMER_ID,NAME) VALUES (''' 
		|| Customer_Id
		|| ''',''' || name		
      ||  ''');'   aa
FROM ( SELECT Customer_Id
	  ,REPLACE(REPLACE(name,'''','-'),'&','-') name
FROM CUSTOMER_INFO
WHERE Customer_Id > 2000) aaa 


SELECT a.Customer_Id
	  ,REPLACE(REPLACE(a.name,'''','-'),'&','-') prod_name
	  ,REPLACE(REPLACE(b.name,'''','-'),'&','-') migr_name
FROM CUSTOMER_INFO a
left join MTK_CUSTOMER_AIM_TAB b ON a.Customer_Id = b.Customer_Id
WHERE a.Customer_Id > 2000
AND REPLACE(REPLACE(a.name,'''','-'),'&','-') <> REPLACE(REPLACE(b.name,'''','-'),'&','-')
