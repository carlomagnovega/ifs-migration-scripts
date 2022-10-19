--------------Receive Inventory Parts
DECLARE
  CURSOR get_qaman IS
    select contract,
           part_no,
           location_no,
           Configuration_Id,
           Lot_Batch_No,
           Serial_No,
           eng_chg_level,
           waiv_dev_rej_no,
           activity_seq,
           handling_unit_id
      from INVENTORY_PART_IN_STOCK_UIV
     where (QTY_ONHAND = 0 and CONTRACT = '10MTL' and PART_NO like 'SP-%');

  info_       VARCHAR2(32000);
  objid_      VARCHAR2(32000);
  objversion_ VARCHAR2(32000);
  attr_       VARCHAR2(26000);

  -- p0 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsContract
  p0_ VARCHAR2(32000);
  -- p1 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsPartNo
  p1_ VARCHAR2(32000);
  -- p2 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsConfigurationId
  p2_ VARCHAR2(32000);
  -- p3 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsLocationNo
  p3_ VARCHAR2(32000);
  -- p4 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsLotBatchNo
  p4_ VARCHAR2(32000);
  -- p5 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsSerialNo
  p5_ VARCHAR2(32000);
  -- p6 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsEngChgLevel
  p6_ VARCHAR2(32000);
  -- p7 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsWaivDevRejNo
  p7_ VARCHAR2(32000);
  -- p8 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colnHandlingUnitId
  p8_ FLOAT;
  -- p9 -> i_hWndFrame.frmInvReceipt.tblPartLoc_coldExpirationDate
  p9_ DATE := NULL;
  -- p10 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colnQtyReceived
  p10_ FLOAT := 1;
  -- p11 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colnQtyCatchReceived
  p11_ FLOAT := NULL;
  -- p12 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsAccountNo
  p12_ VARCHAR2(32000) := '';
  -- p13 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsCostCenter
  p13_ VARCHAR2(32000) := '';
  -- p14 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsCodeC
  p14_ VARCHAR2(32000) := '';
  -- p15 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsCodeD
  p15_ VARCHAR2(32000) := '';
  -- p16 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsObjectNo
  p16_ VARCHAR2(32000) := '';
  -- p17 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsProjectNo
  p17_ VARCHAR2(32000) := '';
  -- p18 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsCodeG
  p18_ VARCHAR2(32000) := '';
  -- p19 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsCodeH
  p19_ VARCHAR2(32000) := '';
  -- p20 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsCodeI
  p20_ VARCHAR2(32000) := '';
  -- p21 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsCodeJ
  p21_ VARCHAR2(32000) := '';
  -- p22 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsInvtranSource
  p22_ VARCHAR2(32000) := '';
  -- p23 -> i_hWndFrame.frmInvReceipt.nCostDetailId
  p23_ FLOAT;
  -- p24 -> i_hWndFrame.frmInvReceipt.tblPartLoc_colsPartOwnershipDb
  p24_ VARCHAR2(32000) := 'COMPANY OWNED';
  -- p25 -> g_Bind.s[0]
  p25_ VARCHAR2(32000) := 'FALSE';
  -- p5 -> i_hWndFrame.dlgDefineCostStructure.dfsConditionCode
  p26_ VARCHAR2(32000) := '';
  -- p7 -> i_hWndFrame.dlgDefineCostStructure.sCallingProcess
  p27_ VARCHAR2(32000) := 'DIRECT RECEIPT';
BEGIN

  FOR row_ IN get_qaman LOOP
    p0_  := row_.contract;
    p1_  := row_.part_no;
    p2_  := row_.Configuration_Id;
    p3_  := row_.location_no;
    p4_  := row_.Lot_Batch_No;
    p5_  := row_.Serial_No;
    p6_  := row_.eng_chg_level;
    p7_  := row_.waiv_dev_rej_no;
    p8_  := row_.handling_unit_id;
    p23_ := Temporary_Part_Cost_Detail_API.Get_Next_Cost_Detail_Id;
    Temporary_Part_Cost_Detail_API.Generate_Default_Details(p0_,
                                                            p1_,
                                                            p2_,
                                                            p4_,
                                                            p5_,
                                                            p26_,
                                                            p23_,
                                                            p27_);
  
    Inventory_Part_In_Stock_API.Receive_Part_With_Posting(p0_,
                                                          p1_,
                                                          p2_,
                                                          p3_,
                                                          p4_,
                                                          p5_,
                                                          p6_,
                                                          p7_,
                                                          0,
                                                          p8_,
                                                          'NREC',
                                                          p9_,
                                                          p10_,
                                                          0,
                                                          p11_,
                                                          p12_,
                                                          p13_,
                                                          p14_,
                                                          p15_,
                                                          p16_,
                                                          p17_,
                                                          p18_,
                                                          p19_,
                                                          p20_,
                                                          p21_,
                                                          p22_,
                                                          NULL,
                                                          p23_,
                                                          NULL,
                                                          p24_);
  END LOOP;
END;
