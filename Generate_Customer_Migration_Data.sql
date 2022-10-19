-----CUSTOMER_INFO
SELECT 'INSERT INTO MTK_CUSTOMER_INFO_TAB (customer_id,name,association_no,country,creation_date,corporate_form,identifier_reference,identifier_ref_validation_db,cust_grp,cust_price_group_id,cust_ref,market_code,discount_type,discount,currency_code,customer_no_pay,salesman_code,pack_list_flag_db,order_id,date_del,order_conf_flag_db,summarized_source_lines_db,edi_auto_order_approval_db,edi_auto_approval_user,edi_authorize_code,edi_site,mtk_mode,cust_part_acq_val_level_db,cust_part_owner_transfer_db,commission_receiver_db,backorder_option_db,default_language_db,credit_control_group_id,note_text,min_sales_amount,receive_pack_size_chg_db,adv_inv_full_pay_db,email_order_conf_db,email_invoice_db,customer_category_db) VALUES (''' 
                 || customer_id
      || ''',''' || name
      || ''',''' || association_no
      || ''',''' || country
      || ''',''' || creation_date
      || ''',''' || corporate_form
      || ''',''' || identifier_reference
      || ''',''' || identifier_ref_validation
      || ''',''' || cust_grp
      || ''',''' || cust_price_group_id
      || ''',''' || cust_ref
      || ''',''' || market_code
      || ''',''' || discount_type
      || ''',''' || discount
      || ''',''' || currency_code
      || ''',''' || customer_no_pay
      || ''',''' || salesman_code
      || ''',''' || pack_list_flag
      || ''',''' || order_id
      || ''',''' || date_del
      || ''',''' || order_conf_flag
      || ''',''' || summarized_source_lines
      || ''',''' || edi_auto_order_approval
      || ''',''' || edi_auto_approval_user
      || ''',''' || edi_authorize_code
      || ''',''' || edi_site
      || ''',''' || mtk_mode
      || ''',''' || cust_part_acq_val_level
      || ''',''' || cust_part_owner_transfer
      || ''',''' || commission_receiver
      || ''',''' || backorder_option
      || ''',''' || default_language
      || ''',''' || credit_control_group_id
      || ''',''' || note_text
      || ''',''' || min_sales_amount
      || ''',''' || receive_pack_size_chg
      || ''',''' || adv_inv_full_pay
      || ''',''' || email_order_conf
      || ''',''' || email_invoice
      || ''',''' || customer_category
    ||  ''');'   aa
FROM (
SELECT a.customer_id,
       name,
       association_no,
       country,
       creation_date,
       corporate_form,
       identifier_reference,
       identifier_ref_validation,
       cust_grp,
       cust_price_group_id,
       cust_ref,
       market_code,
       discount_type,
       discount,
       currency_code,
       customer_no_pay,
       salesman_code,
       pack_list_flag,
       order_id,
       date_del,
       order_conf_flag,
       summarized_source_lines,
       edi_auto_order_approval,
       edi_auto_approval_user,
       edi_authorize_code,
       edi_site,
       '*' mtk_mode,
       cust_part_acq_val_level,
       cust_part_owner_transfer,
       commission_receiver,
       backorder_option,
       default_language,
       credit_control_group_id,
       note_text,
       min_sales_amount,
       receive_pack_size_chg,
       adv_inv_full_pay,
       email_order_conf,
       email_invoice,
       customer_category
  FROM customer_info_tab a
  LEFt JOIN CUST_ORD_CUSTOMER_TAB b
    on a.customer_id = b.customer_no
 WHERE (CUSTOMER_ID = '7000' or CUSTOMER_ID = '7001' or CUSTOMER_ID = '7003' or CUSTOMER_ID = '7004' or CUSTOMER_ID = '7005' or CUSTOMER_ID = '7006' or CUSTOMER_ID = '7007' or CUSTOMER_ID = '7008' or CUSTOMER_ID = '7009' or CUSTOMER_ID = '7010' or CUSTOMER_ID = '7011' or CUSTOMER_ID = '7012' or CUSTOMER_ID = '7013' or CUSTOMER_ID = '7014' or CUSTOMER_ID = '7015' or CUSTOMER_ID = '7016' or CUSTOMER_ID = '7017' or CUSTOMER_ID = '7018' or CUSTOMER_ID = '7019' or CUSTOMER_ID = '7020' or CUSTOMER_ID = '7021' or CUSTOMER_ID = '7022' or CUSTOMER_ID = '7023' or CUSTOMER_ID = '7024' or CUSTOMER_ID = '7025' or CUSTOMER_ID = '7026' or CUSTOMER_ID = '7027' or CUSTOMER_ID = '7028' or CUSTOMER_ID = '7029' or CUSTOMER_ID = '7030' or CUSTOMER_ID = '7031' or CUSTOMER_ID = '7032' or CUSTOMER_ID = '7033' or CUSTOMER_ID = '7034' or CUSTOMER_ID = '7035' or CUSTOMER_ID = '7036' or CUSTOMER_ID = '7037' or CUSTOMER_ID = '7038' or CUSTOMER_ID = '7039' or CUSTOMER_ID = '7040' or CUSTOMER_ID = '7041' or CUSTOMER_ID = '7042' or CUSTOMER_ID = '7043' or CUSTOMER_ID = '7044' or CUSTOMER_ID = '7045' or CUSTOMER_ID = '7046' or CUSTOMER_ID = '7047' or CUSTOMER_ID = '7048' or CUSTOMER_ID = '7049' or CUSTOMER_ID = '7050' or CUSTOMER_ID = '7051' or CUSTOMER_ID = '7052' or CUSTOMER_ID = '7053' or CUSTOMER_ID = '7054' or CUSTOMER_ID = '7055' or CUSTOMER_ID = '7056' or CUSTOMER_ID = '7057' or CUSTOMER_ID = '7058' or CUSTOMER_ID = '7059' or CUSTOMER_ID = '7060' or CUSTOMER_ID = '7061' or CUSTOMER_ID = '7062' or CUSTOMER_ID = '7063' or CUSTOMER_ID = '7064' or CUSTOMER_ID = '7065' or CUSTOMER_ID = '7066' or CUSTOMER_ID = '7067' or CUSTOMER_ID = '7068' or CUSTOMER_ID = '7069' or CUSTOMER_ID = '7070' or CUSTOMER_ID = '7071' or CUSTOMER_ID = '7072' or CUSTOMER_ID = '7073' or CUSTOMER_ID = '7074' or CUSTOMER_ID = '7075' or CUSTOMER_ID = '7076' or CUSTOMER_ID = '7077' or CUSTOMER_ID = '7078' or CUSTOMER_ID = '7079' or CUSTOMER_ID = '7080' or CUSTOMER_ID = '7081' or CUSTOMER_ID = '7082' or CUSTOMER_ID = '7083' or CUSTOMER_ID = '7084' or CUSTOMER_ID = '7085' or CUSTOMER_ID = '7086' or CUSTOMER_ID = '7087' or CUSTOMER_ID = '7088' or CUSTOMER_ID = '7089' or CUSTOMER_ID = '7090' or CUSTOMER_ID = '7091' or CUSTOMER_ID = '7092' or CUSTOMER_ID = '7093' or CUSTOMER_ID = '7094' or CUSTOMER_ID = '7095' or CUSTOMER_ID = '7096' or CUSTOMER_ID = '7097' or CUSTOMER_ID = '7098' or CUSTOMER_ID = '7099' or CUSTOMER_ID = '7100' or CUSTOMER_ID = '7101' or CUSTOMER_ID = '7102' or CUSTOMER_ID = '7103' or CUSTOMER_ID = '7104' or CUSTOMER_ID = '7105' or CUSTOMER_ID = '7106' or CUSTOMER_ID = '7107' or CUSTOMER_ID = '7108' or CUSTOMER_ID = '7109' or CUSTOMER_ID = '7110' or CUSTOMER_ID = '7111' or CUSTOMER_ID = '7112' or CUSTOMER_ID = '7113' or CUSTOMER_ID = '7114' or CUSTOMER_ID = '7115' or CUSTOMER_ID = '7116' or CUSTOMER_ID = '7117' or CUSTOMER_ID = '7118' or CUSTOMER_ID = '7119' or CUSTOMER_ID = '7120' or CUSTOMER_ID = '7121' or CUSTOMER_ID = '7122' or CUSTOMER_ID = '7123' or CUSTOMER_ID = '7124' or CUSTOMER_ID = '7125' or CUSTOMER_ID = '7126' or CUSTOMER_ID = '7127' or CUSTOMER_ID = '7128' or CUSTOMER_ID = '7129' or CUSTOMER_ID = '7130' or CUSTOMER_ID = '7131' or CUSTOMER_ID = '7132' or CUSTOMER_ID = '7133' or CUSTOMER_ID = '7134' or CUSTOMER_ID = '7135' or CUSTOMER_ID = '7136' or CUSTOMER_ID = '7137' or CUSTOMER_ID = '7138' or CUSTOMER_ID = '7139' or CUSTOMER_ID = '7140' or CUSTOMER_ID = '7141' or CUSTOMER_ID = '7142' or CUSTOMER_ID = '7143' or CUSTOMER_ID = '7144' or CUSTOMER_ID = '7145' or CUSTOMER_ID = '7146' or CUSTOMER_ID = '7147' or CUSTOMER_ID = '7148' or CUSTOMER_ID = '7149' or CUSTOMER_ID = '7150' or CUSTOMER_ID = '7151' or CUSTOMER_ID = '7152' or CUSTOMER_ID = '7153' or CUSTOMER_ID = '7154' or CUSTOMER_ID = '7155' or CUSTOMER_ID = '7156' or CUSTOMER_ID = '7157' or CUSTOMER_ID = '7158' or CUSTOMER_ID = '7159' or CUSTOMER_ID = '7160' or CUSTOMER_ID = '7167' or CUSTOMER_ID = '7168' or CUSTOMER_ID = '7169' or CUSTOMER_ID = '7170' or CUSTOMER_ID = '7171' or CUSTOMER_ID = '7172' or CUSTOMER_ID = '7173' or CUSTOMER_ID = '7174' or CUSTOMER_ID = '7175' or CUSTOMER_ID = '7176')) aaa



------CUSTOMER_INFO_ADDRESS
SELECT 'INSERT INTO MTK_CUSTOMER_INFO_ADDRESS_TAB (customer_id,address_id,address1,address2,city,state,zip_code,county,country,in_city,valid_from,valid_to,primary_contact,secondary_contact,def_address_pay,def_address_document,def_address_delivery,def_address_primary_contact,def_address_secondary_contact,def_address_visit,def_address_home,company_name2,delivery_terms,ship_via_code,route_id,delivery_time,contact,region_code,district_code,intrastat_exempt_db,mtk_mode,ean_location,del_terms_location,end_customer_id,end_cust_addr_id) VALUES (''' 
                 || customer_id
      || ''',''' || address_id
      || ''',''' || address1
      || ''',''' || address2
      || ''',''' || city
      || ''',''' || state
      || ''',''' || zip_code
      || ''',''' || county
      || ''',''' || country
      || ''',''' || in_city
      || ''',''' || valid_from
      || ''',''' || valid_to
      || ''',''' || primary_contact
      || ''',''' || secondary_contact
      || ''',''' || def_address_pay
      || ''',''' || def_address_document
      || ''',''' || def_address_delivery
      || ''',''' || def_address_primary_contact
      || ''',''' || def_address_secondary_contact
      || ''',''' || def_address_visit
      || ''',''' || def_address_home
      || ''',''' || company_name2
      || ''',''' || delivery_terms
      || ''',''' || ship_via_code
      || ''',''' || route_id
      || ''',''' || delivery_time
      || ''',''' || contact
      || ''',''' || region_code
      || ''',''' || district_code
      || ''',''' || intrastat_exempt
      || ''',''' || mtk_mode
      || ''',''' || ean_location
      || ''',''' || del_terms_location
      || ''',''' || end_customer_id
      || ''',''' || end_cust_addr_id
    ||  ''');'   aa
FROM (SELECT customer_id,
       address_id,
       translate(REPLACE(REPLACE(address1,'''','-'),'&','-'), chr(10)||chr(11)||chr(13), '    ') address1,
       translate(REPLACE(REPLACE(address2,'''','-'),'&','-'), chr(10)||chr(11)||chr(13), '    ') address2,
       city,
       state,
       zip_code,
       county,
       country,
       in_city,
       valid_from,
       valid_to,
       primary_contact,
       secondary_contact,
       'TRUE' def_address_pay,
       'TRUE' def_address_document,
       'TRUE' def_address_delivery,
       'TRUE' def_address_primary_contact,
       'TRUE' def_address_secondary_contact,
       'TRUE' def_address_visit,
       'TRUE' def_address_home,
       company_name2,
       delivery_terms,
       ship_via_code,
       route_id,
       delivery_time,
       contact,
       region_code,
       district_code,
       intrastat_exempt,
       '*' mtk_mode,
       ean_location,
       del_terms_location,
       end_customer_id,
       end_cust_addr_id
  FROM CUSTOMER_INFO_ADDRESS_TAB a
  LEFT JOIN CUST_ORD_CUSTOMER_ADDRESS_TAB b
    on a.customer_id = b.customer_no
   AND a.address_id = b.addr_no
 WHERE (CUSTOMER_ID = '7000' or CUSTOMER_ID = '7001' or CUSTOMER_ID = '7003' or CUSTOMER_ID = '7004' or CUSTOMER_ID = '7005' or CUSTOMER_ID = '7006' or CUSTOMER_ID = '7007' or CUSTOMER_ID = '7008' or CUSTOMER_ID = '7009' or CUSTOMER_ID = '7010' or CUSTOMER_ID = '7011' or CUSTOMER_ID = '7012' or CUSTOMER_ID = '7013' or CUSTOMER_ID = '7014' or CUSTOMER_ID = '7015' or CUSTOMER_ID = '7016' or CUSTOMER_ID = '7017' or CUSTOMER_ID = '7018' or CUSTOMER_ID = '7019' or CUSTOMER_ID = '7020' or CUSTOMER_ID = '7021' or CUSTOMER_ID = '7022' or CUSTOMER_ID = '7023' or CUSTOMER_ID = '7024' or CUSTOMER_ID = '7025' or CUSTOMER_ID = '7026' or CUSTOMER_ID = '7027' or CUSTOMER_ID = '7028' or CUSTOMER_ID = '7029' or CUSTOMER_ID = '7030' or CUSTOMER_ID = '7031' or CUSTOMER_ID = '7032' or CUSTOMER_ID = '7033' or CUSTOMER_ID = '7034' or CUSTOMER_ID = '7035' or CUSTOMER_ID = '7036' or CUSTOMER_ID = '7037' or CUSTOMER_ID = '7038' or CUSTOMER_ID = '7039' or CUSTOMER_ID = '7040' or CUSTOMER_ID = '7041' or CUSTOMER_ID = '7042' or CUSTOMER_ID = '7043' or CUSTOMER_ID = '7044' or CUSTOMER_ID = '7045' or CUSTOMER_ID = '7046' or CUSTOMER_ID = '7047' or CUSTOMER_ID = '7048' or CUSTOMER_ID = '7049' or CUSTOMER_ID = '7050' or CUSTOMER_ID = '7051' or CUSTOMER_ID = '7052' or CUSTOMER_ID = '7053' or CUSTOMER_ID = '7054' or CUSTOMER_ID = '7055' or CUSTOMER_ID = '7056' or CUSTOMER_ID = '7057' or CUSTOMER_ID = '7058' or CUSTOMER_ID = '7059' or CUSTOMER_ID = '7060' or CUSTOMER_ID = '7061' or CUSTOMER_ID = '7062' or CUSTOMER_ID = '7063' or CUSTOMER_ID = '7064' or CUSTOMER_ID = '7065' or CUSTOMER_ID = '7066' or CUSTOMER_ID = '7067' or CUSTOMER_ID = '7068' or CUSTOMER_ID = '7069' or CUSTOMER_ID = '7070' or CUSTOMER_ID = '7071' or CUSTOMER_ID = '7072' or CUSTOMER_ID = '7073' or CUSTOMER_ID = '7074' or CUSTOMER_ID = '7075' or CUSTOMER_ID = '7076' or CUSTOMER_ID = '7077' or CUSTOMER_ID = '7078' or CUSTOMER_ID = '7079' or CUSTOMER_ID = '7080' or CUSTOMER_ID = '7081' or CUSTOMER_ID = '7082' or CUSTOMER_ID = '7083' or CUSTOMER_ID = '7084' or CUSTOMER_ID = '7085' or CUSTOMER_ID = '7086' or CUSTOMER_ID = '7087' or CUSTOMER_ID = '7088' or CUSTOMER_ID = '7089' or CUSTOMER_ID = '7090' or CUSTOMER_ID = '7091' or CUSTOMER_ID = '7092' or CUSTOMER_ID = '7093' or CUSTOMER_ID = '7094' or CUSTOMER_ID = '7095' or CUSTOMER_ID = '7096' or CUSTOMER_ID = '7097' or CUSTOMER_ID = '7098' or CUSTOMER_ID = '7099' or CUSTOMER_ID = '7100' or CUSTOMER_ID = '7101' or CUSTOMER_ID = '7102' or CUSTOMER_ID = '7103' or CUSTOMER_ID = '7104' or CUSTOMER_ID = '7105' or CUSTOMER_ID = '7106' or CUSTOMER_ID = '7107' or CUSTOMER_ID = '7108' or CUSTOMER_ID = '7109' or CUSTOMER_ID = '7110' or CUSTOMER_ID = '7111' or CUSTOMER_ID = '7112' or CUSTOMER_ID = '7113' or CUSTOMER_ID = '7114' or CUSTOMER_ID = '7115' or CUSTOMER_ID = '7116' or CUSTOMER_ID = '7117' or CUSTOMER_ID = '7118' or CUSTOMER_ID = '7119' or CUSTOMER_ID = '7120' or CUSTOMER_ID = '7121' or CUSTOMER_ID = '7122' or CUSTOMER_ID = '7123' or CUSTOMER_ID = '7124' or CUSTOMER_ID = '7125' or CUSTOMER_ID = '7126' or CUSTOMER_ID = '7127' or CUSTOMER_ID = '7128' or CUSTOMER_ID = '7129' or CUSTOMER_ID = '7130' or CUSTOMER_ID = '7131' or CUSTOMER_ID = '7132' or CUSTOMER_ID = '7133' or CUSTOMER_ID = '7134' or CUSTOMER_ID = '7135' or CUSTOMER_ID = '7136' or CUSTOMER_ID = '7137' or CUSTOMER_ID = '7138' or CUSTOMER_ID = '7139' or CUSTOMER_ID = '7140' or CUSTOMER_ID = '7141' or CUSTOMER_ID = '7142' or CUSTOMER_ID = '7143' or CUSTOMER_ID = '7144' or CUSTOMER_ID = '7145' or CUSTOMER_ID = '7146' or CUSTOMER_ID = '7147' or CUSTOMER_ID = '7148' or CUSTOMER_ID = '7149' or CUSTOMER_ID = '7150' or CUSTOMER_ID = '7151' or CUSTOMER_ID = '7152' or CUSTOMER_ID = '7153' or CUSTOMER_ID = '7154' or CUSTOMER_ID = '7155' or CUSTOMER_ID = '7156' or CUSTOMER_ID = '7157' or CUSTOMER_ID = '7158' or CUSTOMER_ID = '7159' or CUSTOMER_ID = '7160' or CUSTOMER_ID = '7167' or CUSTOMER_ID = '7168' or CUSTOMER_ID = '7169' or CUSTOMER_ID = '7170' or CUSTOMER_ID = '7171' or CUSTOMER_ID = '7172' or CUSTOMER_ID = '7173' or CUSTOMER_ID = '7174' or CUSTOMER_ID = '7175' or CUSTOMER_ID = '7176')) cc

------Customer-Company
SELECT 'INSERT INTO mtk_customer_company_pay_tab (customer_id,company,way_id,credit_rating,credit_analyst_code,credit_limit,parent_identity,group_id,pay_term_id,currency_code,expire_date,other_payee_identity,mtk_mode,credit_number,avg_days_for_payment,credit_comments,credit_block,next_review_date,allowed_due_days,allowed_due_amount,identity_type_db,notes,last4q_sales,add_payment_record,interest_template,def_vat_code) VALUES (''' 
                 || customer_id
      || ''',''' || company
      || ''',''' || way_id
      || ''',''' || credit_rating
      || ''',''' || credit_analyst_code
      || ''',''' || credit_limit
      || ''',''' || parent_identity
      || ''',''' || group_id
      || ''',''' || pay_term_id
      || ''',''' || currency_code
      || ''',''' || expire_date
      || ''',''' || other_payee_identity
      || ''',''' || mtk_mode
      || ''',''' || credit_number
      || ''',''' || avg_days_for_payment
      || ''',''' || credit_comments
      || ''',''' || credit_block
      || ''',''' || next_review_date
      || ''',''' || allowed_due_days
      || ''',''' || allowed_due_amount
      || ''',''' || identity_type
      || ''',''' || notes
      || ''',''' || last4q_sales
      || ''',''' || add_payment_record
      || ''',''' || interest_template
      || ''',''' || def_vat_code
    ||  ''');'   aa
FROM (SELECT 
   a.identity customer_id,
   a.company,
   way_id,
   credit_rating,
   credit_analyst_code,
   credit_limit,
   parent_identity,
   group_id,
   pay_term_id,
   DEF_CURRENCY currency_code,
   expire_date,
   other_payee_identity,
   '*' mtk_mode,
   credit_number,
   avg_days_for_payment,
   credit_comments,
   credit_block,
   next_review_date,
   allowed_due_days,
   allowed_due_amount,
   identity_type,
   notes,
   last4q_sales,   
   'Y' add_payment_record,
   interest_template,
   def_vat_code   
FROM identity_invoice_info_tab a
LEFT JOIN customer_credit_info_tab b ON b.identity = a.identity AND b.COMPANY = a.COMPANY
left join identity_pay_info_tab c ON c.identity = a.identity AND c.COMPANY = a.COMPANY
left join payment_way_per_identity_tab d ON d.identity = a.identity AND d.COMPANY = a.COMPANY
WHERE (a.identity = '7000' or a.identity = '7001' or a.identity = '7003' or a.identity = '7004' or a.identity = '7005' or a.identity = '7006' or a.identity = '7007' or a.identity = '7008' or a.identity = '7009' or a.identity = '7010' or a.identity = '7011' or a.identity = '7012' or a.identity = '7013' or a.identity = '7014' or a.identity = '7015' or a.identity = '7016' or a.identity = '7017' or a.identity = '7018' or a.identity = '7019' or a.identity = '7020' or a.identity = '7021' or a.identity = '7022' or a.identity = '7023' or a.identity = '7024' or a.identity = '7025' or a.identity = '7026' or a.identity = '7027' or a.identity = '7028' or a.identity = '7029' or a.identity = '7030' or a.identity = '7031' or a.identity = '7032' or a.identity = '7033' or a.identity = '7034' or a.identity = '7035' or a.identity = '7036' or a.identity = '7037' or a.identity = '7038' or a.identity = '7039' or a.identity = '7040' or a.identity = '7041' or a.identity = '7042' or a.identity = '7043' or a.identity = '7044' or a.identity = '7045' or a.identity = '7046' or a.identity = '7047' or a.identity = '7048' or a.identity = '7049' or a.identity = '7050' or a.identity = '7051' or a.identity = '7052' or a.identity = '7053' or a.identity = '7054' or a.identity = '7055' or a.identity = '7056' or a.identity = '7057' or a.identity = '7058' or a.identity = '7059' or a.identity = '7060' or a.identity = '7061' or a.identity = '7062' or a.identity = '7063' or a.identity = '7064' or a.identity = '7065' or a.identity = '7066' or a.identity = '7067' or a.identity = '7068' or a.identity = '7069' or a.identity = '7070' or a.identity = '7071' or a.identity = '7072' or a.identity = '7073' or a.identity = '7074' or a.identity = '7075' or a.identity = '7076' or a.identity = '7077' or a.identity = '7078' or a.identity = '7079' or a.identity = '7080' or a.identity = '7081' or a.identity = '7082' or a.identity = '7083' or a.identity = '7084' or a.identity = '7085' or a.identity = '7086' or a.identity = '7087' or a.identity = '7088' or a.identity = '7089' or a.identity = '7090' or a.identity = '7091' or a.identity = '7092' or a.identity = '7093' or a.identity = '7094' or a.identity = '7095' or a.identity = '7096' or a.identity = '7097' or a.identity = '7098' or a.identity = '7099' or a.identity = '7100' or a.identity = '7101' or a.identity = '7102' or a.identity = '7103' or a.identity = '7104' or a.identity = '7105' or a.identity = '7106' or a.identity = '7107' or a.identity = '7108' or a.identity = '7109' or a.identity = '7110' or a.identity = '7111' or a.identity = '7112' or a.identity = '7113' or a.identity = '7114' or a.identity = '7115' or a.identity = '7116' or a.identity = '7117' or a.identity = '7118' or a.identity = '7119' or a.identity = '7120' or a.identity = '7121' or a.identity = '7122' or a.identity = '7123' or a.identity = '7124' or a.identity = '7125' or a.identity = '7126' or a.identity = '7127' or a.identity = '7128' or a.identity = '7129' or a.identity = '7130' or a.identity = '7131' or a.identity = '7132' or a.identity = '7133' or a.identity = '7134' or a.identity = '7135' or a.identity = '7136' or a.identity = '7137' or a.identity = '7138' or a.identity = '7139' or a.identity = '7140' or a.identity = '7141' or a.identity = '7142' or a.identity = '7143' or a.identity = '7144' or a.identity = '7145' or a.identity = '7146' or a.identity = '7147' or a.identity = '7148' or a.identity = '7149' or a.identity = '7150' or a.identity = '7151' or a.identity = '7152' or a.identity = '7153' or a.identity = '7154' or a.identity = '7155' or a.identity = '7156' or a.identity = '7157' or a.identity = '7158' or a.identity = '7159' or a.identity = '7160' or a.identity = '7167' or a.identity = '7168' or a.identity = '7169' or a.identity = '7170' or a.identity = '7171' or a.identity = '7172' or a.identity = '7173' or a.identity = '7174' or a.identity = '7175' or a.identity = '7176')) ss

-----Customer-Info-Comm-Method
SELECT 'INSERT INTO MTK_CUST_INFO_COMM_METHOD_TAB (customer_id,comm_id,value,description,valid_from,valid_to,method_default,address_default,method_id,address_id,name) VALUES (''' 
               || customer_id
    || ''',''' || COMM_ID
    || ''',''' || VALUE
    || ''',''' || DESCRIPTION
    || ''',''' || VALID_FROM
    || ''',''' || VALID_TO
    || ''',''' || METHOD_DEFAULT
    || ''',''' || ADDRESS_DEFAULT
    || ''',''' || METHOD_ID
    || ''',''' || ADDRESS_ID
    || ''',''' || NAME   
    ||  ''');'   aa
FROM (SELECT
   IDENTITY CUSTOMER_ID,
   COMM_ID,
   VALUE,
   DESCRIPTION,
   VALID_FROM,
   VALID_TO,
   METHOD_DEFAULT,
   ADDRESS_DEFAULT,
   METHOD_ID,
   ADDRESS_ID,
   NAME   
FROM comm_method_tab a
WHERE PARTY_TYPE = 'CUSTOMER' AND (a.identity = '7000' or a.identity = '7001' or a.identity = '7003' or a.identity = '7004' or a.identity = '7005' or a.identity = '7006' or a.identity = '7007' or a.identity = '7008' or a.identity = '7009' or a.identity = '7010' or a.identity = '7011' or a.identity = '7012' or a.identity = '7013' or a.identity = '7014' or a.identity = '7015' or a.identity = '7016' or a.identity = '7017' or a.identity = '7018' or a.identity = '7019' or a.identity = '7020' or a.identity = '7021' or a.identity = '7022' or a.identity = '7023' or a.identity = '7024' or a.identity = '7025' or a.identity = '7026' or a.identity = '7027' or a.identity = '7028' or a.identity = '7029' or a.identity = '7030' or a.identity = '7031' or a.identity = '7032' or a.identity = '7033' or a.identity = '7034' or a.identity = '7035' or a.identity = '7036' or a.identity = '7037' or a.identity = '7038' or a.identity = '7039' or a.identity = '7040' or a.identity = '7041' or a.identity = '7042' or a.identity = '7043' or a.identity = '7044' or a.identity = '7045' or a.identity = '7046' or a.identity = '7047' or a.identity = '7048' or a.identity = '7049' or a.identity = '7050' or a.identity = '7051' or a.identity = '7052' or a.identity = '7053' or a.identity = '7054' or a.identity = '7055' or a.identity = '7056' or a.identity = '7057' or a.identity = '7058' or a.identity = '7059' or a.identity = '7060' or a.identity = '7061' or a.identity = '7062' or a.identity = '7063' or a.identity = '7064' or a.identity = '7065' or a.identity = '7066' or a.identity = '7067' or a.identity = '7068' or a.identity = '7069' or a.identity = '7070' or a.identity = '7071' or a.identity = '7072' or a.identity = '7073' or a.identity = '7074' or a.identity = '7075' or a.identity = '7076' or a.identity = '7077' or a.identity = '7078' or a.identity = '7079' or a.identity = '7080' or a.identity = '7081' or a.identity = '7082' or a.identity = '7083' or a.identity = '7084' or a.identity = '7085' or a.identity = '7086' or a.identity = '7087' or a.identity = '7088' or a.identity = '7089' or a.identity = '7090' or a.identity = '7091' or a.identity = '7092' or a.identity = '7093' or a.identity = '7094' or a.identity = '7095' or a.identity = '7096' or a.identity = '7097' or a.identity = '7098' or a.identity = '7099' or a.identity = '7100' or a.identity = '7101' or a.identity = '7102' or a.identity = '7103' or a.identity = '7104' or a.identity = '7105' or a.identity = '7106' or a.identity = '7107' or a.identity = '7108' or a.identity = '7109' or a.identity = '7110' or a.identity = '7111' or a.identity = '7112' or a.identity = '7113' or a.identity = '7114' or a.identity = '7115' or a.identity = '7116' or a.identity = '7117' or a.identity = '7118' or a.identity = '7119' or a.identity = '7120' or a.identity = '7121' or a.identity = '7122' or a.identity = '7123' or a.identity = '7124' or a.identity = '7125' or a.identity = '7126' or a.identity = '7127' or a.identity = '7128' or a.identity = '7129' or a.identity = '7130' or a.identity = '7131' or a.identity = '7132' or a.identity = '7133' or a.identity = '7134' or a.identity = '7135' or a.identity = '7136' or a.identity = '7137' or a.identity = '7138' or a.identity = '7139' or a.identity = '7140' or a.identity = '7141' or a.identity = '7142' or a.identity = '7143' or a.identity = '7144' or a.identity = '7145' or a.identity = '7146' or a.identity = '7147' or a.identity = '7148' or a.identity = '7149' or a.identity = '7150' or a.identity = '7151' or a.identity = '7152' or a.identity = '7153' or a.identity = '7154' or a.identity = '7155' or a.identity = '7156' or a.identity = '7157' or a.identity = '7158' or a.identity = '7159' or a.identity = '7160' or a.identity = '7167' or a.identity = '7168' or a.identity = '7169' or a.identity = '7170' or a.identity = '7171' or a.identity = '7172' or a.identity = '7173' or a.identity = '7174' or a.identity = '7175' or a.identity = '7176')) kkk

----Customer_Document-Text
SELECT 
   a.CUSTOMER_ID,
   b.NOTE_TEXT,
   b.OUTPUT_TYPE   
FROM CUST_ORD_CUSTOMER_ENT a
INNER JOIN DOCUMENT_TEXT b ON b.note_id = a.note_id AND output_type != 'PURCHASE'
WHERE (CUSTOMER_ID = '7000' or CUSTOMER_ID = '7001' or CUSTOMER_ID = '7003' or CUSTOMER_ID = '7004' or CUSTOMER_ID = '7005' or CUSTOMER_ID = '7006' or CUSTOMER_ID = '7007' or CUSTOMER_ID = '7008' or CUSTOMER_ID = '7009' or CUSTOMER_ID = '7010' or CUSTOMER_ID = '7011' or CUSTOMER_ID = '7012' or CUSTOMER_ID = '7013' or CUSTOMER_ID = '7014' or CUSTOMER_ID = '7015' or CUSTOMER_ID = '7016' or CUSTOMER_ID = '7017' or CUSTOMER_ID = '7018' or CUSTOMER_ID = '7019' or CUSTOMER_ID = '7020' or CUSTOMER_ID = '7021' or CUSTOMER_ID = '7022' or CUSTOMER_ID = '7023' or CUSTOMER_ID = '7024' or CUSTOMER_ID = '7025' or CUSTOMER_ID = '7026' or CUSTOMER_ID = '7027' or CUSTOMER_ID = '7028' or CUSTOMER_ID = '7029' or CUSTOMER_ID = '7030' or CUSTOMER_ID = '7031' or CUSTOMER_ID = '7032' or CUSTOMER_ID = '7033' or CUSTOMER_ID = '7034' or CUSTOMER_ID = '7035' or CUSTOMER_ID = '7036' or CUSTOMER_ID = '7037' or CUSTOMER_ID = '7038' or CUSTOMER_ID = '7039' or CUSTOMER_ID = '7040' or CUSTOMER_ID = '7041' or CUSTOMER_ID = '7042' or CUSTOMER_ID = '7043' or CUSTOMER_ID = '7044' or CUSTOMER_ID = '7045' or CUSTOMER_ID = '7046' or CUSTOMER_ID = '7047' or CUSTOMER_ID = '7048' or CUSTOMER_ID = '7049' or CUSTOMER_ID = '7050' or CUSTOMER_ID = '7051' or CUSTOMER_ID = '7052' or CUSTOMER_ID = '7053' or CUSTOMER_ID = '7054' or CUSTOMER_ID = '7055' or CUSTOMER_ID = '7056' or CUSTOMER_ID = '7057' or CUSTOMER_ID = '7058' or CUSTOMER_ID = '7059' or CUSTOMER_ID = '7060' or CUSTOMER_ID = '7061' or CUSTOMER_ID = '7062' or CUSTOMER_ID = '7063' or CUSTOMER_ID = '7064' or CUSTOMER_ID = '7065' or CUSTOMER_ID = '7066' or CUSTOMER_ID = '7067' or CUSTOMER_ID = '7068' or CUSTOMER_ID = '7069' or CUSTOMER_ID = '7070' or CUSTOMER_ID = '7071' or CUSTOMER_ID = '7072' or CUSTOMER_ID = '7073' or CUSTOMER_ID = '7074' or CUSTOMER_ID = '7075' or CUSTOMER_ID = '7076' or CUSTOMER_ID = '7077' or CUSTOMER_ID = '7078' or CUSTOMER_ID = '7079' or CUSTOMER_ID = '7080' or CUSTOMER_ID = '7081' or CUSTOMER_ID = '7082' or CUSTOMER_ID = '7083' or CUSTOMER_ID = '7084' or CUSTOMER_ID = '7085' or CUSTOMER_ID = '7086' or CUSTOMER_ID = '7087' or CUSTOMER_ID = '7088' or CUSTOMER_ID = '7089' or CUSTOMER_ID = '7090' or CUSTOMER_ID = '7091' or CUSTOMER_ID = '7092' or CUSTOMER_ID = '7093' or CUSTOMER_ID = '7094' or CUSTOMER_ID = '7095' or CUSTOMER_ID = '7096' or CUSTOMER_ID = '7097' or CUSTOMER_ID = '7098' or CUSTOMER_ID = '7099' or CUSTOMER_ID = '7100' or CUSTOMER_ID = '7101' or CUSTOMER_ID = '7102' or CUSTOMER_ID = '7103' or CUSTOMER_ID = '7104' or CUSTOMER_ID = '7105' or CUSTOMER_ID = '7106' or CUSTOMER_ID = '7107' or CUSTOMER_ID = '7108' or CUSTOMER_ID = '7109' or CUSTOMER_ID = '7110' or CUSTOMER_ID = '7111' or CUSTOMER_ID = '7112' or CUSTOMER_ID = '7113' or CUSTOMER_ID = '7114' or CUSTOMER_ID = '7115' or CUSTOMER_ID = '7116' or CUSTOMER_ID = '7117' or CUSTOMER_ID = '7118' or CUSTOMER_ID = '7119' or CUSTOMER_ID = '7120' or CUSTOMER_ID = '7121' or CUSTOMER_ID = '7122' or CUSTOMER_ID = '7123' or CUSTOMER_ID = '7124' or CUSTOMER_ID = '7125' or CUSTOMER_ID = '7126' or CUSTOMER_ID = '7127' or CUSTOMER_ID = '7128' or CUSTOMER_ID = '7129' or CUSTOMER_ID = '7130' or CUSTOMER_ID = '7131' or CUSTOMER_ID = '7132' or CUSTOMER_ID = '7133' or CUSTOMER_ID = '7134' or CUSTOMER_ID = '7135' or CUSTOMER_ID = '7136' or CUSTOMER_ID = '7137' or CUSTOMER_ID = '7138' or CUSTOMER_ID = '7139' or CUSTOMER_ID = '7140' or CUSTOMER_ID = '7141' or CUSTOMER_ID = '7142' or CUSTOMER_ID = '7143' or CUSTOMER_ID = '7144' or CUSTOMER_ID = '7145' or CUSTOMER_ID = '7146' or CUSTOMER_ID = '7147' or CUSTOMER_ID = '7148' or CUSTOMER_ID = '7149' or CUSTOMER_ID = '7150' or CUSTOMER_ID = '7151' or CUSTOMER_ID = '7152' or CUSTOMER_ID = '7153' or CUSTOMER_ID = '7154' or CUSTOMER_ID = '7155' or CUSTOMER_ID = '7156' or CUSTOMER_ID = '7157' or CUSTOMER_ID = '7158' or CUSTOMER_ID = '7159' or CUSTOMER_ID = '7160' or CUSTOMER_ID = '7167' or CUSTOMER_ID = '7168' or CUSTOMER_ID = '7169' or CUSTOMER_ID = '7170' or CUSTOMER_ID = '7171' or CUSTOMER_ID = '7172' or CUSTOMER_ID = '7173' or CUSTOMER_ID = '7174' or CUSTOMER_ID = '7175' or CUSTOMER_ID = '7176')

---Customer-Tax-info
SELECT 'INSERT INTO mtk_customer_tax_info_tab (customer_id,address_id,company,tax_regime_db,tax_withholding_db,tax_rounding_method_db,tax_rounding_level_db,mtk_mode) VALUES (''' 
                 || customer_id
      || ''',''' || address_id
      || ''',''' || COMPANY
      || ''',''' || TAX_REGIME
      || ''',''' || TAX_WITHHOLDING
      || ''',''' || TAX_ROUNDING_METHOD
      || ''',''' || TAX_ROUNDING_LEVEL
      || ''',''' || MTK_MODE
    ||  ''');'   aa
FROM (SELECT
   CUSTOMER_ID,
   ADDRESS_ID,
   COMPANY,
   TAX_REGIME,
   TAX_WITHHOLDING,
   TAX_ROUNDING_METHOD,
   TAX_ROUNDING_LEVEL,
   '*' MTK_MODE   
FROM customer_tax_info_tab
WHERE (CUSTOMER_ID = '7000' or CUSTOMER_ID = '7001' or CUSTOMER_ID = '7003' or CUSTOMER_ID = '7004' or CUSTOMER_ID = '7005' or CUSTOMER_ID = '7006' or CUSTOMER_ID = '7007' or CUSTOMER_ID = '7008' or CUSTOMER_ID = '7009' or CUSTOMER_ID = '7010' or CUSTOMER_ID = '7011' or CUSTOMER_ID = '7012' or CUSTOMER_ID = '7013' or CUSTOMER_ID = '7014' or CUSTOMER_ID = '7015' or CUSTOMER_ID = '7016' or CUSTOMER_ID = '7017' or CUSTOMER_ID = '7018' or CUSTOMER_ID = '7019' or CUSTOMER_ID = '7020' or CUSTOMER_ID = '7021' or CUSTOMER_ID = '7022' or CUSTOMER_ID = '7023' or CUSTOMER_ID = '7024' or CUSTOMER_ID = '7025' or CUSTOMER_ID = '7026' or CUSTOMER_ID = '7027' or CUSTOMER_ID = '7028' or CUSTOMER_ID = '7029' or CUSTOMER_ID = '7030' or CUSTOMER_ID = '7031' or CUSTOMER_ID = '7032' or CUSTOMER_ID = '7033' or CUSTOMER_ID = '7034' or CUSTOMER_ID = '7035' or CUSTOMER_ID = '7036' or CUSTOMER_ID = '7037' or CUSTOMER_ID = '7038' or CUSTOMER_ID = '7039' or CUSTOMER_ID = '7040' or CUSTOMER_ID = '7041' or CUSTOMER_ID = '7042' or CUSTOMER_ID = '7043' or CUSTOMER_ID = '7044' or CUSTOMER_ID = '7045' or CUSTOMER_ID = '7046' or CUSTOMER_ID = '7047' or CUSTOMER_ID = '7048' or CUSTOMER_ID = '7049' or CUSTOMER_ID = '7050' or CUSTOMER_ID = '7051' or CUSTOMER_ID = '7052' or CUSTOMER_ID = '7053' or CUSTOMER_ID = '7054' or CUSTOMER_ID = '7055' or CUSTOMER_ID = '7056' or CUSTOMER_ID = '7057' or CUSTOMER_ID = '7058' or CUSTOMER_ID = '7059' or CUSTOMER_ID = '7060' or CUSTOMER_ID = '7061' or CUSTOMER_ID = '7062' or CUSTOMER_ID = '7063' or CUSTOMER_ID = '7064' or CUSTOMER_ID = '7065' or CUSTOMER_ID = '7066' or CUSTOMER_ID = '7067' or CUSTOMER_ID = '7068' or CUSTOMER_ID = '7069' or CUSTOMER_ID = '7070' or CUSTOMER_ID = '7071' or CUSTOMER_ID = '7072' or CUSTOMER_ID = '7073' or CUSTOMER_ID = '7074' or CUSTOMER_ID = '7075' or CUSTOMER_ID = '7076' or CUSTOMER_ID = '7077' or CUSTOMER_ID = '7078' or CUSTOMER_ID = '7079' or CUSTOMER_ID = '7080' or CUSTOMER_ID = '7081' or CUSTOMER_ID = '7082' or CUSTOMER_ID = '7083' or CUSTOMER_ID = '7084' or CUSTOMER_ID = '7085' or CUSTOMER_ID = '7086' or CUSTOMER_ID = '7087' or CUSTOMER_ID = '7088' or CUSTOMER_ID = '7089' or CUSTOMER_ID = '7090' or CUSTOMER_ID = '7091' or CUSTOMER_ID = '7092' or CUSTOMER_ID = '7093' or CUSTOMER_ID = '7094' or CUSTOMER_ID = '7095' or CUSTOMER_ID = '7096' or CUSTOMER_ID = '7097' or CUSTOMER_ID = '7098' or CUSTOMER_ID = '7099' or CUSTOMER_ID = '7100' or CUSTOMER_ID = '7101' or CUSTOMER_ID = '7102' or CUSTOMER_ID = '7103' or CUSTOMER_ID = '7104' or CUSTOMER_ID = '7105' or CUSTOMER_ID = '7106' or CUSTOMER_ID = '7107' or CUSTOMER_ID = '7108' or CUSTOMER_ID = '7109' or CUSTOMER_ID = '7110' or CUSTOMER_ID = '7111' or CUSTOMER_ID = '7112' or CUSTOMER_ID = '7113' or CUSTOMER_ID = '7114' or CUSTOMER_ID = '7115' or CUSTOMER_ID = '7116' or CUSTOMER_ID = '7117' or CUSTOMER_ID = '7118' or CUSTOMER_ID = '7119' or CUSTOMER_ID = '7120' or CUSTOMER_ID = '7121' or CUSTOMER_ID = '7122' or CUSTOMER_ID = '7123' or CUSTOMER_ID = '7124' or CUSTOMER_ID = '7125' or CUSTOMER_ID = '7126' or CUSTOMER_ID = '7127' or CUSTOMER_ID = '7128' or CUSTOMER_ID = '7129' or CUSTOMER_ID = '7130' or CUSTOMER_ID = '7131' or CUSTOMER_ID = '7132' or CUSTOMER_ID = '7133' or CUSTOMER_ID = '7134' or CUSTOMER_ID = '7135' or CUSTOMER_ID = '7136' or CUSTOMER_ID = '7137' or CUSTOMER_ID = '7138' or CUSTOMER_ID = '7139' or CUSTOMER_ID = '7140' or CUSTOMER_ID = '7141' or CUSTOMER_ID = '7142' or CUSTOMER_ID = '7143' or CUSTOMER_ID = '7144' or CUSTOMER_ID = '7145' or CUSTOMER_ID = '7146' or CUSTOMER_ID = '7147' or CUSTOMER_ID = '7148' or CUSTOMER_ID = '7149' or CUSTOMER_ID = '7150' or CUSTOMER_ID = '7151' or CUSTOMER_ID = '7152' or CUSTOMER_ID = '7153' or CUSTOMER_ID = '7154' or CUSTOMER_ID = '7155' or CUSTOMER_ID = '7156' or CUSTOMER_ID = '7157' or CUSTOMER_ID = '7158' or CUSTOMER_ID = '7159' or CUSTOMER_ID = '7160' or CUSTOMER_ID = '7167' or CUSTOMER_ID = '7168' or CUSTOMER_ID = '7169' or CUSTOMER_ID = '7170' or CUSTOMER_ID = '7171' or CUSTOMER_ID = '7172' or CUSTOMER_ID = '7173' or CUSTOMER_ID = '7174' or CUSTOMER_ID = '7175' or CUSTOMER_ID = '7176')) nn

-----CUSTOMER_DELIVERY_TAX_INFO
SELECT 'INSERT INTO mtk_cust_delivery_tax_info_tab (customer_id,address_id,company,supply_country_db,tax_liability,tax_book_id,tax_book_type,tax_structure_id,mtk_mode) VALUES (''' 
                 || customer_id
      || ''',''' || address_id
      || ''',''' || COMPANY
      || ''',''' || SUPPLY_COUNTRY
      || ''',''' || TAX_LIABILITY
      || ''',''' || TAX_BOOK_ID
      || ''',''' || TAX_BOOK_TYPE
      || ''',''' || TAX_STRUCTURE_ID
      || ''',''' || MTK_MODE
    ||  ''');'   aa
FROM (SELECT 
   CUSTOMER_ID,
   ADDRESS_ID,
   COMPANY,
   SUPPLY_COUNTRY,
   TAX_LIABILITY,
   TAX_BOOK_ID,
   TAX_BOOK_TYPE,
   TAX_STRUCTURE_ID,
   '*' MTK_MODE
FROM  customer_delivery_tax_info_tab 
WHERE (CUSTOMER_ID = '7000' or CUSTOMER_ID = '7001' or CUSTOMER_ID = '7003' or CUSTOMER_ID = '7004' or CUSTOMER_ID = '7005' or CUSTOMER_ID = '7006' or CUSTOMER_ID = '7007' or CUSTOMER_ID = '7008' or CUSTOMER_ID = '7009' or CUSTOMER_ID = '7010' or CUSTOMER_ID = '7011' or CUSTOMER_ID = '7012' or CUSTOMER_ID = '7013' or CUSTOMER_ID = '7014' or CUSTOMER_ID = '7015' or CUSTOMER_ID = '7016' or CUSTOMER_ID = '7017' or CUSTOMER_ID = '7018' or CUSTOMER_ID = '7019' or CUSTOMER_ID = '7020' or CUSTOMER_ID = '7021' or CUSTOMER_ID = '7022' or CUSTOMER_ID = '7023' or CUSTOMER_ID = '7024' or CUSTOMER_ID = '7025' or CUSTOMER_ID = '7026' or CUSTOMER_ID = '7027' or CUSTOMER_ID = '7028' or CUSTOMER_ID = '7029' or CUSTOMER_ID = '7030' or CUSTOMER_ID = '7031' or CUSTOMER_ID = '7032' or CUSTOMER_ID = '7033' or CUSTOMER_ID = '7034' or CUSTOMER_ID = '7035' or CUSTOMER_ID = '7036' or CUSTOMER_ID = '7037' or CUSTOMER_ID = '7038' or CUSTOMER_ID = '7039' or CUSTOMER_ID = '7040' or CUSTOMER_ID = '7041' or CUSTOMER_ID = '7042' or CUSTOMER_ID = '7043' or CUSTOMER_ID = '7044' or CUSTOMER_ID = '7045' or CUSTOMER_ID = '7046' or CUSTOMER_ID = '7047' or CUSTOMER_ID = '7048' or CUSTOMER_ID = '7049' or CUSTOMER_ID = '7050' or CUSTOMER_ID = '7051' or CUSTOMER_ID = '7052' or CUSTOMER_ID = '7053' or CUSTOMER_ID = '7054' or CUSTOMER_ID = '7055' or CUSTOMER_ID = '7056' or CUSTOMER_ID = '7057' or CUSTOMER_ID = '7058' or CUSTOMER_ID = '7059' or CUSTOMER_ID = '7060' or CUSTOMER_ID = '7061' or CUSTOMER_ID = '7062' or CUSTOMER_ID = '7063' or CUSTOMER_ID = '7064' or CUSTOMER_ID = '7065' or CUSTOMER_ID = '7066' or CUSTOMER_ID = '7067' or CUSTOMER_ID = '7068' or CUSTOMER_ID = '7069' or CUSTOMER_ID = '7070' or CUSTOMER_ID = '7071' or CUSTOMER_ID = '7072' or CUSTOMER_ID = '7073' or CUSTOMER_ID = '7074' or CUSTOMER_ID = '7075' or CUSTOMER_ID = '7076' or CUSTOMER_ID = '7077' or CUSTOMER_ID = '7078' or CUSTOMER_ID = '7079' or CUSTOMER_ID = '7080' or CUSTOMER_ID = '7081' or CUSTOMER_ID = '7082' or CUSTOMER_ID = '7083' or CUSTOMER_ID = '7084' or CUSTOMER_ID = '7085' or CUSTOMER_ID = '7086' or CUSTOMER_ID = '7087' or CUSTOMER_ID = '7088' or CUSTOMER_ID = '7089' or CUSTOMER_ID = '7090' or CUSTOMER_ID = '7091' or CUSTOMER_ID = '7092' or CUSTOMER_ID = '7093' or CUSTOMER_ID = '7094' or CUSTOMER_ID = '7095' or CUSTOMER_ID = '7096' or CUSTOMER_ID = '7097' or CUSTOMER_ID = '7098' or CUSTOMER_ID = '7099' or CUSTOMER_ID = '7100' or CUSTOMER_ID = '7101' or CUSTOMER_ID = '7102' or CUSTOMER_ID = '7103' or CUSTOMER_ID = '7104' or CUSTOMER_ID = '7105' or CUSTOMER_ID = '7106' or CUSTOMER_ID = '7107' or CUSTOMER_ID = '7108' or CUSTOMER_ID = '7109' or CUSTOMER_ID = '7110' or CUSTOMER_ID = '7111' or CUSTOMER_ID = '7112' or CUSTOMER_ID = '7113' or CUSTOMER_ID = '7114' or CUSTOMER_ID = '7115' or CUSTOMER_ID = '7116' or CUSTOMER_ID = '7117' or CUSTOMER_ID = '7118' or CUSTOMER_ID = '7119' or CUSTOMER_ID = '7120' or CUSTOMER_ID = '7121' or CUSTOMER_ID = '7122' or CUSTOMER_ID = '7123' or CUSTOMER_ID = '7124' or CUSTOMER_ID = '7125' or CUSTOMER_ID = '7126' or CUSTOMER_ID = '7127' or CUSTOMER_ID = '7128' or CUSTOMER_ID = '7129' or CUSTOMER_ID = '7130' or CUSTOMER_ID = '7131' or CUSTOMER_ID = '7132' or CUSTOMER_ID = '7133' or CUSTOMER_ID = '7134' or CUSTOMER_ID = '7135' or CUSTOMER_ID = '7136' or CUSTOMER_ID = '7137' or CUSTOMER_ID = '7138' or CUSTOMER_ID = '7139' or CUSTOMER_ID = '7140' or CUSTOMER_ID = '7141' or CUSTOMER_ID = '7142' or CUSTOMER_ID = '7143' or CUSTOMER_ID = '7144' or CUSTOMER_ID = '7145' or CUSTOMER_ID = '7146' or CUSTOMER_ID = '7147' or CUSTOMER_ID = '7148' or CUSTOMER_ID = '7149' or CUSTOMER_ID = '7150' or CUSTOMER_ID = '7151' or CUSTOMER_ID = '7152' or CUSTOMER_ID = '7153' or CUSTOMER_ID = '7154' or CUSTOMER_ID = '7155' or CUSTOMER_ID = '7156' or CUSTOMER_ID = '7157' or CUSTOMER_ID = '7158' or CUSTOMER_ID = '7159' or CUSTOMER_ID = '7160' or CUSTOMER_ID = '7167' or CUSTOMER_ID = '7168' or CUSTOMER_ID = '7169' or CUSTOMER_ID = '7170' or CUSTOMER_ID = '7171' or CUSTOMER_ID = '7172' or CUSTOMER_ID = '7173' or CUSTOMER_ID = '7174' or CUSTOMER_ID = '7175' or CUSTOMER_ID = '7176')) hh


----CUSTOMER_IPD_TAX_INFO_ADDR
SELECT 'INSERT INTO mtk_cust_document_tax_info_tab (customer_id,address_id,company,supply_country_db,tax_id_type,vat_no,validated_date,mtk_mode) VALUES (''' 
                 || customer_id
      || ''',''' || address_id
      || ''',''' || COMPANY
      || ''',''' || supply_country_db
      || ''',''' || tax_id_type
      || ''',''' || vat_no
      || ''',''' || validated_date
      || ''',''' || MTK_MODE
    ||  ''');'   aa
FROM (SELECT 
       a.CUSTOMER_ID,
       a.ADDRESS_ID,
       a.COMPANY,
       country_db SUPPLY_COUNTRY_DB,
       TAX_ID_TYPE,
       VAT_NO,
       VALIDATED_DATE,
       '*' MTK_MODE
from CUSTOMER_DOCUMENT_TAX_INFO a
INNER JOIN CUSTOMER_INFO_ADDRESS b ON a.CUSTOMER_ID = b.CUSTOMER_ID AND a.ADDRESS_ID = b.ADDRESS_ID
 WHERE (a.CUSTOMER_ID = '7000' or a.CUSTOMER_ID = '7001' or a.CUSTOMER_ID = '7003' or a.CUSTOMER_ID = '7004' or a.CUSTOMER_ID = '7005' or a.CUSTOMER_ID = '7006' or a.CUSTOMER_ID = '7007' or a.CUSTOMER_ID = '7008' or a.CUSTOMER_ID = '7009' or a.CUSTOMER_ID = '7010' or a.CUSTOMER_ID = '7011' or a.CUSTOMER_ID = '7012' or a.CUSTOMER_ID = '7013' or a.CUSTOMER_ID = '7014' or a.CUSTOMER_ID = '7015' or a.CUSTOMER_ID = '7016' or a.CUSTOMER_ID = '7017' or a.CUSTOMER_ID = '7018' or a.CUSTOMER_ID = '7019' or a.CUSTOMER_ID = '7020' or a.CUSTOMER_ID = '7021' or a.CUSTOMER_ID = '7022' or a.CUSTOMER_ID = '7023' or a.CUSTOMER_ID = '7024' or a.CUSTOMER_ID = '7025' or a.CUSTOMER_ID = '7026' or a.CUSTOMER_ID = '7027' or a.CUSTOMER_ID = '7028' or a.CUSTOMER_ID = '7029' or a.CUSTOMER_ID = '7030' or a.CUSTOMER_ID = '7031' or a.CUSTOMER_ID = '7032' or a.CUSTOMER_ID = '7033' or a.CUSTOMER_ID = '7034' or a.CUSTOMER_ID = '7035' or a.CUSTOMER_ID = '7036' or a.CUSTOMER_ID = '7037' or a.CUSTOMER_ID = '7038' or a.CUSTOMER_ID = '7039' or a.CUSTOMER_ID = '7040' or a.CUSTOMER_ID = '7041' or a.CUSTOMER_ID = '7042' or a.CUSTOMER_ID = '7043' or a.CUSTOMER_ID = '7044' or a.CUSTOMER_ID = '7045' or a.CUSTOMER_ID = '7046' or a.CUSTOMER_ID = '7047' or a.CUSTOMER_ID = '7048' or a.CUSTOMER_ID = '7049' or a.CUSTOMER_ID = '7050' or a.CUSTOMER_ID = '7051' or a.CUSTOMER_ID = '7052' or a.CUSTOMER_ID = '7053' or a.CUSTOMER_ID = '7054' or a.CUSTOMER_ID = '7055' or a.CUSTOMER_ID = '7056' or a.CUSTOMER_ID = '7057' or a.CUSTOMER_ID = '7058' or a.CUSTOMER_ID = '7059' or a.CUSTOMER_ID = '7060' or a.CUSTOMER_ID = '7061' or a.CUSTOMER_ID = '7062' or a.CUSTOMER_ID = '7063' or a.CUSTOMER_ID = '7064' or a.CUSTOMER_ID = '7065' or a.CUSTOMER_ID = '7066' or a.CUSTOMER_ID = '7067' or a.CUSTOMER_ID = '7068' or a.CUSTOMER_ID = '7069' or a.CUSTOMER_ID = '7070' or a.CUSTOMER_ID = '7071' or a.CUSTOMER_ID = '7072' or a.CUSTOMER_ID = '7073' or a.CUSTOMER_ID = '7074' or a.CUSTOMER_ID = '7075' or a.CUSTOMER_ID = '7076' or a.CUSTOMER_ID = '7077' or a.CUSTOMER_ID = '7078' or a.CUSTOMER_ID = '7079' or a.CUSTOMER_ID = '7080' or a.CUSTOMER_ID = '7081' or a.CUSTOMER_ID = '7082' or a.CUSTOMER_ID = '7083' or a.CUSTOMER_ID = '7084' or a.CUSTOMER_ID = '7085' or a.CUSTOMER_ID = '7086' or a.CUSTOMER_ID = '7087' or a.CUSTOMER_ID = '7088' or a.CUSTOMER_ID = '7089' or a.CUSTOMER_ID = '7090' or a.CUSTOMER_ID = '7091' or a.CUSTOMER_ID = '7092' or a.CUSTOMER_ID = '7093' or a.CUSTOMER_ID = '7094' or a.CUSTOMER_ID = '7095' or a.CUSTOMER_ID = '7096' or a.CUSTOMER_ID = '7097' or a.CUSTOMER_ID = '7098' or a.CUSTOMER_ID = '7099' or a.CUSTOMER_ID = '7100' or a.CUSTOMER_ID = '7101' or a.CUSTOMER_ID = '7102' or a.CUSTOMER_ID = '7103' or a.CUSTOMER_ID = '7104' or a.CUSTOMER_ID = '7105' or a.CUSTOMER_ID = '7106' or a.CUSTOMER_ID = '7107' or a.CUSTOMER_ID = '7108' or a.CUSTOMER_ID = '7109' or a.CUSTOMER_ID = '7110' or a.CUSTOMER_ID = '7111' or a.CUSTOMER_ID = '7112' or a.CUSTOMER_ID = '7113' or a.CUSTOMER_ID = '7114' or a.CUSTOMER_ID = '7115' or a.CUSTOMER_ID = '7116' or a.CUSTOMER_ID = '7117' or a.CUSTOMER_ID = '7118' or a.CUSTOMER_ID = '7119' or a.CUSTOMER_ID = '7120' or a.CUSTOMER_ID = '7121' or a.CUSTOMER_ID = '7122' or a.CUSTOMER_ID = '7123' or a.CUSTOMER_ID = '7124' or a.CUSTOMER_ID = '7125' or a.CUSTOMER_ID = '7126' or a.CUSTOMER_ID = '7127' or a.CUSTOMER_ID = '7128' or a.CUSTOMER_ID = '7129' or a.CUSTOMER_ID = '7130' or a.CUSTOMER_ID = '7131' or a.CUSTOMER_ID = '7132' or a.CUSTOMER_ID = '7133' or a.CUSTOMER_ID = '7134' or a.CUSTOMER_ID = '7135' or a.CUSTOMER_ID = '7136' or a.CUSTOMER_ID = '7137' or a.CUSTOMER_ID = '7138' or a.CUSTOMER_ID = '7139' or a.CUSTOMER_ID = '7140' or a.CUSTOMER_ID = '7141' or a.CUSTOMER_ID = '7142' or a.CUSTOMER_ID = '7143' or a.CUSTOMER_ID = '7144' or a.CUSTOMER_ID = '7145' or a.CUSTOMER_ID = '7146' or a.CUSTOMER_ID = '7147' or a.CUSTOMER_ID = '7148' or a.CUSTOMER_ID = '7149' or a.CUSTOMER_ID = '7150' or a.CUSTOMER_ID = '7151' or a.CUSTOMER_ID = '7152' or a.CUSTOMER_ID = '7153' or a.CUSTOMER_ID = '7154' or a.CUSTOMER_ID = '7155' or a.CUSTOMER_ID = '7156' or a.CUSTOMER_ID = '7157' or a.CUSTOMER_ID = '7158' or a.CUSTOMER_ID = '7159' or a.CUSTOMER_ID = '7160' or a.CUSTOMER_ID = '7167' or a.CUSTOMER_ID = '7168' or a.CUSTOMER_ID = '7169' or a.CUSTOMER_ID = '7170' or a.CUSTOMER_ID = '7171' or a.CUSTOMER_ID = '7172' or a.CUSTOMER_ID = '7173' or a.CUSTOMER_ID = '7174' or a.CUSTOMER_ID = '7175' or a.CUSTOMER_ID = '7176')) mm
	 
---Customer-Delivery-Fee-Code
SELECT 'INSERT INTO mtk_cust_delivery_fee_code_tab (company,fee_code,identity,party_type_db,address_id,tax_id_number,mtk_mode,supply_country_db) VALUES (''' 
                 || company
      || ''',''' || fee_code
      || ''',''' || identity
      || ''',''' || party_type_db
      || ''',''' || address_id
      || ''',''' || tax_id_number
      || ''',''' || mtk_mode
      || ''',''' || supply_country_db
    ||  ''');'   aa
FROM (SELECT 
   a.COMPANY,
   FEE_CODE,
   a.CUSTOMER_ID IDENTITY,
   'CUSTOMER' PARTY_TYPE_DB,
   a.ADDRESS_ID,
   TAX_ID_NUMBER,
   '*' MTK_MODE,
   CASE WHEN SUPPLY_COUNTRY_DB = '*' THEN c.country_db ELSE SUPPLY_COUNTRY_DB END SUPPLY_COUNTRY_DB
FROM  CUSTOMER_DELIVERY_TAX_INFO a
INNER JOIN CUSTOMER_DELIVERY_FEE_CODE b ON a.COMPANY = b.COMPANY AND a.CUSTOMER_ID = b.CUSTOMER_ID AND a.ADDRESS_ID = b.ADDRESS_ID
INNER JOIN CUSTOMER_INFO_ADDRESS c ON a.CUSTOMER_ID = c.CUSTOMER_ID AND a.ADDRESS_ID = c.ADDRESS_ID
WHERE (a.CUSTOMER_ID = '7000' or a.CUSTOMER_ID = '7001' or a.CUSTOMER_ID = '7003' or a.CUSTOMER_ID = '7004' or a.CUSTOMER_ID = '7005' or a.CUSTOMER_ID = '7006' or a.CUSTOMER_ID = '7007' or a.CUSTOMER_ID = '7008' or a.CUSTOMER_ID = '7009' or a.CUSTOMER_ID = '7010' or a.CUSTOMER_ID = '7011' or a.CUSTOMER_ID = '7012' or a.CUSTOMER_ID = '7013' or a.CUSTOMER_ID = '7014' or a.CUSTOMER_ID = '7015' or a.CUSTOMER_ID = '7016' or a.CUSTOMER_ID = '7017' or a.CUSTOMER_ID = '7018' or a.CUSTOMER_ID = '7019' or a.CUSTOMER_ID = '7020' or a.CUSTOMER_ID = '7021' or a.CUSTOMER_ID = '7022' or a.CUSTOMER_ID = '7023' or a.CUSTOMER_ID = '7024' or a.CUSTOMER_ID = '7025' or a.CUSTOMER_ID = '7026' or a.CUSTOMER_ID = '7027' or a.CUSTOMER_ID = '7028' or a.CUSTOMER_ID = '7029' or a.CUSTOMER_ID = '7030' or a.CUSTOMER_ID = '7031' or a.CUSTOMER_ID = '7032' or a.CUSTOMER_ID = '7033' or a.CUSTOMER_ID = '7034' or a.CUSTOMER_ID = '7035' or a.CUSTOMER_ID = '7036' or a.CUSTOMER_ID = '7037' or a.CUSTOMER_ID = '7038' or a.CUSTOMER_ID = '7039' or a.CUSTOMER_ID = '7040' or a.CUSTOMER_ID = '7041' or a.CUSTOMER_ID = '7042' or a.CUSTOMER_ID = '7043' or a.CUSTOMER_ID = '7044' or a.CUSTOMER_ID = '7045' or a.CUSTOMER_ID = '7046' or a.CUSTOMER_ID = '7047' or a.CUSTOMER_ID = '7048' or a.CUSTOMER_ID = '7049' or a.CUSTOMER_ID = '7050' or a.CUSTOMER_ID = '7051' or a.CUSTOMER_ID = '7052' or a.CUSTOMER_ID = '7053' or a.CUSTOMER_ID = '7054' or a.CUSTOMER_ID = '7055' or a.CUSTOMER_ID = '7056' or a.CUSTOMER_ID = '7057' or a.CUSTOMER_ID = '7058' or a.CUSTOMER_ID = '7059' or a.CUSTOMER_ID = '7060' or a.CUSTOMER_ID = '7061' or a.CUSTOMER_ID = '7062' or a.CUSTOMER_ID = '7063' or a.CUSTOMER_ID = '7064' or a.CUSTOMER_ID = '7065' or a.CUSTOMER_ID = '7066' or a.CUSTOMER_ID = '7067' or a.CUSTOMER_ID = '7068' or a.CUSTOMER_ID = '7069' or a.CUSTOMER_ID = '7070' or a.CUSTOMER_ID = '7071' or a.CUSTOMER_ID = '7072' or a.CUSTOMER_ID = '7073' or a.CUSTOMER_ID = '7074' or a.CUSTOMER_ID = '7075' or a.CUSTOMER_ID = '7076' or a.CUSTOMER_ID = '7077' or a.CUSTOMER_ID = '7078' or a.CUSTOMER_ID = '7079' or a.CUSTOMER_ID = '7080' or a.CUSTOMER_ID = '7081' or a.CUSTOMER_ID = '7082' or a.CUSTOMER_ID = '7083' or a.CUSTOMER_ID = '7084' or a.CUSTOMER_ID = '7085' or a.CUSTOMER_ID = '7086' or a.CUSTOMER_ID = '7087' or a.CUSTOMER_ID = '7088' or a.CUSTOMER_ID = '7089' or a.CUSTOMER_ID = '7090' or a.CUSTOMER_ID = '7091' or a.CUSTOMER_ID = '7092' or a.CUSTOMER_ID = '7093' or a.CUSTOMER_ID = '7094' or a.CUSTOMER_ID = '7095' or a.CUSTOMER_ID = '7096' or a.CUSTOMER_ID = '7097' or a.CUSTOMER_ID = '7098' or a.CUSTOMER_ID = '7099' or a.CUSTOMER_ID = '7100' or a.CUSTOMER_ID = '7101' or a.CUSTOMER_ID = '7102' or a.CUSTOMER_ID = '7103' or a.CUSTOMER_ID = '7104' or a.CUSTOMER_ID = '7105' or a.CUSTOMER_ID = '7106' or a.CUSTOMER_ID = '7107' or a.CUSTOMER_ID = '7108' or a.CUSTOMER_ID = '7109' or a.CUSTOMER_ID = '7110' or a.CUSTOMER_ID = '7111' or a.CUSTOMER_ID = '7112' or a.CUSTOMER_ID = '7113' or a.CUSTOMER_ID = '7114' or a.CUSTOMER_ID = '7115' or a.CUSTOMER_ID = '7116' or a.CUSTOMER_ID = '7117' or a.CUSTOMER_ID = '7118' or a.CUSTOMER_ID = '7119' or a.CUSTOMER_ID = '7120' or a.CUSTOMER_ID = '7121' or a.CUSTOMER_ID = '7122' or a.CUSTOMER_ID = '7123' or a.CUSTOMER_ID = '7124' or a.CUSTOMER_ID = '7125' or a.CUSTOMER_ID = '7126' or a.CUSTOMER_ID = '7127' or a.CUSTOMER_ID = '7128' or a.CUSTOMER_ID = '7129' or a.CUSTOMER_ID = '7130' or a.CUSTOMER_ID = '7131' or a.CUSTOMER_ID = '7132' or a.CUSTOMER_ID = '7133' or a.CUSTOMER_ID = '7134' or a.CUSTOMER_ID = '7135' or a.CUSTOMER_ID = '7136' or a.CUSTOMER_ID = '7137' or a.CUSTOMER_ID = '7138' or a.CUSTOMER_ID = '7139' or a.CUSTOMER_ID = '7140' or a.CUSTOMER_ID = '7141' or a.CUSTOMER_ID = '7142' or a.CUSTOMER_ID = '7143' or a.CUSTOMER_ID = '7144' or a.CUSTOMER_ID = '7145' or a.CUSTOMER_ID = '7146' or a.CUSTOMER_ID = '7147' or a.CUSTOMER_ID = '7148' or a.CUSTOMER_ID = '7149' or a.CUSTOMER_ID = '7150' or a.CUSTOMER_ID = '7151' or a.CUSTOMER_ID = '7152' or a.CUSTOMER_ID = '7153' or a.CUSTOMER_ID = '7154' or a.CUSTOMER_ID = '7155' or a.CUSTOMER_ID = '7156' or a.CUSTOMER_ID = '7157' or a.CUSTOMER_ID = '7158' or a.CUSTOMER_ID = '7159' or a.CUSTOMER_ID = '7160' or a.CUSTOMER_ID = '7167' or a.CUSTOMER_ID = '7168' or a.CUSTOMER_ID = '7169' or a.CUSTOMER_ID = '7170' or a.CUSTOMER_ID = '7171' or a.CUSTOMER_ID = '7172' or a.CUSTOMER_ID = '7173' or a.CUSTOMER_ID = '7174' or a.CUSTOMER_ID = '7175' or a.CUSTOMER_ID = '7176')) hh

----Customer Tax Free Tax Code
SELECT 
   a.CUSTOMER_ID,
   a.ADDRESS_ID,
   a.COMPANY,
   SUPPLY_COUNTRY_DB,
   DELIVERY_TYPE,
   VAT_FREE_VAT_CODE,
   '' MTK_MODE
FROM  CUSTOMER_DELIVERY_TAX_INFO a
INNER JOIN CUSTOMER_TAX_FREE_TAX_CODE b ON b.CUSTOMER_ID = a.CUSTOMER_ID AND
   b.ADDRESS_ID = a.ADDRESS_ID AND
   b.COMPANY = a.COMPANY
WHERE (a.CUSTOMER_ID = '7000' or a.CUSTOMER_ID = '7001' or a.CUSTOMER_ID = '7003' or a.CUSTOMER_ID = '7004' or a.CUSTOMER_ID = '7005' or a.CUSTOMER_ID = '7006' or a.CUSTOMER_ID = '7007' or a.CUSTOMER_ID = '7008' or a.CUSTOMER_ID = '7009' or a.CUSTOMER_ID = '7010' or a.CUSTOMER_ID = '7011' or a.CUSTOMER_ID = '7012' or a.CUSTOMER_ID = '7013' or a.CUSTOMER_ID = '7014' or a.CUSTOMER_ID = '7015' or a.CUSTOMER_ID = '7016' or a.CUSTOMER_ID = '7017' or a.CUSTOMER_ID = '7018' or a.CUSTOMER_ID = '7019' or a.CUSTOMER_ID = '7020' or a.CUSTOMER_ID = '7021' or a.CUSTOMER_ID = '7022' or a.CUSTOMER_ID = '7023' or a.CUSTOMER_ID = '7024' or a.CUSTOMER_ID = '7025' or a.CUSTOMER_ID = '7026' or a.CUSTOMER_ID = '7027' or a.CUSTOMER_ID = '7028' or a.CUSTOMER_ID = '7029' or a.CUSTOMER_ID = '7030' or a.CUSTOMER_ID = '7031' or a.CUSTOMER_ID = '7032' or a.CUSTOMER_ID = '7033' or a.CUSTOMER_ID = '7034' or a.CUSTOMER_ID = '7035' or a.CUSTOMER_ID = '7036' or a.CUSTOMER_ID = '7037' or a.CUSTOMER_ID = '7038' or a.CUSTOMER_ID = '7039' or a.CUSTOMER_ID = '7040' or a.CUSTOMER_ID = '7041' or a.CUSTOMER_ID = '7042' or a.CUSTOMER_ID = '7043' or a.CUSTOMER_ID = '7044' or a.CUSTOMER_ID = '7045' or a.CUSTOMER_ID = '7046' or a.CUSTOMER_ID = '7047' or a.CUSTOMER_ID = '7048' or a.CUSTOMER_ID = '7049' or a.CUSTOMER_ID = '7050' or a.CUSTOMER_ID = '7051' or a.CUSTOMER_ID = '7052' or a.CUSTOMER_ID = '7053' or a.CUSTOMER_ID = '7054' or a.CUSTOMER_ID = '7055' or a.CUSTOMER_ID = '7056' or a.CUSTOMER_ID = '7057' or a.CUSTOMER_ID = '7058' or a.CUSTOMER_ID = '7059' or a.CUSTOMER_ID = '7060' or a.CUSTOMER_ID = '7061' or a.CUSTOMER_ID = '7062' or a.CUSTOMER_ID = '7063' or a.CUSTOMER_ID = '7064' or a.CUSTOMER_ID = '7065' or a.CUSTOMER_ID = '7066' or a.CUSTOMER_ID = '7067' or a.CUSTOMER_ID = '7068' or a.CUSTOMER_ID = '7069' or a.CUSTOMER_ID = '7070' or a.CUSTOMER_ID = '7071' or a.CUSTOMER_ID = '7072' or a.CUSTOMER_ID = '7073' or a.CUSTOMER_ID = '7074' or a.CUSTOMER_ID = '7075' or a.CUSTOMER_ID = '7076' or a.CUSTOMER_ID = '7077' or a.CUSTOMER_ID = '7078' or a.CUSTOMER_ID = '7079' or a.CUSTOMER_ID = '7080' or a.CUSTOMER_ID = '7081' or a.CUSTOMER_ID = '7082' or a.CUSTOMER_ID = '7083' or a.CUSTOMER_ID = '7084' or a.CUSTOMER_ID = '7085' or a.CUSTOMER_ID = '7086' or a.CUSTOMER_ID = '7087' or a.CUSTOMER_ID = '7088' or a.CUSTOMER_ID = '7089' or a.CUSTOMER_ID = '7090' or a.CUSTOMER_ID = '7091' or a.CUSTOMER_ID = '7092' or a.CUSTOMER_ID = '7093' or a.CUSTOMER_ID = '7094' or a.CUSTOMER_ID = '7095' or a.CUSTOMER_ID = '7096' or a.CUSTOMER_ID = '7097' or a.CUSTOMER_ID = '7098' or a.CUSTOMER_ID = '7099' or a.CUSTOMER_ID = '7100' or a.CUSTOMER_ID = '7101' or a.CUSTOMER_ID = '7102' or a.CUSTOMER_ID = '7103' or a.CUSTOMER_ID = '7104' or a.CUSTOMER_ID = '7105' or a.CUSTOMER_ID = '7106' or a.CUSTOMER_ID = '7107' or a.CUSTOMER_ID = '7108' or a.CUSTOMER_ID = '7109' or a.CUSTOMER_ID = '7110' or a.CUSTOMER_ID = '7111' or a.CUSTOMER_ID = '7112' or a.CUSTOMER_ID = '7113' or a.CUSTOMER_ID = '7114' or a.CUSTOMER_ID = '7115' or a.CUSTOMER_ID = '7116' or a.CUSTOMER_ID = '7117' or a.CUSTOMER_ID = '7118' or a.CUSTOMER_ID = '7119' or a.CUSTOMER_ID = '7120' or a.CUSTOMER_ID = '7121' or a.CUSTOMER_ID = '7122' or a.CUSTOMER_ID = '7123' or a.CUSTOMER_ID = '7124' or a.CUSTOMER_ID = '7125' or a.CUSTOMER_ID = '7126' or a.CUSTOMER_ID = '7127' or a.CUSTOMER_ID = '7128' or a.CUSTOMER_ID = '7129' or a.CUSTOMER_ID = '7130' or a.CUSTOMER_ID = '7131' or a.CUSTOMER_ID = '7132' or a.CUSTOMER_ID = '7133' or a.CUSTOMER_ID = '7134' or a.CUSTOMER_ID = '7135' or a.CUSTOMER_ID = '7136' or a.CUSTOMER_ID = '7137' or a.CUSTOMER_ID = '7138' or a.CUSTOMER_ID = '7139' or a.CUSTOMER_ID = '7140' or a.CUSTOMER_ID = '7141' or a.CUSTOMER_ID = '7142' or a.CUSTOMER_ID = '7143' or a.CUSTOMER_ID = '7144' or a.CUSTOMER_ID = '7145' or a.CUSTOMER_ID = '7146' or a.CUSTOMER_ID = '7147' or a.CUSTOMER_ID = '7148' or a.CUSTOMER_ID = '7149' or a.CUSTOMER_ID = '7150' or a.CUSTOMER_ID = '7151' or a.CUSTOMER_ID = '7152' or a.CUSTOMER_ID = '7153' or a.CUSTOMER_ID = '7154' or a.CUSTOMER_ID = '7155' or a.CUSTOMER_ID = '7156' or a.CUSTOMER_ID = '7157' or a.CUSTOMER_ID = '7158' or a.CUSTOMER_ID = '7159' or a.CUSTOMER_ID = '7160' or a.CUSTOMER_ID = '7167' or a.CUSTOMER_ID = '7168' or a.CUSTOMER_ID = '7169' or a.CUSTOMER_ID = '7170' or a.CUSTOMER_ID = '7171' or a.CUSTOMER_ID = '7172' or a.CUSTOMER_ID = '7173' or a.CUSTOMER_ID = '7174' or a.CUSTOMER_ID = '7175' or a.CUSTOMER_ID = '7176')	 

---------------------

DECLARE
CURSOR get_qaman IS
SELECT a.IDENTITY,
a.COMPANY
FROM IDENTITY_PAY_INFO a
LEFT JOIN PAYMENT_WAY_PER_IDENTITY b ON a.IDENTITY = b.IDENTITY AND a.company = b.company AND a.PARTY_TYPE_DB = b.PARTY_TYPE_DB
WHERE b.PARTY_TYPE_DB IS NULL
AND a.COMPANY = '33-CX'
AND a.party_type_db = 'CUSTOMER';

info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('COMPANY', row_.COMPANY, attr_);
      Client_SYS.Add_To_Attr('IDENTITY', row_.IDENTITY, attr_);
      Client_SYS.Add_To_Attr('PARTY_TYPE_DB', 'CUSTOMER', attr_);
      Client_SYS.Add_To_Attr('WAY_ID', 'WIRE', attr_);
      Client_SYS.Add_To_Attr('DEFAULT_PAYMENT_WAY', 'TRUE', attr_);
PAYMENT_WAY_PER_IDENTITY_API.NEW__( info_ , objid_ , objversion_ , attr_, 'DO' );
   END LOOP;   
END;
---------------------
DECLARE
CURSOR get_qaman IS
SELECT qcp.objid,
qcp.objversion
FROM CUST_ORD_CUSTOMER_ADDRESS qcp
WHERE (customer_no = '7000' or customer_no = '7001' or customer_no = '7003' or customer_no = '7004' or customer_no = '7005' or customer_no = '7006' or customer_no = '7007' or customer_no = '7008' or customer_no = '7009' or customer_no = '7010' or customer_no = '7011' or customer_no = '7012' or customer_no = '7013' or customer_no = '7014' or customer_no = '7015' or customer_no = '7016' or customer_no = '7017' or customer_no = '7018' or customer_no = '7019' or customer_no = '7020' or customer_no = '7021' or customer_no = '7022' or customer_no = '7023' or customer_no = '7024' or customer_no = '7025' or customer_no = '7026' or customer_no = '7027' or customer_no = '7028' or customer_no = '7029' or customer_no = '7030' or customer_no = '7031' or customer_no = '7032' or customer_no = '7033' or customer_no = '7034' or customer_no = '7035' or customer_no = '7036' or customer_no = '7037' or customer_no = '7038' or customer_no = '7039' or customer_no = '7040' or customer_no = '7041' or customer_no = '7042' or customer_no = '7043' or customer_no = '7044' or customer_no = '7045' or customer_no = '7046' or customer_no = '7047' or customer_no = '7048' or customer_no = '7049' or customer_no = '7050' or customer_no = '7051' or customer_no = '7052' or customer_no = '7053' or customer_no = '7054' or customer_no = '7055' or customer_no = '7056' or customer_no = '7057' or customer_no = '7058' or customer_no = '7059' or customer_no = '7060' or customer_no = '7061' or customer_no = '7062' or customer_no = '7063' or customer_no = '7064' or customer_no = '7065' or customer_no = '7066' or customer_no = '7067' or customer_no = '7068' or customer_no = '7069' or customer_no = '7070' or customer_no = '7071' or customer_no = '7072' or customer_no = '7073' or customer_no = '7074' or customer_no = '7075' or customer_no = '7076' or customer_no = '7077' or customer_no = '7078' or customer_no = '7079' or customer_no = '7080' or customer_no = '7081' or customer_no = '7082' or customer_no = '7083' or customer_no = '7084' or customer_no = '7085' or customer_no = '7086' or customer_no = '7087' or customer_no = '7088' or customer_no = '7089' or customer_no = '7090' or customer_no = '7091' or customer_no = '7092' or customer_no = '7093' or customer_no = '7094' or customer_no = '7095' or customer_no = '7096' or customer_no = '7097' or customer_no = '7098' or customer_no = '7099' or customer_no = '7100' or customer_no = '7101' or customer_no = '7102' or customer_no = '7103' or customer_no = '7104' or customer_no = '7105' or customer_no = '7106' or customer_no = '7107' or customer_no = '7108' or customer_no = '7109' or customer_no = '7110' or customer_no = '7111' or customer_no = '7112' or customer_no = '7113' or customer_no = '7114' or customer_no = '7115' or customer_no = '7116' or customer_no = '7117' or customer_no = '7118' or customer_no = '7119' or customer_no = '7120' or customer_no = '7121' or customer_no = '7122' or customer_no = '7123' or customer_no = '7124' or customer_no = '7125' or customer_no = '7126' or customer_no = '7127' or customer_no = '7128' or customer_no = '7129' or customer_no = '7130' or customer_no = '7131' or customer_no = '7132' or customer_no = '7133' or customer_no = '7134' or customer_no = '7135' or customer_no = '7136' or customer_no = '7137' or customer_no = '7138' or customer_no = '7139' or customer_no = '7140' or customer_no = '7141' or customer_no = '7142' or customer_no = '7143' or customer_no = '7144' or customer_no = '7145' or customer_no = '7146' or customer_no = '7147' or customer_no = '7148' or customer_no = '7149' or customer_no = '7150' or customer_no = '7151' or customer_no = '7152' or customer_no = '7153' or customer_no = '7154' or customer_no = '7155' or customer_no = '7156' or customer_no = '7157' or customer_no = '7158' or customer_no = '7159' or customer_no = '7160' or customer_no = '7167' or customer_no = '7168' or customer_no = '7169' or customer_no = '7170' or customer_no = '7171' or customer_no = '7172' or customer_no = '7173' or customer_no = '7174' or customer_no = '7175' or customer_no = '7176');

info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('SHIPMENT_TYPE', 'NR', attr_);
      CUST_ORD_CUSTOMER_ADDRESS_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;