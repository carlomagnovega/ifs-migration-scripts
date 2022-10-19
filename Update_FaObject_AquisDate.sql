DROP TABLE MTK_FAOBJECT_CF_TAB;

CREATE TABLE MTK_FAOBJECT_CF_TAB
(
   COMPANY                           VARCHAR2(6)         NOT NULL,   
   OBJECT_ID                            VARCHAR2(25)        NOT NULL,
   ACQUISITION_DATE                   VARCHAR2(50)        NULL
);


SELECT 'INSERT INTO MTK_FAOBJECT_CF_TAB (COMPANY, OBJECT_ID, ACQUISITION_DATE) VALUES (''' 
+ LTRIM(RTRIM([COMPANY])) 
+ ''',''' + ISNULL([OBJECT_ID], '') 
+ ''',''' + [ACQUISITION_DATE]
+  ''');' aaa  
FROM ( SELECT [COMPANY] 
	  ,[OBJECT_ID]
      ,convert(varchar(50), [ACQUISITION_DATE], 120) [ACQUISITION_DATE]
  FROM [dbo].[FaObjectMEX$] ipt) aa;


DECLARE   
   CURSOR get_qaman IS
      SELECT
         qcp.objid,
         qcpa.COMPANY,
         qcpa.OBJECT_ID,
			qcpa.ACQUISITION_DATE		
      FROM MTK_FAOBJECT_CF_TAB qcpa
      INNER JOIN FA_OBJECT qcp ON qcp.COMPANY = qcpa.COMPANY AND qcp.OBJECT_ID = qcpa.OBJECT_ID;
   
   
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
      Client_SYS.Add_To_Attr('CF$_AIM_AQUISITION_DATE', row_.ACQUISITION_DATE, attr_cf_);

      FA_OBJECT_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;   
END;   