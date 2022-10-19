DROP TABLE MTK_CUST_ORD_CUSTOMER_TAB;

CREATE TABLE MTK_CUST_ORD_CUSTOMER_TAB
(
   CUSTOMER_NO                        VARCHAR2(20)        NOT NULL,
   MARKET_CODE                        VARCHAR2(10)        NULL,
   CURRENCY_CODE                      VARCHAR2(3)         NOT NULL
);

  
SELECT 'INSERT INTO MTK_CUST_ORD_CUSTOMER_TAB (CUSTOMER_NO, MARKET_CODE, CURRENCY_CODE) VALUES (''' 
		+ [CUSTOMER_NO]
		+ ''',''' + [MARKET_CODE]
		+ ''',''' + [CURRENCY_CODE]
		+  ''');'   aa
FROM ( SELECT [CUSTOMER_NO]
			  ,case when [MARKET_CODE] is null then '' else [MARKET_CODE] END [MARKET_CODE]
			  ,[CURRENCY_CODE]      
	  FROM [IFSDEV-ManualUpload].[dbo].[CustomerInfoCorrection$]) aaa  


--Update Customer/MarketCode
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcp.objid,
              qcp.objversion,
              qcpa.MARKET_CODE,
              qcpa.CURRENCY_CODE              
      FROM MTK_CUST_ORD_CUSTOMER_TAB qcpa
      INNER JOIN CUST_ORD_CUSTOMER qcp ON qcp.CUSTOMER_NO  = qcpa.CUSTOMER_NO;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('MARKET_CODE', row_.MARKET_CODE, attr_);
      Client_SYS.Add_To_Attr('CURRENCY_CODE', row_.CURRENCY_CODE, attr_);
	  
      CUST_ORD_CUSTOMER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;  

---------Update Invoice.DEF_CURRENCY
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcp.objid,
              qcp.objversion,
              qcpa.CURRENCY_CODE              
      FROM MTK_CUST_ORD_CUSTOMER_TAB qcpa
      INNER JOIN IDENTITY_INVOICE_INFO qcp ON qcp.IDENTITY = qcpa.CUSTOMER_NO 
      WHERE qcp.COMPANY = '20-MEX' AND qcp.party_type = 'Customer';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('DEF_CURRENCY', row_.CURRENCY_CODE, attr_);
      
      IDENTITY_INVOICE_INFO_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;  