DECLARE
   year_ 	NUMBER := 2022;
   month_ 	NUMBER := 10;
   day_ 	NUMBER := 12;
   
   CURSOR c_SHIPMENT IS
      SELECT   OBJID,
               CF$_AIM_LASERFICHE_EXP               
      FROM SHIPMENT_CFV
      WHERE --CF$_AIM_LASERFICHE_EXP IS NOT NULL;
	  extract(year FROM CF$_AIM_LASERFICHE_EXP) = year_
      AND extract(month FROM CF$_AIM_LASERFICHE_EXP) = month_
      AND extract(day FROM CF$_AIM_LASERFICHE_EXP) = day_;
      --AND STATE = 'Closed'      
	  
   CURSOR c_INVOICE IS
      SELECT   OBJID
      FROM INVOICE_CFV t 
      WHERE --CF$_AIM_LASERFICHE_EXP IS NOT NULL;       
	  extract(year FROM CF$_AIM_LASERFICHE_EXP) = year_
      AND extract(month FROM CF$_AIM_LASERFICHE_EXP) = month_
      AND extract(day FROM CF$_AIM_LASERFICHE_EXP) = day_;

   CURSOR c_MIXPAYMENT IS
      SELECT   OBJID
      FROM MIXED_PAYMENT_CFV t 
      WHERE extract(year FROM CF$_AIM_LASERFICHE_EXP) = year_
      AND extract(month FROM CF$_AIM_LASERFICHE_EXP) = month_
      AND extract(day FROM CF$_AIM_LASERFICHE_EXP) = day_;   
	  
	CURSOR c_CHECK IS
      SELECT   b.OBJID
      FROM  CHECK_LEDGER_ITEM_CFV b 
      WHERE --CF$_AIM_LASERFICHE_EXP IS NOT NULL;
	  extract(year FROM CF$_AIM_LASERFICHE_EXP) = year_
      AND extract(month FROM CF$_AIM_LASERFICHE_EXP) = month_
      AND extract(day FROM CF$_AIM_LASERFICHE_EXP) = day_;
   
   CURSOR c_PASTE IS
      SELECT   b.OBJID              
      FROM PROD_MASTER_SHOP_ORDER_CLV PMSO 
      INNER JOIN SHOP_ORD_CFV b ON PMSO.cf$_order_no_assig    = b.order_no
                             AND PMSO.cf$_release_no_assig = b.release_no
                             AND PMSO.cf$_sequence_no_assig = b.sequence_no                                    
      WHERE upper( INVENTORY_PART_API.Get_Planner_Buyer(b.Contract,b.PART_NO) ) like upper( 'PASTE_SE-FG' )
      AND --b.CF$_AIM_LASERFICHE_EXP IS NOT NULL;
	  extract(year FROM CF$_AIM_LASERFICHE_EXP) = year_
      AND extract(month FROM CF$_AIM_LASERFICHE_EXP) = month_
      AND extract(day FROM CF$_AIM_LASERFICHE_EXP) = day_;
   
   CURSOR c_PRODUCCION IS
      SELECT   b.OBJID
      FROM SHOP_ORD_CFV b 
      WHERE upper( INVENTORY_PART_API.Get_Planner_Buyer(b.Contract,b.PART_NO) ) <> upper( 'PASTE_SE-FG' )
      AND --b.CF$_AIM_LASERFICHE_EXP IS NOT NULL;
	  extract(year FROM CF$_AIM_LASERFICHE_EXP) = year_
      AND extract(month FROM CF$_AIM_LASERFICHE_EXP) = month_
      AND extract(day FROM CF$_AIM_LASERFICHE_EXP) = day_;
     
  CURSOR c_WIRE IS
	  SELECT    
         a.OBJID,   
         a.PAYMENT_ID
      FROM PAYMENT_CFV a 
      WHERE --a.CF$_AIM_LASERFICHE_EXP IS NOT NULL;
	  extract(year FROM CF$_AIM_LASERFICHE_EXP) = year_
      AND extract(month FROM CF$_AIM_LASERFICHE_EXP) = month_
      AND extract(day FROM CF$_AIM_LASERFICHE_EXP) = day_
	  AND a.PAYMENT_TYPE_CODE_DB ='SUPPPAY';
		 
	CURSOR c_MAINTENANCE IS
      SELECT   OBJID
      FROM HISTORICAL_WORK_ORDER_CFV t 
      WHERE --CF$_AIM_LASERFICHE_EXP IS NOT NULL;
	  extract(year FROM CF$_AIM_LASERFICHE_EXP) = year_
      AND extract(month FROM CF$_AIM_LASERFICHE_EXP) = month_
      AND extract(day FROM CF$_AIM_LASERFICHE_EXP) = day_;
   
   info_                 VARCHAR2(2000);
   objid_                VARCHAR2(32000);   
   attr_                 VARCHAR2(26000);    
   attr_cf_              VARCHAR2(26000);
