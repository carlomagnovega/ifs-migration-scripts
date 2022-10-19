--Remove InvoicedLines from Preliminary Shipments
DECLARE   
   CURSOR get_qaman IS
	SELECT   a.SHIPMENT_ID,
            b.OBJID,
            b.OBJVERSION
   FROM SHIPMENT a
   INNER JOIN SHIPMENT_ORDER_LINE b ON a.SHIPMENT_ID = b.SHIPMENT_ID
   WHERE  (a.STATE = 'Preliminary')
   AND (CUSTOMER_ORDER_LINE_API.get_state(b.ORDER_NO, b.LINE_NO, b.REL_NO, b.LINE_ITEM_NO) = 'Invoiced/Closed');   
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   
BEGIN
   FOR row_ IN get_qaman LOOP
      objid_ := row_.OBJID;
      objversion_ := row_.OBJVERSION;
      SHIPMENT_ORDER_LINE_API.REMOVE__(info_, objid_, objversion_, 'DO');
      COMMIT;
   END LOOP;   
END;


--Cancel Shipments without lines
DECLARE   
   CURSOR get_qaman IS
	SELECT SHIPMENT_ID
      FROM SHIPMENT a
      WHERE OBJSTATE = 'Preliminary' 
      AND upper( Shipment_Order_Line_API.Get_Lines_To_Pick_Shipment(SHIPMENT_ID) ) = upper( '0' )
      AND NOT EXISTS (SELECT 1 FROM SHIPMENT_ORDER_LINE b WHERE b.SHIPMENT_ID = a.SHIPMENT_ID);   
BEGIN
   FOR row_ IN get_qaman LOOP
      Shipment_API.Cancel_Shipment__(row_.SHIPMENT_ID );
      COMMIT;
   END LOOP;   
END;