----Create PurchPartSupp
DECLARE   
   CURSOR get_qaman IS
      SELECT a.contract,
			a.part_no,
			a.vendor_no,
			a.buy_unit_meas,
			a.conv_factor,
			a.price_unit_meas,
			a.price_conv_factor,
			a.standard_pack_size,
			a.status_code,
			a.vendor_part_no,
			a.vendor_part_description,
			a.assortment,
			a.contact,
			a.minimum_qty,
			a.vendor_manuf_leadtime,
			a.leadtime_auto,
			a.part_ownership,
			a.delivery_pattern_id,
			a.list_price,
			a.currency_code,
			a.discount,
			a.fee_code,
			a.additional_cost_amount,
			a.primary_vendor,
			a.external_service_allowed,
			a.multisite_planned_part,
			a.orders_price_option,
			a.supply_configuration,
			a.dist_order_coordinator,
			a.dist_order_receipt_type,
			a.receive_case,
			a.inspection_code,
			a.sample_percent,
			a.sample_qty,
			a.internal_control_time,
			a.std_multiple_qty,
			a.country_of_origin
		FROM PURCHASE_PART_SUPPLIER a
		LEFT JOIN PURCHASE_PART_SUPPLIER_TAB b ON a.CONTRACT = b.CONTRACT AND a.PART_NO = b.PART_NO AND b.VENDOR_NO = '1577'
		WHERE a.CONTRACT = '11RI'
		AND a.VENDOR_NO = '1751'
		AND b.PART_NO IS NULL;

BEGIN   
   FOR row_ IN get_qaman LOOP
      PURCHASE_PART_SUPPLIER_API.Create_Supplier_Part(
			row_.contract,
			row_.part_no,
			'1577',
			row_.buy_unit_meas,
			row_.conv_factor,
			row_.price_unit_meas,
			row_.price_conv_factor,
			row_.standard_pack_size,
			row_.status_code,
			row_.vendor_part_no,
			row_.vendor_part_description,
			row_.assortment,
			row_.contact,
			row_.minimum_qty,
			row_.vendor_manuf_leadtime,
			row_.leadtime_auto,
			row_.part_ownership,
			row_.delivery_pattern_id,
			row_.list_price,
			row_.currency_code,
			row_.discount,
			row_.fee_code,
			row_.additional_cost_amount,
			'Alternate supplier',
			row_.external_service_allowed,
			row_.multisite_planned_part,
			row_.orders_price_option,
			row_.supply_configuration,
			row_.dist_order_coordinator,
			row_.dist_order_receipt_type,
			row_.receive_case,
			row_.inspection_code,
			row_.sample_percent,
			row_.sample_qty,
			row_.internal_control_time,
			row_.std_multiple_qty,
			row_.country_of_origin);
      COMMIT;
   END LOOP;   
END;
