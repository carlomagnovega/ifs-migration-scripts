DROP TABLE MTK_CUTOMER_AIM_TAB;

CREATE TABLE MTK_CUSTOMER_AIM_TAB 
(
   CUSTOMER_ID                        VARCHAR2(20)        NOT NULL,
   CORPORATE_FORM                     VARCHAR2(8)         NULL
);

  
SELECT 'INSERT INTO MTK_CUSTOMER_AIM_TAB (CUSTOMER_ID,CORPORATE_FORM) VALUES (''' 
		+ [Customer_Id]
		+ ''',''' + [Corporate_Form]
		+  ''');'   aa
FROM ( SELECT [Customer_Id]
	  ,[Corporate_Form]
	  FROM [IFSDEV-ManualUpload].[dbo].[CustomerCFDI$]) aaa  

-----Validate non existing CorporateForms
SELECT  
   qcpa.CORPORATE_FORM,
   qcp.country_db
FROM MTK_CUSTOMER_AIM_TAB qcpa
INNER JOIN CUSTOMER_INFO qcp ON qcp.CUSTOMER_ID = qcpa.CUSTOMER_ID
left join CORPORATE_FORM cft ON cft.country_code = qcp.country_db AND cft.CORPORATE_FORM = qcpa.CORPORATE_FORM
WHERE cft.country_code IS NULL
GROUP BY qcpa.CORPORATE_FORM,
   qcp.country_db
  
----Update CustomerOrder
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcp.objid,
			 qcp.objversion,
			 qcpa.CORPORATE_FORM
	  FROM MTK_CUSTOMER_AIM_TAB qcpa
	  INNER JOIN CUSTOMER_INFO qcp ON qcp.CUSTOMER_ID = qcpa.CUSTOMER_ID; 
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CORPORATE_FORM', row_.CORPORATE_FORM, attr_);
	  
      CUSTOMER_INFO_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;      


