----Update ControlPlan	Def Location
DROP TABLE MTK_CONTROL_PL_TEMP_HEAD_TAB;
CREATE TABLE MTK_CONTROL_PL_TEMP_HEAD_TAB
(
   CF$_DESCRIPTION                    VARCHAR2(200)       NULL,
   CF$_SPEC_ID                        VARCHAR2(100)       NULL,
)


----------
SELECT 'INSERT INTO MTK_CONTROL_PL_TEMP_HEAD_TAB (CF$_SPEC_ID, CF$_DESCRIPTION) VALUES (''' 
		|| CF$_SPEC_ID
		|| ''',''' || NVL(CF$_DESCRIPTION, '')
		||  ''');'   aa
FROM ( SELECT CF$_SPEC_ID
			  ,CF$_DESCRIPTION
FROM CONTROL_PLAN_TEMPL_HEADER_CLT) aaa  

----------------------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT 
         IPT.CF$_SPEC_ID, 
         IPT.CF$_DESCRIPTION
      FROM MTK_CONTROL_PL_TEMP_HEAD_TAB IPT
      LEFT JOIN CONTROL_PLAN_TEMPL_HEADER_CLT CPT ON CPT.CF$_SPEC_ID = IPT.CF$_SPEC_ID
      WHERE CPT.CF$_SPEC_ID IS NULL;
      
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CF$_SPEC_ID', row_.CF$_SPEC_ID, attr_);
      Client_SYS.Add_To_Attr('CF$_DESCRIPTION', row_.CF$_DESCRIPTION, attr_);
      
      Control_Plan_Templ_Header_Clp.New__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

-------------------------------------------------
DROP TABLE MTK_CONTROL_PL_TEMP_TBL;
CREATE TABLE MTK_CONTROL_PL_TEMP_TBL
(
   CF$_DECIMALS                       NUMBER              NULL,
   CF$_INNER_MAX                      NUMBER              NULL,
   CF$_INNER_MIN                      NUMBER              NULL,
   CF$_INSPECTION_CODE                VARCHAR2(25)        NULL,
   CF$_INSPECTION_CODE_DESC           VARCHAR2(100)       NULL,
   CF$_NORM_VALUE                     NUMBER              NULL,
   CF$_OUTER_MAX                      NUMBER              NULL,
   CF$_OUTER_MIN                      NUMBER              NULL,
   CF$_PRINT                          VARCHAR2(5)         NULL,
   CF$_SAMPLE_PERCENT                 NUMBER              NULL,
   CF$_SPEC_ID                        VARCHAR2(100)       NULL,
   CF$_TEST_OPERATION_NO              NUMBER              NULL,
   CF$_UDB_BALANCE                    VARCHAR2(5)         NULL,
   CF$_CONTROL_PLAN_EXCEP             VARCHAR2(20)        NULL
)

SELECT 'INSERT INTO MTK_CONTROL_PL_TEMP_TBL (CF$_SPEC_ID,CF$_DECIMALS,CF$_INNER_MAX,CF$_INNER_MIN,CF$_INSPECTION_CODE,CF$_INSPECTION_CODE_DESC,CF$_NORM_VALUE,CF$_OUTER_MAX,CF$_OUTER_MIN,CF$_PRINT,CF$_SAMPLE_PERCENT,CF$_TEST_OPERATION_NO,CF$_UDB_BALANCE,CF$_CONTROL_PLAN_EXCEP) VALUES (''' 
		|| CF$_SPEC_ID
		|| ''',''' || NVL(CF$_DECIMALS, '')
		|| ''',''' || NVL(CF$_INNER_MAX, '')
		|| ''',''' || NVL(CF$_INNER_MIN, '')
		|| ''',''' || NVL(CF$_INSPECTION_CODE, '')
		|| ''',''' || NVL(CF$_INSPECTION_CODE_DESC, '')
		|| ''',''' || NVL(CF$_NORM_VALUE, '')
		|| ''',''' || NVL(CF$_OUTER_MAX, '')
		|| ''',''' || NVL(CF$_OUTER_MIN, '')
		|| ''',''' || NVL(CF$_PRINT, '')
		|| ''',''' || NVL(CF$_SAMPLE_PERCENT, '')
		|| ''',''' || NVL(CF$_TEST_OPERATION_NO, '')
		|| ''',''' || NVL(CF$_UDB_BALANCE, '')
		|| ''',''' || NVL(CF$_CONTROL_PLAN_EXCEP, '')
		||  ''');'   aa
FROM ( SELECT CF$_SPEC_ID,CF$_DECIMALS,CF$_INNER_MAX,CF$_INNER_MIN,CF$_INSPECTION_CODE,CF$_INSPECTION_CODE_DESC,CF$_NORM_VALUE,CF$_OUTER_MAX,CF$_OUTER_MIN,CF$_PRINT,CF$_SAMPLE_PERCENT,CF$_TEST_OPERATION_NO,CF$_UDB_BALANCE,CF$_CONTROL_PLAN_EXCEP
FROM CONTROL_PLAN_TEMPLATE_CLT) aaa 
---------------------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT IPT.CF$_SPEC_ID,
             IPT.CF$_DECIMALS,
             IPT.CF$_INNER_MAX,
             IPT.CF$_INNER_MIN,
             IPT.CF$_INSPECTION_CODE,
             IPT.CF$_INSPECTION_CODE_DESC,
             IPT.CF$_NORM_VALUE,
             IPT.CF$_OUTER_MAX,
             IPT.CF$_OUTER_MIN,
             IPT.CF$_PRINT,
             IPT.CF$_SAMPLE_PERCENT,
             IPT.CF$_TEST_OPERATION_NO,
             IPT.CF$_UDB_BALANCE,
             IPT.CF$_CONTROL_PLAN_EXCEP
      FROM MTK_CONTROL_PL_TEMP_TBL IPT
      LEFT JOIN control_plan_template_clt CPT ON CPT.CF$_SPEC_ID = IPT.CF$_SPEC_ID AND CPT.CF$_INSPECTION_CODE = IPT.CF$_INSPECTION_CODE
      WHERE CPT.CF$_INSPECTION_CODE IS NULL
      AND IPT.CF$_SPEC_ID IS NOT null; 

   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CF$_DECIMALS', row_.CF$_DECIMALS, attr_);
      Client_SYS.Add_To_Attr('CF$_INNER_MAX', row_.CF$_INNER_MAX, attr_);
      Client_SYS.Add_To_Attr('CF$_INNER_MIN', row_.CF$_INNER_MIN, attr_);
      Client_SYS.Add_To_Attr('CF$_INSPECTION_CODE', row_.CF$_INSPECTION_CODE, attr_);
      Client_SYS.Add_To_Attr('CF$_INSPECTION_CODE_DESC', row_.CF$_INSPECTION_CODE_DESC, attr_);
      Client_SYS.Add_To_Attr('CF$_NORM_VALUE', row_.CF$_NORM_VALUE, attr_);
      Client_SYS.Add_To_Attr('CF$_OUTER_MAX', row_.CF$_OUTER_MAX, attr_);
      Client_SYS.Add_To_Attr('CF$_OUTER_MIN', row_.CF$_OUTER_MIN, attr_);
      Client_SYS.Add_To_Attr('CF$_PRINT', row_.CF$_PRINT, attr_);
      Client_SYS.Add_To_Attr('CF$_SAMPLE_PERCENT', row_.CF$_SAMPLE_PERCENT, attr_);
      Client_SYS.Add_To_Attr('CF$_SPEC_ID', row_.CF$_SPEC_ID, attr_);
      Client_SYS.Add_To_Attr('CF$_TEST_OPERATION_NO', row_.CF$_TEST_OPERATION_NO, attr_);
      Client_SYS.Add_To_Attr('CF$_UDB_BALANCE', row_.CF$_UDB_BALANCE, attr_);
      Client_SYS.Add_To_Attr('CF$_CONTROL_PLAN_EXCEP', 'Powder', attr_);
      
      CONTROL_PLAN_TEMPLATE_CLP.New__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;   