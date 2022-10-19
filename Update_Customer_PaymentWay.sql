DROP TABLE MTK_CUSTOMER_AIM_TAB;

CREATE TABLE MTK_CUSTOMER_AIM_TAB 
(
   COMPANY                        VARCHAR2(20)        NULL,
   WAY_ID                         VARCHAR2(50)        NULL,
   IDENTITY                       VARCHAR2(20)        NULL,
   DEFAULT_PAYMENT_WAY            VARCHAR2(20)        NULL,
);

  
SELECT 'INSERT INTO MTK_CUSTOMER_AIM_TAB (COMPANY,WAY_ID, IDENTITY, DEFAULT_PAYMENT_WAY) VALUES (''' 
		+ [COMPANY]
		+ ''',''' + [WAY_ID]
		+ ''',''' + [IDENTITY]
		+ ''',''' + [DEFAULT_PAYMENT_WAY]
		+  ''');'   aa
FROM ( SELECT [COMPANY]
			  ,[WAY_ID]
			  ,[IDENTITY]
			  ,[DEFAULT_PAYMENT_WAY]
	  FROM [IFSDEV-ManualUpload].[dbo].[PaymentWayMX$]) aaa  

---Update ZipCOde
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcpa.COMPANY,
              qcpa.IDENTITY,
              qcpa.WAY_ID,
              qcpa.DEFAULT_PAYMENT_WAY
      FROM MTK_CUSTOMER_AIM_TAB qcpa
      LEFT JOIN PAYMENT_WAY_PER_IDENTITY b ON b.COMPANY = qcpa.COMPANY AND
              b.IDENTITY = qcpa.IDENTITY AND 
              b.PARTY_TYPE = 'Customer' AND
              b.WAY_ID = qcpa.WAY_ID
      WHERE b.COMPANY IS NULL; 
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('COMPANY', row_.COMPANY, attr_);         
      Client_SYS.Add_To_Attr('IDENTITY', row_.IDENTITY, attr_);
      Client_SYS.Add_To_Attr('PARTY_TYPE', 'Customer', attr_);
      Client_SYS.Add_To_Attr('WAY_ID', row_.WAY_ID, attr_);
      Client_SYS.Add_To_Attr('DEFAULT_PAYMENT_WAY', row_.DEFAULT_PAYMENT_WAY, attr_);
      PAYMENT_WAY_PER_IDENTITY_API.NEW__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;  