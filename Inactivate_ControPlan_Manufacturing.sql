DECLARE   
   CURSOR get_qaman IS
      SELECT OBJID, 
             OBJVERSION, 
             CONTROL_PLAN_NO, 
             CTRL_PLAN_REVISION_NO,
             objstate
      FROM QMAN_CONTROL_PLAN_MANUF 
      WHERE objstate = 'Active';   
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(info_);
      Client_SYS.Clear_Attr(attr_);
      objid_ := row_.OBJID;
      objversion_ := row_.OBJVERSION;
      QMAN_CONTROL_PLAN_MANUF_API.INACTIVATE__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;