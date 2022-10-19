CREATE OR REPLACE VIEW SALES_DATA_NEW AS
SELECT a.Company,
      COMPANY_API.Get_Name(a.Company) Company_Name,
      a.Contract,
      nvl(sps.CF$_AIM_SALESMAN, aa.Salesman_code) Salesman_Code,
      a.identity Customer_No,
      CUSTOMER_INFO_API.Get_Name(a.identity) Customer_Name,
      ORDER_AIM_API.Get_CustomerOrder_Shipments(a.Order_No) Shipments,
      ORDER_AIM_API.Get_CustomerOrder_DelivNote(a.Order_No) DelivNote_No,
      a.Invoice_Date,
      ahead.Print_Date,
      to_char(ahead.Print_Date,'YYYY') as YTD_year,
      to_char(ahead.Print_Date,'Mon-YYYY') as month_YEAR,
      extract(month from ahead.Print_Date) as Month,
      a.Order_No,
      a.Series_Id,
      a.Invoice_Id,
      a.Item_Id,
      a.Invoice_No,
      a.Line_No,
      a.release_no Rel_No,
      a.LINE_ITEM_NO,
      b.Part_No,
      b.Description Part_Desc,
      aaa.catalog_No,
       a.description catalog_desc,    
      CASE when b.Part_no IS NULL OR INVOICE_API.Is_Correction_Invoice(a.Company,a.Invoice_Id) = 'TRUE' THEN 0 
           ELSE CASE WHEN a.invoice_type IN ('CUSTORDCRE','CUSTCOLCRE') THEN a.Invoiced_Qty * -1 ELSE a.Invoiced_Qty END 
      END as Invoiced_Qty,  
      a.sale_um Sales_unit_meas,
      b.unit_meas as Inventory_UoM,
      a.Sale_Unit_Price,
      a.Sale_Unit_Price * a.vat_rate Base_Sale_Unit_Price,
       a.Discount,       
      nvl(CASE when (b.Part_no IS NULL OR INVOICE_API.Is_Correction_Invoice(a.Company,a.Invoice_Id) = 'TRUE') THEN 0 
           ELSE CASE WHEN a.invoice_type IN ('CUSTORDCRE','CUSTCOLCRE') THEN aaa.Cost * aaa.Conv_Factor * a.Invoiced_Qty * -1 ELSE aaa.Cost * aaa.Conv_Factor * a.Invoiced_Qty END
      end,0) Cost, 
      CASE 
          WHEN a.invoice_type IN ('CUSTORDDEB','CUSTCOLDEB') AND a.CHARGE_SEQ_NO IS NULL THEN INV_CST_AIM_API.Get_Invoice_Line_Freight(a.Invoice_Id,a.Order_No, a.line_no, a.release_no, a.LINE_ITEM_NO) 
          ELSE 0 
       END freight_cost,      
      a.Net_Curr_Amount,
      aa.currency_code as Currency,
      a.net_dom_amount Net_Amount,   
      nvl(CASE  when b.Part_no IS NULL OR INVOICE_API.Is_Correction_Invoice(a.Company,a.Invoice_Id) = 'TRUE' THEN a.net_dom_amount 
            ELSE CASE WHEN a.invoice_type IN ('CUSTORDCRE','CUSTCOLCRE') THEN (a.net_dom_amount + (aaa.Cost * aaa.Conv_Factor * a.Invoiced_Qty)) ELSE (a.net_dom_amount - (aaa.Cost * aaa.Conv_Factor * a.Invoiced_Qty)) END
      end,0) - nvl(CASE WHEN a.invoice_type IN ('CUSTORDDEB','CUSTCOLDEB') AND a.CHARGE_SEQ_NO IS NULL THEN INV_CST_AIM_API.Get_Invoice_Line_Freight(a.Invoice_Id,a.Order_No, a.line_no, a.release_no, a.LINE_ITEM_NO) ELSE 0 END, 0) as GrossProfit,      
      nvl(CASE  when b.Part_no IS NULL OR INVOICE_API.Is_Correction_Invoice(a.Company,a.Invoice_Id) = 'TRUE' THEN a.net_dom_amount 
            ELSE CASE WHEN a.invoice_type IN ('CUSTORDCRE','CUSTCOLCRE') THEN (a.net_dom_amount + (aaa.Cost * aaa.Conv_Factor * a.Invoiced_Qty)) ELSE (a.net_dom_amount - (aaa.Cost * aaa.Conv_Factor * a.Invoiced_Qty)) END
      end,0) as GrossProfit_WtFr,
       
       nvl((CASE when b.Part_no IS NULL OR INVOICE_API.Is_Correction_Invoice(a.Company,a.Invoice_Id) = 'TRUE' THEN a.net_dom_amount              
             ELSE CASE WHEN a.invoice_type IN ('CUSTORDCRE','CUSTCOLCRE') THEN (a.net_dom_amount + (aaa.Cost * aaa.Conv_Factor * a.Invoiced_Qty)) ELSE (a.net_dom_amount - (aaa.Cost * aaa.Conv_Factor * a.Invoiced_Qty)) END
       END) - nvl(CASE WHEN a.invoice_type IN ('CUSTORDDEB','CUSTCOLDEB') AND a.CHARGE_SEQ_NO IS NULL THEN INV_CST_AIM_API.Get_Invoice_Line_Freight(a.Invoice_Id,a.Order_No, a.line_no, a.release_no, a.LINE_ITEM_NO) ELSE 0 END, 0) / CASE WHEN a.Invoiced_Qty = 0 THEN 0.00001 ELSE a.Invoiced_Qty END,0) as UnitGrossProfit,
       
      CASE WHEN a.net_dom_amount = 0 THEN 0
      ELSE (nvl(CASE  when b.Part_no IS NULL OR INVOICE_API.Is_Correction_Invoice(a.Company,a.Invoice_Id) = 'TRUE' THEN a.net_dom_amount 
            ELSE CASE WHEN a.invoice_type IN ('CUSTORDCRE','CUSTCOLCRE') THEN (a.net_dom_amount + (aaa.Cost * aaa.Conv_Factor * a.Invoiced_Qty)) ELSE (a.net_dom_amount - (aaa.Cost * aaa.Conv_Factor * a.Invoiced_Qty)) END
      end,0) - nvl(CASE WHEN a.invoice_type IN ('CUSTORDDEB','CUSTCOLDEB') AND a.CHARGE_SEQ_NO IS NULL THEN INV_CST_AIM_API.Get_Invoice_Line_Freight(a.Invoice_Id,a.Order_No, a.line_no, a.release_no, a.LINE_ITEM_NO) ELSE 0 END, 0)) / a.net_dom_amount END AS PercentGrossProfit,
       
       CASE WHEN a.net_dom_amount = 0 THEN 0
      ELSE (nvl(CASE  when b.Part_no IS NULL OR INVOICE_API.Is_Correction_Invoice(a.Company,a.Invoice_Id) = 'TRUE' THEN a.net_dom_amount 
            ELSE CASE WHEN a.invoice_type IN ('CUSTORDCRE','CUSTCOLCRE') THEN (a.net_dom_amount + (aaa.Cost * aaa.Conv_Factor * a.Invoiced_Qty)) ELSE (a.net_dom_amount - (aaa.Cost * aaa.Conv_Factor * a.Invoiced_Qty)) END
      end,0)) / a.net_dom_amount END AS PercentGrossProfit_WtFr,
       
      e.conversion_factor as conversion_factor_KG,
      CASE WHEN a.sale_um = 'lb' then (a.Invoiced_Qty / e.conversion_factor) ELSE (a.Invoiced_Qty * e.conversion_factor) END as Base_Sales_Qty,
      b.Part_Product_Family,
      INVENTORY_PRODUCT_FAMILY_API.Get_Description(b.Part_Product_Family)Prod_Family_Description,
      b.planner_buyer,
      b.Accounting_Group,
      b.Prime_Commodity Comm_Group_1,
      Commodity_Group_API.Get_Description(b.PRIME_COMMODITY) Comm_Group_1_Desc, 
      b.Second_Commodity Comm_Group_2,
      Commodity_Group_API.Get_Description(b.SECOND_COMMODITY) Comm_Group_2_Desc,
      b.Part_Product_code,
      INVENTORY_PRODUCT_CODE_API.Get_Description(b.Part_Product_code) Product_code_Desc, 
      b.Asset_Class,
      substr(aa.Market_Code,1,CASE WHEN INSTR(aa.Market_Code,'-') = 0 then 7 ELSE INSTR(aa.Market_Code,'-')-1 END) as MarketCodeLevel1,
      aa.Market_Code,
      SALES_MARKET_API.Get_Description(aa.Market_Code) Market_Desc,
       cust_ord_customer_api.Get_Cust_Grp(a.identity) AS Cust_Grp,
       aaa.ship_via_code,
       Mpccom_Ship_Via_API.Get_Description(aaa.SHIP_VIA_CODE) ship_via_code_desc,
      aaa.Region_Code,
      aaa.District_Code,
      aaa.District_Code District_Desc,
      cust_ord_customer_api.Get_Market_Code(a.identity) as CustomerCard_Market,
      b.Cf$_AIM_Leadtype as Inventory_LeadType, 
      b.Cf$_Market as Market_Global,
      nvl(aaa.CF$_AIM_SALESMAN_MARKET, aa.CF$_AIM_SALEMAN_MARKET) as Aim_Salesman_Market,
      b.CF$_AIM_CLASSIFIC as Classif_for_SGM,
      CASE WHEN b.Cf$_AIM_Leadtype IS NULL THEN 'NO_METAL' ELSE b.Cf$_AIM_Leadtype END as Alloy_for_SGM,
      CASE WHEN a.sale_um = 'ea1galus' THEN a.Invoiced_Qty
      WHEN a.sale_um = 'ea5galus' THEN a.Invoiced_Qty * 5
      WHEN a.sale_um = 'ea55galus' THEN a.Invoiced_Qty * 55   
      WHEN b.Part_Product_Family IN ('03', '12', '06', '10', '02', '09', '08', '15', '13', '19', '21', '27', '20') THEN CASE WHEN a.sale_um = 'lb' then (a.Invoiced_Qty / e.conversion_factor) ELSE (a.Invoiced_Qty * e.conversion_factor) END
      ELSE a.Invoiced_Qty END as Volume_for_PS,
      k.ship_addr_no, 
      k.addr_1, 
      k.addr_2, 
      k.addr_3, 
      k.addr_4,
      k.state,
      h.district_code as MAIN_district_code, 
      h.Region_code as MAIN_Region_code,
      ORDER_AIM_API.Get_CO_Line_Cost(a.order_no, a.line_no, a.RELEASE_NO, a.LINE_ITEM_NO, b.Part_no) * aaa.Conv_Factor AIM_Unit_Cost,
      nvl(CASE when b.Part_no IS NULL OR INVOICE_API.Is_Correction_Invoice(a.Company,a.Invoice_Id) = 'TRUE' THEN 0 
           ELSE CASE WHEN a.invoice_type IN ('CUSTORDCRE','CUSTCOLCRE') THEN aaa.Cost * aaa.Conv_Factor * a.Invoiced_Qty * -1 ELSE aaa.Cost * aaa.Conv_Factor * a.Invoiced_Qty END
      end,0) AIM_Cost_Per_Line,
       a.objid,
       a.objversion,
       a.objkey
