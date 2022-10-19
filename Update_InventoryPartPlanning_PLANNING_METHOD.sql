DECLARE   
   CURSOR get_qaman IS
      SELECT b.objid,            
             b.objversion,
             a.CONTRACT,
             a.PART_NO,
             b.planning_method,
             b.MAXWEEK_SUPPLY
      FROM INVENTORY_PART a
      INNER JOIN INVENTORY_PART_PLANNING b ON a.PART_NO = b.PART_NO AND a.CONTRACT = b.CONTRACT
      WHERE a.CONTRACT = '20MEX'
      AND a.TYPE_CODE_DB = 1
      AND b.planning_method <> 'G'
      AND b.MAXWEEK_SUPPLY > 0;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('PLANNING_METHOD', 'G', attr_);
      
      INVENTORY_PART_PLANNING_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;
---------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT b.objid,            
             b.objversion,
             a.CONTRACT,
             a.PART_NO,
             b.planning_method,
             b.SAFETY_STOCK_AUTO_DB,
             b.lot_size_auto_db,
             b.order_point_qty_auto_db,
             b.planning_method_auto_db
      FROM INVENTORY_PART a
      INNER JOIN INVENTORY_PART_PLANNING b ON a.PART_NO = b.PART_NO AND a.CONTRACT = b.CONTRACT
      WHERE  b.planning_method IN ('G','M','P')
      AND (b.SAFETY_STOCK_AUTO_DB <> 'N' OR b.lot_size_auto_db <> 'N'OR b.order_point_qty_auto_db <> 'N');
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('SAFETY_STOCK_AUTO_DB', 'N', attr_);
      Client_SYS.Add_To_Attr('LOT_SIZE_AUTO_DB', 'N', attr_);
      Client_SYS.Add_To_Attr('ORDER_POINT_QTY_AUTO_DB', 'N', attr_); 
      
      INVENTORY_PART_PLANNING_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;


---------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT b.objid,            
             b.objversion,
             a.CONTRACT,
             a.PART_NO,
             b.planning_method,
             b.SAFETY_STOCK_AUTO_DB,
             b.lot_size_auto_db,
             b.order_point_qty_auto_db,
             b.planning_method_auto_db
      FROM INVENTORY_PART a
      INNER JOIN INVENTORY_PART_PLANNING b ON a.PART_NO = b.PART_NO AND a.CONTRACT = b.CONTRACT
      WHERE  b.planning_method IN ('B','A')
      AND (b.SAFETY_STOCK_AUTO_DB <> 'N' OR b.lot_size_auto_db <> 'N'OR b.order_point_qty_auto_db <> 'N' OR PLANNING_METHOD_AUTO_DB <>'FALSE');
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('SAFETY_STOCK_AUTO_DB', 'N', attr_);
      Client_SYS.Add_To_Attr('LOT_SIZE_AUTO_DB', 'N', attr_);
      Client_SYS.Add_To_Attr('ORDER_POINT_QTY_AUTO_DB', 'N', attr_); 
      Client_SYS.Add_To_Attr('PLANNING_METHOD_AUTO_DB', 'FALSE', attr_); 
      
      INVENTORY_PART_PLANNING_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;
