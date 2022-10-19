DROP TABLE MTK_CUSTOMER_AIM_TAB;

CREATE TABLE MTK_CUSTOMER_AIM_TAB 
(
   CUSTOMER_ID                        VARCHAR2(20)        NOT NULL,
   CF$_AIM_FISCAL_RES                     VARCHAR2(100)       NULL,
   CF$_AIM_ID_TRIB_REG                    VARCHAR2(100)       NULL,
   CF$_AS400NUMBER                    VARCHAR2(100)           NULL,
   CORPORATE_FORM                     VARCHAR2(8)         NULL
);

  
SELECT 'INSERT INTO MTK_CUSTOMER_AIM_TAB (CUSTOMER_ID,AIM_FISCAL_RES, AIM_ID_TRIB_REG, AS400NUMBER) VALUES (''' 
		+ [Customer_Id]
		+ ''',''' + ISNULL([cf$_aim_id_trib_reg], '')
		+ ''',''' + ISNULL([cf$_aim_fiscal_res], '')
		+ ''',''' + [ClienteAS400]
		+  ''');'   aa
FROM ( SELECT CAST([Customer_Id] AS VARCHAR)	[Customer_Id]
	  ,[cf$_aim_fiscal_res]
	  ,[cf$_aim_id_trib_reg]
	  ,[ClienteAS400]
	  FROM [IFSDEV-ManualUpload].[dbo].[RFC-customersCF$]) aaa   

-------
SELECT 'INSERT INTO MTK_CUSTOMER_AIM_TAB (CUSTOMER_ID,CF$_AIM_FISCAL_RES, CF$_AIM_ID_TRIB_REG, CF$_AS400NUMBER, CORPORATE_FORM) VALUES (''' 
		|| Customer_Id
		|| ''',''' || NVL(CF$_AIM_FISCAL_RES, '')
		|| ''',''' || NVL(CF$_AIM_ID_TRIB_REG, '')
		|| ''',''' || NVL(CF$_AS400NUMBER, '')
		|| ''',''' || NVL(CORPORATE_FORM, '')
		||  ''');'   aa
FROM ( SELECT Customer_Id
	  ,CF$_AIM_FISCAL_RES
	  ,CF$_AIM_ID_TRIB_REG
	  ,CF$_AS400NUMBER
	  ,CORPORATE_FORM
FROM CUSTOMER_INFO_CFV
WHERE CF$_AIM_FISCAL_RES IS NOT NULL) aaa    
  
----Update Serial Object CustomFields
DECLARE   
   CURSOR get_qaman IS
      SELECT
         qcp.objid,
         qcp.objversion,
         qcpa.AIM_FISCAL_RES,   
         qcpa.AIM_ID_TRIB_REG,
         qcpa.AS400NUMBER, 
		 qcpa.CORPORATE_FORM		 
      FROM MTK_CUSTOMER_AIM_TAB qcpa
      INNER JOIN CUSTOMER_INFO_CFV qcp ON qcp.CUSTOMER_ID = qcpa.CUSTOMER_ID;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_cf_);
      Client_SYS.Clear_Attr(attr_);
      
      Client_SYS.Add_To_Attr('CF$_AIM_FISCAL_RES', row_.AIM_FISCAL_RES, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_ID_TRIB_REG', row_.AIM_ID_TRIB_REG, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AS400NUMBER', row_.AS400NUMBER, attr_cf_);
      
      --Client_SYS.Add_To_Attr('ASSOCIATION_NO', '', attr_);
	  Client_SYS.Add_To_Attr('CORPORATE_FORM', row_.CORPORATE_FORM, attr_);
      
      CUSTOMER_INFO_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      CUSTOMER_INFO_API.MODIFY__( info_, objid_, objversion_, attr_, 'DO' );
   END LOOP;   
END;

