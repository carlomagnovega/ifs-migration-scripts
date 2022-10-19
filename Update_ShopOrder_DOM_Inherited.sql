DECLARE   
   CURSOR get_mfstr IS
      select   objid,
               objversion,
               ORDER_NO, 
               RELEASE_NO, 
               SEQUENCE_NO, 
               CF$_HEAT_NO HEAT_NO,
               CF$_AIM_DOM_INHERIT
      from SHOP_ORD_CFV
      where SHOP_ORD_AIM_API.Is_Inherite_Wdr(Contract, Part_No) = 'TRUE';
      
   CURSOR get_dom(order_no_aux_ VARCHAR2, release_no_aux_ VARCHAR2, sequence_no_aux_ VARCHAR2, wdr_aux_ VARCHAR2) IS
      SELECT DOM
      FROM (SELECT SMAT.part_no,
                   SMAT.lot_batch_no,
                   SMAT.WAIV_DEV_REJ_NO,
                   lbm.manufactured_date DOM
            FROM SHOP_MATERIAL_ASSIGN SMAT
            INNER JOIN INVENTORY_PART_IN_STOCK_CFV IPIS ON 
            IPIS.PART_NO = SMAT.PART_NO AND
            IPIS.CONTRACT = SMAT.CONTRACT AND
            IPIS.CONFIGURATION_ID = SMAT.CONFIGURATION_ID AND
            IPIS.LOCATION_NO = SMAT.LOCATION_NO AND
            IPIS.LOT_BATCH_NO = SMAT.LOT_BATCH_NO AND
            IPIS.SERIAL_NO = SMAT.SERIAL_NO AND
            IPIS.ENG_CHG_LEVEL = SMAT.ENG_CHG_LEVEL AND
            IPIS.WAIV_DEV_REJ_NO  = SMAT.WAIV_DEV_REJ_NO AND
            IPIS.ACTIVITY_SEQ = SMAT.ACTIVITY_SEQ
            INNER JOIN LOT_BATCH_MASTER lbm ON lbm.PART_NO = SMAT.PART_NO AND lbm.LOT_BATCH_NO = SMAT.LOT_BATCH_NO AND lbm.ORDER_TYPE_DB = 'SHOP ORDER'
            WHERE SMAT.order_no = order_no_aux_
            AND SMAT.release_no = release_no_aux_
            AND SMAT.sequence_no = sequence_no_aux_
            AND SMAT.WAIV_DEV_REJ_NO = wdr_aux_
            AND INVENTORY_PART_API.Get_Part_Product_Family(IPIS.CONTRACT, IPIS.PART_NO) <> '12'
            ORDER BY NVL(IPIS.CF$_AIM_OVERWRITE_LOT_DB, 'FALSE') DESC, SMAT.qty_issued DESC, SMAT.qty_assigned DESC) AA
            WHERE ROWNUM  = 1;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
   dom_                 DATE;
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_mfstr LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(info_);
      Client_SYS.Clear_Attr(attr_);
      
      dom_ := NULL;
      OPEN get_dom(row_.order_no, row_.release_no, row_.sequence_no, row_.heat_no);
      FETCH get_dom INTO dom_;
      CLOSE get_dom;      
         
      Client_SYS.Add_To_Attr('CF$_AIM_DOM_INHERIT', dom_, attr_cf_);
      SHOP_ORD_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');         
   END LOOP; 
   COMMIT;   
END;