DROP TABLE MTK_CUST_ORD_CUSTOMER_TAB;

CREATE TABLE MTK_CUST_ORD_CUSTOMER_TAB
(
   CUSTOMER_ID                        VARCHAR2(20)        NOT NULL,
   ADDRESS_ID                         VARCHAR2(50)        NOT NULL,
   COUNTRY                            VARCHAR2(20)         NOT NULL,
   ADDRESS1                           VARCHAR2(35)        NULL,
   ADDRESS2                           VARCHAR2(35)        NULL,
   ZIP_CODE                           VARCHAR2(35)        NULL,
   CITY                               VARCHAR2(35)        NULL,
   STATE                              VARCHAR2(35)        NULL
);

  
  
SELECT 'INSERT INTO MTK_CUST_ORD_CUSTOMER_TAB (CUSTOMER_ID, ADDRESS_ID, COUNTRY, ADDRESS1, ADDRESS2, ZIP_CODE, CITY, STATE) VALUES (''' 
		+ [CUSTOMER_NO]
		+ ''',''' + [ADDRESS_ID]
		+ ''',''' + [COUNTRY]
		+ ''',''' + [ADDRESS1]
		+ ''',''' + [ADDRESS2]
		+ ''',''' + [ZIP_CODE]
		+ ''',''' + [CITY]
		+ ''',''' + [STATE]
		+  ''');'   aa
FROM ( SELECT [CUSTOMER_NO]
			  ,[ADDRESS_ID]     
			  ,CASE WHEN [COUNTRY] = 'USA' THEN 'UNITED STATES'
			        WHEN [COUNTRY] = 'BRASIL' THEN 'BRAZIL'
					ELSE [COUNTRY] END [COUNTRY]
			  ,[ADDRESS1]    
			  ,case when [ADDRESS2] is null then '' else [ADDRESS2]  END [ADDRESS2]    
			  ,[ZIP_CODE]    
			  ,[CITY]      
			  ,[STATE]      
	  FROM [IFSDEV-ManualUpload].[dbo].[CustomerInfoAddCorrection$]) aaa   


--Update Customer/MarketCode
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcp.objid,
              qcp.objversion,
              qcpa.ADDRESS1,
              qcpa.ADDRESS2,
              qcpa.ZIP_CODE,
              qcpa.STATE,
              qcpa.CITY,              
              qcpa.COUNTRY
      FROM MTK_CUST_ORD_CUSTOMER_TAB qcpa
      INNER JOIN CUSTOMER_INFO_ADDRESS qcp ON qcp.CUSTOMER_ID  = qcpa.CUSTOMER_ID AND qcp.ADDRESS_ID  = qcpa.ADDRESS_ID;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('COUNTRY', row_.COUNTRY, attr_);
      Client_SYS.Add_To_Attr('ADDRESS1', row_.ADDRESS1, attr_);
      Client_SYS.Add_To_Attr('ADDRESS2', row_.ADDRESS2, attr_);
      Client_SYS.Add_To_Attr('ZIP_CODE', row_.ZIP_CODE, attr_);
      Client_SYS.Add_To_Attr('STATE', row_.STATE, attr_);
      Client_SYS.Add_To_Attr('CITY', row_.CITY, attr_);	  
	  
      CUSTOMER_INFO_ADDRESS_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;  


--------------------------Altering COMPANY_NAME2
DROP TABLE MTK_CUST_ORD_CUSTOMER_TAB;

CREATE TABLE MTK_CUST_ORD_CUSTOMER_TAB
(
   CUSTOMER_ID                        VARCHAR2(20)        NOT NULL,
   ADDRESS_ID                         VARCHAR2(50)        NOT NULL,
   COMPANY_NAME2                      VARCHAR2(100)       NOT NULL,
);

  
SELECT 'INSERT INTO MTK_CUST_ORD_CUSTOMER_TAB (CUSTOMER_ID, ADDRESS_ID, COMPANY_NAME2) VALUES (''' 
		+ [CUSTOMER_NO]
		+ ''',''' + [ADDRESS_ID]
		+ ''',''' + [COMPANY_NAME2]
		+  ''');'   aa
FROM ( SELECT [Customer_Id] [CUSTOMER_NO]
			  ,[ADDRESS_ID]     
			  ,[name] [COMPANY_NAME2]    
	  FROM [IFSDEV-ManualUpload].[dbo].[CustomerInfoAddMX$]) aaa  

--Update Customer/MarketCode
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcp.objid,
              qcp.objversion,
              qcpa.COMPANY_NAME2
      FROM MTK_CUST_ORD_CUSTOMER_TAB qcpa
      INNER JOIN CUST_ORD_CUSTOMER_ADDRESS qcp ON qcp.customer_no  = qcpa.CUSTOMER_ID AND qcp.addr_no  = qcpa.ADDRESS_ID;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('COMPANY_NAME2', row_.COMPANY_NAME2, attr_);
	  
      CUST_ORD_CUSTOMER_ADDRESS_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;

--------------------------Altering Custom Fiedlds	  
DROP TABLE MTK_CUST_ORD_CUSTOMER_TAB;

CREATE TABLE MTK_CUST_ORD_CUSTOMER_TAB
(
   CUSTOMER_ID                        VARCHAR2(20)        NOT NULL,
   ADDRESS_ID                         VARCHAR2(50)        NOT NULL,
   CF$_AIM_ECALLE                     VARCHAR2(100)       NULL,
   CF$_AIM_ECOLONIA                   VARCHAR2(100)       NULL,
   CF$_AIM_EESTADO                    VARCHAR2(100)       NULL,
   CF$_AIM_ELOCALIDAD                 VARCHAR2(100)       NULL,
   CF$_AIM_EMUNICIPIO                 VARCHAR2(100)       NULL,
   CF$_AIM_ENOEXT                     VARCHAR2(100)       NULL,
   CF$_AIM_ENOINT                     VARCHAR2(100)       NULL,
   CF$_AIM_EPAIS                      VARCHAR2(100)       NULL,
   CF$_AIM_EZIPCODE                   VARCHAR2(100)       NULL,
   CF$_AIM_EXPORT_DB                  VARCHAR2(20)        NULL,
   CF$_AIM_EVIRTUALINV_DB                VARCHAR2(20)     NULL,
   CF$_AIM_ELEYENDAFISC               VARCHAR2(100)       NULL
);

  
SELECT 'INSERT INTO MTK_CUST_ORD_CUSTOMER_TAB (CUSTOMER_ID,ADDRESS_ID,CF$_AIM_ECALLE,CF$_AIM_ECOLONIA,CF$_AIM_EESTADO,CF$_AIM_ELOCALIDAD,CF$_AIM_EMUNICIPIO,CF$_AIM_ENOEXT,CF$_AIM_ENOINT,CF$_AIM_EPAIS,CF$_AIM_EZIPCODE,CF$_AIM_EXPORT) VALUES (''' 
		+ [CUSTOMER_NO]
		+ ''',''' + [ADDRESS_ID]
		+ ''',''' + ISNULL([Cf$_Aim_Ecalle], '')
		+ ''',''' + ISNULL([Cf$_Aim_Ecolonia], '')
		+ ''',''' + ISNULL([Cf$_Aim_Eestado], '')
		+ ''',''' + ISNULL([Cf$_Aim_Elocalidad], '')
		+ ''',''' + ISNULL([Cf$_Aim_Emunicipio], '')
		+ ''',''' + ISNULL([Cf$_Aim_Enoext], '')
		+ ''',''' + ISNULL([cf$_AIM_ENOINT], '')
		+ ''',''' + ISNULL([Cf$_Aim_Epais], '')
		+ ''',''' + ISNULL([Cf$_Aim_Ezipcode], '')
		+ ''',''' + ISNULL([Cf$_Aim_Export], '')
		+  ''');'   aa
FROM ( SELECT [Customer_Id] [CUSTOMER_NO]
			  ,[ADDRESS_ID]     
			  ,[Cf$_Aim_Ecalle]   
			  ,[Cf$_Aim_Ecolonia]      
			  ,[Cf$_Aim_Eestado]
			  ,[Cf$_Aim_Elocalidad]
			  ,[Cf$_Aim_Emunicipio]
			  ,[Cf$_Aim_Enoext]
			  ,'' [cf$_AIM_ENOINT]
			  ,[Cf$_Aim_Epais]
			  ,[Cf$_Aim_Ezipcode]
			  ,[Cf$_Aim_Export]
	  FROM [IFSDEV-ManualUpload].[dbo].[CustomersMX$]) aaa   
	  
--
SELECT 'INSERT INTO MTK_CUST_ORD_CUSTOMER_TAB (CUSTOMER_ID,ADDRESS_ID,CF$_AIM_ECALLE,CF$_AIM_ECOLONIA,CF$_AIM_EESTADO,CF$_AIM_ELOCALIDAD,CF$_AIM_EMUNICIPIO,CF$_AIM_ENOEXT,CF$_AIM_ENOINT,CF$_AIM_EPAIS,CF$_AIM_EZIPCODE,CF$_AIM_EXPORT_DB,CF$_AIM_EVIRTUALINV_DB,CF$_AIM_ELEYENDAFISC) VALUES (''' 
		|| CUSTOMER_id
		|| ''',''' || ADDRESS_ID
		|| ''',''' || NVL(Cf$_Aim_Ecalle, '')
		|| ''',''' || NVL(Cf$_Aim_Ecolonia, '')
		|| ''',''' || NVL(Cf$_Aim_Eestado, '')
		|| ''',''' || NVL(Cf$_Aim_Elocalidad, '')
		|| ''',''' || NVL(Cf$_Aim_Emunicipio, '')
		|| ''',''' || NVL(Cf$_Aim_Enoext, '')
		|| ''',''' || NVL(cf$_AIM_ENOINT, '')
		|| ''',''' || NVL(Cf$_Aim_Epais, '')
		|| ''',''' || NVL(Cf$_Aim_Ezipcode, '')
		|| ''',''' || NVL(Cf$_Aim_Export_DB, '')
		|| ''',''' || NVL(CF$_AIM_EVIRTUALINV_DB, '')
		|| ''',''' || NVL(CF$_AIM_ELEYENDAFISC, '')
		||  ''');'   aa
FROM ( SELECT Customer_Id
			  ,ADDRESS_ID     
			  ,Cf$_Aim_Ecalle   
			  ,Cf$_Aim_Ecolonia     
			  ,Cf$_Aim_Eestado
			  ,Cf$_Aim_Elocalidad
			  ,Cf$_Aim_Emunicipio
			  ,Cf$_Aim_Enoext
			  ,cf$_AIM_ENOINT
			  ,Cf$_Aim_Epais
			  ,Cf$_Aim_Ezipcode
           ,Cf$_Aim_Export_DB
           ,CF$_AIM_EVIRTUALINV_DB
           ,CF$_AIM_ELEYENDAFISC
FROM CUSTOMER_INFO_ADDRESS_CFV
WHERE Cf$_Aim_Ecalle IS NOT NULL) aaa    


--Update Customer/MarketCode
DECLARE   
   CURSOR get_qaman IS
      /*SELECT  qcp.objid,
              qcp.objversion,
              qcpa.CF$_AIM_ECALLE,
			  qcpa.CF$_AIM_ECOLONIA,
			  qcpa.CF$_AIM_EESTADO,
			  qcpa.CF$_AIM_ELOCALIDAD,
			  qcpa.CF$_AIM_EMUNICIPIO,
			  qcpa.CF$_AIM_ENOEXT,
			  qcpa.CF$_AIM_ENOINT,
			  qcpa.CF$_AIM_EPAIS,
			  qcpa.CF$_AIM_EZIPCODE,
			  qcpa.CF$_AIM_EXPORT_DB,
			  qcpa.CF$_AIM_EVIRTUALINV_DB,
			  qcpa.CF$_AIM_ELEYENDAFISC
      FROM MTK_CUST_ORD_CUSTOMER_TAB qcpa
      INNER JOIN CUSTOMER_INFO_ADDRESS qcp ON qcp.CUSTOMER_ID  = qcpa.CUSTOMER_ID AND qcp.ADDRESS_ID  = qcpa.ADDRESS_ID;*/
   SELECT  
         b.objid,
         b.objversion,
         a.CF$_AIM_ECALLE,
         a.CF$_AIM_ECOLONIA,
         a.CF$_AIM_EESTADO,
         a.CF$_AIM_ELOCALIDAD,
         a.CF$_AIM_EMUNICIPIO,
         a.CF$_AIM_ENOEXT,
         a.CF$_AIM_ENOINT,
         a.CF$_AIM_EPAIS,
         a.CF$_AIM_EZIPCODE,
         a.CF$_AIM_EXPORT_DB,
         a.CF$_AIM_EVIRTUALINV_DB,
         a.CF$_AIM_ELEYENDAFISC
      FROM CUSTOMER_INFO_ADDRESS_CFV a
      INNER JOIN CUSTOMER_INFO_ADDRESS b ON b.CUSTOMER_ID  = a.CUSTOMER_ID AND b.ADDRESS_ID <> 'MAIN'
      WHERE a.CF$_AIM_ECALLE IS NOT NULL
      AND a.ADDRESS_ID = 'MAIN';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
   attr_cf_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_cf_);
      Client_SYS.Clear_Attr(attr_);
      
      Client_SYS.Add_To_Attr('CF$_AIM_ECALLE', row_.CF$_AIM_ECALLE, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_ECOLONIA', row_.CF$_AIM_ECOLONIA, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_EESTADO', row_.CF$_AIM_EESTADO, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_ELOCALIDAD', row_.CF$_AIM_ELOCALIDAD, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_EMUNICIPIO', row_.CF$_AIM_EMUNICIPIO, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_ENOEXT', row_.CF$_AIM_ENOEXT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_ENOINT', row_.CF$_AIM_ENOINT, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_EPAIS', row_.CF$_AIM_EPAIS, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_EZIPCODE', row_.CF$_AIM_EZIPCODE, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_AIM_EXPORT_DB',row_.CF$_AIM_EXPORT_DB, attr_cf_);      
      Client_SYS.Add_To_Attr('CF$_AIM_EVIRTUALINV_DB',row_.CF$_AIM_EVIRTUALINV_DB, attr_cf_);      
      Client_SYS.Add_To_Attr('CF$_AIM_ELEYENDAFISC',row_.CF$_AIM_ELEYENDAFISC, attr_cf_);   

      CUSTOMER_INFO_ADDRESS_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END; 


----------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT aa.CUSTOMER_ID,
             aa.ADDRESS_ID,
             bb.objid,
             bb.objversion 
      FROM CUSTOMER_INFO_ADDRESS aa
      inner join CUSTOMER_INFO_ADDRESS_TYPE bb ON aa.CUSTOMER_ID = bb.CUSTOMER_ID AND bb.ADDRESS_ID = aa.ADDRESS_ID 
      WHERE bb.ADDRESS_ID = 'MAIN' AND aa.PARTY_TYPE_DB = 'CUSTOMER'
      AND EXISTS ( SELECT a.CUSTOMER_ID
         FROM CUSTOMER_INFO_ADDRESS a
         left join CUSTOMER_INFO_ADDRESS_TYPE b ON a.CUSTOMER_ID = b.CUSTOMER_ID AND upper(b.def_address) = 'TRUE'
         WHERE a.PARTY_TYPE_DB = 'CUSTOMER'
         AND b.CUSTOMER_ID IS NULL
         AND a.CUSTOMER_ID = aa.CUSTOMER_ID
      GROUP BY a.CUSTOMER_ID) 
      ORDER BY bb.objid, bb.objversion;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('DEF_ADDRESS', 'TRUE', attr_);
      CUSTOMER_INFO_ADDRESS_TYPE_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;