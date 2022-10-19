CREATE OR REPLACE PACKAGE BODY SALES_BY_CUSTOMER_RPI IS

   TYPE binds$ IS RECORD (
      report_key                VARCHAR2(2000),
      salesman_code             VARCHAR2(2000),
      site                      VARCHAR2(2000),
      title                     VARCHAR2(2000),
      months                    NUMBER,
      contract                  VARCHAR2(2000),
      customer_no               VARCHAR2(2000),
      part_no                   VARCHAR2(2000));

   CURSOR get_contract(CONTRACT_ VARCHAR2, current_year_ NUMBER, current_month_ NUMBER) IS
      Select   Contract,
               Company,
               min(description) Company_Name
      from site d  
      WHERE EXISTS (SELECT 1 
         FROM SALES_DATA_NEW a --CUST_ORD_INVO_STAT a
         where extract(year from a.invoice_Date) = current_year_ 
         AND extract(month from a.invoice_Date) <= current_month_ 
         AND a.CONTRACT = d.CONTRACT)
         AND (CONTRACT_ = '%' OR INSTR(CONTRACT_, d.contract) >0)
      GROUP BY Contract, Company;

	CURSOR get_supervisor (CONTRACT_ VARCHAR2, SALESMAN_ VARCHAR2, current_year_ NUMBER, current_month_ NUMBER ) IS
	      SELECT NVL(aa.CF$_AIM_SUPERVISOR,SALESMAN_) SUPERVISOR,
	             PERSON_INFO_API.Get_Name(NVL(aa.CF$_AIM_SUPERVISOR,SALESMAN_)) name
	      FROM SALES_DATA_NEW a
	      LEFT JOIN SALES_PART_SALESMAN_CFV aa ON aa.Salesman_code = a.Salesman_code
         where (SALESMAN_ = '%'
               OR INSTR(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SALESMAN_,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '),REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(a.Salesman_code,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '))>0
               OR INSTR(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SALESMAN_,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '),REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(aa.CF$_AIM_SUPERVISOR,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '))>0)
	      AND extract(year from a.invoice_Date) = current_year_
	      AND extract(month from a.invoice_Date) <= current_month_
	      AND a.CONTRACT = CONTRACT_
	      GROUP BY NVL(aa.CF$_AIM_SUPERVISOR,SALESMAN_);

   CURSOR get_salesman (CONTRACT_ VARCHAR2, SUPERVISOR_ VARCHAR2, SALESMAN_ VARCHAR2, current_year_ NUMBER, current_month_ NUMBER) IS
      SELECT   a.Salesman_code Salesman_code ,
               aa.CF$_AIM_SALESMAN_NAME name
      FROM SALES_DATA_NEW a
      LEFT JOIN SALES_PART_SALESMAN_CFV aa ON aa.Salesman_code = a.Salesman_code
      where (   INSTR(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SUPERVISOR_,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '),REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(a.Salesman_code,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '))>0
             OR INSTR(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SUPERVISOR_,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '),REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(aa.CF$_AIM_SUPERVISOR,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '))>0
             OR (SUPERVISOR_ = '%' AND aa.CF$_AIM_SUPERVISOR IS NULL))
      AND (SALESMAN_ = '%'
            OR INSTR(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SALESMAN_,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '), REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(a.Salesman_code,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' ')) > 0
            OR INSTR(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SALESMAN_,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '),REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(aa.CF$_AIM_SUPERVISOR,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' ')) > 0)
      AND extract(year from a.invoice_Date) = current_year_ 
      AND extract(month from a.invoice_Date) <= current_month_ 
      AND a.CONTRACT = CONTRACT_
      GROUP BY a.Salesman_code, aa.CF$_AIM_SALESMAN_NAME;

   CURSOR get_customer (CONTRACT_ VARCHAR2, salesman_code_ VARCHAR2, current_year_ NUMBER, current_month_ NUMBER) IS
      SELECT customer_id Customer_No,
             min(NAME) Customer_Name       
      FROM CUSTOMER_INFO c
      WHERE EXISTS (SELECT 1       
                     from SALES_DATA_NEW a
                     where  extract(year from a.invoice_Date) = current_year_ 
                     AND extract(month from a.invoice_Date) <= current_month_ 
                     AND a.CONTRACT = CONTRACT_
                     AND nvl(a.Salesman_code,'xxx') = nvl(salesman_code_,'xxx')
                     AND nvl(a.customer_no,'xxx') = nvl(c.customer_id,'xxx'))
      GROUP BY customer_id;

   CURSOR get_part (contract_ VARCHAR2, salesman_code_ VARCHAR2, customer_no_ VARCHAR2, current_year_ NUMBER, current_month_ NUMBER) IS
      SELECT  a.PART_NO, 
              min(a.catalog_desc) DESCRIPTION       
      FROM SALES_DATA_NEW a
      where  extract(year from a.invoice_Date) = current_year_ 
      AND extract(month from a.invoice_Date) <= current_month_ 
      AND a.CONTRACT = CONTRACT_
      AND nvl(a.Salesman_code,'xxx') = nvl(salesman_code_,'xxx')
      AND nvl(a.customer_no,'xxx') = nvl(customer_no_,'xxx')
      GROUP BY a.PART_NO;

   CURSOR get_part_detail (contract_ VARCHAR2, salesman_code_ VARCHAR2, customer_no_ VARCHAR2, part_no_ VARCHAR2, current_year_ NUMBER, current_month_ NUMBER) IS
      select   d.YTD_year,
               e.Current_Month,
               e.Qty,
               e.currencynetamount,
               e.netamount,
               e.cost,
			      e.freight_cost,
               e.Gross_Profit,
               d.Ytd_Qty,
               d.Ytd_curr_netamount,
               d.Ytd_netamount,
               d.ytd_cost,
               d.ytd_freight,
               d.YTD_Gross_Profit,
               e.CostSalesUom,
               e.CostSalesUomTotal,
               d.YtdCostSalesUom,
               d.YtdCostSalesUomTotal                  
      from 
      (SELECT  extract(year from a.invoice_Date) YTD_year,
               a.company,
               a.salesman_code,
               a.customer_no,
               a.PART_NO,
               sum(a.invoiced_qty) as YTD_Qty,
               sum(a.cost) as YTD_Cost,
               sum(a.freight_cost) as YTD_Freight,
               sum(a.net_amount) as YTD_NetAmount,
               sum(a.net_curr_amount) as YTD_Curr_NetAmount,
               sum(a.GrossProfit) as YTD_Gross_Profit,
               sum(NVL(a.AIM_Unit_Cost,0)) as YtdCostSalesUom,
               sum(NVL(a.AIM_Cost_Per_Line,0)) as YtdCostSalesUomTotal
            from SALES_DATA_NEW a
            left outer join SALES_PART_cfv i ON i.CATALOG_NO = a.catalog_no and i.Contract = a.Contract
            where  extract(year from a.invoice_Date) = current_year_ 
               AND extract(month from a.invoice_Date) <= current_month_ 
               AND a.contract = contract_
               AND nvl(a.Salesman_code,'xxx') = nvl(salesman_code_,'xxx')
               AND nvl(a.customer_no,'xxx') = nvl(customer_no_,'xxx')
               AND nvl(a.PART_NO,'xxx') = nvl(PART_NO_,'xxx')
               AND NVL(i.CF$_AIM_EXCLUDE_SALES_REP_DB, 'FALSE') = 'FALSE'
            group by 
                  extract(year from a.invoice_Date),
                  a.company,
                  a.salesman_code,
                  a.customer_no,
                  a.PART_NO
              ) d
      left outer join 
      (SELECT  extract(month from a.invoice_Date) as Current_Month,
               a.company,
               a.salesman_code,
               a.customer_no,
               a.part_no,
               sum(a.invoiced_qty) as Qty,
               sum(a.cost) as Cost,
			      sum(a.freight_cost) as freight_cost,
               sum(a.net_amount) as NetAmount,
               sum(a.net_curr_amount) as CurrencyNetAmount,
               sum(a.GrossProfit) as Gross_Profit,
               sum(NVL(a.AIM_Unit_Cost,0)) as CostSalesUom,
               sum(NVL(a.AIM_Cost_Per_Line,0)) as CostSalesUomTotal
            from SALES_DATA_NEW a 
            left outer join SALES_PART_cfv i ON i.CATALOG_NO = a.catalog_no and i.Contract = a.Contract
            where  extract(year from a.invoice_Date) = current_year_ 
               AND extract(month from a.invoice_Date) = current_month_
               AND a.contract = contract_
               AND nvl(a.Salesman_code,'xxx') = nvl(salesman_code_,'xxx')
               AND a.customer_no = customer_no_
               AND nvl(a.PART_NO,'xxx') = nvl(PART_NO_,'xxx')   
               AND NVL(i.CF$_AIM_EXCLUDE_SALES_REP_DB, 'FALSE') = 'FALSE'
            group by 
                  extract(month from a.invoice_Date),
                  a.company,
                  a.salesman_code,
                  a.customer_no,
                  a.part_no) e on d.Company = e.company and 
                                 nvl(d.salesman_code,'xxx') = nvl(e.salesman_code,'xxx') and 
                                 nvl(d.customer_no,'xxx') = nvl(e.customer_no,'xxx') AND
                                 nvl(d.part_no,'xxx') = nvl(e.part_no,'xxx');

-----------------------------------------------------------------------------
-------------------- RESULT SET METHODS -------------------------------------
-----------------------------------------------------------------------------

--@IgnoreWrongParamOrder
PROCEDURE Add_Result_Row___ (
   result_key$_               IN NUMBER,
   binds$_                    IN binds$,
   rec_contract_              IN get_contract%ROWTYPE DEFAULT NULL,
   rec_salesman_              IN get_salesman%ROWTYPE DEFAULT NULL,
   rec_customer_              IN get_customer%ROWTYPE DEFAULT NULL,
   rec_part_                  IN get_part%ROWTYPE DEFAULT NULL,
   rec_part_detail_           IN get_part_detail%ROWTYPE DEFAULT NULL,
   rec_supervisor_            IN get_supervisor%ROWTYPE DEFAULT NULL,
   row_no$_                   IN OUT NUMBER)
IS
BEGIN
   INSERT INTO SALES_BY_CUSTOMER_RPT (
      result_key,
      report_key,
      salesman_code,
      site,
      title,
      months,
      contract,
      company,
      company_name,
--      cur_percent,
--      ytd_percent,
--      salesman_code_aim,
      name,
      customer_no,
      customer_name,
      part_no,
      description,
      ytd_year,
      current_month,
      qty,
      currencynetamount,
      netamount,
      cost,
      freight_cost,
      gross_profit,
 --     ytd_qty,
--      ytd_curr_netamount,
--      ytd_netamount,
 --     ytd_cost,
 --     ytd_gross_profit,
 --     cost_sales_uom,
 --     cost_sales_uom_total,
 --     ytd_cost_sales_uom,
 --     ytd_cost_sales_uom_total,
	   supervisor,
      row_no, parent_row_no)
   VALUES (
      result_key$_,
      binds$_.report_key,
      nvl(rec_salesman_.salesman_code,
      binds$_.salesman_code),
      binds$_.site,
      binds$_.title,
      binds$_.months,
      rec_contract_.contract,
      rec_contract_.company,
      rec_contract_.company_name,
--      nvl(rec_part_detail_.cur_percent,
--      nvl(rec_part_.cur_percent,
--      nvl(rec_customer_.cur_percent,
--      nvl(rec_salesman_.cur_percent,
--      rec_contract_.cur_percent)))),
--      nvl(rec_part_detail_.ytd_percent,
--     nvl(rec_part_.ytd_percent,
--      nvl(rec_customer_.ytd_percent,
--      nvl(rec_salesman_.ytd_percent,
--      rec_contract_.ytd_percent)))),
--      rec_salesman_.salesman_code_aim,
      rec_salesman_.name,
      rec_customer_.customer_no,
      rec_customer_.customer_name,
      rec_part_.part_no,
      rec_part_.description,
      rec_part_detail_.ytd_year,
      rec_part_detail_.current_month,
      rec_part_detail_.qty,
      rec_part_detail_.currencynetamount,
      rec_part_detail_.netamount,
      rec_part_detail_.cost,
      rec_part_detail_.freight_cost,
      rec_part_detail_.gross_profit,
--      rec_part_detail_.ytd_qty,
--      rec_part_detail_.ytd_curr_netamount,
--      rec_part_detail_.ytd_netamount,
--      rec_part_detail_.ytd_cost,
--      rec_part_detail_.ytd_gross_profit,
--      rec_part_detail_.cost_sales_uom,
--      rec_part_detail_.cost_sales_uom_total,
--      rec_part_detail_.ytd_cost_sales_uom,
--      rec_part_detail_.ytd_cost_sales_uom_total,
	  rec_supervisor_.supervisor,
      row_no$_, 0);
   row_no$_ := row_no$_+1;
END Add_Result_Row___;

-----------------------------------------------------------------------------
-------------------- REPORT EXECUTION ---------------------------------------
-----------------------------------------------------------------------------

PROCEDURE Execute_Report (
   report_attr_    IN VARCHAR2,
   parameter_attr_ IN VARCHAR2 )
IS
   result_key$_              NUMBER;
   row_no$_                  NUMBER := 1;
   binds$_                   binds$;
   xml$_                     CLOB;
   outer_filter_attr$_       VARCHAR2(32000);
   outer_filter_where$_      VARCHAR2(32000);
   inner_filter_attr$_       VARCHAR2(32000);
   inner_filter_where$_      VARCHAR2(32000);
   has_contract_ BOOLEAN;
   rec_contract_ get_contract%ROWTYPE;
   par_contract_ binds$;
   has_supervisor_ BOOLEAN;
   rec_supervisor_ get_supervisor%ROWTYPE;
   par_supervisor_ binds$;
   has_salesman_ BOOLEAN;
   rec_salesman_ get_salesman%ROWTYPE;
   par_salesman_ binds$;
   has_customer_ BOOLEAN;
   rec_customer_ get_customer%ROWTYPE;
   par_customer_ binds$;
   has_part_ BOOLEAN;
   rec_part_ get_part%ROWTYPE;
   par_part_ binds$;
   has_part_detail_ BOOLEAN;
   rec_part_detail_ get_part_detail%ROWTYPE;
   par_part_detail_ binds$;
   
   detail_netamount        NUMBER;
   detail_ytd_netamount    NUMBER;
   
   part_gross_profit       NUMBER;
   part_netamount          NUMBER;
   part_ytd_gross_profit   NUMBER;
   part_ytd_netamount      NUMBER;
   
   customer_gross_profit       NUMBER;
   customer_netamount          NUMBER;
   customer_ytd_gross_profit   NUMBER;
   customer_ytd_netamount      NUMBER;

   salesman_gross_profit       NUMBER;
   salesman_netamount          NUMBER;
   salesman_ytd_gross_profit   NUMBER;
   salesman_ytd_netamount      NUMBER;

   supervisor_gross_profit       NUMBER;
   supervisor_netamount          NUMBER;
   supervisor_ytd_gross_profit   NUMBER;
   supervisor_ytd_netamount      NUMBER;

   contract_gross_profit       NUMBER;
   contract_netamount          NUMBER;
   contract_ytd_gross_profit   NUMBER;
   contract_ytd_netamount      NUMBER;
   
   cur_percent_ NUMBER;
   ytd_percent_ NUMBER;
   
   salesman_code_ VARCHAR2(25);
   CONTRACT_ VARCHAR2(200);
   SALESMAN_ VARCHAR2(20000);
   current_year_        NUMBER;
   current_month_       NUMBER;
   current_month_desc_  VARCHAR2(200);
   previus_month_desc_  VARCHAR2(200);
   
BEGIN
   General_SYS.Init_Method(lu_name_, 'SALES_BY_CUSTOMER_RPI', 'Execute_Report');
   result_key$_                 := Client_SYS.Attr_Value_To_Number(Client_SYS.Get_Item_Value('RESULT_KEY', report_attr_));
   binds$_.report_key           := Client_SYS.Get_Item_Value('REPORT_KEY', parameter_attr_); 
   binds$_.salesman_code        := Client_SYS.Get_Item_Value('SALESMAN_CODE', parameter_attr_); 
   binds$_.site                 := Client_SYS.Get_Item_Value('SITE', parameter_attr_); 
   binds$_.title                := Client_SYS.Get_Item_Value('TITLE', parameter_attr_); 
   binds$_.months               := Client_SYS.Attr_Value_To_Number(Client_SYS.Get_Item_Value('MONTHS', parameter_attr_));
   
   CONTRACT_ := Client_SYS.Get_Item_Value('SITE', parameter_attr_);
   SALESMAN_ := Client_SYS.Get_Item_Value('SALESMAN_CODE', parameter_attr_);
   
   SALESMAN_ := REPLACE(SALESMAN_,'&',' ');
   SALESMAN_ := REPLACE(SALESMAN_,'-',' ');
   SALESMAN_ := REPLACE(SALESMAN_,'''',' ');
   SALESMAN_ := REPLACE(SALESMAN_,'.',' ');
   SALESMAN_ := REPLACE(SALESMAN_,'(',' ');
   SALESMAN_ := REPLACE(SALESMAN_,')',' ');
   
   current_year_  := to_number(to_char(ADD_MONTHS(SYSDATE, binds$_.months*-1),'YYYY'));
   current_month_ := to_number(to_char(ADD_MONTHS(SYSDATE, binds$_.months*-1),'MM'));
   current_month_desc_ := to_char(ADD_MONTHS(SYSDATE, binds$_.months*-1),'Mon-YYYY');

   Xml_Record_Writer_SYS.Create_Report_Header(xml$_, 'SALES_BY_CUSTOMER_REP', 'Sales By Customer');
   Xml_Record_Writer_SYS.Add_Element(xml$_, 'CURRENT_YEAR', current_year_);
   Xml_Record_Writer_SYS.Add_Element(xml$_, 'CURRENT_MONTH', current_month_desc_);

   has_contract_ := FALSE;
   par_contract_ := binds$_;
   Xml_Record_Writer_SYS.Start_Element(xml$_, 'CONTRACTS');
   OPEN get_contract(CONTRACT_, current_year_, current_month_);
   LOOP
      FETCH get_contract INTO rec_contract_;
      has_contract_ := get_contract%FOUND OR get_contract%ROWCOUNT > 0;
      EXIT WHEN get_contract%NOTFOUND;
      contract_gross_profit       := 0;
      contract_netamount          := 0;
      contract_ytd_gross_profit   := 0;
      contract_ytd_netamount      := 0;

      Xml_Record_Writer_SYS.Start_Element(xml$_, 'CONTRACT');
      Xml_Record_Writer_SYS.Add_Element(xml$_, 'CONTRACT', rec_contract_.contract);
      Xml_Record_Writer_SYS.Add_Element(xml$_, 'COMPANY', rec_contract_.company);
      Xml_Record_Writer_SYS.Add_Element(xml$_, 'COMPANY_NAME', rec_contract_.company_name);

	   has_supervisor_ := FALSE;
      par_supervisor_ := binds$_;
      Xml_Record_Writer_SYS.Start_Element(xml$_, 'SUPERVISORS');
      OPEN get_supervisor(rec_contract_.contract, SALESMAN_, current_year_, current_month_);
      LOOP
         FETCH get_supervisor INTO rec_supervisor_;
         has_supervisor_ := get_supervisor%FOUND OR get_supervisor%ROWCOUNT > 0;
         EXIT WHEN get_supervisor%NOTFOUND;
         supervisor_gross_profit       := 0;
         supervisor_netamount          := 0;
         supervisor_ytd_gross_profit   := 0;
         supervisor_ytd_netamount      := 0;

         Xml_Record_Writer_SYS.Start_Element(xml$_, 'SUPERVISOR');
         Xml_Record_Writer_SYS.Add_Element(xml$_, 'SUPERVISOR', rec_supervisor_.supervisor);
         Xml_Record_Writer_SYS.Add_Element(xml$_, 'NAME', rec_supervisor_.name);

	      has_salesman_ := FALSE;
	      par_salesman_ := binds$_;
	      Xml_Record_Writer_SYS.Start_Element(xml$_, 'SALESMEN');
         OPEN get_salesman(rec_contract_.contract, rec_supervisor_.supervisor, SALESMAN_, current_year_, current_month_);
	      LOOP
	         FETCH get_salesman INTO rec_salesman_;
	         has_salesman_ := get_salesman%FOUND OR get_salesman%ROWCOUNT > 0;
	         EXIT WHEN get_salesman%NOTFOUND;
	         salesman_gross_profit       := 0;
	         salesman_netamount          := 0;
	         salesman_ytd_gross_profit   := 0;
	         salesman_ytd_netamount      := 0;

	         Xml_Record_Writer_SYS.Start_Element(xml$_, 'SALESMAN');
	         Xml_Record_Writer_SYS.Add_Element(xml$_, 'SALESMAN_CODE', rec_salesman_.salesman_code);

	         salesman_code_ := rec_salesman_.salesman_code;
	         salesman_code_ := REPLACE(salesman_code_,'&',' ');
	         salesman_code_ := REPLACE(salesman_code_,'-',' ');
	         salesman_code_ := REPLACE(salesman_code_,'''',' ');
	         salesman_code_ := REPLACE(salesman_code_,'.',' ');
	         salesman_code_ := REPLACE(salesman_code_,'(',' ');
	         salesman_code_ := REPLACE(salesman_code_,')',' ');
	         Xml_Record_Writer_SYS.Add_Element(xml$_, 'SALESMAN_CODE_AIM', salesman_code_);

	         Xml_Record_Writer_SYS.Add_Element(xml$_, 'NAME', rec_salesman_.name);
	         has_customer_ := FALSE;
	         par_customer_ := binds$_;
	         Xml_Record_Writer_SYS.Start_Element(xml$_, 'CUSTOMERS');
	         OPEN get_customer(rec_contract_.contract, rec_salesman_.salesman_code, current_year_, current_month_);
	         LOOP
	            FETCH get_customer INTO rec_customer_;
	            has_customer_ := get_customer%FOUND OR get_customer%ROWCOUNT > 0;
	            EXIT WHEN get_customer%NOTFOUND;
	            customer_gross_profit       := 0;
	            customer_netamount          := 0;
	            customer_ytd_gross_profit   := 0;
	            customer_ytd_netamount      := 0;

	            Xml_Record_Writer_SYS.Start_Element(xml$_, 'CUSTOMER');
	            Xml_Record_Writer_SYS.Add_Element(xml$_, 'CUSTOMER_NO', rec_customer_.customer_no);
	            Xml_Record_Writer_SYS.Add_Element(xml$_, 'CUSTOMER_NAME', rec_customer_.customer_name);
	            has_part_ := FALSE;
	            par_part_ := binds$_;
	            Xml_Record_Writer_SYS.Start_Element(xml$_, 'PARTS');
	            OPEN get_part(rec_contract_.contract, rec_salesman_.salesman_code, rec_customer_.customer_no, current_year_, current_month_);
	            LOOP
	               FETCH get_part INTO rec_part_;
	               has_part_ := get_part%FOUND OR get_part%ROWCOUNT > 0;
	               EXIT WHEN get_part%NOTFOUND;
	               part_gross_profit       := 0;
	               part_netamount          := 0;
	               part_ytd_gross_profit   := 0;
	               part_ytd_netamount      := 0;

	               Xml_Record_Writer_SYS.Start_Element(xml$_, 'PART');
	               Xml_Record_Writer_SYS.Add_Element(xml$_, 'PART_NO', rec_part_.part_no);
	               Xml_Record_Writer_SYS.Add_Element(xml$_, 'DESCRIPTION', rec_part_.description);
	               has_part_detail_ := FALSE;
	               par_part_detail_ := binds$_;
	               Xml_Record_Writer_SYS.Start_Element(xml$_, 'DETAILS');
	               OPEN get_part_detail(rec_contract_.contract, rec_salesman_.salesman_code, rec_customer_.customer_no, rec_part_.part_no, current_year_, current_month_);
	               LOOP
	                  FETCH get_part_detail INTO rec_part_detail_;
	                  has_part_detail_ := get_part_detail%FOUND OR get_part_detail%ROWCOUNT > 0;
	                  EXIT WHEN get_part_detail%NOTFOUND;
	                  Xml_Record_Writer_SYS.Start_Element(xml$_, 'PART_DETAIL');
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_YEAR', rec_part_detail_.ytd_year);
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'CURRENT_MONTH', rec_part_detail_.current_month);
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'QTY', NVL(rec_part_detail_.qty,0));
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'CURRENCYNETAMOUNT', NVL(rec_part_detail_.currencynetamount,0));
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'NETAMOUNT', NVL(rec_part_detail_.netamount,0));
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'COST', NVL(rec_part_detail_.cost,0));
					      Xml_Record_Writer_SYS.Add_Element(xml$_, 'FREIGHT_COST', NVL(rec_part_detail_.freight_cost,0));
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'GROSS_PROFIT', NVL(rec_part_detail_.gross_profit,0));
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_QTY', NVL(rec_part_detail_.ytd_qty,0));
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_CURR_NETAMOUNT', NVL(rec_part_detail_.ytd_curr_netamount,0));
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_NETAMOUNT', NVL(rec_part_detail_.ytd_netamount,0));
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_COST', NVL(rec_part_detail_.ytd_cost,0));
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_FREIGHT', NVL(rec_part_detail_.ytd_freight,0));
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_GROSS_PROFIT', NVL(rec_part_detail_.ytd_gross_profit,0));

	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'COST_SALES_UOM', NVL(rec_part_detail_.CostSalesUom,0));
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'COST_SALES_UOM_TOTAL', NVL(rec_part_detail_.CostSalesUomTotal,0));
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_COST_SALES_UOM', NVL(rec_part_detail_.YtdCostSalesUom,0));
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_COST_SALES_UOM_TOTAL', NVL(rec_part_detail_.YtdCostSalesUomTotal,0));

	                  detail_netamount := rec_part_detail_.netamount;
	                  IF ( detail_netamount = 0) THEN
	                     detail_netamount := 0.0001;
	                  END IF;
	                  detail_ytd_netamount := rec_part_detail_.ytd_netamount;
	                  IF ( detail_ytd_netamount = 0) THEN
	                     detail_ytd_netamount := 0.0001;
	                  END IF;
	                  cur_percent_ := 100.0 * rec_part_detail_.gross_profit / detail_netamount;
	                  ytd_percent_ := 100.0 * rec_part_detail_.ytd_gross_profit / detail_ytd_netamount;
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'CUR_PERCENT', cur_percent_);
	                  Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_PERCENT', ytd_percent_);

	                  Xml_Record_Writer_SYS.End_Element(xml$_, 'PART_DETAIL');
	                  Add_Result_Row___(result_key$_,
	                                    binds$_ => binds$_,
	                                    rec_contract_ => rec_contract_,
	                                    rec_salesman_ => rec_salesman_,
	                                    rec_customer_ => rec_customer_,
	                                    rec_part_ => rec_part_,
	                                    rec_part_detail_ => rec_part_detail_,
	                                    row_no$_ => row_no$_);

	                  part_gross_profit       := part_gross_profit + nvl(rec_part_detail_.gross_profit,0);
	                  part_netamount          := part_netamount + nvl(rec_part_detail_.netamount,0);
	                  part_ytd_gross_profit   := part_ytd_gross_profit + nvl(rec_part_detail_.ytd_gross_profit,0);
	                  part_ytd_netamount      := part_ytd_netamount + nvl(rec_part_detail_.ytd_netamount,0);
	               END LOOP;
	               CLOSE get_part_detail;

	               Xml_Record_Writer_SYS.End_Element(xml$_, 'DETAILS');
	               binds$_ := par_part_detail_;
	               IF NOT has_part_detail_ THEN
	                  Add_Result_Row___(result_key$_,
	                                    binds$_ => binds$_,
	                                    rec_contract_ => rec_contract_,
	                                    rec_supervisor_ => rec_supervisor_,
	                                    rec_salesman_ => rec_salesman_,
	                                    rec_customer_ => rec_customer_,
	                                    rec_part_ => rec_part_,
	                                    row_no$_ => row_no$_);
	               END IF;

	               customer_gross_profit       := customer_gross_profit + part_gross_profit;
	               customer_netamount          := customer_netamount + part_netamount;
	               customer_ytd_gross_profit   := customer_ytd_gross_profit + part_ytd_gross_profit;
	               customer_ytd_netamount      := customer_ytd_netamount + part_ytd_netamount;
	               IF ( part_netamount = 0) THEN
	                  part_netamount := 0.0001;
	               END IF;
	               IF ( part_ytd_netamount = 0) THEN
	                  part_ytd_netamount := 0.0001;
	               END IF;
	               cur_percent_ := 100.0 * part_gross_profit / part_netamount;
	               ytd_percent_ := 100.0 * part_ytd_gross_profit / part_ytd_netamount;
	               Xml_Record_Writer_SYS.Add_Element(xml$_, 'CUR_PERCENT', cur_percent_);
	               Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_PERCENT', ytd_percent_);
	               Xml_Record_Writer_SYS.End_Element(xml$_, 'PART');
	            END LOOP;
	            CLOSE get_part;
	            Xml_Record_Writer_SYS.End_Element(xml$_, 'PARTS');
	            binds$_ := par_part_;
	            IF NOT has_part_ THEN
	               Add_Result_Row___(result_key$_,
	                                 binds$_ => binds$_,
	                                 rec_contract_ => rec_contract_,
                                    rec_supervisor_ => rec_supervisor_,
	                                 rec_salesman_ => rec_salesman_,
	                                 rec_customer_ => rec_customer_,
	                                 row_no$_ => row_no$_);
	            END IF;

	            salesman_gross_profit       := salesman_gross_profit + customer_gross_profit;
	            salesman_netamount          := salesman_netamount + customer_netamount;
	            salesman_ytd_gross_profit   := salesman_ytd_gross_profit + customer_ytd_gross_profit;
	            salesman_ytd_netamount      := salesman_ytd_netamount + customer_ytd_netamount;
	            IF ( customer_netamount = 0) THEN
	               customer_netamount := 0.0001;
	            END IF;
	            IF ( customer_ytd_netamount = 0) THEN
	               customer_ytd_netamount := 0.0001;
	            END IF;
	            cur_percent_ := 100.0 * customer_gross_profit / customer_netamount;
	            ytd_percent_ := 100.0 * customer_ytd_gross_profit / customer_ytd_netamount;
	            Xml_Record_Writer_SYS.Add_Element(xml$_, 'CUR_PERCENT', cur_percent_);
	            Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_PERCENT', ytd_percent_);
	            Xml_Record_Writer_SYS.End_Element(xml$_, 'CUSTOMER');
	         END LOOP;
	         CLOSE get_customer;
	         Xml_Record_Writer_SYS.End_Element(xml$_, 'CUSTOMERS');
	         binds$_ := par_customer_;
	         IF NOT has_customer_ THEN
	            Add_Result_Row___(result_key$_,
	                              binds$_ => binds$_,
                                 rec_contract_ => rec_contract_,
                                 rec_supervisor_ => rec_supervisor_,
	                              rec_salesman_ => rec_salesman_,
	                              row_no$_ => row_no$_);
	         END IF;

	         supervisor_gross_profit       := supervisor_gross_profit + salesman_gross_profit;
	         supervisor_netamount          := supervisor_netamount + salesman_netamount;
	         supervisor_ytd_gross_profit   := supervisor_ytd_gross_profit + salesman_ytd_gross_profit;
	         supervisor_ytd_netamount      := supervisor_ytd_netamount + salesman_ytd_netamount;
	         IF ( salesman_netamount = 0) THEN
	            salesman_netamount := 0.0001;
	         END IF;
	         IF ( salesman_ytd_netamount = 0) THEN
	            salesman_ytd_netamount := 0.0001;
	         END IF;
	         cur_percent_ := 100.0 * salesman_gross_profit / salesman_netamount;
	         ytd_percent_ := 100.0 * salesman_ytd_gross_profit / salesman_ytd_netamount;
	         Xml_Record_Writer_SYS.Add_Element(xml$_, 'CUR_PERCENT', cur_percent_);
	         Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_PERCENT', ytd_percent_);

	         Xml_Record_Writer_SYS.End_Element(xml$_, 'SALESMAN');
	      END LOOP;
	      CLOSE get_salesman;
	      Xml_Record_Writer_SYS.End_Element(xml$_, 'SALESMEN');
	      binds$_ := par_salesman_;
	      IF NOT has_salesman_ THEN
	         Add_Result_Row___(result_key$_,
	                           binds$_ => binds$_,
                              rec_contract_ => rec_contract_,
                              rec_supervisor_ => rec_supervisor_,
                              row_no$_ => row_no$_);
         END IF;
         contract_gross_profit       := contract_gross_profit + supervisor_gross_profit;
         contract_netamount          := contract_netamount + supervisor_netamount;
         contract_ytd_gross_profit   := contract_ytd_gross_profit + supervisor_ytd_gross_profit;
         contract_ytd_netamount      := contract_ytd_netamount + supervisor_ytd_netamount;

         IF ( supervisor_netamount = 0) THEN
	            supervisor_netamount := 0.0001;
         END IF;
         IF ( supervisor_ytd_netamount = 0) THEN
            supervisor_ytd_netamount := 0.0001;
         END IF;
         cur_percent_ := 100.0 * supervisor_gross_profit / supervisor_netamount;
         ytd_percent_ := 100.0 * supervisor_ytd_gross_profit / supervisor_ytd_netamount;
         Xml_Record_Writer_SYS.Add_Element(xml$_, 'CUR_PERCENT', cur_percent_);
         Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_PERCENT', ytd_percent_);
         Xml_Record_Writer_SYS.End_Element(xml$_, 'SUPERVISOR');
      END LOOP;
      CLOSE get_supervisor;
      Xml_Record_Writer_SYS.End_Element(xml$_, 'SUPERVISORS');
      binds$_ := par_supervisor_;
      IF NOT has_supervisor_ THEN
         Add_Result_Row___(result_key$_,
                           binds$_ => binds$_,
                           rec_contract_ => rec_contract_,
                           row_no$_ => row_no$_);
      END IF;
      
      IF ( contract_netamount = 0) THEN 
         contract_netamount := 0.0001;
      END IF;
      IF ( contract_ytd_netamount = 0) THEN 
         contract_ytd_netamount := 0.0001;
      END IF;
      cur_percent_ := 100.0 * contract_gross_profit / contract_netamount;
      ytd_percent_ := 100.0 * contract_ytd_gross_profit / contract_ytd_netamount;      
      Xml_Record_Writer_SYS.Add_Element(xml$_, 'CUR_PERCENT', cur_percent_);
      Xml_Record_Writer_SYS.Add_Element(xml$_, 'YTD_PERCENT', ytd_percent_);
      
      Xml_Record_Writer_SYS.End_Element(xml$_, 'CONTRACT');
   END LOOP;
   CLOSE get_contract;
   Xml_Record_Writer_SYS.End_Element(xml$_, 'CONTRACTS');
   binds$_ := par_contract_;
   IF NOT has_contract_ THEN
      Add_Result_Row___(result_key$_,
                        binds$_ => binds$_,
                        row_no$_ => row_no$_);
   END IF;

   Xml_Record_Writer_SYS.End_Element(xml$_, 'SALES_BY_CUSTOMER_REP');
   Report_SYS.Finish_Xml_Report('SALES_BY_CUSTOMER_REP', result_key$_, xml$_);
   EXCEPTION
      WHEN OTHERS THEN
         IF get_contract%ISOPEN THEN
            CLOSE get_contract;
         END IF;
         IF get_salesman%ISOPEN THEN
            CLOSE get_salesman;
         END IF;
         IF get_customer%ISOPEN THEN
            CLOSE get_customer;
         END IF;
         IF get_part%ISOPEN THEN
            CLOSE get_part;
         END IF;
         IF get_part_detail%ISOPEN THEN
            CLOSE get_part_detail;
         END IF;
         IF get_supervisor%ISOPEN THEN
            CLOSE get_supervisor;
         END IF;
         RAISE;
