DECLARE   
   CURSOR get_qaman IS
      SELECT b.objid,
             b.objversion
      FROM INVENTORY_PART a
      INNER JOIN INVENTORY_PART_PLANNING b ON a.CONTRACT = b.CONTRACT AND a.PART_NO = b.PART_NO
      WHERE a.CONTRACT = '21BRA' AND a.PART_NO NOT LIKE 'M%';
   
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
      Client_SYS.Add_To_Attr('PLANNING_METHOD', 'G', attr_);
      Client_SYS.Add_To_Attr('MAXWEEK_SUPPLY', '90', attr_);
 
      INVENTORY_PART_PLANNING_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');           
   END LOOP;   
END;

DECLARE   
   CURSOR get_qaman IS
      SELECT b.objid,
             b.objversion
      FROM INVENTORY_PART a
      INNER JOIN MANUF_PART_ATTRIBUTE b ON a.CONTRACT = b.CONTRACT AND a.PART_NO = b.PART_NO
      WHERE a.CONTRACT = '21BRA' AND a.PART_NO NOT LIKE 'M%';
   
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
      Client_SYS.Add_To_Attr('BACKFLUSH_PART', 'Only Floor Stock', attr_);
      
      MANUF_PART_ATTRIBUTE_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');  
      COMMIT;
   END LOOP;   
END;