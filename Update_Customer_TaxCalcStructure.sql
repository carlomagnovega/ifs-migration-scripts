DECLARE   
   CURSOR get_DELIVERY_FEE_CODE IS
      SELECT d.objid,
             d.objversion
      FROM CUSTOMER_INFO_ADDRESS a
      INNER JOIN CUSTOMER_TAX_INFO b ON a.customer_id = b.customer_id AND a.address_id = b.address_id AND b.company = '10-MTL'
      INNER JOIN CUSTOMER_DELIVERY_TAX_INFO c ON b.customer_id = c.customer_id AND b.address_id = c.address_id AND b.company = c.company
      INNER JOIN CUSTOMER_DELIVERY_FEE_CODE d ON d.customer_id = c.customer_id AND d.address_id = c.address_id AND d.company = c.company --AND d.supply_country = c.supply_country
      WHERE a.state = 'QC';
      --AND d.customer_id = '2019'; 
   
   CURSOR get_DELIVERY_TAX_INFO IS
      SELECT c.objid,
             c.objversion
      FROM CUSTOMER_INFO_ADDRESS a
      INNER JOIN CUSTOMER_TAX_INFO b ON a.customer_id = b.customer_id AND a.address_id = b.address_id AND b.company = '10-MTL'
      INNER JOIN CUSTOMER_DELIVERY_TAX_INFO c ON b.customer_id = c.customer_id AND b.address_id = c.address_id AND b.company = c.company
      WHERE a.state = 'QC';
      --AND a.customer_id = '2019'; 
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_DELIVERY_FEE_CODE LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      CUSTOMER_DELIVERY_FEE_CODE_API.REMOVE__(info_, objid_, objversion_, 'DO');      
   END LOOP;   
   
   FOR row_ IN get_DELIVERY_TAX_INFO LOOP
      info_ := '';
      objid_ := row_.objid;
      objversion_ := row_.objversion;  
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('TAX_CALC_STRUCTURE_ID', '1', attr_);       
      
      CUSTOMER_DELIVERY_TAX_INFO_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');      
   END LOOP;    
END;