from  CUSTOMER_ORDER_INV_JOIN a
INNER JOIN CUSTOMER_ORDER_INV_HEAD_UIV ahead ON ahead.company = a.company AND ahead.invoice_id = a.invoice_id
left join CUSTOMER_ORDER_CFV aa ON aa.ORDER_NO = a.ORDER_NO
left join SALES_PART_SALESMAN_CFV sps ON sps.SALESMAN_CODE = aa.Salesman_Code
left join INVOICE_ITEM_CFT iic ON iic.rowkey = a.objkey
left join CUSTOMER_ORDER_LINE_CFV aaa ON aaa.ORDER_NO = a.ORDER_NO AND aaa.LINE_NO = a.LINE_NO AND aaa.REL_NO = a.RELEASE_NO AND aaa.LINE_ITEM_NO = a.LINE_ITEM_NO
left outer join inventory_part_cfv b ON b.Part_no = SALES_PART_API.Get_Part_No(a.Contract, a.catalog_no) and a.Contract = b.Contract
left outer join CUSTOMER_ORDER_ADDRESS k on a.identity = k.customer_no and  a.order_no =  k.order_no
left join (select unit_code, conversion_factor from INPUT_UNIT_MEAS where input_unit_meas_group_id = 'UM_BASE_KG') e on a.sale_um = e.unit_code
left join (select customer_id, address_id, district_code, Region_code from CUST_ORD_CUSTOMER_ADDRESS_ENT where address_id = 'MAIN') h on a.identity = h.customer_id
WHERE a.Series_Id <> 'PR'
WITH   read only;

COMMENT ON TABLE SALES_DATA_NEW
   IS 'LU=OrderAim^PROMPT=AIM Sales Data New View^MODULE=ORDER^OBJVERSION=ltrim(lpad(to_char(rowversion),2000))^';

COMMENT ON COLUMN SALES_DATA_NEW.cost
   IS 'FLAGS=AM---^DATATYPE=NUMBER^PROMPT=Cost^';
COMMENT ON COLUMN SALES_DATA_NEW.net_amount
   IS 'FLAGS=AM---^DATATYPE=NUMBER^PROMPT=Net Amount^';
COMMENT ON COLUMN SALES_DATA_NEW.aim_cost_per_line
   IS 'FLAGS=AM---^DATATYPE=NUMBER^PROMPT=AIM_Cost_Per_Line^';
