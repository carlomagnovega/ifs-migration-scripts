DROP TABLE MTK_SALESMAN_NEW_TAB;

CREATE TABLE MTK_SALESMAN_NEW_TAB
(
   customer_id                        VARCHAR2(25)        NOT NULL,
   SALESMAN                           VARCHAR2(25)        NOT NULL
);

SELECT 'INSERT INTO MTK_SALESMAN_NEW_TAB (customer_id,SALESMAN) VALUES (''' 
		+ LTRIM(RTRIM([CUSTOMER_NO])) 
		+ ''',''' + [SALESMAN_CODE]
		+  ''');'   aa
FROM ( SELECT [CUSTOMER_NO]
		  ,CAST ([SALESMAN_CODE]   as varchar)  [SALESMAN_CODE]    
	  FROM [IFSDEV-ManualUpload].[dbo].[CustomerInfoPOL$]) aaa  
  
SELECT 'INSERT INTO MTK_SALESMAN_NEW_TAB (customer_id,SALESMAN) VALUES (''' 
		+ [SALESMAN]
		+ ''',''' + [NEW_CODE]
		+  ''');'   aa
FROM ( SELECT replace(replace([Salesman code in use in IFS MIGR], '''', '-'), '&', '-')  [SALESMAN]
		  ,CAST ([New Code] as varchar) [NEW_CODE]      
	  FROM [IFSDEV-ManualUpload].[dbo].[NewSalesman$]) aaa  

  
----Update CustomerOrder
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcp.objid,
              qcp.objversion,
              qcp.SALESMAN_CODE
      FROM MTK_SALESMAN_NEW_TAB qcpa
      INNER JOIN CUSTOMER_ORDER qcp ON REPLACE(REPLACE(qcp.SALESMAN_CODE,'&','-'),'''','-')  = qcpa.SALESMAN
      INNER JOIN SALES_PART_SALESMAN b ON b.salesman_code = qcpa.SALESMAN_CODE;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('SALESMAN_CODE', row_.NEW_CODE, attr_);
      
      CUSTOMER_ORDER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;      


--Save old SALESMAN_CODE
DROP TABLE MTK_SALESMAN_NEW_TAB;

CREATE TABLE MTK_SALESMAN_NEW_TAB
(
   customer_id                        VARCHAR2(25)        NOT NULL,
   SALESMAN                           VARCHAR2(25)        NOT NULL
);

SELECT 'INSERT INTO MTK_SALESMAN_NEW_TAB (customer_id,SALESMAN) VALUES (''' 
		+ LTRIM(RTRIM([CUSTOMER_NO])) 
		+ ''',''' + [SALESMAN_CODE]
		+  ''');'   aa
FROM ( SELECT [CUSTOMER_NO]
		  ,CAST ([SALESMAN_CODE]   as varchar)  [SALESMAN_CODE]    
	  FROM [IFSDEV-ManualUpload].[dbo].[CustomerInfoPOL$]) aaa 

--Update Customer/Salesman
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcp.objid,
              qcp.objversion,
              qcp.SALESMAN_CODE,
              qcpa.SALESMAN
      FROM MTK_SALESMAN_NEW_TAB qcpa
      INNER JOIN CUST_ORD_CUSTOMER_ENT qcp ON qcp.customer_id  = qcpa.customer_id
      INNER JOIN SALES_PART_SALESMAN b ON b.salesman_code = qcpa.SALESMAN
      WHERE qcp.SALESMAN_CODE <> qcpa.SALESMAN;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('SALESMAN_CODE', row_.SALESMAN, attr_);
      
      CUST_ORD_CUSTOMER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;
   
END;  

-----------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT   qcp.objid,
               qcp.objversion,
               qcp.SALESMAN_CODE,
               '1113' SALESMAN
      FROM CUST_ORD_CUSTOMER_ENT qcp
      INNER JOIN SALES_PART_SALESMAN b ON b.salesman_code = qcp.salesman_code
      INNER JOIN IDENTITY_INVOICE_INFO c ON qcp.customer_id = c.identity
      WHERE qcp.SALESMAN_CODE = '1111'
      AND c.COMPANY = '40-UK';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('SALESMAN_CODE', row_.SALESMAN, attr_);
      
      CUST_ORD_CUSTOMER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END; 

------------------------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT   qcp.objid,
               qcp.objversion,
               qcp.SALESMAN_CODE,
               '1113' SALESMAN
      FROM CUST_ORD_CUSTOMER_ENT qcp
      INNER JOIN SALES_PART_SALESMAN b ON b.salesman_code = qcp.salesman_code
      INNER JOIN IDENTITY_INVOICE_INFO c ON qcp.customer_id = c.identity
      WHERE qcp.PRINT_AMOUNTS_INCL_TAX_DB <> 'TRUE'
      AND c.COMPANY = '40-UK';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('PRINT_AMOUNTS_INCL_TAX_DB', 'TRUE', attr_);
      
      CUST_ORD_CUSTOMER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END; 