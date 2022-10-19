DECLARE   
   CURSOR get_qaman IS
   SELECT mpa.objid,            
          mpa.objversion,
          ipt.CONTRACT,
          ipt.PART_NO,
          mpa.PROCESS_TYPE
   FROM MANUF_PART_ATTRIBUTE mpa
   INNER JOIN INVENTORY_PART ipt ON ipt.PART_NO = mpa.PART_NO AND ipt.CONTRACT = mpa.CONTRACT
   INNER JOIN PART_CATALOG pct ON pct.PART_NO = ipt.PART_NO
   WHERE mpa.PROCESS_TYPE IS NULL
   and ipt.TYPE_CODE_DB = (select INVENTORY_PART_TYPE_API.Encode('Manufactured') from dual)
   AND pct.lot_tracking_code_db = 'LOT TRACKING';  
   --AND ipt.PART_NO = '3903KG';   

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);  
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('PROCESS_TYPE', '10', attr_);      
      
      MANUF_PART_ATTRIBUTE_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;

----------------------------------Extrusion
DECLARE   
   CURSOR get_qaman IS
   SELECT mpa.objid,            
          mpa.objversion,
          ipt.CONTRACT,
          ipt.PART_NO,
          ipt.PLANNER_BUYER,
          pct.lot_tracking_code_db
   FROM MANUF_PART_ATTRIBUTE mpa
   INNER JOIN INVENTORY_PART ipt ON ipt.PART_NO = mpa.PART_NO AND ipt.CONTRACT = mpa.CONTRACT
   INNER JOIN PART_CATALOG pct ON pct.PART_NO = ipt.PART_NO
   WHERE ipt.PLANNER_BUYER LIKE 'EXTR%'
   AND mpa.LOT_BATCH_STRING IS NULL
   AND ipt.CONTRACT IN ('20MEX', '10MTL', '41POL', '40UK')
   AND pct.lot_tracking_code_db = 'LOT TRACKING';   

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);  
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('LOT_BATCH_STRING', 'EXT', attr_);      
      
      MANUF_PART_ATTRIBUTE_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;

--------------------------PASTE_SE 
DECLARE   
   CURSOR get_qaman IS
   SELECT b.objid,            
         b.objversion,
         a.CONTRACT,
         a.PART_NO,
		 a.PLANNER_BUYER,
         b.lot_batch_string
   FROM INVENTORY_PART a
   INNER JOIN MANUF_PART_ATTRIBUTE b ON a.CONTRACT = b.CONTRACT AND a.PART_NO = b.PART_NO
   INNER JOIN PART_CATALOG pct ON pct.PART_NO = a.PART_NO
   WHERE a.CONTRACT IN ('20MEX', '10MTL', '41POL', '40UK') 
   and (a.PLANNER_BUYER like 'PASTE_SE%')
   AND pct.lot_tracking_code_db = 'LOT TRACKING'
   AND (b.lot_batch_string IS NULL OR b.lot_batch_string <> 'P');    

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('LOT_BATCH_STRING', 'P', attr_);
      MANUF_PART_ATTRIBUTE_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;

--------------------------PASTE_FG 
DECLARE   
   CURSOR get_qaman IS
   SELECT b.objid,            
         b.objversion,
         a.CONTRACT,
         a.PART_NO,
		 a.PLANNER_BUYER,
         b.lot_batch_string
   FROM INVENTORY_PART a
   INNER JOIN MANUF_PART_ATTRIBUTE b ON a.CONTRACT = b.CONTRACT AND a.PART_NO = b.PART_NO
   INNER JOIN PART_CATALOG pct ON pct.PART_NO = a.PART_NO
   WHERE a.CONTRACT IN ('20MEX', '10MTL', '41POL', '40UK') 
   and (a.PLANNER_BUYER like 'PASTE_FG%')
   AND pct.lot_tracking_code_db = 'LOT TRACKING'
   AND (b.lot_batch_string IS NULL OR b.lot_batch_string <> 'PAS');    

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('LOT_BATCH_STRING', 'PAS', attr_);
      MANUF_PART_ATTRIBUTE_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;


