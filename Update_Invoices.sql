DECLARE   
   CURSOR get_qaman IS
      SELECT objid
		FROM  INVOICE_CFV  
      WHERE CF$_AIM_SHIPMENT_SUPPLIER IN ('1699', '1663')
      AND COMPANY = '10-MTL';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      Client_SYS.Clear_Attr(attr_cf_);
	   Client_SYS.Add_To_Attr('CF$_AIM_SHIPMENT_SUPPLIER', '1000', attr_cf_);      
	   Client_SYS.Add_To_Attr('CF$_AIM_FREIGHT_CURR', 'CAD', attr_cf_);      
      INVOICE_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

------------------------
DROP TABLE MTK_MATCHED_INVOICE_TAB;

CREATE TABLE MTK_MATCHED_INVOICE_TAB
(
   COMPANY       VARCHAR2(30)        NOT NULL,
   INVOICE_NO    VARCHAR2(30)        NOT NULL,
   UUID        VARCHAR2(200)              NOT NULL
);

SELECT 'INSERT INTO MTK_MATCHED_INVOICE_TAB (COMPANY,INVOICE_NO,UUID) VALUES (''' 
+ COMPANY 
+ ''',''' + INVOICE_NO 
+ ''',''' + UUID 
+  ''');'   aa
FROM ( SELECT  '20MEX'	COMPANY  
			  ,rtrim(cast([Folio] as CHAR)) INVOICE_NO
	          ,[UUID]	UUID
  FROM [IFSDEV-ManualUpload].[dbo].[FacturasMEX$]
  WHERE [UUID] IS NOT NULL) aaa 
  
DECLARE   
   CURSOR get_qaman IS
      SELECT   a.OBJID,
               a.invoice_id,
               b.INVOICE_NO,
               b.UUID
      FROM INVOICE_CFV a 
      INNER JOIN MTK_MATCHED_INVOICE_TAB b ON a.COMPANY = '20-MEX' AND b.INVOICE_NO = a.INVOICE_NO
      WHERE  a.CF$_AIM_UUID IS NULL;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      Client_SYS.Clear_Attr(attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_UUID', row_.UUID, attr_cf_);     
 
      INVOICE_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');      
   END LOOP;   
END;
  