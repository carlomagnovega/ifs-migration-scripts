----SupplierInfo
SELECT 'INSERT INTO MTK_SUPPLIER_INFO_TAB (supplier_id,name,association_no,country,suppliers_own_id,creation_date,corporate_form,identifier_reference,identifier_ref_validation_db,supp_grp,buyer_code,pay_term_id,currency_code,pay_tax_db,customer_no,our_customer_no,additional_cost_amount,discount,qc_approval_db,qc_date,qc_type,qc_audit,environmental_approval_db,environment_date,environment_type,environment_audit,cr_check_db,cr_date,ord_conf_reminder,ord_conf_rem_interval,days_before_delivery,category_db,acquisition_site,date_del,receipt_ref_reminder_db,delivery_reminder,delivery_rem_interval,days_before_arrival,purch_order_flag_db,print_amounts_incl_tax_db,note_text,edi_auto_order_approval_db,edi_auto_approval_user,blanket_date_db,express_order_allowed_db,edi_pri_cat_app_user,pricat_automatic_approval_db,automatic_repl_change_db,send_change_message_db,default_language_db,mtk_mode,dme_qsl)  VALUES (''' 
                 || SUPPLIER_ID
      || ''',''' || name
      || ''',''' || association_no           
      || ''',''' || country                  
      || ''',''' || suppliers_own_id         
      || ''',''' || creation_date 	         
      || ''',''' || corporate_form	         
      || ''',''' || identifier_reference	     
      || ''',''' || identifier_ref_validation_db 
      || ''',''' || supp_grp 		     
      || ''',''' || buyer_code	         
      || ''',''' || pay_term_id		     
      || ''',''' || currency_code		 
      || ''',''' || pay_tax_db            
      || ''',''' || customer_no           
      || ''',''' || our_customer_no       
      || ''',''' || additional_cost_amount
      || ''',''' || discount
      || ''',''' || qc_approval_db                
      || ''',''' || qc_date 	              
      || ''',''' || qc_type                   
      || ''',''' || qc_audit 	              
      || ''',''' || environmental_approval_db 
      || ''',''' || environment_date 	 
      || ''',''' || environment_type     
      || ''',''' || environment_audit    
      || ''',''' || cr_check_db          
      || ''',''' || cr_date 	         
      || ''',''' || ord_conf_reminder    
      || ''',''' || ord_conf_rem_interval
      || ''',''' || days_before_delivery
      || ''',''' || category_db            
      || ''',''' || acquisition_site       
      || ''',''' || date_del               
      || ''',''' || receipt_ref_reminder_db
      || ''',''' || delivery_reminder    
      || ''',''' || delivery_rem_interval
      || ''',''' || days_before_arrival
      || ''',''' || purch_order_flag_db           
      || ''',''' || print_amounts_incl_tax_db     
      || ''',''' || note_text                     
      || ''',''' || edi_auto_order_approval_db    
      || ''',''' || edi_auto_approval_user       
      || ''',''' || blanket_date_db              
      || ''',''' || express_order_allowed_db     
      || ''',''' || edi_pri_cat_app_user         
      || ''',''' || pricat_automatic_approval_db 
      || ''',''' || automatic_repl_change_db 
      || ''',''' || send_change_message_db   
      || ''',''' || default_language_db      
      || ''',''' || mtk_mode		         
      || ''',''' || dme_qsl                       
    ||  ''');'   aa
FROM (
select 
   a.supplier_id,
   name,
   association_no,
   country,
   suppliers_own_id,
   creation_date,
   corporate_form,
   identifier_reference,
   identifier_ref_validation_db,
   supp_grp,
   buyer_code,
   b.pay_term_id,
   b.currency_code,
   '' pay_tax_db,
   customer_no,
   our_customer_no,
   additional_cost_amount,
   discount,
   qc_approval_db,
   qc_date,
   qc_type,
   qc_audit,
   environmental_approval_db,
   environment_date,
   environment_type,
   environment_audit,
   cr_check_db,
   cr_date,
   ord_conf_reminder,
   ord_conf_rem_interval,
   days_before_delivery,
   category_db,
   acquisition_site,
   date_del,
   receipt_ref_reminder_db,
   delivery_reminder,
   delivery_rem_interval,
   days_before_arrival,
   purch_order_flag_db,
   print_amounts_incl_tax_db,
   note_text,
   '' edi_auto_order_approval_db,
   edi_auto_approval_user,
   blanket_date_db,
   express_order_allowed_db,
   edi_pri_cat_app_user,
   pricat_automatic_approval_db,
   automatic_repl_change_db,
   send_change_message_db,
   default_language_db,
   '*' mtk_mode,
   '' dme_qsl
FROM SUPPLIER_INFO a
LEFT JOIN SUPPLIER_ENT c ON a.supplier_id = c.supplier_id
INNER JOIN IDENTITY_INVOICE_INFO b ON a.supplier_id = b.identity AND a.party_type = b.party_type
WHERE (a.supplier_id = '9006' or a.supplier_id = '9005' or a.supplier_id = '9001' or a.supplier_id = '9003' or a.supplier_id = '9004' or a.supplier_id = '9002' or a.supplier_id = '9010' or a.supplier_id = '9007' or a.supplier_id = '9008' or a.supplier_id = '9009' or a.supplier_id = '9011' or a.supplier_id = '9012' or a.supplier_id = '9013' or a.supplier_id = '9014' or a.supplier_id = '9015' or a.supplier_id = '9016' or a.supplier_id = '9017' or a.supplier_id = '9018' or a.supplier_id = '9019' or a.supplier_id = '9020' or a.supplier_id = '9021' or a.supplier_id = '9022' or a.supplier_id = '9023' or a.supplier_id = '9024' or a.supplier_id = '9025' or a.supplier_id = '9026' or a.supplier_id = '9027' or a.supplier_id = '9028' or a.supplier_id = '9029' or a.supplier_id = '9030' or a.supplier_id = '9034' or a.supplier_id = '9031' or a.supplier_id = '9032' or a.supplier_id = '9033' or a.supplier_id = '9035' or a.supplier_id = '9036' or a.supplier_id = '9037' or a.supplier_id = '9038' or a.supplier_id = '9039' or a.supplier_id = '9040' or a.supplier_id = '9041' or a.supplier_id = '9042' or a.supplier_id = '9043' or a.supplier_id = '9044' or a.supplier_id = '9045' or a.supplier_id = '9046' or a.supplier_id = '9047' or a.supplier_id = '9048' or a.supplier_id = '9049' or a.supplier_id = '9050' or a.supplier_id = '9051' or a.supplier_id = '9052' or a.supplier_id = '9053' or a.supplier_id = '9054' or a.supplier_id = '9055' or a.supplier_id = '9059' or a.supplier_id = '9056' or a.supplier_id = '9057' or a.supplier_id = '9058' or a.supplier_id = '9060' or a.supplier_id = '9061' or a.supplier_id = '9062' or a.supplier_id = '9063' or a.supplier_id = '9064' or a.supplier_id = '9065' or a.supplier_id = '9066' or a.supplier_id = '9067' or a.supplier_id = '9068' or a.supplier_id = '9069' or a.supplier_id = '9070' or a.supplier_id = '9071' or a.supplier_id = '9072' or a.supplier_id = '9073' or a.supplier_id = '9074' or a.supplier_id = '9075' or a.supplier_id = '9076' or a.supplier_id = '9077' or a.supplier_id = '9078' or a.supplier_id = '9079' or a.supplier_id = '9083' or a.supplier_id = '9080' or a.supplier_id = '9081' or a.supplier_id = '9082' or a.supplier_id = '9084' or a.supplier_id = '9085' or a.supplier_id = '9086' or a.supplier_id = '9087' or a.supplier_id = '9088' or a.supplier_id = '9089' or a.supplier_id = '9090' or a.supplier_id = '9091' or a.supplier_id = '9092' or a.supplier_id = '9093' or a.supplier_id = '9094' or a.supplier_id = '9095' or a.supplier_id = '9096' or a.supplier_id = '9097' or a.supplier_id = '9098' or a.supplier_id = '9099' or a.supplier_id = '9100' or a.supplier_id = '9101' or a.supplier_id = '9102' or a.supplier_id = '9103' or a.supplier_id = '9107' or a.supplier_id = '9104' or a.supplier_id = '9105' or a.supplier_id = '9106' or a.supplier_id = '9108' or a.supplier_id = '9109' or a.supplier_id = '9110' or a.supplier_id = '9111' or a.supplier_id = '9112' or a.supplier_id = '9113' or a.supplier_id = '9114' or a.supplier_id = '9115' or a.supplier_id = '9116' or a.supplier_id = '9117' or a.supplier_id = '9118' or a.supplier_id = '9119' or a.supplier_id = '9120' or a.supplier_id = '9121' or a.supplier_id = '9122' or a.supplier_id = '9123' or a.supplier_id = '9124' or a.supplier_id = '9125' or a.supplier_id = '9126' or a.supplier_id = '9127' or a.supplier_id = '9128' or a.supplier_id = '9129' or a.supplier_id = '9133' or a.supplier_id = '9130' or a.supplier_id = '9131' or a.supplier_id = '9132' or a.supplier_id = '9134' or a.supplier_id = '9135' or a.supplier_id = '9136' or a.supplier_id = '9137' or a.supplier_id = '9138' or a.supplier_id = '9139' or a.supplier_id = '9140' or a.supplier_id = '9141' or a.supplier_id = '9142' or a.supplier_id = '9143' or a.supplier_id = '9144' or a.supplier_id = '9145' or a.supplier_id = '9146' or a.supplier_id = '9147' or a.supplier_id = '9148' or a.supplier_id = '9149' or a.supplier_id = '9150' or a.supplier_id = '9151' or a.supplier_id = '9152' or a.supplier_id = '9158' or a.supplier_id = '9153' or a.supplier_id = '9154' or a.supplier_id = '9155' or a.supplier_id = '9156' or a.supplier_id = '9157' or a.supplier_id = '9159' or a.supplier_id = '9160')) aa


----SUPPLIER_INFO_ADDRESS
SELECT 'INSERT INTO mtk_supplier_info_address_tab (supplier_id,address_id,company_name2,address1,address2,city,zip_code,state,country,delivery_terms,ship_via_code,contact,phone,def_address_pay,def_address_document,def_address_delivery,def_address_visit,name_phone,ean_location,valid_from,valid_to,county)  VALUES (''' 
                 || SUPPLIER_ID
      || ''',''' || address_id
      || ''',''' || company_name2
      || ''',''' || address1
      || ''',''' || address2
      || ''',''' || city
      || ''',''' || zip_code
      || ''',''' || state
      || ''',''' || country
      || ''',''' || delivery_terms
      || ''',''' || ship_via_code
      || ''',''' || contact
      || ''',''' || phone
      || ''',''' || def_address_pay
      || ''',''' || def_address_document
      || ''',''' || def_address_delivery
      || ''',''' || def_address_visit
      || ''',''' || name_phone
      || ''',''' || ean_location
      || ''',''' || valid_from
      || ''',''' || valid_to
      || ''',''' || county
    ||  ''');'   aa
FROM (SELECT
       a.SUPPLIER_ID
      ,a.ADDRESS_ID
      ,COMPANY_NAME2
      ,ADDRESS1
      ,ADDRESS2
      ,CITY
      ,ZIP_CODE
      ,STATE
      ,COUNTRY
      ,DELIVERY_TERMS
      ,SHIP_VIA_CODE
      ,CONTACT
      ,'' PHONE
      ,'TRUE' DEF_ADDRESS_PAY
      ,'TRUE' DEF_ADDRESS_DOCUMENT
      ,'TRUE' DEF_ADDRESS_DELIVERY
      ,'TRUE' DEF_ADDRESS_VISIT
      ,'' NAME_PHONE
      ,'' EAN_LOCATION
      ,VALID_FROM
      ,VALID_TO
      ,COUNTY
FROM SUPPLIER_INFO_ADDRESS a
left join SUPPLIER_ADDRESS_ENT c ON a.supplier_id = c.supplier_id AND  a.ADDRESS_ID = c.ADDRESS_ID
WHERE (a.supplier_id = '9006' or a.supplier_id = '9005' or a.supplier_id = '9001' or a.supplier_id = '9003' or a.supplier_id = '9004' or a.supplier_id = '9002' or a.supplier_id = '9010' or a.supplier_id = '9007' or a.supplier_id = '9008' or a.supplier_id = '9009' or a.supplier_id = '9011' or a.supplier_id = '9012' or a.supplier_id = '9013' or a.supplier_id = '9014' or a.supplier_id = '9015' or a.supplier_id = '9016' or a.supplier_id = '9017' or a.supplier_id = '9018' or a.supplier_id = '9019' or a.supplier_id = '9020' or a.supplier_id = '9021' or a.supplier_id = '9022' or a.supplier_id = '9023' or a.supplier_id = '9024' or a.supplier_id = '9025' or a.supplier_id = '9026' or a.supplier_id = '9027' or a.supplier_id = '9028' or a.supplier_id = '9029' or a.supplier_id = '9030' or a.supplier_id = '9034' or a.supplier_id = '9031' or a.supplier_id = '9032' or a.supplier_id = '9033' or a.supplier_id = '9035' or a.supplier_id = '9036' or a.supplier_id = '9037' or a.supplier_id = '9038' or a.supplier_id = '9039' or a.supplier_id = '9040' or a.supplier_id = '9041' or a.supplier_id = '9042' or a.supplier_id = '9043' or a.supplier_id = '9044' or a.supplier_id = '9045' or a.supplier_id = '9046' or a.supplier_id = '9047' or a.supplier_id = '9048' or a.supplier_id = '9049' or a.supplier_id = '9050' or a.supplier_id = '9051' or a.supplier_id = '9052' or a.supplier_id = '9053' or a.supplier_id = '9054' or a.supplier_id = '9055' or a.supplier_id = '9059' or a.supplier_id = '9056' or a.supplier_id = '9057' or a.supplier_id = '9058' or a.supplier_id = '9060' or a.supplier_id = '9061' or a.supplier_id = '9062' or a.supplier_id = '9063' or a.supplier_id = '9064' or a.supplier_id = '9065' or a.supplier_id = '9066' or a.supplier_id = '9067' or a.supplier_id = '9068' or a.supplier_id = '9069' or a.supplier_id = '9070' or a.supplier_id = '9071' or a.supplier_id = '9072' or a.supplier_id = '9073' or a.supplier_id = '9074' or a.supplier_id = '9075' or a.supplier_id = '9076' or a.supplier_id = '9077' or a.supplier_id = '9078' or a.supplier_id = '9079' or a.supplier_id = '9083' or a.supplier_id = '9080' or a.supplier_id = '9081' or a.supplier_id = '9082' or a.supplier_id = '9084' or a.supplier_id = '9085' or a.supplier_id = '9086' or a.supplier_id = '9087' or a.supplier_id = '9088' or a.supplier_id = '9089' or a.supplier_id = '9090' or a.supplier_id = '9091' or a.supplier_id = '9092' or a.supplier_id = '9093' or a.supplier_id = '9094' or a.supplier_id = '9095' or a.supplier_id = '9096' or a.supplier_id = '9097' or a.supplier_id = '9098' or a.supplier_id = '9099' or a.supplier_id = '9100' or a.supplier_id = '9101' or a.supplier_id = '9102' or a.supplier_id = '9103' or a.supplier_id = '9107' or a.supplier_id = '9104' or a.supplier_id = '9105' or a.supplier_id = '9106' or a.supplier_id = '9108' or a.supplier_id = '9109' or a.supplier_id = '9110' or a.supplier_id = '9111' or a.supplier_id = '9112' or a.supplier_id = '9113' or a.supplier_id = '9114' or a.supplier_id = '9115' or a.supplier_id = '9116' or a.supplier_id = '9117' or a.supplier_id = '9118' or a.supplier_id = '9119' or a.supplier_id = '9120' or a.supplier_id = '9121' or a.supplier_id = '9122' or a.supplier_id = '9123' or a.supplier_id = '9124' or a.supplier_id = '9125' or a.supplier_id = '9126' or a.supplier_id = '9127' or a.supplier_id = '9128' or a.supplier_id = '9129' or a.supplier_id = '9133' or a.supplier_id = '9130' or a.supplier_id = '9131' or a.supplier_id = '9132' or a.supplier_id = '9134' or a.supplier_id = '9135' or a.supplier_id = '9136' or a.supplier_id = '9137' or a.supplier_id = '9138' or a.supplier_id = '9139' or a.supplier_id = '9140' or a.supplier_id = '9141' or a.supplier_id = '9142' or a.supplier_id = '9143' or a.supplier_id = '9144' or a.supplier_id = '9145' or a.supplier_id = '9146' or a.supplier_id = '9147' or a.supplier_id = '9148' or a.supplier_id = '9149' or a.supplier_id = '9150' or a.supplier_id = '9151' or a.supplier_id = '9152' or a.supplier_id = '9158' or a.supplier_id = '9153' or a.supplier_id = '9154' or a.supplier_id = '9155' or a.supplier_id = '9156' or a.supplier_id = '9157' or a.supplier_id = '9159' or a.supplier_id = '9160')) a 

UPDATE MTK_SUPPLIER_INFO_ADDRESS_TAB
SET VALID_TO = to_date('2050-12-31', 'YYYY-MM-DD')
WHERE VALID_FROM IS NULL


----SupplierCompany
SELECT 'INSERT INTO mtk_supplier_company_tab (supplier_id,company,identity_type,group_id,def_authorizer,currency_code,pay_term_id,expire_date,vat_no,supplier_income_type,supplier_tax_office_id,priority,way_id,tax_id_type,notes,auto_auth_final_entry_db,automatic_invoice_db,netting_allowed,income_type_as_default_db,blocked_for_payment,percent_tolerance,amount_tolerance,matching_level_db,tax_liability,allow_tolerance,invoice_recipient,invoicing_supplier,automatic_pay_auth_flag_db,auto_creation_tax_lines,def_vat_code,report_and_withhold_db,comm_id,output_media_db,sup_vat_free_vat_code,payment_advice_db,is_one_inv_per_pay_db)  VALUES (''' 
                 || SUPPLIER_ID
      || ''',''' || company
      || ''',''' || identity_type_db
      || ''',''' || group_id
      || ''',''' || def_authorizer
      || ''',''' || currency_code
      || ''',''' || pay_term_id
      || ''',''' || expire_date
      || ''',''' || vat_no
      || ''',''' || supplier_income_type
      || ''',''' || supplier_tax_office_id
      || ''',''' || priority
      || ''',''' || way_id
      || ''',''' || tax_id_type
      || ''',''' || notes
      || ''',''' || auto_auth_final_entry_db
      || ''',''' || automatic_invoice_db
      || ''',''' || netting_allowed
      || ''',''' || income_type_as_default_db
      || ''',''' || blocked_for_payment
      || ''',''' || percent_tolerance
      || ''',''' || amount_tolerance
      || ''',''' || matching_level_db
      || ''',''' || tax_liability
      || ''',''' || allow_tolerance
      || ''',''' || invoice_recipient
      || ''',''' || invoicing_supplier
      || ''',''' || automatic_pay_auth_flag_db
      || ''',''' || auto_creation_tax_lines
      || ''',''' || def_vat_code
      || ''',''' || report_and_withhold_db
      || ''',''' || comm_id              
      || ''',''' || output_media_db
      || ''',''' || sup_vat_free_vat_code
      || ''',''' || payment_advice_db
      || ''',''' || is_one_inv_per_pay_db
    ||  ''');'   aa
FROM (SELECT
      b.SUPPLIER_ID   
      ,b.COMPANY
      ,b.IDENTITY_TYPE_DB
      ,b.GROUP_ID
      ,b.DEF_AUTHORIZER
      ,b.CURRENCY_CODE
      ,b.PAY_TERM_ID
      ,b.EXPIRE_DATE
      ,'' VAT_NO
      ,'' SUPPLIER_INCOME_TYPE
      ,'' SUPPLIER_TAX_OFFICE_ID
      ,c.PRIORITY
      ,'CHK' WAY_ID
      ,'' TAX_ID_TYPE
      ,'' NOTES
      ,'' AUTO_AUTH_FINAL_ENTRY_DB
      ,'' AUTOMATIC_INVOICE_DB
      ,'' NETTING_ALLOWED
      ,'' INCOME_TYPE_AS_DEFAULT_db
      ,'' BLOCKED_FOR_PAYMENT
      ,b.PERCENT_TOLERANCE
      ,b.AMOUNT_TOLERANCE
      ,b.MATCHING_LEVEL_DB
      ,b.TAX_LIABILITY
      ,b.ALLOW_TOLERANCE
      ,b.INVOICE_RECIPIENT
      ,b.INVOICING_SUPPLIER
      ,b.AUTOMATIC_PAY_AUTH_FLAG_DB
      ,'' AUTO_CREATION_TAX_LINES
      ,b.DEF_VAT_CODE
      ,b.REPORT_AND_WITHHOLD_db
      ,comm_id                     
      ,output_media_db
      ,sup_vat_free_vat_code
      ,payment_advice_db
      ,is_one_inv_per_pay_db 
FROM IDENTITY_INVOICE_INFO b
LEFT JOIN IDENTITY_PAY_INFO c ON b.supplier_id = c.identity AND b.COMPANY = c.COMPANY AND b.PARTY_TYPE = c.PARTY_TYPE
WHERE b.PARTY_TYPE = 'Supplier'
AND (b.supplier_id = '9006' or b.supplier_id = '9005' or b.supplier_id = '9001' or b.supplier_id = '9003' or b.supplier_id = '9004' or b.supplier_id = '9002' or b.supplier_id = '9010' or b.supplier_id = '9007' or b.supplier_id = '9008' or b.supplier_id = '9009' or b.supplier_id = '9011' or b.supplier_id = '9012' or b.supplier_id = '9013' or b.supplier_id = '9014' or b.supplier_id = '9015' or b.supplier_id = '9016' or b.supplier_id = '9017' or b.supplier_id = '9018' or b.supplier_id = '9019' or b.supplier_id = '9020' or b.supplier_id = '9021' or b.supplier_id = '9022' or b.supplier_id = '9023' or b.supplier_id = '9024' or b.supplier_id = '9025' or b.supplier_id = '9026' or b.supplier_id = '9027' or b.supplier_id = '9028' or b.supplier_id = '9029' or b.supplier_id = '9030' or b.supplier_id = '9034' or b.supplier_id = '9031' or b.supplier_id = '9032' or b.supplier_id = '9033' or b.supplier_id = '9035' or b.supplier_id = '9036' or b.supplier_id = '9037' or b.supplier_id = '9038' or b.supplier_id = '9039' or b.supplier_id = '9040' or b.supplier_id = '9041' or b.supplier_id = '9042' or b.supplier_id = '9043' or b.supplier_id = '9044' or b.supplier_id = '9045' or b.supplier_id = '9046' or b.supplier_id = '9047' or b.supplier_id = '9048' or b.supplier_id = '9049' or b.supplier_id = '9050' or b.supplier_id = '9051' or b.supplier_id = '9052' or b.supplier_id = '9053' or b.supplier_id = '9054' or b.supplier_id = '9055' or b.supplier_id = '9059' or b.supplier_id = '9056' or b.supplier_id = '9057' or b.supplier_id = '9058' or b.supplier_id = '9060' or b.supplier_id = '9061' or b.supplier_id = '9062' or b.supplier_id = '9063' or b.supplier_id = '9064' or b.supplier_id = '9065' or b.supplier_id = '9066' or b.supplier_id = '9067' or b.supplier_id = '9068' or b.supplier_id = '9069' or b.supplier_id = '9070' or b.supplier_id = '9071' or b.supplier_id = '9072' or b.supplier_id = '9073' or b.supplier_id = '9074' or b.supplier_id = '9075' or b.supplier_id = '9076' or b.supplier_id = '9077' or b.supplier_id = '9078' or b.supplier_id = '9079' or b.supplier_id = '9083' or b.supplier_id = '9080' or b.supplier_id = '9081' or b.supplier_id = '9082' or b.supplier_id = '9084' or b.supplier_id = '9085' or b.supplier_id = '9086' or b.supplier_id = '9087' or b.supplier_id = '9088' or b.supplier_id = '9089' or b.supplier_id = '9090' or b.supplier_id = '9091' or b.supplier_id = '9092' or b.supplier_id = '9093' or b.supplier_id = '9094' or b.supplier_id = '9095' or b.supplier_id = '9096' or b.supplier_id = '9097' or b.supplier_id = '9098' or b.supplier_id = '9099' or b.supplier_id = '9100' or b.supplier_id = '9101' or b.supplier_id = '9102' or b.supplier_id = '9103' or b.supplier_id = '9107' or b.supplier_id = '9104' or b.supplier_id = '9105' or b.supplier_id = '9106' or b.supplier_id = '9108' or b.supplier_id = '9109' or b.supplier_id = '9110' or b.supplier_id = '9111' or b.supplier_id = '9112' or b.supplier_id = '9113' or b.supplier_id = '9114' or b.supplier_id = '9115' or b.supplier_id = '9116' or b.supplier_id = '9117' or b.supplier_id = '9118' or b.supplier_id = '9119' or b.supplier_id = '9120' or b.supplier_id = '9121' or b.supplier_id = '9122' or b.supplier_id = '9123' or b.supplier_id = '9124' or b.supplier_id = '9125' or b.supplier_id = '9126' or b.supplier_id = '9127' or b.supplier_id = '9128' or b.supplier_id = '9129' or b.supplier_id = '9133' or b.supplier_id = '9130' or b.supplier_id = '9131' or b.supplier_id = '9132' or b.supplier_id = '9134' or b.supplier_id = '9135' or b.supplier_id = '9136' or b.supplier_id = '9137' or b.supplier_id = '9138' or b.supplier_id = '9139' or b.supplier_id = '9140' or b.supplier_id = '9141' or b.supplier_id = '9142' or b.supplier_id = '9143' or b.supplier_id = '9144' or b.supplier_id = '9145' or b.supplier_id = '9146' or b.supplier_id = '9147' or b.supplier_id = '9148' or b.supplier_id = '9149' or b.supplier_id = '9150' or b.supplier_id = '9151' or b.supplier_id = '9152' or b.supplier_id = '9158' or b.supplier_id = '9153' or b.supplier_id = '9154' or b.supplier_id = '9155' or b.supplier_id = '9156' or b.supplier_id = '9157' or b.supplier_id = '9159' or b.supplier_id = '9160')) a 


----SupplierTax
SELECT
       a.SUPPLIER_ID
      ,a.ADDRESS_ID
      ,a.COMPANY
      ,TAX_CODE
      ,'' USE_SUPP_ADDRESS_FOR_TAX 
FROM SUPPLIER_DELIVERY_TAX_CODE a
INNER JOIN IDENTITY_INVOICE_INFO b ON a.supplier_id = b.identity AND a.COMPANY = b.COMPANY AND party_type = 'Supplier'
WHERE (b.supplier_id = '9006' or b.supplier_id = '9005' or b.supplier_id = '9001' or b.supplier_id = '9003' or b.supplier_id = '9004' or b.supplier_id = '9002' or b.supplier_id = '9010' or b.supplier_id = '9007' or b.supplier_id = '9008' or b.supplier_id = '9009' or b.supplier_id = '9011' or b.supplier_id = '9012' or b.supplier_id = '9013' or b.supplier_id = '9014' or b.supplier_id = '9015' or b.supplier_id = '9016' or b.supplier_id = '9017' or b.supplier_id = '9018' or b.supplier_id = '9019' or b.supplier_id = '9020' or b.supplier_id = '9021' or b.supplier_id = '9022' or b.supplier_id = '9023' or b.supplier_id = '9024' or b.supplier_id = '9025' or b.supplier_id = '9026' or b.supplier_id = '9027' or b.supplier_id = '9028' or b.supplier_id = '9029' or b.supplier_id = '9030' or b.supplier_id = '9034' or b.supplier_id = '9031' or b.supplier_id = '9032' or b.supplier_id = '9033' or b.supplier_id = '9035' or b.supplier_id = '9036' or b.supplier_id = '9037' or b.supplier_id = '9038' or b.supplier_id = '9039' or b.supplier_id = '9040' or b.supplier_id = '9041' or b.supplier_id = '9042' or b.supplier_id = '9043' or b.supplier_id = '9044' or b.supplier_id = '9045' or b.supplier_id = '9046' or b.supplier_id = '9047' or b.supplier_id = '9048' or b.supplier_id = '9049' or b.supplier_id = '9050' or b.supplier_id = '9051' or b.supplier_id = '9052' or b.supplier_id = '9053' or b.supplier_id = '9054' or b.supplier_id = '9055' or b.supplier_id = '9059' or b.supplier_id = '9056' or b.supplier_id = '9057' or b.supplier_id = '9058' or b.supplier_id = '9060' or b.supplier_id = '9061' or b.supplier_id = '9062' or b.supplier_id = '9063' or b.supplier_id = '9064' or b.supplier_id = '9065' or b.supplier_id = '9066' or b.supplier_id = '9067' or b.supplier_id = '9068' or b.supplier_id = '9069' or b.supplier_id = '9070' or b.supplier_id = '9071' or b.supplier_id = '9072' or b.supplier_id = '9073' or b.supplier_id = '9074' or b.supplier_id = '9075' or b.supplier_id = '9076' or b.supplier_id = '9077' or b.supplier_id = '9078' or b.supplier_id = '9079' or b.supplier_id = '9083' or b.supplier_id = '9080' or b.supplier_id = '9081' or b.supplier_id = '9082' or b.supplier_id = '9084' or b.supplier_id = '9085' or b.supplier_id = '9086' or b.supplier_id = '9087' or b.supplier_id = '9088' or b.supplier_id = '9089' or b.supplier_id = '9090' or b.supplier_id = '9091' or b.supplier_id = '9092' or b.supplier_id = '9093' or b.supplier_id = '9094' or b.supplier_id = '9095' or b.supplier_id = '9096' or b.supplier_id = '9097' or b.supplier_id = '9098' or b.supplier_id = '9099' or b.supplier_id = '9100' or b.supplier_id = '9101' or b.supplier_id = '9102' or b.supplier_id = '9103' or b.supplier_id = '9107' or b.supplier_id = '9104' or b.supplier_id = '9105' or b.supplier_id = '9106' or b.supplier_id = '9108' or b.supplier_id = '9109' or b.supplier_id = '9110' or b.supplier_id = '9111' or b.supplier_id = '9112' or b.supplier_id = '9113' or b.supplier_id = '9114' or b.supplier_id = '9115' or b.supplier_id = '9116' or b.supplier_id = '9117' or b.supplier_id = '9118' or b.supplier_id = '9119' or b.supplier_id = '9120' or b.supplier_id = '9121' or b.supplier_id = '9122' or b.supplier_id = '9123' or b.supplier_id = '9124' or b.supplier_id = '9125' or b.supplier_id = '9126' or b.supplier_id = '9127' or b.supplier_id = '9128' or b.supplier_id = '9129' or b.supplier_id = '9133' or b.supplier_id = '9130' or b.supplier_id = '9131' or b.supplier_id = '9132' or b.supplier_id = '9134' or b.supplier_id = '9135' or b.supplier_id = '9136' or b.supplier_id = '9137' or b.supplier_id = '9138' or b.supplier_id = '9139' or b.supplier_id = '9140' or b.supplier_id = '9141' or b.supplier_id = '9142' or b.supplier_id = '9143' or b.supplier_id = '9144' or b.supplier_id = '9145' or b.supplier_id = '9146' or b.supplier_id = '9147' or b.supplier_id = '9148' or b.supplier_id = '9149' or b.supplier_id = '9150' or b.supplier_id = '9151' or b.supplier_id = '9152' or b.supplier_id = '9158' or b.supplier_id = '9153' or b.supplier_id = '9154' or b.supplier_id = '9155' or b.supplier_id = '9156' or b.supplier_id = '9157' or b.supplier_id = '9159' or b.supplier_id = '9160')


------Supplier_info_comm_Method
SELECT 'INSERT INTO mtk_supp_info_comm_method_tab (supplier_id,comm_id,value,description,valid_from,valid_to,method_default,address_default,method_id,address_id,name,document_receiver)  VALUES (''' 
                 || SUPPLIER_ID
      || ''',''' || comm_id
      || ''',''' || value
      || ''',''' || description
      || ''',''' || valid_from
      || ''',''' || valid_to
      || ''',''' || method_default
      || ''',''' || address_default
      || ''',''' || method_id
      || ''',''' || address_id
      || ''',''' || name
      || ''',''' || document_receiver      
    ||  ''');'   aa
FROM (SELECT
   a.identity SUPPLIER_ID, 
   COMM_ID,
   VALUE,
   DESCRIPTION,
   VALID_FROM,
   VALID_TO,
   METHOD_DEFAULT,
   ADDRESS_DEFAULT,
   METHOD_ID,
   ADDRESS_ID,
   NAME,
   '' DOCUMENT_RECEIVER
FROM COMM_METHOD a
INNER JOIN IDENTITY_INVOICE_INFO b ON a.identity = b.identity AND a.party_type = b.party_type
WHERE (a.identity = '9006' or a.identity = '9005' or a.identity = '9001' or a.identity = '9003' or a.identity = '9004' or a.identity = '9002' or a.identity = '9010' or a.identity = '9007' or a.identity = '9008' or a.identity = '9009' or a.identity = '9011' or a.identity = '9012' or a.identity = '9013' or a.identity = '9014' or a.identity = '9015' or a.identity = '9016' or a.identity = '9017' or a.identity = '9018' or a.identity = '9019' or a.identity = '9020' or a.identity = '9021' or a.identity = '9022' or a.identity = '9023' or a.identity = '9024' or a.identity = '9025' or a.identity = '9026' or a.identity = '9027' or a.identity = '9028' or a.identity = '9029' or a.identity = '9030' or a.identity = '9034' or a.identity = '9031' or a.identity = '9032' or a.identity = '9033' or a.identity = '9035' or a.identity = '9036' or a.identity = '9037' or a.identity = '9038' or a.identity = '9039' or a.identity = '9040' or a.identity = '9041' or a.identity = '9042' or a.identity = '9043' or a.identity = '9044' or a.identity = '9045' or a.identity = '9046' or a.identity = '9047' or a.identity = '9048' or a.identity = '9049' or a.identity = '9050' or a.identity = '9051' or a.identity = '9052' or a.identity = '9053' or a.identity = '9054' or a.identity = '9055' or a.identity = '9059' or a.identity = '9056' or a.identity = '9057' or a.identity = '9058' or a.identity = '9060' or a.identity = '9061' or a.identity = '9062' or a.identity = '9063' or a.identity = '9064' or a.identity = '9065' or a.identity = '9066' or a.identity = '9067' or a.identity = '9068' or a.identity = '9069' or a.identity = '9070' or a.identity = '9071' or a.identity = '9072' or a.identity = '9073' or a.identity = '9074' or a.identity = '9075' or a.identity = '9076' or a.identity = '9077' or a.identity = '9078' or a.identity = '9079' or a.identity = '9083' or a.identity = '9080' or a.identity = '9081' or a.identity = '9082' or a.identity = '9084' or a.identity = '9085' or a.identity = '9086' or a.identity = '9087' or a.identity = '9088' or a.identity = '9089' or a.identity = '9090' or a.identity = '9091' or a.identity = '9092' or a.identity = '9093' or a.identity = '9094' or a.identity = '9095' or a.identity = '9096' or a.identity = '9097' or a.identity = '9098' or a.identity = '9099' or a.identity = '9100' or a.identity = '9101' or a.identity = '9102' or a.identity = '9103' or a.identity = '9107' or a.identity = '9104' or a.identity = '9105' or a.identity = '9106' or a.identity = '9108' or a.identity = '9109' or a.identity = '9110' or a.identity = '9111' or a.identity = '9112' or a.identity = '9113' or a.identity = '9114' or a.identity = '9115' or a.identity = '9116' or a.identity = '9117' or a.identity = '9118' or a.identity = '9119' or a.identity = '9120' or a.identity = '9121' or a.identity = '9122' or a.identity = '9123' or a.identity = '9124' or a.identity = '9125' or a.identity = '9126' or a.identity = '9127' or a.identity = '9128' or a.identity = '9129' or a.identity = '9133' or a.identity = '9130' or a.identity = '9131' or a.identity = '9132' or a.identity = '9134' or a.identity = '9135' or a.identity = '9136' or a.identity = '9137' or a.identity = '9138' or a.identity = '9139' or a.identity = '9140' or a.identity = '9141' or a.identity = '9142' or a.identity = '9143' or a.identity = '9144' or a.identity = '9145' or a.identity = '9146' or a.identity = '9147' or a.identity = '9148' or a.identity = '9149' or a.identity = '9150' or a.identity = '9151' or a.identity = '9152' or a.identity = '9158' or a.identity = '9153' or a.identity = '9154' or a.identity = '9155' or a.identity = '9156' or a.identity = '9157' or a.identity = '9159' or a.identity = '9160')) a