--------------Flux
DECLARE   
   CURSOR get_qaman IS
   SELECT b.objid,            
         b.objversion,
         a.CONTRACT,
         a.PART_NO,
		 a.PLANNER_BUYER,
         b.lot_batch_string
   FROM INVENTORY_PART a
   INNER JOIN MANUF_PART_ATTRIBUTE b ON a.CONTRACT = b.CONTRACT AND a.PART_NO = b.PART_NO
   INNER JOIN PART_CATALOG pct ON pct.PART_NO = a.PART_NO
   WHERE a.CONTRACT IN ('20MEX', '10MTL', '41POL', '40UK')
   and (a.PLANNER_BUYER like 'FLUX_SE%')
   AND pct.lot_tracking_code_db = 'LOT TRACKING'
   AND (b.lot_batch_string IS NULL OR b.lot_batch_string <> 'FLU');

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('LOT_BATCH_STRING', 'FLU', attr_);
      MANUF_PART_ATTRIBUTE_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;


---------MEDIUM FG
DECLARE   
   CURSOR get_qaman IS
   SELECT b.objid,            
         b.objversion,
         a.CONTRACT,
         a.PART_NO,
		 a.PLANNER_BUYER,
         b.lot_batch_string
   FROM INVENTORY_PART a
   INNER JOIN MANUF_PART_ATTRIBUTE b ON a.CONTRACT = b.CONTRACT AND a.PART_NO = b.PART_NO
   INNER JOIN PART_CATALOG pct ON pct.PART_NO = a.PART_NO
   WHERE a.CONTRACT IN ('20MEX', '10MTL', '41POL', '40UK') 
   and (a.PLANNER_BUYER like 'MEDIUM_FG%')
   AND pct.lot_tracking_code_db = 'LOT TRACKING'
   AND (b.lot_batch_string IS NULL OR b.lot_batch_string <> 'MED');   

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);  
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('LOT_BATCH_STRING', 'MED', attr_);
      MANUF_PART_ATTRIBUTE_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;

-------MEDIUM MEDIUM_SE-FG_MX
DECLARE   
   CURSOR get_qaman IS
   SELECT b.objid,            
         b.objversion,
         a.CONTRACT,
         a.PART_NO,
		 a.PLANNER_BUYER,
         b.lot_batch_string
   FROM INVENTORY_PART a
   INNER JOIN MANUF_PART_ATTRIBUTE b ON a.CONTRACT = b.CONTRACT AND a.PART_NO = b.PART_NO
   INNER JOIN PART_CATALOG pct ON pct.PART_NO = a.PART_NO
   WHERE a.CONTRACT IN ('20MEX', '10MTL', '41POL', '40UK') 
   and (a.PLANNER_BUYER like 'MEDIUM_SE%')
   AND pct.lot_tracking_code_db = 'LOT TRACKING'
   AND (b.lot_batch_string IS NULL OR b.lot_batch_string <> 'M');

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);  
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('LOT_BATCH_STRING', 'M', attr_);
      MANUF_PART_ATTRIBUTE_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;

------CASTING
DECLARE   
   CURSOR get_qaman IS
   SELECT b.objid,            
         b.objversion,
         a.CONTRACT,
         a.PART_NO,
		 a.PLANNER_BUYER,
         b.lot_batch_string
   FROM INVENTORY_PART a
   INNER JOIN MANUF_PART_ATTRIBUTE b ON a.CONTRACT = b.CONTRACT AND a.PART_NO = b.PART_NO
   INNER JOIN PART_CATALOG pct ON pct.PART_NO = a.PART_NO
   WHERE a.CONTRACT IN ('20MEX', '10MTL', '41POL', '40UK')
   and (a.PLANNER_BUYER like 'CASTING_FG%')
   AND pct.lot_tracking_code_db = 'LOT TRACKING'
   AND (b.lot_batch_string IS NULL OR b.lot_batch_string <> 'CAS');

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('LOT_BATCH_STRING', 'CAS', attr_);
      MANUF_PART_ATTRIBUTE_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;