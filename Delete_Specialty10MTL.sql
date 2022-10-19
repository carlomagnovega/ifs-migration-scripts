----Deleting Specialty
----Update Sales Purchase Inventory and PartMaste
DECLARE   
   
   CURSOR get_sales_parts IS
      SELECT   d.contract,
				 d.catalog_no,
				 d.objid,
				 d.objversion
		FROM (SELECT contract, part_no
			  FROM  INVENTORY_PART a
			  WHERE 
			  (a.PART_NO like '%BULK%')
			  and (a.CONTRACT = '10MTL') 
			  and (a.PLANNER_BUYER LIKE 'SPEC_%')
			  AND NOT EXISTS (SELECT * FROM INVENTORY_PART b
			  WHERE (b.PART_NO like '%BULK%')
			  and (b.CONTRACT = '11RI') 
			  and (b.PLANNER_BUYER LIKE 'SPEC_%')
			  AND (b.PART_NO = a.PART_NO)
			  AND (b.CONTRACT <> a.CONTRACT))) a
		LEFT OUTER JOIN SALES_PRICE_LIST_PART b ON a.PART_NO = b.CATALOG_NO AND b.price_list_no = 'INTERCO'
		LEFT OUTER JOIN SALES_PART_BASE_PRICE c ON a.PART_NO = c.CATALOG_NO
		INNER JOIN SALES_PART d ON d.PART_NO = a.PART_NO AND d.CONTRACT = a.CONTRACT
		WHERE b.CATALOG_NO IS NULL
		AND c.CATALOG_NO IS NULL;
   
   CURSOR get_sales_parts_desc(CONTRACT_ VARCHAR2, CATALOG_NO_ VARCHAR2) IS
      SELECT   objid,
               objversion
      FROM SALES_PART_LANGUAGE_DESC
      WHERE CONTRACT = CONTRACT_      
      AND CATALOG_NO = CATALOG_NO_;
   
   CURSOR get_purchase_parts IS
      SELECT   d.contract,
				 d.part_no,
				 d.objid,
				 d.objversion
		FROM (SELECT contract, part_no
			  FROM  INVENTORY_PART a
			  WHERE 
			  (a.PART_NO like '%BULK%')
			  and (a.CONTRACT = '10MTL') 
			  and (a.PLANNER_BUYER LIKE 'SPEC_%')
			  AND NOT EXISTS (SELECT * FROM INVENTORY_PART b
			  WHERE (b.PART_NO like '%BULK%')
			  and (b.CONTRACT = '11RI') 
			  and (b.PLANNER_BUYER LIKE 'SPEC_%')
			  AND (b.PART_NO = a.PART_NO)
			  AND (b.CONTRACT <> a.CONTRACT))) a
		LEFT OUTER JOIN SALES_PRICE_LIST_PART b ON a.PART_NO = b.CATALOG_NO AND b.price_list_no = 'INTERCO'
		LEFT OUTER JOIN SALES_PART_BASE_PRICE c ON a.PART_NO = c.CATALOG_NO
		INNER JOIN PURCHASE_PART d ON d.PART_NO = a.PART_NO AND d.CONTRACT = a.CONTRACT
		WHERE b.CATALOG_NO IS NULL
		AND c.CATALOG_NO IS NULL;
   
   CURSOR get_purchase_parts_desc(CONTRACT_ VARCHAR2, PART_NO_ VARCHAR2) IS
      SELECT   objid,
               objversion
      FROM PURCHASE_PART_LANG_DESC
      WHERE CONTRACT = CONTRACT_      
      AND PART_NO = PART_NO_;   
   
   CURSOR get_purchase_parts_suppl(CONTRACT_ VARCHAR2, PART_NO_ VARCHAR2) IS
      SELECT   objid,
               objversion
      FROM PURCHASE_PART_SUPPLIER
      WHERE CONTRACT = CONTRACT_      
      AND PART_NO = PART_NO_;   
   
   CURSOR get_inventory_parts IS
		SELECT   d.contract,
				 d.part_no,
				 d.objid,
				 d.objversion
		FROM (SELECT contract, part_no
			  FROM  INVENTORY_PART a
			  WHERE 
			  (a.PART_NO like '%BULK%')
			  and (a.CONTRACT = '10MTL') 
			  and (a.PLANNER_BUYER LIKE 'SPEC_%')
			  AND NOT EXISTS (SELECT * FROM INVENTORY_PART b
			  WHERE (b.PART_NO like '%BULK%')
			  and (b.CONTRACT = '11RI') 
			  and (b.PLANNER_BUYER LIKE 'SPEC_%')
			  AND (b.PART_NO = a.PART_NO)
			  AND (b.CONTRACT <> a.CONTRACT))) a
		LEFT OUTER JOIN SALES_PRICE_LIST_PART b ON a.PART_NO = b.CATALOG_NO AND b.price_list_no = 'INTERCO'
		LEFT OUTER JOIN SALES_PART_BASE_PRICE c ON a.PART_NO = c.CATALOG_NO
		INNER JOIN INVENTORY_PART d ON d.PART_NO = a.PART_NO AND d.CONTRACT = a.CONTRACT
		WHERE b.CATALOG_NO IS NULL
		AND c.CATALOG_NO IS NULL;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   
   i_ NUMBER;
