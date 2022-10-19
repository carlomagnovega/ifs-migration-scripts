DECLARE
   CURSOR c_SHIPMENT IS
      SELECT OBJID 
      FROM SHIPMENT_CFV
      WHERE CONTRACT = '11RI' 
      AND CF$_AIM_QUOTE_AMOUNT IS NOT NULL
      AND CF$_AIM_QUOTE_CURR IS NULL;   
   
   info_                 VARCHAR2(2000);
   objid_                VARCHAR2(32000);   
   attr_                 VARCHAR2(26000);    
   attr_cf_              VARCHAR2(26000);
   
   currency_key_         VARCHAR2(50);
BEGIN
   SELECT OBJKEY 
   INTO currency_key_
   FROM ISO_CURRENCY
   WHERE CURRENCY_CODE = 'USD';
   
   FOR cur_rec IN c_SHIPMENT LOOP
      objid_ := cur_rec.OBJID;
      Client_SYS.Clear_Attr(attr_cf_);
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CF$_AIM_QUOTE_CURR', currency_key_, attr_cf_);
      SHIPMENT_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;   
END;