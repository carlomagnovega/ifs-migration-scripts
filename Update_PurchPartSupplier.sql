DROP TABLE MTK_PURCHPART_SUPP_AIM_TAB;

CREATE TABLE MTK_PURCHPART_SUPP_AIM_TAB 
(
   PART_NO                            VARCHAR2(25)        NOT NULL,
   CONTRACT                           VARCHAR2(5)         NOT NULL,
   VENDOR_NO                          VARCHAR2(20)        NOT NULL,
   CURRENCY_CODE                      VARCHAR2(3)         NOT NULL
);

SELECT 'INSERT INTO MTK_PURCHPART_SUPP_AIM_TAB (PART_NO,CONTRACT,VENDOR_NO,CURRENCY_CODE) VALUES (''' 
		+ [Part No]
		+ ''',''' + [Site]
		+ ''',''' + [Supplier No]
		+ ''',''' + [Currency]
		+  ''');'   aa
FROM ( SELECT [Part No]
	  ,[Site]
	  ,[Supplier No]
	  ,[Currency]
	  FROM [IFSDEV-ManualUpload].[dbo].[SupplierforPurchaseParts200806$]) aaa 
	
DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid, 
             a.objversion,
             b.CURRENCY_CODE
      FROM PURCHASE_PART_SUPPLIER a
      INNER JOIN MTK_PURCHPART_SUPP_AIM_TAB b ON a.PART_NO = b.PART_NO AND a.CONTRACT = b.CONTRACT AND a.VENDOR_NO = b.VENDOR_NO
      WHERE a.CURRENCY_CODE <> b.CURRENCY_CODE;      
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CURRENCY_CODE', row_.CURRENCY_CODE, attr_);

      PURCHASE_PART_SUPPLIER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;
   
END;
--------
	
DECLARE   
   CURSOR get_qaman IS
      SELECT qcp.objid, qcp.objversion
      FROM PURCHASE_PART_SUPPLIER qcp
      WHERE CONTRACT = '21BRA'
      AND qcp.currency_code <> 'USD';      
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CURRENCY_CODE', 'USD', attr_);

      PURCHASE_PART_SUPPLIER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;
   
END;

-----
DECLARE   
   CURSOR get_qaman IS
		SELECT qcp.objid, qcp.objversion
		FROM PURCHASE_PART_SUPPLIER qcp
		WHERE CONTRACT IN ('21BRA', '34MAY')
		AND qcp.fee_code <> 'NO-TAX';   
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('FEE_CODE', 'NO-TAX', attr_);

      PURCHASE_PART_SUPPLIER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

-----------------------------------------
DECLARE   
   CURSOR get_qaman IS
		SELECT qcp.objid, qcp.objversion
		FROM PURCHASE_PART_SUPPLIER qcp
		WHERE CONTRACT = '40UK' and FEE_CODE not like 'VAT-0%';   
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('FEE_CODE', 'VAT-0%', attr_);

      PURCHASE_PART_SUPPLIER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;


