/*DROP TABLE MTK_INVENTORY_COUNT_CF_TAB;

CREATE TABLE MTK_INVENTORY_COUNT_CF_TAB
(
CONTRACT                           VARCHAR2(25)        NOT NULL,
COUNTER                            VARCHAR2(25)        NOT NULL,
PART_NO                            VARCHAR2(25)        NOT NULL,
LOT_VALUE                          VARCHAR2(100)       NULL,
TAG                                NUMBER       NULL,
QUANTITY                           NUMBER              NULL,
);

DELETE FROM MTK_INVENTORY_COUNT_CF_TAB;

alter session set NLS_NUMERIC_CHARACTERS = '.,';

SELECT 'INSERT INTO MTK_INVENTORY_COUNT_CF_TAB (CONTRACT,COUNTER,PART_NO,LOT_VALUE,TAG,QUANTITY) VALUES (''' 
		+ [Contract]
		+ ''',''' + [Counter]
		+ ''',''' + [Part No]
		+ ''',''' + [Lot No] 
		+ ''',''' + ISNULL([Tag], '') 
		+ ''',''' + ISNULL([Quantity], '')   
		+  ''');'   aa
FROM ( SELECT [Contract]
      ,upper([Counter]) [Counter]
      ,[Part No]      
      ,[Lot No]      
      ,CAST([Tag] AS VARCHAR) [Tag]
      ,CAST([Quantity] AS VARCHAR) [Quantity]
  FROM [IFSDEV-ManualUpload].[dbo].[InventCountData$]) aaa
*/

---- Add SCREEN lines
DECLARE   
   CURSOR get_count_sheet IS
      SELECT 
         CPT.CONTRACT,
         COUNTER,
         CPT.PART_NO,
         LOT_VALUE,
         TAG,
         QUANTITY,
         NVL(INVENTORY_PART_PLANNER_cfp.Get_Cf$_Count_Lot_Track(INVENTORY_PART_PLANNER_cfp.Get_Objkey(Inventory_Part_API.Get_Planner_Buyer(CPT.CONTRACT, CPT.PART_NO))), 'CLT1') ChangeWdr
      FROM MTK_INVENTORY_COUNT_CF_TAB CPT
      INNER JOIN INVENTORY_PART a ON a.CONTRACT = CPT.CONTRACT AND a.PART_NO = CPT.PART_NO; 
   
   CURSOR get_clt1(CountReportId_ VARCHAR2, PartNo_ VARCHAR2, LotValue_ VARCHAR2) IS
      SELECT waiv_dev_rej_no sWDR, 
             seq sSeq
      FROM COUNTING_REPORT_LINE 
      WHERE INV_LIST_NO = CountReportId_
      AND part_no = PartNo_
      AND UPPER(lot_batch_no) = UPPER(LotValue_); 
   
   CURSOR get_clt2(CountReportId_ VARCHAR2, PartNo_ VARCHAR2, LotValue_ VARCHAR2) IS
      SELECT min(lot_batch_no) sLotBatchNo, 
             min(seq) sSeq
      FROM COUNTING_REPORT_LINE 
      WHERE INV_LIST_NO = CountReportId_
      AND part_no = PartNo_
      AND UPPER(waiv_dev_rej_no) = UPPER(LotValue_) 
      AND ROWNUM < 2; 
   
   CURSOR get_clt3(CountReportId_ VARCHAR2, PartNo_ VARCHAR2, LotValue_ VARCHAR2) IS
      SELECT min(waiv_dev_rej_no) sWDR, 
             min(seq) sSeq
      FROM COUNTING_REPORT_LINE 
      WHERE INV_LIST_NO = CountReportId_
      AND part_no = PartNo_
      AND INSTR(UPPER(lot_batch_no), UPPER(LotValue_), 1)<>0 
      AND ROWNUM < 2; 
   
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
   
   CountId_             VARCHAR2(200);
   CountReportId_       VARCHAR2(200);
   New_                 VARCHAR2(200);
   WDR_                 VARCHAR2(200);
   Seq_                 NUMBER;
   LotBatchNo_          VARCHAR2(200);   
   CountSheetId_        NUMBER;
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   CountId_       := 'CM-6';   
   CountReportId_ := '22';
   
   CountSheetId_   := 0;   
   FOR row_ IN get_count_sheet LOOP
      
      New_        := 'True';
      WDR_        := '';
      LotBatchNo_ := '';
      Seq_        := 0;
      
      CountSheetId_ := CountSheetId_ + 1;
      
      IF(row_.ChangeWdr = 'CLT2') THEN
         OPEN get_clt2(CountReportId_ , row_.PART_NO , row_.LOT_VALUE);
         FETCH get_clt2 INTO LotBatchNo_, Seq_;
         CLOSE get_clt2;
         
         IF(LotBatchNo_ IS NOT NULL) THEN
            New_ := 'False';
		 ELSE
		    LotBatchNo_ := row_.LOT_VALUE;
         END IF;
         WDR_ := row_.LOT_VALUE;
		 
		 IF( LotBatchNo_ <> row_.LOT_VALUE) THEN
			LotBatchNo_ := row_.LOT_VALUE;
		 END IF;
         
      ELSIF (row_.ChangeWdr = 'CLT3') THEN
         OPEN get_clt3(CountReportId_, row_.PART_NO, row_.LOT_VALUE);
         FETCH get_clt3 INTO WDR_, Seq_;
         CLOSE get_clt3;
         
         IF(WDR_ IS NOT NULL) THEN
            New_ := 'False';
		 ELSE
		    WDR_ := '*';
         END IF;
         
         LotBatchNo_ := row_.LOT_VALUE;  
      ELSE
         OPEN get_clt1(CountReportId_ , row_.PART_NO , row_.LOT_VALUE);
         FETCH get_clt1 INTO WDR_, Seq_;
         CLOSE get_clt1;
         
         IF(WDR_ IS NOT NULL) THEN
            New_ := 'False';
		 ELSE
		    WDR_ := '*';
         END IF;
         LotBatchNo_ := row_.LOT_VALUE; 
      END IF;
      
      Client_SYS.Clear_Attr(attr_);      
      Client_SYS.Add_To_Attr('CF$_CONTRACT', row_.Contract, attr_);
      Client_SYS.Add_To_Attr('CF$_COUNT_ID', CountId_, attr_);
      Client_SYS.Add_To_Attr('CF$_COUNT_SHEET_ID', CountSheetId_, attr_);      
      Client_SYS.Add_To_Attr('CF$_PERSON_ID', row_.Counter, attr_);
      
      Client_SYS.Add_To_Attr('CF$_SEQ', Seq_, attr_);      
      Client_SYS.Add_To_Attr('CF$_NEW_PART', New_, attr_);      
      Client_SYS.Add_To_Attr('CF$_LOT_BATCH_NO', LotBatchNo_, attr_);      
      Client_SYS.Add_To_Attr('CF$_WDR', WDR_, attr_);  
      
      Client_SYS.Add_To_Attr('CF$_LOT_VALUE', row_.LOT_VALUE, attr_);
      Client_SYS.Add_To_Attr('CF$_PART_NO', row_.PART_NO, attr_);
      Client_SYS.Add_To_Attr('CF$_QUANTITY', row_.QUANTITY, attr_);
      Client_SYS.Add_To_Attr('CF$_TAG', row_.TAG, attr_);
	  
      Client_SYS.Add_To_Attr('CF$_CONFIRMED', 'True', attr_);
      
      INVENT_COUNT_SHEET_CLP.New__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;
