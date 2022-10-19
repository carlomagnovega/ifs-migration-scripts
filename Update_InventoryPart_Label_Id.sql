DROP TABLE MTK_INVENTORY_PART_CF_TAB;

CREATE TABLE MTK_INVENTORY_PART_CF_TAB
(
   PART_NO                            VARCHAR2(25)        NOT NULL,
   CONTRACT                           VARCHAR2(5)         NOT NULL,   
   AIM_LABEL_ID                       VARCHAR2(100)       NULL,
   AIM_LABEL_LAYOUT                   VARCHAR2(100)       NULL
);

  
----Update Inventory_Part CustomFields
DECLARE   
   CURSOR get_qaman IS
      SELECT
            qcp.objid,
            qcpa.AIM_LABEL_ID,
			qcpa.AIM_LABEL_LAYOUT
      FROM MTK_INVENTORY_PART_CF_TAB qcpa
      INNER JOIN Inventory_Part_CFV qcp ON qcp.PART_NO = qcpa.PART_NO AND qcp.CONTRACT = qcpa.CONTRACT;
   
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
      Client_SYS.Add_To_Attr('CF$_AIM_LABEL_ID', row_.AIM_LABEL_ID, attr_cf_);
      Client_SYS.Add_To_Attr('CF$_LABEL_LAYOUT', row_.AIM_LABEL_LAYOUT, attr_cf_);

      INVENTORY_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;
   
END;

-----------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT
            qcp.objid,
            qcp.CF$_LABEL_DATE_FORMAT_DB,
            qcp.CF$_LABEL_LAYOUT
      FROM Inventory_Part_CFV qcp 
      WHERE qcp.PART_NO IN ('6363','18018','18019','18020','18021','18022','18023','18024','18029','18033','18034','18035','18038','18042','18043','18045','18046','18052','18054','18055','18056','18068','18074','18075','18076','18077','18080','18081','18082','18083','18088','18090','18093','18097','18099','18100','18105','18106','18114','18122','18123','18140','18145','18146','18147','18148','18152','18155','18158','19000','19002','19003','19007','19009','19010','19011','19015','19024','19025','19026','19027','19028','19032','19036','19037','19039','19049','19050','19051','19052','19056','19061','19064','19069','19074','19079','19080','19081','19085','19091','19095','19096','19099','19105','19106','19107','19110','19115','19116','19117','19131','19135','19136','19139','19140','19141','19142','19144','19145','19149','19150','19151','19152','19153','19154','19155','19156','20001','20002','20003','20004','20005','20006','20008','20010','20011','20012','20013','20016','20028','20029','20030','20031','20032','20035','20036','20037','20038','20039','20040','20041','20042','20044','20046','20047','20048','20049','20053','20054','20056','20060','20061','20062','20063','20064','20065','20066','20067','20068','20070','20077','20084','20091','20098','20100','20103','20107','20108','20109','20110','20111','20113','20114','20117','20119','20121','20129','20139','20147','20148','20149','20150','20151','20158','20159','20160','20162','20163','20164','20165','20166','20167','20168','20169','20170','20171','20172','20175','20180','20181','20188','20189','20190','20198','20199','20201','20202','20204','20206','20210','20213','20215','20220','20221','20222','20223','20225','20228','20229','20230','20231','20232','20233','20234','20235','20236','20239','20240','20244','20245','20246','20247','20248','20249','20250','20251','20252','20253','20254','20257','20258','20259','20260','20264','20265','20266','20267','20268','20269','20270','20271','20272','20273','20274','20278','20279','20280','20290','20293','20294','20295','20297','20298','20300','20301','20302','20303','20306','20308','20309','20310','20314','20317','20324','20326','20330','20332','20335','20336','20337','20338','20339','20340','20341','20342','20343','20344','20346','20347','20348','20349','20350','20351','20352','20353','20354','20356','20357','20358','20359','20361','20362','20363','20364','20365','20369','20370','20371','20373','20374','20375','20376','20377','20380','20385','20386','20391','20392','20393','20394','20405','20407','20408','20415','20421','20422','20427','20428','20429','20435','20436','20437','20438','20439','20440','20442','20443','20446','20447','18100GAL','18105GAL','19136-100G','20100-C','20389GAL','20431GAL','20434GAL','20730-LB') 
      AND qcp.CONTRACT = '10MTL';
   
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
      Client_SYS.Add_To_Attr('CF$_LABEL_DATE_FORMAT_DB', 'LB2', attr_cf_);
      Client_SYS.Add_To_Attr('CF$_LABEL_LAYOUT', 'F4x4,F4x4O', attr_cf_);

      INVENTORY_PART_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;
   
END;


-----------------------Update InventoryPart/PartMaster Description con caracteres chinos
DROP TABLE MTK_INVENTORY_PART_CF_TAB;

CREATE TABLE MTK_INVENTORY_PART_CF_TAB
(
   PART_NO                            VARCHAR2(25)        NOT NULL,
   CONTRACT                           VARCHAR2(5)         NOT NULL,   
   DESCRIPTION                       VARCHAR2(200)       NULL
);
------
SELECT 'INSERT INTO MTK_INVENTORY_PART_CF_TAB (PART_NO,CONTRACT,DESCRIPTION) VALUES (''' 
+ LTRIM(RTRIM(PART_NO)) 
+ ''',''' + CONTRACT 
+ ''',''' + [DESCRIPTION] 
+  ''');'   aa
FROM ( SELECT  IFS_PART_NO	PART_NO  
	  ,[CONTRACT]				CONTRACT
	  ,[DESCRIPTION]
  FROM [IFSDEV-ManualUpload].[dbo].[InventoryPartCXspare$]
  where IFS_PART_NO IS NOT NULL) aa
-----  
DECLARE   
   CURSOR get_qaman IS
      SELECT a.PART_NO,
      --       a.contract,
             b.description,
             a.objid,            
             a.objversion
             --FROM  INVENTORY_PART a
      FROM  PART_CATALOG a
      INNER JOIN MTK_INVENTORY_PART_CF_TAB b ON b.PART_NO = a.PART_NO;  --AND b.contract = a.contract;
   
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
	  
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('DESCRIPTION', row_.DESCRIPTION, attr_);

      --INVENTORY_PART_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      PART_CATALOG_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;
   
END;
