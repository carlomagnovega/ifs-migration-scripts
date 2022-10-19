CREATE TABLE MTK_COMM_METHOD_AIM_TAB
(
   IDENTITY                           VARCHAR2(20)        NOT NULL,
   COMM_ID                            NUMBER              NOT NULL,
   VALUE                              VARCHAR2(200)       NOT NULL,
   DESCRIPTION                        VARCHAR2(200)       NULL,
   METHOD_DEFAULT                     VARCHAR2(5)         NULL,
   ADDRESS_DEFAULT                    VARCHAR2(5)         NULL,
   NAME                               VARCHAR2(100)       NULL,
   METHOD_ID                          VARCHAR2(20)        NOT NULL,
   ADDRESS_ID                         VARCHAR2(50)        NULL
)

------------------------
SELECT 'INSERT INTO MTK_COMM_METHOD_AIM_TAB (IDENTITY,COMM_ID,VALUE,DESCRIPTION,METHOD_DEFAULT,ADDRESS_DEFAULT,NAME,METHOD_ID,ADDRESS_ID) VALUES (''' 
		+ [IDENTITY]
		+ ''',''' + [COMM_ID]
		+ ''',''' + [VALUE]
		+ ''',''' + [DESCRIPTION]
		+ ''',''' + [METHOD_DEFAULT]
		+ ''',''' + [ADDRESS_DEFAULT]
		+ ''',''' + [NAME]
		+ ''',''' + [METHOD_ID]
		+ ''',''' + [ADDRESS_ID]
		+  ''');'   aa
FROM ( SELECT [CUSTOMER_ID] [IDENTITY]
			  ,[COMM_ID]
			  ,[VALUE]
			  ,CASE WHEN [DESCRIPTION] IS NULL THEN '-' ELSE [DESCRIPTION] END [DESCRIPTION]
			  ,[METHOD_DEFAULT]
			  ,[ADDRESS_DEFAULT]
			  ,[METHOD_ID]
			  ,[ADDRESS_ID]
			  ,CASE WHEN [NAME] IS NULL THEN '-' ELSE [NAME] END [NAME]     
	  FROM [IFSDEV-ManualUpload].[dbo].[CustomerInfoCommMethodUK$]
  WHERE [VALUE] IS NOT NULL) aaa   

---------------------------------------
DECLARE   
   CURSOR get_qaman IS
		SELECT  qcp.objid,
              qcp.objversion,
              qcp.IDENTITY,
              qcpa.DESCRIPTION,
              qcpa.METHOD_DEFAULT,
              qcpa.ADDRESS_DEFAULT
      FROM MTK_COMM_METHOD_AIM_TAB qcpa
      INNER JOIN COMM_METHOD qcp ON qcp.IDENTITY  = qcpa.IDENTITY 
      AND qcp.Name  = qcpa.Name
      AND qcp.VALUE  = qcpa.VALUE
      AND qcp.PARTY_TYPE_DB = 'CUSTOMER';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('DESCRIPTION', row_.DESCRIPTION, attr_);
      Client_SYS.Add_To_Attr('METHOD_DEFAULT', row_.METHOD_DEFAULT, attr_);
      Client_SYS.Add_To_Attr('ADDRESS_DEFAULT', row_.ADDRESS_DEFAULT, attr_);
	  
      COMM_METHOD_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;