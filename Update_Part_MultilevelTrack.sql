DECLARE   
   CURSOR get_qaman IS
      SELECT PART_NO,
             qcp.objid, qcp.objversion
      FROM PART_CATALOG qcp
      WHERE MULTILEVEL_TRACKING_DB <> 'TRACKING_OFF';      
   
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
      Client_SYS.Add_To_Attr('MULTILEVEL_TRACKING_DB', 'TRACKING_OFF', attr_);
      
      PART_CATALOG_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;
   
END;