END Execute_Report;

-----------------------------------------------------------------------------
-------------------- FOUNDATION1 METHODS ------------------------------------
-----------------------------------------------------------------------------
-- Test
--   Invokes the report method for testing purposes.
-- Init
--   Dummy procedure that can be called at database startup to ensure that
--   this package is loaded into memory for performance reasons only.
-----------------------------------------------------------------------------

FUNCTION Test (
   report_key_               IN VARCHAR2,
   salesman_code_            IN VARCHAR2,
   site_                     IN VARCHAR2,
   title_                    IN VARCHAR2,
   months_                   IN NUMBER)
RETURN NUMBER
IS
   result_key_     NUMBER;
   report_attr_    VARCHAR2(200);
   parameter_attr_ VARCHAR2(32000);
BEGIN
   General_SYS.Init_Method(lu_name_, 'SALES_BY_CUSTOMER_RPI', 'Test');
   Report_SYS.Get_Result_Key__(result_key_);
   Client_SYS.Add_To_Attr('RESULT_KEY', result_key_, report_attr_);
   IF (report_key_ IS NOT NULL) THEN
      Client_SYS.Add_To_Attr('REPORT_KEY', report_key_, parameter_attr_);
   END IF;
   IF (salesman_code_ IS NOT NULL) THEN
      Client_SYS.Add_To_Attr('SALESMAN_CODE', salesman_code_, parameter_attr_);
   END IF;
   IF (site_ IS NOT NULL) THEN
      Client_SYS.Add_To_Attr('SITE', site_, parameter_attr_);
   END IF;
   IF (title_ IS NOT NULL) THEN
      Client_SYS.Add_To_Attr('TITLE', title_, parameter_attr_);
   END IF;
   IF (months_ IS NOT NULL) THEN
      Client_SYS.Add_To_Attr('MONTHS', months_, parameter_attr_);
   END IF;
   Execute_Report(report_attr_, parameter_attr_);
   RETURN result_key_;
END Test;


PROCEDURE Init
IS
BEGIN
   NULL;
END Init;

END SALES_BY_CUSTOMER_RPI;