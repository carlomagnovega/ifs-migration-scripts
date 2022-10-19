DROP TABLE MTK_CUSTOMER_AIM_TAB;

CREATE TABLE MTK_CUSTOMER_AIM_TAB 
(
   CUSTOMER_ID                        VARCHAR2(20)        NOT NULL,
   ADDRESS_ID                         VARCHAR2(50)        NOT NULL,
   COMPANY                            VARCHAR2(20)        NOT NULL,
   SUPPLY_COUNTRY                     VARCHAR2(2)         NOT NULL,
   DELIVERY_COUNTRY                     VARCHAR2(2)         NOT NULL,
   TAX_ID_TYPE                        VARCHAR2(10)        NULL,
   VAT_NO                             VARCHAR2(50)        NULL
);

  
SELECT 'INSERT INTO MTK_CUSTOMER_AIM_TAB (CUSTOMER_ID,ADDRESS_ID,COMPANY,SUPPLY_COUNTRY,,DELIVERY_COUNTRY,TAX_ID_TYPE,VAT_NO) VALUES (''' 
		+ [Customer_Id]
		+ ''',''' + [Address_Id]
		+ ''',''' + [Company]
		+ ''',''' + [Supply_Country]
		+ ''',''' + [Delivery_Country]
		+ ''',''' + [Tax_Id_Type]
		+ ''',''' + [Vat_No]
		+  ''');'   aa
FROM ( SELECT CAST([Customer_Id] AS VARCHAR)	[Customer_Id]
	  ,[Address_Id]
	  ,[Company]
	  ,[Supply_Country]
	  ,[Delivery_Country]
	  ,[Tax_Id_Type]
	  ,[Vat_No]
	  FROM [IFSDEV-ManualUpload].[dbo].['Customer-VatNo$'] WHERE [Vat_No] IS NOT NULL) aaa   
	  
	  
SELECT 'INSERT INTO MTK_CUSTOMER_AIM_TAB (CUSTOMER_ID,ADDRESS_ID,COMPANY,SUPPLY_COUNTRY,TAX_ID_TYPE,VAT_NO) VALUES (''' 
		|| Customer_Id
		|| ''',''' || Address_Id
		|| ''',''' || Company
		|| ''',''' || Supply_Country
		|| ''',''' || nvl(Tax_Id_Type,'')
		|| ''',''' || Vat_No
      ||  ''');'   aa
FROM ( SELECT to_char(Customer_Id) Customer_Id
	  ,Address_Id
	  ,Company
	  ,Supply_Country_DB Supply_Country
	  ,to_char(Tax_Id_Type) Tax_Id_Type
	  ,Vat_No
FROM CUSTOMER_DOCUMENT_TAX_INFO
WHERE Customer_Id >= 3500) aaa 	  

---Update ZipCOde
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcp.objid,
              qcp.objversion
      FROM CUSTOMER_INFO_ADDRESS qcp 
      WHERE customer_id IN ('3510','3611','3564','3586','3600','3658','3566','3502','3525','3565','3660','3579','3527','3521','3626','3551','3556','3582','3574','3599','3643','3598','3526','3591','3542','3553','3518','3524','3618','3590','3612','3541','3633','3644','3596','3504','3513','3583','3543','3665','3620','3628','3607','3610','3501','3655','3562','3615','3647','3622','3621','3664','3629','3635')
      AND zip_code IS NULL; 
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('ZIP_CODE', '.', attr_);      
      CUSTOMER_INFO_ADDRESS_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;    
  
  
----Update CustomerOrder
DECLARE    
   CURSOR get_qaman IS
      SELECT  qcp.objid,
              qcp.objversion,
              qcpa.CUSTOMER_ID,
              qcpa.ADDRESS_ID,
              qcpa.COMPANY,
              qcpa.SUPPLY_COUNTRY,
              qcpa.TAX_ID_TYPE,
              qcpa.VAT_NO,
              Customer_Info_Address_API.Get_Country_Code(qcpa.CUSTOMER_ID, qcpa.ADDRESS_ID) MAIN_COUNTRY
      FROM MTK_CUSTOMER_AIM_TAB qcpa
      LEFT JOIN CUSTOMER_DOCUMENT_TAX_INFO qcp ON qcp.CUSTOMER_ID = qcpa.CUSTOMER_ID AND
      qcp.ADDRESS_ID = qcpa.ADDRESS_ID AND
      qcp.COMPANY = qcpa.COMPANY AND
      qcp.supply_country_db = qcpa.SUPPLY_COUNTRY
      WHERE Customer_Info_Address_API.Get_Country_Code(qcpa.CUSTOMER_ID, qcpa.ADDRESS_ID) <> 'BR'
      AND (qcp.VAT_NO IS NULL OR qcpa.VAT_NO <> qcp.VAT_NO); 
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('VAT_NO', row_.VAT_NO, attr_);
      
      IF( objid_ IS NULL) THEN
         Client_SYS.Add_To_Attr('CUSTOMER_ID', row_.CUSTOMER_ID, attr_);         
         Client_SYS.Add_To_Attr('ADDRESS_ID', row_.ADDRESS_ID, attr_);
         Client_SYS.Add_To_Attr('COMPANY', row_.COMPANY, attr_);
         Client_SYS.Add_To_Attr('SUPPLY_COUNTRY_DB', row_.SUPPLY_COUNTRY, attr_);
         IF (row_.MAIN_COUNTRY = 'MX') THEN
            Client_SYS.Add_To_Attr('TAX_ID_TYPE', row_.TAX_ID_TYPE, attr_);            
         END IF;         
         CUSTOMER_DOCUMENT_TAX_INFO_API.NEW__(info_, objid_, objversion_, attr_, 'DO');
      ELSE
         CUSTOMER_DOCUMENT_TAX_INFO_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      END IF;      
   END LOOP;   
END; 

--------
DECLARE
  CURSOR get_qaman IS
    SELECT qcp.objid,
           qcp.objversion,
           qcpa.CUSTOMER_ID,
           qcpa.ADDRESS_ID,
           qcpa.COMPANY,
           qcpa.SUPPLY_COUNTRY,
           qcpa.DELIVERY_COUNTRY,
           qcpa.VAT_NO
      FROM MTK_CUSTOMER_AIM_TAB qcpa
     INNER JOIN CUSTOMER_INFO_ADDRESS b
        ON b.CUSTOMER_ID = qcpa.CUSTOMER_ID
       AND b.ADDRESS_ID = qcpa.ADDRESS_ID
      LEFT JOIN CUSTOMER_DOCUMENT_TAX_INFO qcp
        ON qcp.CUSTOMER_ID = qcpa.CUSTOMER_ID
       AND qcp.ADDRESS_ID = qcpa.ADDRESS_ID
       AND qcp.COMPANY = qcpa.COMPANY
       AND qcp.supply_country_db = qcpa.SUPPLY_COUNTRY
     WHERE (qcp.VAT_NO IS NULL OR qcpa.VAT_NO <> qcp.VAT_NO);

  info_       VARCHAR2(32000);
  objid_      VARCHAR2(32000);
  objversion_ VARCHAR2(32000);
  attr_       VARCHAR2(26000);
BEGIN
  FOR row_ IN get_qaman LOOP
    objid_      := row_.objid;
    objversion_ := row_.objversion;
    Client_SYS.Clear_Attr(attr_);
    Client_SYS.Add_To_Attr('VAT_NO', row_.VAT_NO, attr_);
  
    IF (objid_ IS NULL) THEN
      Client_SYS.Add_To_Attr('CUSTOMER_ID', row_.CUSTOMER_ID, attr_);
      Client_SYS.Add_To_Attr('ADDRESS_ID', row_.ADDRESS_ID, attr_);
      Client_SYS.Add_To_Attr('COMPANY', row_.COMPANY, attr_);
      Client_SYS.Add_To_Attr('SUPPLY_COUNTRY_DB',
                             row_.SUPPLY_COUNTRY,
                             attr_);
      Client_SYS.Add_To_Attr('DELIVERY_COUNTRY_DB',
                             row_.DELIVERY_COUNTRY,
                             attr_);
    
      CUSTOMER_DOCUMENT_TAX_INFO_API.NEW__(info_,
                                           objid_,
                                           objversion_,
                                           attr_,
                                           'DO');
    ELSE
      CUSTOMER_DOCUMENT_TAX_INFO_API.MODIFY__(info_,
                                              objid_,
                                              objversion_,
                                              attr_,
                                              'DO');
    END IF;
  END LOOP;
END;
