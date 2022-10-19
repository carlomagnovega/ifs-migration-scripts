DECLARE   
   CURSOR get_qaman IS
      SELECT qcp.objid, 
             qcp.objversion,
             qcp.identity,
             qcp.LIABILITY_TYPE
      FROM SUPPLIER_INFO a   
      INNER JOIN IDENTITY_INVOICE_INFO qcp ON qcp.identity = a.supplier_id
      WHERE qcp.company = '40-UK'
      AND qcp.PARTY_TYPE = 'Supplier'
      AND qcp.LIABILITY_TYPE <> 'EXEMPT'
      AND VAT_NO IS NULL;   
   
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
      Client_SYS.Add_To_Attr('LIABILITY_TYPE', 'EXEMPT', attr_);      
      IDENTITY_INVOICE_INFO_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

--------------------------------------------
SELECT qcp.objid, 
             qcp.objversion,
             a.supplier_id,
             def_address
      FROM SUPPLIER_INFO a   
      INNER JOIN SUPPLIER_INFO_ADDRESS_TYPE qcp ON a.supplier_id = qcp.supplier_id
      WHERE qcp.address_type_code_db = 'DELIVERY'
      AND qcp.ADDRESS_ID = 'MAIN'
      AND def_address <> 'TRUE'
      AND a.supplier_id > 9000; 

---------------------------------------------------------------

DROP TABLE MTK_SUPPLIER_CONTRACT_CF_TAB;

CREATE TABLE MTK_SUPPLIER_CONTRACT_CF_TAB
(
   SUPPLIER_ID       VARCHAR2(100)        NOT NULL,
   COMPANY           VARCHAR2(100)        NOT NULL,
   WAY_ID            VARCHAR2(100)       NULL,
   LIABILITY_TYPE    VARCHAR2(100)       NULL
);