BEGIN
   
   ----Delete SALES_PART
   FOR row_sales_parts_ IN get_sales_parts LOOP
      BEGIN
         --Delete SALES_PART_LANGUAGE_DESC
         FOR row_sales_parts_desc_ IN get_sales_parts_desc(row_sales_parts_.contract, row_sales_parts_.CATALOG_NO) LOOP
            objid_      := row_sales_parts_desc_.objid;
            objversion_ := row_sales_parts_desc_.objversion;
            SALES_PART_LANGUAGE_DESC_API.Remove__(info_, objid_, objversion_, 'DO');
         END LOOP;

         objid_      := row_sales_parts_.objid;
         objversion_ := row_sales_parts_.objversion;
         SALES_PART_API.Remove__(info_, objid_, objversion_, 'DO');         
      EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' failed deleting SALES_PART. Part_No: ' || row_sales_parts_.CATALOG_NO);        
      END;  -- sub-block ends
	  COMMIT;
   END LOOP;
   
      
   ----Delete PURCHASE_PART   
   FOR row_purchase_parts_ IN get_purchase_parts LOOP
      --Delete PURCHASE_PART_LANG_DESC
      FOR row_purchase_parts_desc_ IN get_purchase_parts_desc(row_purchase_parts_.contract, row_purchase_parts_.PART_NO) LOOP
         objid_      := row_purchase_parts_desc_.objid;
         objversion_ := row_purchase_parts_desc_.objversion;
         PURCHASE_PART_LANG_DESC_API.Remove__(info_, objid_, objversion_, 'DO');
      END LOOP;
      --Delete PURCHASE_PART_SUPPLIER
      FOR row_purchase_parts_suppl_ IN get_purchase_parts_suppl(row_purchase_parts_.contract, row_purchase_parts_.PART_NO) LOOP
         BEGIN
            objid_      := row_purchase_parts_suppl_.objid;
            objversion_ := row_purchase_parts_suppl_.objversion;
            PURCHASE_PART_SUPPLIER_API.Remove__(info_, objid_, objversion_, 'DO');
         EXCEPTION
         WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE(' failed deleting PURCHASE_PART_SUPPLIER; Part_No: ' || row_purchase_parts_.PART_NO);        
         END;  
      END LOOP;

      BEGIN
         objid_      := row_purchase_parts_.objid;
         objversion_ := row_purchase_parts_.objversion;
         PURCHASE_PART_API.Remove__(info_, objid_, objversion_, 'DO');         
      EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' failed deleting PURCHASE_PART. Part_No: ' || row_purchase_parts_.PART_NO);        
      END;  -- sub-block ends
 	  COMMIT;   	  
   END LOOP;  

----Delete INVENTORY_PART
   i_ := 0;
   FOR row_inventory_parts_ IN get_inventory_parts LOOP     
      BEGIN
         objid_      := row_inventory_parts_.objid;
         objversion_ := row_inventory_parts_.objversion;
         INVENTORY_PART_API.Remove__(info_, objid_, objversion_, 'DO');  
		 i_ := i_ + 1;
		 IF(i_ = 20) THEN
			 COMMIT;
			 i_ := 0;
		  END IF; 
      EXCEPTION
         WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE(' failed deleting INVENTORY_PART. Part_No: ' || row_inventory_parts_.PART_NO);        
      END;  -- sub-block ends           
   END LOOP;
   COMMIT;
END;