BEGIN
   FOR cur_rec IN c_SHIPMENT LOOP
       objid_ := cur_rec.OBJID;
       Client_SYS.Clear_Attr(attr_cf_);
       Client_SYS.Clear_Attr(attr_);
       Client_SYS.Add_To_Attr('CF$_AIM_LASERFICHE_EXP', '', attr_cf_);
       SHIPMENT_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;
   COMMIT;
   
   FOR cur_rec IN c_INVOICE LOOP
       objid_ := cur_rec.OBJID;
       Client_SYS.Clear_Attr(attr_cf_);
       Client_SYS.Clear_Attr(attr_);
       Client_SYS.Add_To_Attr('CF$_AIM_LASERFICHE_EXP', '', attr_cf_);
       INVOICE_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;
   COMMIT;

   FOR cur_rec IN c_MIXPAYMENT LOOP
       objid_ := cur_rec.OBJID;
       Client_SYS.Clear_Attr(attr_cf_);
       Client_SYS.Clear_Attr(attr_);
       Client_SYS.Add_To_Attr('CF$_AIM_LASERFICHE_EXP', '', attr_cf_);
       MIXED_PAYMENT_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;
   COMMIT;
   
   FOR cur_rec IN c_CHECK LOOP
       objid_ := cur_rec.OBJID;
       Client_SYS.Clear_Attr(attr_cf_);
       Client_SYS.Clear_Attr(attr_);
       Client_SYS.Add_To_Attr('CF$_AIM_LASERFICHE_EXP', '', attr_cf_);
       CHECK_LEDGER_ITEM_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;
   COMMIT;
   
   FOR cur_rec IN c_PASTE LOOP
       objid_ := cur_rec.OBJID;
       Client_SYS.Clear_Attr(attr_cf_);
       Client_SYS.Clear_Attr(attr_);
       Client_SYS.Add_To_Attr('CF$_AIM_LASERFICHE_EXP', '', attr_cf_);
       SHOP_ORD_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;
   COMMIT;
   
   FOR cur_rec IN c_PRODUCCION LOOP
       objid_ := cur_rec.OBJID;
       Client_SYS.Clear_Attr(attr_cf_);
       Client_SYS.Clear_Attr(attr_);
       Client_SYS.Add_To_Attr('CF$_AIM_LASERFICHE_EXP', '', attr_cf_);
       SHOP_ORD_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;
   COMMIT;   
   
   FOR cur_rec IN c_WIRE LOOP
       objid_ := cur_rec.OBJID;
       Client_SYS.Clear_Attr(attr_cf_);
       Client_SYS.Clear_Attr(attr_);
       Client_SYS.Add_To_Attr('CF$_AIM_LASERFICHE_EXP', '', attr_cf_);
       payment_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;
   COMMIT;
   
   FOR cur_rec IN c_MAINTENANCE LOOP
      objid_ := cur_rec.OBJID;
      Client_SYS.Clear_Attr(attr_cf_);
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CF$_AIM_LASERFICHE_EXP', '', attr_cf_);
      HISTORICAL_WORK_ORDER_CFP.Cf_Modify__(info_, objid_, attr_cf_, attr_, 'DO');
   END LOOP;
   COMMIT;
END;
