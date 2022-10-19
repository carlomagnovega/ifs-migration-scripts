CREATE TABLE MTK_CUSTOMER_CREDIT_INFO_TAB
(
   COMPANY                            VARCHAR2(20)        NOT NULL,
   IDENTITY                           VARCHAR2(20)        NOT NULL,
   CREDIT_LIMIT                       NUMBER              NULL
)

SELECT 'INSERT INTO MTK_CUSTOMER_CREDIT_INFO_TAB (COMPANY,IDENTITY,CREDIT_LIMIT) VALUES (''' 
		+ LTRIM(RTRIM([COMPANY])) 
		+ ''',''' + [CUSTOMER_ID]
		+ ''',''' + [CREDIT_LIMIT_PLN]
		+  ''');'   aa
FROM ( SELECT [COMPANY]
		  ,CAST ([CUSTOMER_ID]   as varchar)  [CUSTOMER_ID]    
		  ,CAST ([CREDIT_LIMIT_PLN]   as varchar)  [CREDIT_LIMIT_PLN]    
	  FROM [IFSDEV-ManualUpload].[dbo].[CustomerCompanyPOL$]
	  WHERE [COMPANY] IS NOT NULL) aaa  

------------------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcp.objid,
              qcp.objversion,
              qcpa.CREDIT_LIMIT
      FROM MTK_CUSTOMER_CREDIT_INFO_TAB qcpa
      INNER JOIN CUSTOMER_CREDIT_INFO qcp ON qcp.COMPANY  = qcpa.COMPANY 
	  AND qcp.IDENTITY  = qcpa.IDENTITY;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CREDIT_LIMIT', row_.CREDIT_LIMIT, attr_);
      
      CUSTOMER_CREDIT_INFO_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;
   
END;