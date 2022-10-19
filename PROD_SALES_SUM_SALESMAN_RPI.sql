CREATE OR REPLACE PACKAGE BODY SALES_SUM_SALESMAN_RPI IS

   TYPE binds$ IS RECORD (
      report_key                VARCHAR2(2000),
      salesman_code             VARCHAR2(2000),
      site                      VARCHAR2(2000),
      title                     VARCHAR2(2000),
      months                    NUMBER,
      current_year              VARCHAR2(2000),
      previus_year              VARCHAR2(2000),
      current_month             VARCHAR2(2000),
      previus_month             VARCHAR2(2000),
      gp_prc_prev               NUMBER,
      gp_prc_current            NUMBER,
      gp_prc_month              NUMBER,
      gp_prc_month_prev         NUMBER,
      contract                  VARCHAR2(2000),
      salesman                  VARCHAR2(2000));
   
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
   
   CURSOR get_supervisor (contract_ VARCHAR2, salesman_ VARCHAR2) IS
      SELECT NVL(aa.CF$_AIM_SUPERVISOR,a.Salesman_code) SUPERVISOR,             
             PERSON_INFO_API.Get_Name(NVL(aa.CF$_AIM_SUPERVISOR,a.Salesman_code)) name
      FROM SALES_DATA_NEW a
      LEFT JOIN SALES_PART_SALESMAN_CFV aa ON aa.Salesman_code = a.Salesman_code
      where (SALESMAN_ = '%'
            OR INSTR(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SALESMAN_,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '), REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(a.Salesman_code,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' ')) > 0
            OR INSTR(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SALESMAN_,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '),REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(aa.CF$_AIM_SUPERVISOR,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' ')) > 0)
      AND (CONTRACT_ = '%' OR INSTR(CONTRACT_, a.contract) >0)
      GROUP BY NVL(aa.CF$_AIM_SUPERVISOR,a.Salesman_code);
      
   CURSOR get_salesman (CONTRACT_ VARCHAR2, SUPERVISOR_ VARCHAR2, SALESMAN_ VARCHAR2) IS
      SELECT a.Salesman_code,
             aa.CF$_AIM_SALESMAN_NAME name
      FROM SALES_DATA_NEW a
      LEFT JOIN SALES_PART_SALESMAN_CFV aa ON aa.Salesman_code = a.Salesman_code
      where (   INSTR(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SUPERVISOR_,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '),REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(a.Salesman_code,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' ')) >0
             OR INSTR(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SUPERVISOR_,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '),REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(aa.CF$_AIM_SUPERVISOR,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '))>0
             OR (SUPERVISOR_ = '%' AND aa.CF$_AIM_SUPERVISOR IS NULL)
             OR (SUPERVISOR_ IS NULL AND aa.CF$_AIM_SUPERVISOR IS NULL AND a.Salesman_code IS NULL)
             )
      AND (SALESMAN_ = '%'
            OR INSTR(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SALESMAN_,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '), REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(a.Salesman_code,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' ')) > 0
            OR INSTR(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SALESMAN_,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' '),REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(aa.CF$_AIM_SUPERVISOR,'&',' '),'-',' '),'''',' '),'.',' '),'(',' '),')',' ')) > 0)
      AND (CONTRACT_ = '%' OR INSTR(CONTRACT_, a.contract) >0)
      GROUP BY a.Salesman_code, aa.CF$_AIM_SALESMAN_NAME;
   
   CURSOR get_customer_detail (contract_ VARCHAR2, SALESMAN_ VARCHAR2, current_year_ NUMBER, current_month_ NUMBER) IS
      SELECT * FROM (SELECT   a.customer_no,
                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ - 1 AND extract(month from INVOICE_DATE) <= current_month_ THEN nvl(Net_Amount,0) ELSE 0 END) Amount_Prev,
                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ AND extract(month from INVOICE_DATE) <= current_month_ THEN nvl(Net_Amount,0) ELSE 0 END) Amount_Current,
                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ AND extract(month from INVOICE_DATE) = current_month_ THEN nvl(Net_Amount,0) ELSE 0 END) Amount_Month,
                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ -1 AND extract(month from INVOICE_DATE) = current_month_ THEN nvl(Net_Amount,0) ELSE 0 END) Amount_Month_Prev,

                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ - 1 AND extract(month from INVOICE_DATE) <= current_month_ THEN a.Cost ELSE 0.0 END) Cost_Prev,
                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ AND extract(month from INVOICE_DATE) <= current_month_ THEN a.Cost ELSE 0 END) Cost_Current,
                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ AND extract(month from INVOICE_DATE) = current_month_ THEN a.Cost ELSE 0 END) Cost_Month,
                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ -1 AND extract(month from INVOICE_DATE) = current_month_ THEN a.Cost ELSE 0 END) Cost_Month_Prev,

                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ - 1 AND extract(month from INVOICE_DATE) <= current_month_ THEN a.freight_cost ELSE 0.0 END) freight_Prev,
                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ AND extract(month from INVOICE_DATE) <= current_month_ THEN a.freight_cost ELSE 0 END) freight_Current,
                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ AND extract(month from INVOICE_DATE) = current_month_ THEN a.freight_cost ELSE 0 END) freight_Month,
                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ -1 AND extract(month from INVOICE_DATE) = current_month_ THEN a.freight_cost ELSE 0 END) freight_Month_Prev,
                              
                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ - 1 AND extract(month from INVOICE_DATE) <= current_month_ THEN a.GrossProfit ELSE 0.0 END) gp_Prev,
                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ AND extract(month from INVOICE_DATE) <= current_month_ THEN a.GrossProfit ELSE 0 END) gp_Current,
                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ AND extract(month from INVOICE_DATE) = current_month_ THEN a.GrossProfit ELSE 0 END) gp_Month,
                     sum(CASE WHEN extract(year from INVOICE_DATE) = current_year_ -1 AND extract(month from INVOICE_DATE) = current_month_ THEN a.GrossProfit ELSE 0 END) gp_Month_Prev
                              
            FROM SALES_DATA_NEW a 
            left outer join SALES_PART_cfv i ON i.CATALOG_NO = a.catalog_no and i.Contract = a.Contract
            WHERE (CONTRACT_ = '%' OR INSTR(CONTRACT_, a.contract) >0)
            AND nvl(Salesman_code,'xxx') = nvl(SALESMAN_,'xxx')
            AND NVL(i.CF$_AIM_EXCLUDE_SALES_REP_DB, 'FALSE') = 'FALSE' 
            GROUP BY a.customer_no)
      WHERE Amount_Prev <> 0 
            OR Amount_Current <> 0
            OR Amount_Month <> 0
            OR Amount_Month_Prev <> 0
            OR Cost_Prev <> 0
            OR Cost_Current <> 0
            OR Cost_Month <> 0
            OR Cost_Month_Prev <> 0
            OR freight_Prev <> 0
            OR freight_Current <> 0
            OR freight_Month <> 0
            OR freight_Month_Prev <> 0
      ORDER BY Amount_Current DESC;
   


-----------------------------------------------------------------------------
-------------------- RESULT SET METHODS -------------------------------------
-----------------------------------------------------------------------------

--@IgnoreWrongParamOrder
PROCEDURE Add_Result_Row___ (
   result_key$_               IN NUMBER,
   binds$_                    IN binds$,
   rec_customer_detail_       IN get_customer_detail%ROWTYPE DEFAULT NULL,
   rec_salesman_              IN get_salesman%ROWTYPE DEFAULT NULL,
   rec_supervisor_            IN get_supervisor%ROWTYPE DEFAULT NULL,
   rec_contract_              IN get_contract%ROWTYPE DEFAULT NULL,
   row_no$_                   IN OUT NUMBER)
IS
BEGIN
   INSERT INTO SALES_SUM_SALESMAN_RPT (
      result_key,
      report_key,
      salesman_code,
      site,
      title,
      months,
      current_year,
      previus_year,
      current_month,
      previus_month,
--      gp_prc_prev,
--      gp_prc_current,
--      gp_prc_month,
--      gp_prc_month_prev,
      customer_no,
--      customer_desc,
      amount_prev,
      amount_current,
      amount_month,
      amount_month_prev,
      cost_prev,
      cost_current,
      cost_month,
      cost_month_prev,
--      freight_prev,
--      freight_current,
--      freight_month,
--      freight_month_prev,
--      gp_prev,
--      gp_current,
--      gp_month,
--      gp_month_prev,
     -- salesman_code_aim,
      name,
      supervisor,
      contract,
      company,
      company_name,
      row_no, parent_row_no)
   VALUES (
      result_key$_,
      binds$_.report_key,
      nvl(rec_salesman_.salesman_code,
      binds$_.salesman_code),
      binds$_.site,
      binds$_.title,
      binds$_.months,
      binds$_.current_year,
      binds$_.previus_year,
      binds$_.current_month,
      binds$_.previus_month,
--      nvl(rec_contract_.gp_prc_prev,
--      nvl(rec_supervisor_.gp_prc_prev,
--      nvl(rec_salesman_.gp_prc_prev,
--      nvl(rec_customer_detail_.gp_prc_prev,
--      binds$_.gp_prc_prev)))),
--      nvl(rec_contract_.gp_prc_current,
--      nvl(rec_supervisor_.gp_prc_current,
--     nvl(rec_salesman_.gp_prc_current,
--      nvl(rec_customer_detail_.gp_prc_current,
--      binds$_.gp_prc_current)))),
--      nvl(rec_contract_.gp_prc_month,
--      nvl(rec_supervisor_.gp_prc_month,
--      nvl(rec_salesman_.gp_prc_month,
--      nvl(rec_customer_detail_.gp_prc_month,
--      binds$_.gp_prc_month)))),
--      nvl(rec_contract_.gp_prc_month_prev,
--      nvl(rec_supervisor_.gp_prc_month_prev,
--      nvl(rec_salesman_.gp_prc_month_prev,
--      nvl(rec_customer_detail_.gp_prc_month_prev,
 --     binds$_.gp_prc_month_prev)))),
      rec_customer_detail_.customer_no,
--      rec_customer_detail_.customer_desc,
      rec_customer_detail_.amount_prev,
      rec_customer_detail_.amount_current,
      rec_customer_detail_.amount_month,
      rec_customer_detail_.amount_month_prev,
      rec_customer_detail_.cost_prev,
      rec_customer_detail_.cost_current,
      rec_customer_detail_.cost_month,
      rec_customer_detail_.cost_month_prev,
--      rec_customer_detail_.freight_prev,
--      rec_customer_detail_.freight_current,
--      rec_customer_detail_.freight_month,
--      rec_customer_detail_.freight_month_prev,
--      rec_customer_detail_.gp_prev,
--      rec_customer_detail_.gp_current,
--      rec_customer_detail_.gp_month,
--      rec_customer_detail_.gp_month_prev,
--      rec_salesman_.salesman_code_aim,
      nvl(rec_supervisor_.name,
      rec_salesman_.name),
      rec_supervisor_.supervisor,
      rec_contract_.contract,
      rec_contract_.company,
      rec_contract_.company_name,
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
   has_customer_detail_ BOOLEAN;
   rec_customer_detail_ get_customer_detail%ROWTYPE;
   par_customer_detail_ binds$;
   has_salesman_ BOOLEAN;
   rec_salesman_ get_salesman%ROWTYPE;
   par_salesman_ binds$;
   has_supervisor_ BOOLEAN;
   rec_supervisor_ get_supervisor%ROWTYPE;
   par_supervisor_ binds$;
   has_contract_ BOOLEAN;
   rec_contract_ get_contract%ROWTYPE;
   par_contract_ binds$;

   CONTRACT_            VARCHAR2(200);
   SALESMAN_            VARCHAR2(2000);
   current_year_        NUMBER;
   current_month_       NUMBER;
   current_month_desc_  VARCHAR2(200);
   previus_month_desc_  VARCHAR2(200);
   customer_desc_       VARCHAR2(200);
   salesman_code_       VARCHAR2(25);
   
   salesman_gross_profit       NUMBER;
   salesman_gross_profit_pr    NUMBER;
   salesman_netamount          NUMBER;
   salesman_netamount_pr       NUMBER;
   salesman_ytd_gross_profit    NUMBER;
   salesman_ytd_gross_profit_pr NUMBER;
   salesman_ytd_netamount       NUMBER;          
   salesman_ytd_netamount_pr    NUMBER;
   
   market_gross_profit       NUMBER;
   market_netamount          NUMBER;      
   market_gross_profit_pr    NUMBER;
   market_netamount_pr       NUMBER;      
   market_ytd_gross_profit   NUMBER;
   market_ytd_netamount      NUMBER;      
   market_ytd_gross_profit_pr   NUMBER;
   market_ytd_netamount_pr      NUMBER;
   
   supervisor_gross_profit       NUMBER;
   supervisor_netamount          NUMBER;
   supervisor_gross_profit_pr       NUMBER;
   supervisor_netamount_pr          NUMBER;
   supervisor_ytd_gross_profit   NUMBER;
   supervisor_ytd_netamount      NUMBER;
   supervisor_ytd_gross_profit_pr   NUMBER;
   supervisor_ytd_netamount_pr      NUMBER;
   
   contract_gross_profit       NUMBER;
   contract_netamount          NUMBER;
   contract_gross_profit_pr       NUMBER;
   contract_netamount_pr          NUMBER;
   contract_ytd_gross_profit   NUMBER;
   contract_ytd_netamount      NUMBER;
   contract_ytd_gross_profit_pr   NUMBER;
   contract_ytd_netamount_pr      NUMBER;
   
   cur_percent_    NUMBER;
   cur_percent_pr_ NUMBER;
   ytd_percent_    NUMBER;
   ytd_percent_pr_ NUMBER;
   
BEGIN
   General_SYS.Init_Method(lu_name_, 'SALES_SUM_SALESMAN_RPI', 'Execute_Report');
   result_key$_                 := Client_SYS.Attr_Value_To_Number(Client_SYS.Get_Item_Value('RESULT_KEY', report_attr_));
   binds$_.report_key           := Client_SYS.Get_Item_Value('REPORT_KEY', parameter_attr_); 
   binds$_.salesman_code        := Client_SYS.Get_Item_Value('SALESMAN_CODE', parameter_attr_); 
   binds$_.site                 := Client_SYS.Get_Item_Value('SITE', parameter_attr_); 
   binds$_.title                := Client_SYS.Get_Item_Value('TITLE', parameter_attr_); 
   binds$_.months               := Client_SYS.Attr_Value_To_Number(Client_SYS.Get_Item_Value('MONTHS', parameter_attr_));

   CONTRACT_      := Client_SYS.Get_Item_Value('SITE', parameter_attr_);
   SALESMAN_      := Client_SYS.Get_Item_Value('SALESMAN_CODE', parameter_attr_);
   current_year_  := to_number(to_char(ADD_MONTHS(SYSDATE, binds$_.months*-1),'YYYY'));
   current_month_ := to_number(to_char(ADD_MONTHS(SYSDATE, binds$_.months*-1),'MM'));
   current_month_desc_ := to_char(ADD_MONTHS(SYSDATE, binds$_.months*-1),'Mon-YYYY');
   previus_month_desc_ := to_char(ADD_MONTHS(SYSDATE, (binds$_.months + 12)*-1),'Mon-YYYY');
   
   Xml_Record_Writer_SYS.Create_Report_Header(xml$_, 'SALES_SUM_SALESMAN_REP', 'Sales Sum By Customer');
   Xml_Record_Writer_SYS.Add_Element(xml$_, 'CURRENT_YEAR', current_year_);
   Xml_Record_Writer_SYS.Add_Element(xml$_, 'PREVIUS_YEAR', current_year_-1);
   Xml_Record_Writer_SYS.Add_Element(xml$_, 'CURRENT_MONTH', current_month_desc_);
   Xml_Record_Writer_SYS.Add_Element(xml$_, 'PREVIUS_MONTH', previus_month_desc_);
   
   market_gross_profit       := 0;
   market_netamount          := 0;         
   market_gross_profit_pr    := 0;
   market_netamount_pr       := 0;         
   market_ytd_gross_profit   := 0;
   market_ytd_netamount      := 0;         
   market_ytd_gross_profit_pr   := 0;
   market_ytd_netamount_pr      := 0;
         
   has_contract_ := FALSE;
   par_contract_ := binds$_;
   Xml_Record_Writer_SYS.Start_Element(xml$_, 'CONTRACTS');
   OPEN get_contract(CONTRACT_, current_year_, current_month_);
   LOOP
      FETCH get_contract INTO rec_contract_;
      has_contract_ := get_contract%FOUND OR get_contract%ROWCOUNT > 0;
      EXIT WHEN get_contract%NOTFOUND;
      Xml_Record_Writer_SYS.Start_Element(xml$_, 'CONTRACT');
      Xml_Record_Writer_SYS.Add_Element(xml$_, 'CONTRACT', rec_contract_.contract);
      Xml_Record_Writer_SYS.Add_Element(xml$_, 'COMPANY', rec_contract_.company);
      Xml_Record_Writer_SYS.Add_Element(xml$_, 'COMPANY_NAME', rec_contract_.company_name);
      
      contract_gross_profit       := 0;
      contract_netamount          := 0;         
      contract_gross_profit_pr    := 0;
      contract_netamount_pr       := 0;         
      contract_ytd_gross_profit   := 0;
      contract_ytd_netamount      := 0;         
      contract_ytd_gross_profit_pr   := 0;
      contract_ytd_netamount_pr      := 0;

	   has_supervisor_ := FALSE;
	   par_supervisor_ := binds$_;
	   Xml_Record_Writer_SYS.Start_Element(xml$_, 'SUPERVISORS');
	   OPEN get_supervisor(rec_contract_.contract, SALESMAN_);
	   LOOP
	      FETCH get_supervisor INTO rec_supervisor_;
	      has_supervisor_ := get_supervisor%FOUND OR get_supervisor%ROWCOUNT > 0;
	      EXIT WHEN get_supervisor%NOTFOUND;
	      Xml_Record_Writer_SYS.Start_Element(xml$_, 'SUPERVISOR');
	      Xml_Record_Writer_SYS.Add_Element(xml$_, 'SUPERVISOR', rec_supervisor_.supervisor);
	      Xml_Record_Writer_SYS.Add_Element(xml$_, 'NAME', rec_supervisor_.name);
	      
	      supervisor_gross_profit       := 0;
	      supervisor_netamount          := 0;
	      supervisor_gross_profit_pr       := 0;
	      supervisor_netamount_pr          := 0;
	      supervisor_ytd_gross_profit   := 0;
	      supervisor_ytd_netamount      := 0;
	      supervisor_ytd_gross_profit_pr   := 0;
	      supervisor_ytd_netamount_pr      := 0;
	   
		   has_salesman_ := FALSE;
		   par_salesman_ := binds$_;
		   Xml_Record_Writer_SYS.Start_Element(xml$_, 'SALESMEN');
		   OPEN get_salesman(rec_contract_.contract, rec_supervisor_.supervisor, SALESMAN_);
		   LOOP
		       FETCH get_salesman INTO rec_salesman_;
		       has_salesman_ := get_salesman%FOUND OR get_salesman%ROWCOUNT > 0;
		       EXIT WHEN get_salesman%NOTFOUND;
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
	         
	           salesman_gross_profit       := 0;
	           salesman_gross_profit_pr    := 0;
	           salesman_netamount          := 0;
	           salesman_netamount_pr       := 0;
	           salesman_ytd_gross_profit    := 0;
	           salesman_ytd_gross_profit_pr := 0;
	           salesman_ytd_netamount       := 0;            
	           salesman_ytd_netamount_pr    := 0;
	            
			   has_customer_detail_ := FALSE;
			   par_customer_detail_ := binds$_;
			   Xml_Record_Writer_SYS.Start_Element(xml$_, 'CUSTOMER_DETAILS');
			   OPEN get_customer_detail(rec_contract_.contract, rec_salesman_.salesman_code, current_year_, current_month_);
			   LOOP
			      FETCH get_customer_detail INTO rec_customer_detail_;
			      has_customer_detail_ := get_customer_detail%FOUND OR get_customer_detail%ROWCOUNT > 0;
			      EXIT WHEN get_customer_detail%NOTFOUND;
	
			      customer_desc_ := Cust_Ord_Customer_API.Get_Name(rec_customer_detail_.customer_no);
			      Xml_Record_Writer_SYS.Start_Element(xml$_, 'CUSTOMER_DETAIL');
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'CUSTOMER_NO', rec_customer_detail_.customer_no);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'CUSTOMER_DESC', customer_desc_);
	
	            Xml_Record_Writer_SYS.Add_Element(xml$_, 'AMOUNT_PREV', rec_customer_detail_.amount_prev);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'AMOUNT_CURRENT', rec_customer_detail_.amount_current);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'AMOUNT_MONTH', rec_customer_detail_.amount_month);
	            Xml_Record_Writer_SYS.Add_Element(xml$_, 'AMOUNT_MONTH_PREV', rec_customer_detail_.amount_month_prev);
	
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'COST_PREV', rec_customer_detail_.cost_prev);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'COST_CURRENT', rec_customer_detail_.cost_current);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'COST_MONTH', rec_customer_detail_.cost_month);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'COST_MONTH_PREV', rec_customer_detail_.cost_month_prev);
	
	            Xml_Record_Writer_SYS.Add_Element(xml$_, 'FREIGHT_PREV', rec_customer_detail_.freight_prev);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'FREIGHT_CURRENT', rec_customer_detail_.freight_current);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'FREIGHT_MONTH', rec_customer_detail_.freight_month);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'FREIGHT_MONTH_PREV', rec_customer_detail_.freight_month_prev);
	
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PREV', rec_customer_detail_.gp_prev);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_CURRENT', rec_customer_detail_.gp_current);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_MONTH', rec_customer_detail_.gp_month);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_MONTH_PREV', rec_customer_detail_.gp_month_prev);
	
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_PREV', (rec_customer_detail_.gp_prev)*100/CASE WHEN rec_customer_detail_.amount_prev = 0 THEN 1 ELSE rec_customer_detail_.amount_prev END);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_CURRENT', (rec_customer_detail_.gp_current)*100/CASE WHEN rec_customer_detail_.amount_current = 0 THEN 1 ELSE rec_customer_detail_.amount_current END);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_MONTH', (rec_customer_detail_.gp_month)*100/CASE WHEN rec_customer_detail_.amount_month = 0 THEN 1 ELSE rec_customer_detail_.amount_month END);
			      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_MONTH_PREV', (rec_customer_detail_.gp_month_prev)*100/CASE WHEN rec_customer_detail_.amount_month_prev = 0 THEN 1 ELSE rec_customer_detail_.amount_month_prev END);
			      Xml_Record_Writer_SYS.End_Element(xml$_, 'CUSTOMER_DETAIL');
			      Add_Result_Row___(result_key$_,
			                        binds$_ => binds$_,
			                        rec_customer_detail_ => rec_customer_detail_,	
	                                row_no$_ => row_no$_);
	            
	            salesman_gross_profit       := salesman_gross_profit + rec_customer_detail_.amount_month - rec_customer_detail_.cost_month - rec_customer_detail_.freight_month;
	            salesman_gross_profit_pr    := salesman_gross_profit_pr + rec_customer_detail_.amount_month_prev - rec_customer_detail_.cost_month_prev - rec_customer_detail_.freight_month_prev;
	            salesman_ytd_gross_profit    := salesman_ytd_gross_profit + rec_customer_detail_.amount_current - rec_customer_detail_.cost_current - rec_customer_detail_.freight_current;
	            salesman_ytd_gross_profit_pr := salesman_ytd_gross_profit_pr + rec_customer_detail_.amount_prev - rec_customer_detail_.cost_prev - rec_customer_detail_.freight_prev;
	                        
	            salesman_netamount          := salesman_netamount + nvl(rec_customer_detail_.amount_month,0);
	            salesman_netamount_pr       := salesman_netamount_pr + nvl(rec_customer_detail_.amount_month_prev,0);
	            salesman_ytd_netamount      := salesman_ytd_netamount + rec_customer_detail_.amount_current;            
	            salesman_ytd_netamount_pr   := salesman_ytd_netamount_pr + rec_customer_detail_.amount_prev;
	                        
			   END LOOP;
			   CLOSE get_customer_detail;
			   Xml_Record_Writer_SYS.End_Element(xml$_, 'CUSTOMER_DETAILS');
			   binds$_ := par_customer_detail_;
			   IF NOT has_customer_detail_ THEN
			      Add_Result_Row___(result_key$_,
			                        binds$_ => binds$_,
			                        row_no$_ => row_no$_);
	         END IF;
	         
	         supervisor_gross_profit       := supervisor_gross_profit + salesman_gross_profit;
	         supervisor_gross_profit_pr    := supervisor_gross_profit_pr + salesman_gross_profit_pr;
	         supervisor_ytd_gross_profit   := supervisor_ytd_gross_profit + salesman_ytd_gross_profit;
	         supervisor_ytd_gross_profit_pr   := supervisor_ytd_gross_profit_pr + salesman_ytd_gross_profit_pr;
	         
	         supervisor_netamount          := supervisor_netamount + salesman_netamount;         
	         supervisor_netamount_pr       := supervisor_netamount_pr + salesman_netamount_pr;         
	         supervisor_ytd_netamount      := supervisor_ytd_netamount + salesman_ytd_netamount;         
	         supervisor_ytd_netamount_pr   := supervisor_ytd_netamount_pr + salesman_ytd_netamount_pr;
	         
	         IF ( salesman_netamount = 0) THEN
	            salesman_netamount := 0.0001;
	         END IF;
	         IF ( salesman_netamount_pr = 0) THEN
	            salesman_netamount_pr := 0.0001;
	         END IF;
	         IF ( salesman_ytd_netamount = 0) THEN
	            salesman_ytd_netamount := 0.0001;
	         END IF;
	         IF ( salesman_ytd_netamount_pr = 0) THEN
	            salesman_ytd_netamount_pr := 0.0001;
	         END IF;
	         
	         cur_percent_    := 100.0 * salesman_gross_profit / salesman_netamount;
	         cur_percent_pr_ := 100.0 * salesman_gross_profit_pr / salesman_netamount_pr;
	         ytd_percent_    := 100.0 * salesman_ytd_gross_profit / salesman_ytd_netamount;
	         ytd_percent_pr_ := 100.0 * salesman_ytd_gross_profit_pr / salesman_ytd_netamount_pr;
	         
	         Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_MONTH', cur_percent_);
	         Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_MONTH_PREV', cur_percent_pr_);           
	         Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_CURRENT', ytd_percent_);
	         Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_PREV', ytd_percent_pr_);
	         
			 Xml_Record_Writer_SYS.End_Element(xml$_, 'SALESMAN');
			END LOOP;
		   CLOSE get_salesman;
		   Xml_Record_Writer_SYS.End_Element(xml$_, 'SALESMEN');
		   binds$_ := par_salesman_;
		   IF NOT has_salesman_ THEN
	
		      Add_Result_Row___(result_key$_,
		                        binds$_ => binds$_,
		                        row_no$_ => row_no$_);
	      END IF;
	      
	      contract_gross_profit       := contract_gross_profit + supervisor_gross_profit;
	      contract_gross_profit_pr       := contract_gross_profit_pr + supervisor_gross_profit_pr;
	      contract_ytd_gross_profit   := contract_ytd_gross_profit + supervisor_ytd_gross_profit;
	      contract_ytd_gross_profit_pr   := contract_ytd_gross_profit_pr + supervisor_ytd_gross_profit_pr;
	      
	      contract_netamount          := contract_netamount + supervisor_netamount;         
	      contract_netamount_pr       := contract_netamount_pr + supervisor_netamount_pr;         
	      contract_ytd_netamount      := contract_ytd_netamount + supervisor_ytd_netamount;         
	      contract_ytd_netamount_pr   := contract_ytd_netamount_pr + supervisor_ytd_netamount_pr;
	
	      IF ( supervisor_netamount = 0) THEN
	         supervisor_netamount := 0.0001;
	      END IF;
	      IF ( supervisor_netamount_pr = 0) THEN
	         supervisor_netamount_pr := 0.0001;
	      END IF;
	      IF ( supervisor_ytd_netamount = 0) THEN
	         supervisor_ytd_netamount := 0.0001;
	      END IF;
	      IF ( supervisor_ytd_netamount_pr = 0) THEN
	         supervisor_ytd_netamount_pr := 0.0001;
	      END IF;
	      cur_percent_    := 100.0 * supervisor_gross_profit / supervisor_netamount;
	      cur_percent_pr_ := 100.0 * supervisor_gross_profit_pr / supervisor_netamount_pr;
	      ytd_percent_    := 100.0 * supervisor_ytd_gross_profit / supervisor_ytd_netamount;
	      ytd_percent_pr_ := 100.0 * supervisor_ytd_gross_profit_pr / supervisor_ytd_netamount_pr;
	      
	      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_MONTH', cur_percent_);
	      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_MONTH_PREV', cur_percent_pr_);           
	      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_CURRENT', ytd_percent_);
	      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_PREV', ytd_percent_pr_);            
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
      
      market_gross_profit       := market_gross_profit + contract_gross_profit;
      market_gross_profit_pr    := market_gross_profit_pr + contract_gross_profit_pr;
      market_ytd_gross_profit   := market_ytd_gross_profit + contract_ytd_gross_profit;
      market_ytd_gross_profit_pr   := market_ytd_gross_profit_pr + contract_ytd_gross_profit_pr;

      market_netamount          := market_netamount + contract_netamount;         
      market_netamount_pr       := market_netamount_pr + contract_netamount_pr;         
      market_ytd_netamount      := market_ytd_netamount + contract_ytd_netamount;         
      market_ytd_netamount_pr   := market_ytd_netamount_pr + contract_ytd_netamount_pr;

      IF ( contract_netamount = 0) THEN
         contract_netamount := 0.0001;
      END IF;
      IF ( contract_netamount_pr = 0) THEN
         contract_netamount_pr := 0.0001;
      END IF;
      IF ( contract_ytd_netamount = 0) THEN
         contract_ytd_netamount := 0.0001;
      END IF;
      IF ( contract_ytd_netamount_pr = 0) THEN
         contract_ytd_netamount_pr := 0.0001;
      END IF;
      cur_percent_    := 100.0 * contract_gross_profit / contract_netamount;
      cur_percent_pr_ := 100.0 * contract_gross_profit_pr / contract_netamount_pr;
      ytd_percent_    := 100.0 * contract_ytd_gross_profit / contract_ytd_netamount;
      ytd_percent_pr_ := 100.0 * contract_ytd_gross_profit_pr / contract_ytd_netamount_pr;

      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_MONTH', cur_percent_);
      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_MONTH_PREV', cur_percent_pr_);           
      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_CURRENT', ytd_percent_);
      Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_PREV', ytd_percent_pr_);
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
   IF ( market_netamount = 0) THEN
      market_netamount := 0.0001;
   END IF;
   IF ( market_netamount_pr = 0) THEN
      market_netamount_pr := 0.0001;
   END IF;
   IF ( market_ytd_netamount = 0) THEN
      market_ytd_netamount := 0.0001;
   END IF;
   IF ( market_ytd_netamount_pr = 0) THEN
      market_ytd_netamount_pr := 0.0001;
   END IF;
   
   cur_percent_    := 100.0 * market_gross_profit / market_netamount;
   cur_percent_pr_ := 100.0 * market_gross_profit_pr / market_netamount_pr;
   ytd_percent_    := 100.0 * market_ytd_gross_profit / market_ytd_netamount;
   ytd_percent_pr_ := 100.0 * market_ytd_gross_profit_pr / market_ytd_netamount_pr;   
   
   Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_MONTH', cur_percent_);
   Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_MONTH_PREV', cur_percent_pr_);           
   Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_CURRENT', ytd_percent_);
   Xml_Record_Writer_SYS.Add_Element(xml$_, 'GP_PRC_PREV', ytd_percent_pr_);
      
   Xml_Record_Writer_SYS.End_Element(xml$_, 'SALES_SUM_SALESMAN_REP');
   Report_SYS.Finish_Xml_Report('SALES_SUM_SALESMAN_REP', result_key$_, xml$_);
   EXCEPTION
      WHEN OTHERS THEN
         IF get_customer_detail%ISOPEN THEN
            CLOSE get_customer_detail;
         END IF;
         IF get_salesman%ISOPEN THEN
            CLOSE get_salesman;
         END IF;
         IF get_supervisor%ISOPEN THEN
            CLOSE get_supervisor;
         END IF;
         IF get_contract%ISOPEN THEN
            CLOSE get_contract;
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
   General_SYS.Init_Method(lu_name_, 'SALES_SUM_SALESMAN_RPI', 'Test');
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

END SALES_SUM_SALESMAN_RPI;