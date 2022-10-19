DROP TABLE MTK_TAX_INFO_AIM_TAB;

CREATE TABLE MTK_TAX_INFO_AIM_TAB 
(
   COMPANY                      VARCHAR2(20)        NULL,
   SUPPLIER_ID                  VARCHAR2(20)        NULL,
   VAT_NO                       VARCHAR2(20)        NULL
);

  
SELECT 'INSERT INTO MTK_TAX_INFO_AIM_TAB (COMPANY,SUPPLIER_ID, VAT_NO) VALUES (''' 
		+ [COMPANY]
		+ ''',''' + SUPPLIER_ID
		+ ''',''' + VAT_NO
		+  ''');'   aa
FROM ( SELECT [COMPANY]
			  ,[SUPPLIER_ID]
			  ,[VAT_NO]
  FROM [IFSDEV-ManualUpload].[dbo].[SupplierCompanyCHN$]
  WHERE [VAT_NO] IS NOT NULL) s

---Update ZipCOde
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcpa.COMPANY,
			qcpa.SUPPLIER_ID,
			b.ADDRESS_ID,
			qcpa.VAT_NO
	FROM MTK_TAX_INFO_AIM_TAB qcpa
	INNER JOIN SUPPLIER_INFO_ADDRESS b ON b.SUPPLIER_ID = qcpa.SUPPLIER_ID AND b.ADDRESS_ID = 'MAIN'
	LEFT JOIN SUPPLIER_DOCUMENT_TAX_INFO c ON c.SUPPLIER_ID = qcpa.SUPPLIER_ID AND b.ADDRESS_ID = c.ADDRESS_ID AND c.COMPANY = qcpa.COMPANY
	WHERE c.ADDRESS_ID IS NULL;  
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('SUPPLIER_ID', row_.SUPPLIER_ID, attr_);         
      Client_SYS.Add_To_Attr('ADDRESS_ID', row_.ADDRESS_ID, attr_);
      Client_SYS.Add_To_Attr('COMPANY', row_.COMPANY, attr_);
      Client_SYS.Add_To_Attr('TAX_ID_TYPE', 'TIN', attr_);
      Client_SYS.Add_To_Attr('VAT_NO', row_.VAT_NO, attr_);
	  
      SUPPLIER_DOCUMENT_TAX_INFO_API.NEW__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;  