SELECT 'INSERT INTO MTK_SUPPLIER_CONTRACT_CF_TAB (SUPPLIER_ID, COMPANY, WAY_ID, LIABILITY_TYPE) VALUES (''' 
+ LTRIM(RTRIM([SUPPLIER_ID])) 
+ ''',''' + LTRIM(RTRIM([COMPANY])) 
+ ''',''' + LTRIM(RTRIM([WAY_ID])) 
+ ''',''' + LTRIM(RTRIM([LIABILITY_TYPE])) 
+  ''');' aaa  
FROM ( SELECT  [SUPPLIER_ID]
      ,[COMPANY]
	  ,[WAY_ID]
	  ,[LIABILITY_TYPE]      
  FROM [SupplierCompanyMX$] ipt) aa;
  

-----Update   IDENTITY_INVOICE_INFO.LIABILITY_TYPE
DECLARE   
   CURSOR get_qaman IS
		SELECT qcp.objid, qcp.objversion,
       qcp.identity,
       qcp.COMPANY,
       c.LIABILITY_TYPE
      FROM SUPPLIER_INFO a   
      INNER JOIN IDENTITY_INVOICE_INFO qcp ON qcp.identity = a.supplier_id
      INNER JOIN MTK_SUPPLIER_CONTRACT_CF_TAB c ON c.SUPPLIER_ID = a.supplier_id AND c.COMPANY = qcp.COMPANY
      WHERE qcp.liability_type <> c.LIABILITY_TYPE;   
   
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
      Client_SYS.Add_To_Attr('LIABILITY_TYPE', row_.LIABILITY_TYPE, attr_);      
      
      IDENTITY_INVOICE_INFO_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;


------Update WAY_ID
UPDATE PAYMENT_WAY_PER_IDENTITY_TAB qcp SET
WAY_ID = (SELECT min(c.WAY_ID)
            FROM MTK_SUPPLIER_CONTRACT_CF_TAB c 
            WHERE c.SUPPLIER_ID = qcp.IDENTITY 
            AND c.COMPANY = qcp.COMPANY
            AND qcp.PARTY_TYPE = 'SUPPLIER'
            AND qcp.WAY_ID <> c.WAY_ID)
WHERE exists (SELECT 1
               FROM SUPPLIER_INFO a   
               INNER JOIN PAYMENT_WAY_PER_IDENTITY_TAB b ON b.identity = a.supplier_id
               INNER JOIN MTK_SUPPLIER_CONTRACT_CF_TAB c ON c.SUPPLIER_ID = a.supplier_id AND c.COMPANY = b.COMPANY
               WHERE b.PARTY_TYPE = 'SUPPLIER'
               AND b.WAY_ID <> c.WAY_ID
               AND b.COMPANY = qcp.COMPANY AND b.IDENTITY = qcp.IDENTITY AND b.PARTY_TYPE = qcp.PARTY_TYPE);

------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid, 
             a.objversion,
             qcp.identity
      FROM SUPPLIER a   
      INNER JOIN IDENTITY_INVOICE_INFO qcp ON qcp.identity = a.vendor_no
      WHERE qcp.company = '40-UK'
      AND qcp.PARTY_TYPE = 'Supplier'      
      AND a.PRINT_AMOUNTS_INCL_TAX_DB <> 'TRUE';   
   
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
      Client_SYS.Add_To_Attr('PRINT_AMOUNTS_INCL_TAX_DB', 'TRUE', attr_);   
      
      
      SUPPLIER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

------------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT qcp.objid, 
             qcp.objversion,
             qcp.identity,
             TAX_REGIME
      FROM SUPPLIER_INFO a   
      INNER JOIN IDENTITY_INVOICE_INFO qcp ON qcp.identity = a.supplier_id
      WHERE qcp.company = '40-UK'
      AND qcp.PARTY_TYPE = 'Supplier'
      AND TAX_REGIME <> 'VAT';   
   
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
      Client_SYS.Add_To_Attr('TAX_REGIME', 'VAT', attr_);      
      
      IDENTITY_INVOICE_INFO_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;

--------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT a.IDENTITY,
             a.COMPANY
      FROM IDENTITY_PAY_INFO a
      LEFT JOIN PAYMENT_WAY_PER_IDENTITY b ON a.IDENTITY = b.IDENTITY AND a.company = b.company AND a.PARTY_TYPE_DB = b.PARTY_TYPE_DB
      WHERE b.PARTY_TYPE_DB IS NULL
      AND a.COMPANY = '40-UK'
      AND a.party_type_db = 'SUPPLIER';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('COMPANY', row_.COMPANY, attr_);
      Client_SYS.Add_To_Attr('IDENTITY', row_.IDENTITY, attr_);
      Client_SYS.Add_To_Attr('PARTY_TYPE_DB', 'SUPPLIER', attr_);
      Client_SYS.Add_To_Attr('WAY_ID', 'WIRE', attr_);
      Client_SYS.Add_To_Attr('DEFAULT_PAYMENT_WAY', 'TRUE', attr_);
            
      PAYMENT_WAY_PER_IDENTITY_API.NEW__( info_ , objid_ , objversion_ , attr_, 'DO' );
   END LOOP;   
END;
----------------------

DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid, 
             a.objversion,
             qcp.name
      FROM SUPPLIER_INFO a   
      INNER JOIN MTK_SUPPLIER_INFO_TAB qcp ON qcp.SUPPLIER_ID = a.SUPPLIER_ID;   
   
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
      Client_SYS.Add_To_Attr('NAME', row_.name, attr_);  
      
      SUPPLIER_INFO_GENERAL_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

----------------------

DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid, 
             a.objversion,
             qcp.company_name2 name
      FROM SUPPLIER_INFO_ADDRESS a   
      INNER JOIN mtk_supplier_info_address_tab qcp ON qcp.SUPPLIER_ID = a.SUPPLIER_ID AND qcp.address_id = a.address_id;   
   
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
      Client_SYS.Add_To_Attr('NAME', row_.name, attr_);  
      
      SUPPLIER_INFO_ADDRESS_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;