------Create WorkCenterGroupPart

DROP TABLE MTK_WCG_INFO_CF_TAB;

CREATE TABLE MTK_WCG_INFO_CF_TAB
(
   
   CONTRACT 		VARCHAR2(5)        NOT NULL, 
   PART_NO  		VARCHAR2(25)       NOT NULL, 
   WORK_CENTER_GRP 	VARCHAR2(25)       NOT NULL, 
   WORK_CENTER_NO  	VARCHAR2(5)        NOT NULL 
);

-------------------------------------------------------
SELECT 'INSERT INTO MTK_WCG_INFO_CF_TAB (PART_NO,CONTRACT,WORK_CENTER_GRP,WORK_CENTER_NO) VALUES (''' 
	+ PART_NO 
	+ ''',''' + CONTRACT
	+ ''',''' + WORK_CENTER_GRP
	+ ''',''' + WORK_CENTER_NO
	+  ''');' aaa  
FROM (
  SELECT a.[PART_NO]				PART_NO
      ,a.[CONTRACT]				CONTRACT
      ,b.[Work center Group]	WORK_CENTER_GRP
      ,a.[DEFAULT WORK CENTER]	WORK_CENTER_NO
  FROM [IFSDEV-ManualUpload].[dbo].[WorkCenterGroupPart$] a
  LEFT JOIN [dbo].[AllWorkCenter$] b ON a.[DEFAULT WORK CENTER] = b.[Work_Center_No]
  WHERE a.[DEFAULT WORK CENTER] IS NOT NULL
UNION ALL
  SELECT a.[PART_NO]				PART_NO
      ,a.[CONTRACT]				CONTRACT
      ,b.[Work center Group]	WORK_CENTER_GRP
      ,a.[ALTERNATE WC 1]	WORK_CENTER_NO
  FROM [IFSDEV-ManualUpload].[dbo].[WorkCenterGroupPart$] a
  LEFT JOIN [dbo].[AllWorkCenter$] b ON a.[ALTERNATE WC 1] = b.[Work_Center_No]
  WHERE a.[ALTERNATE WC 1] IS NOT NULL
UNION ALL
  SELECT a.[PART_NO]				PART_NO
      ,a.[CONTRACT]				CONTRACT
      ,b.[Work center Group]	WORK_CENTER_GRP
      ,a.[ALTERNATE WC 2]	WORK_CENTER_NO
  FROM [IFSDEV-ManualUpload].[dbo].[WorkCenterGroupPart$] a
  LEFT JOIN [dbo].[AllWorkCenter$] b ON a.[ALTERNATE WC 2] = b.[Work_Center_No]
  WHERE a.[ALTERNATE WC 2] IS NOT NULL
UNION ALL
  SELECT a.[PART_NO]			PART_NO
      ,a.[CONTRACT]				CONTRACT
      ,b.[Work center Group]	WORK_CENTER_GRP
      ,a.[ALTERNATE WC 3]		WORK_CENTER_NO
  FROM [IFSDEV-ManualUpload].[dbo].[WorkCenterGroupPart$] a
  LEFT JOIN [dbo].[AllWorkCenter$] b ON a.[ALTERNATE WC 3] = b.[Work_Center_No]
  WHERE a.[ALTERNATE WC 3] IS NOT NULL
UNION ALL
  SELECT a.[PART_NO]			PART_NO
      ,a.[CONTRACT]				CONTRACT
      ,b.[Work center Group]	WORK_CENTER_GRP
      ,a.[ALTERNATE WC 4]		WORK_CENTER_NO
  FROM [IFSDEV-ManualUpload].[dbo].[WorkCenterGroupPart$] a
  LEFT JOIN [dbo].[AllWorkCenter$] b ON a.[ALTERNATE WC 4] = b.[Work_Center_No]
  WHERE a.[ALTERNATE WC 4] IS NOT NULL
UNION ALL
  SELECT a.[PART_NO]			PART_NO
      ,a.[CONTRACT]				CONTRACT
      ,b.[Work center Group]	WORK_CENTER_GRP
      ,a.[ALTERNATE WC 5]		WORK_CENTER_NO
  FROM [IFSDEV-ManualUpload].[dbo].[WorkCenterGroupPart$] a
  LEFT JOIN [dbo].[AllWorkCenter$] b ON a.[ALTERNATE WC 5] = b.[Work_Center_No]
  WHERE a.[ALTERNATE WC 5] IS NOT NULL
  ) aa
  

----Update WorkCenterGroupPart
DECLARE   
   CURSOR get_qaman IS
      SELECT
         a.CONTRACT,
         a.PART_NO,
         a.WORK_CENTER_GRP,
         a.WORK_CENTER_NO,
         min(b.LABOR_RUN_FACTOR) LABOR_RUN_FACTOR,
         min(b.LABOR_SETUP_TIME) LABOR_SETUP_TIME,
         min(b.MACH_RUN_FACTOR) MACH_RUN_FACTOR,
         min(b.MACH_SETUP_TIME) MACH_SETUP_TIME,
         min(b.CREW_SIZE) CREW_SIZE,
         min(b.SETUP_CREW_SIZE) SETUP_CREW_SIZE
      FROM MTK_WCG_INFO_CF_TAB a
      LEFT JOIN ROUTING_OPERATION b ON a.PART_NO = b.PART_NO AND b.CONTRACT = '10MTL'
      LEFT JOIN WORK_CENTER_GROUP_PARTS_CLV c ON c.CF$_CONTRACT = a.CONTRACT AND c.CF$_PART_NO = a.PART_NO
      WHERE c.CF$_PART_NO IS NULL
      GROUP BY a.CONTRACT,
         a.PART_NO,
         a.WORK_CENTER_GRP,
         a.WORK_CENTER_NO;
   
   info_                VARCHAR2(32000);
   objkey_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CF$_CONTRACT', row_.CONTRACT, attr_);
      Client_SYS.Add_To_Attr('CF$_PART_NO', row_.PART_NO, attr_);
      Client_SYS.Add_To_Attr('CF$_WORK_CENTER_GRP', row_.WORK_CENTER_GRP, attr_);
      Client_SYS.Add_To_Attr('CF$_WORK_CENTER_NO', row_.WORK_CENTER_NO, attr_);
	  
      Client_SYS.Add_To_Attr('CF$_LABOR_RUN_FACTOR', row_.LABOR_RUN_FACTOR, attr_);
      Client_SYS.Add_To_Attr('CF$_LABOR_SETUP_TIME', row_.LABOR_SETUP_TIME, attr_);
      Client_SYS.Add_To_Attr('CF$_MACH_RUN_FACTOR', row_.MACH_RUN_FACTOR, attr_);
      Client_SYS.Add_To_Attr('CF$_MACH_SETUP_TIME', row_.MACH_SETUP_TIME, attr_);
      Client_SYS.Add_To_Attr('CF$_CREW_SIZE', row_.CREW_SIZE, attr_);
      Client_SYS.Add_To_Attr('CF$_SETUP_CREW_SIZE', row_.SETUP_CREW_SIZE, attr_);

      WORK_CENTER_GROUP_PARTS_CLP.New__(info_, objkey_, objversion_, attr_, 'DO');
   END LOOP;   
END;      


-----CAST
DECLARE   
   CURSOR get_qaman IS
      SELECT
			a.CONTRACT,
			a.PART_NO,
			c.CF$_WORK_CENTER_GRP WORK_CENTER_GRP,
			c.CF$_WORK_CENTER_NO WORK_CENTER_NO,
			'150' LABOR_RUN_FACTOR,
			'0,5' LABOR_SETUP_TIME,
			'150' MACH_RUN_FACTOR,
			'0,5' MACH_SETUP_TIME,
			'1' CREW_SIZE,
			'1' SETUP_CREW_SIZE
	  FROM INVENTORY_PART a
	  inner JOIN WORK_CENTER_GROUP_LINES_CLV c ON c.CF$_CONTRACT = a.CONTRACT AND c.CF$_WORK_CENTER_GRP = 'CAST TL'
	  WHERE a.PART_NO IN ('1379','1208','1213-S10','1217-S1','1218-S1','1219','1220','1220-S2','1221-S2','1407-S1','1268','1280-S1','1281','11214-S20','11280','1329-S19','1364','1408-S95','1411-S95','1412','1412-S1','1416-S1','1430','1430-S95','1465-S2','84086','85013-S1','85020-S1','85025-S2','85025-S57','5736-S94','5747-S100','5749-S90','5750','5750-S34','5764','5766-S1','5769-S13','5772-S13','5815','5822','5822-S1','5823','5828','5830','5832','5833','5847','5848-S2','5850','5853','5878','5879','5881','5889-S98','5893','5895-S98','5897','5909-S2','5925-S2','5953-S98','5962-S30','5968','5977','5978-S39','5601','5604-S96','5652','5654','5655','5659','5664-S1','5670','5672-S1','5674','5676','5687-S2','5689-S2','5691-S2','5695-S1','5695-S2','5698-S2','5700-S1','5702-S1','5703-S1','17360','17361','3961','3961-S70','3964-S2','3964-S70','5704-S90','5707-S90','5726-S1','17362','3966-S2','3967-S2','3968-S70','3981-S70','3984-S70','4076-S70','17458','17545','17546','4825-S1','85056','5607-S1','5671-S1','85034-S52','85061-S45','85080-S14','87026-S2','87028-S1','87032-S2','87039-S31','87068','87068-S1','87088-S112','5823-S2','85028-S1','87020-S1','87048-S2','87055-S2','87046-S2','17544-S2','17360-S2','17546-S2','4825','5664','5687','85013')
	  AND a.CONTRACT = '20MEX';
	  
	  SELECT
            a.CONTRACT,
            a.PART_NO,
            c.CF$_WORK_CENTER_GRP WORK_CENTER_GRP,
            c.CF$_WORK_CENTER_NO WORK_CENTER_NO,
            '150' LABOR_RUN_FACTOR,
            '0,5' LABOR_SETUP_TIME,
            '150' MACH_RUN_FACTOR,
            '0,5' MACH_SETUP_TIME,
            '1' CREW_SIZE,
            '1' SETUP_CREW_SIZE
      FROM INVENTORY_PART a
      inner JOIN WORK_CENTER_GROUP_LINES_CLV c ON c.CF$_CONTRACT = a.CONTRACT AND c.CF$_WORK_CENTER_GRP = 'CAST LF'
      WHERE a.PART_NO IN ('1389','1229','1230-S1','1231-S10','1233-S2','1235','1291-S2','1241-S2','1324-S2','1336','1336-S2','1343','1343-S70','1344-S26','1374','1425-S95','1426-S95','1427-S14','1427-S2','1436-S1','1438','1438-S95','1439-S1','1441-S2','1445','1459-S92','84137','85005-S60','85006-S23','85010','85016','85017','85018-S91','85022-S23','85023-S23','85026','5728CCU','5729-S1','5733','5734-S92','5743-S1','5744-S34','5745-S1','5748-S2','5755-S2','5756-S2','5758-S2','5760-S1','5770-S1','5774-S44','5777-S1','5779-S2','5781-S18','5795','5796','5796-S34','5806','5808-S75','5814','5817','5825-S2','5831-S1','5836-S91','5838','5843','5844','5849','5849-S44','5855-S1','5859','5867','5869-S29','5871-S91','5882','5886-S35','5892-S10','5894-S63','5898','5931-S1','5931-S14','5951-S10','5959','5961-S43','5969','5969-S96','5983','5600-S2','5602-S2','5603-S2','5613-S2','5620-S91','5624','5631-S43','5653-S1','3611-S70','3612','5682-S1','3963-S14','3963-S70','3965-S70','5711-S44','5712-S2','5716-S2','5718-S96','5719-S2','5720-S2','5728-S1','17363','17365','3969-S70','4085-S70','17460','17509','17516','17534','17622','17623','17624','17625','17626','17628','17669','87112-S2','1232','85026-S2','85036-S43','85046-S2','85057-S1','85058','85058-S2','85059-S1','85060-S2','85062','85066','85066-S34','85070-S96','85079-S51','85084-S1','85084-S50','85086-S50','85087-S1','85088-S2','85090-S96','87019-S2','87024-S92','87030-S92','87031-S92','87033-S2','87036','87038','87043-S95','87058','87058-S2','87072-S1','87078','87078-S1','87078-S50','87081-S1','87081-S2','87111-S92','87120-S78','84137-S2','85031-S2','85058-S1','85062-S2','85097-S34','87045-S2','17509-S97','5774-S2','85104-S1','85105-S23','1374-S2','17516-S1','17534-S2','17538-S2','3612-S70','85106-S2','5795-S1','85107-S92','5600','5718','5825','5831','85036','5744')
      AND a.CONTRACT = '20MEX';
   
   info_                VARCHAR2(32000);
   objkey_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CF$_CONTRACT', row_.CONTRACT, attr_);
      Client_SYS.Add_To_Attr('CF$_PART_NO', row_.PART_NO, attr_);
      Client_SYS.Add_To_Attr('CF$_WORK_CENTER_GRP', row_.WORK_CENTER_GRP, attr_);
      Client_SYS.Add_To_Attr('CF$_WORK_CENTER_NO', row_.WORK_CENTER_NO, attr_);
      
      Client_SYS.Add_To_Attr('CF$_LABOR_RUN_FACTOR', row_.LABOR_RUN_FACTOR, attr_);
      Client_SYS.Add_To_Attr('CF$_LABOR_SETUP_TIME', row_.LABOR_SETUP_TIME, attr_);
      Client_SYS.Add_To_Attr('CF$_MACH_RUN_FACTOR', row_.MACH_RUN_FACTOR, attr_);
      Client_SYS.Add_To_Attr('CF$_MACH_SETUP_TIME', row_.MACH_SETUP_TIME, attr_);
      Client_SYS.Add_To_Attr('CF$_CREW_SIZE', row_.CREW_SIZE, attr_);
      Client_SYS.Add_To_Attr('CF$_SETUP_CREW_SIZE', row_.SETUP_CREW_SIZE, attr_);
      
      WORK_CENTER_GROUP_PARTS_CLP.New__(info_, objkey_, objversion_, attr_, 'DO');
   END LOOP;   
END; 


-----Extrusion Ribbon
DECLARE   
   CURSOR get_qaman IS
      SELECT
            a.CONTRACT,
            a.PART_NO,
            c.CF$_WORK_CENTER_GRP WORK_CENTER_GRP,
            c.CF$_WORK_CENTER_NO WORK_CENTER_NO,
            '60' LABOR_RUN_FACTOR,
            '1' LABOR_SETUP_TIME,
            '60' MACH_RUN_FACTOR,
            '1' MACH_SETUP_TIME,
            '1' CREW_SIZE,
            '1' SETUP_CREW_SIZE
      FROM INVENTORY_PART a
      inner JOIN WORK_CENTER_GROUP_LINES_CLV c ON c.CF$_CONTRACT = a.CONTRACT AND c.CF$_WORK_CENTER_GRP = 'Extrusion Ribbon'
      WHERE a.PART_NO IN ('6182-S39','6183','6184','6185','6186','6187','6188','6188-S24','6190','6191','6192','6192-S14','6193','6194','6195','6196','6197','6495','6495-S17','6498','6498-S17','6499','6499-S17','6102','6103','6104','6105','6106','6107','6108','7099','7099-S12','6109','6110','6110-S14','6111','6112','6113','6114','6116','6116-S14','6117','6118','6119','6121','6122','6124','83130-S85','6125','6126','6127','6131','6137','6138','6140','6140-S14','6143','6144','6145','6145-S14','6146','6158','6159','6166','6167','6169','6170','6171','6172','6173','6174','6175','6177','6179','6179-S14','6180','6181','6182','17312','17312-S3-EACH','86800-S85','86807-S14','86813','86814','86815','86816','86817','86818','86833-S24','86835','86837','86838-S14','86839-S14','86840','86841','86828','86842-S14','6108-S14')
      AND a.CONTRACT = '20MEX';
   
   info_                VARCHAR2(32000);
   objkey_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CF$_CONTRACT', row_.CONTRACT, attr_);
      Client_SYS.Add_To_Attr('CF$_PART_NO', row_.PART_NO, attr_);
      Client_SYS.Add_To_Attr('CF$_WORK_CENTER_GRP', row_.WORK_CENTER_GRP, attr_);
      Client_SYS.Add_To_Attr('CF$_WORK_CENTER_NO', row_.WORK_CENTER_NO, attr_);
      
      Client_SYS.Add_To_Attr('CF$_LABOR_RUN_FACTOR', row_.LABOR_RUN_FACTOR, attr_);
      Client_SYS.Add_To_Attr('CF$_LABOR_SETUP_TIME', row_.LABOR_SETUP_TIME, attr_);
      Client_SYS.Add_To_Attr('CF$_MACH_RUN_FACTOR', row_.MACH_RUN_FACTOR, attr_);
      Client_SYS.Add_To_Attr('CF$_MACH_SETUP_TIME', row_.MACH_SETUP_TIME, attr_);
      Client_SYS.Add_To_Attr('CF$_CREW_SIZE', row_.CREW_SIZE, attr_);
      Client_SYS.Add_To_Attr('CF$_SETUP_CREW_SIZE', row_.SETUP_CREW_SIZE, attr_);
      
      WORK_CENTER_GROUP_PARTS_CLP.New__(info_, objkey_, objversion_, attr_, 'DO');
   END LOOP;   
END; 