DECLARE
   contract_       VARCHAR2(200);
   part_no_        VARCHAR2(200);
   workcenter_old_ VARCHAR2(200);
   workcenter_new_ VARCHAR2(200);
   
BEGIN
   contract_       := '10MTL';
   part_no_        := '4237-POP';
   workcenter_old_ := '115';
   workcenter_new_ := '108';
   
   --UPDATE  Analysis_Type_Operation_Tab  
   INSERT INTO ANALYSIS_TYPE_OPERATION_TAB (ANALYSIS_TYPE, TEST_OPERATION_NO, DESCRIPTION, QTY_TO_CONTROL, NOTE_TEXT, NOTE_ID, SAMPLE_PERCENTAGE, ROWVERSION, ROWKEY) 
   SELECT   workcenter_new_||'.'||b.control_plan_no||'.'||to_char(b.ctrl_plan_revision_no),
            a.TEST_OPERATION_NO,
            a.DESCRIPTION,
            a.QTY_TO_CONTROL,
            a.NOTE_TEXT,
            a.NOTE_ID,
            a.SAMPLE_PERCENTAGE,
            a.ROWVERSION,
            a.ROWKEY
   FROM Analysis_Type_Operation_Tab A
   INNER JOIN Qman_Control_Plan_Line_Tab B ON a.analysis_type = b.analysis_type AND a.test_operation_no = b.data_point*10
   INNER JOIN Qman_Control_Plan_Tab d ON d.CONTROL_PLAN_NO = b.CONTROL_PLAN_NO and d.CTRL_PLAN_REVISION_NO = b.CTRL_PLAN_REVISION_NO
   WHERE d.CONTRACT = contract_
   AND d.PART_NO = part_no_
   AND d.ROUTING_ALTERNATIVE_NO = '*'
   AND b.work_center_no = workcenter_old_;
   
   DELETE FROM Analysis_Type_Operation_Tab a
   WHERE EXISTS (SELECT 1 
      FROM Qman_Control_Plan_Line_Tab b 
      INNER JOIN Qman_Control_Plan_Tab d ON d.CONTROL_PLAN_NO = b.CONTROL_PLAN_NO and d.CTRL_PLAN_REVISION_NO = b.CTRL_PLAN_REVISION_NO
      WHERE a.analysis_type = b.analysis_type 
      AND a.test_operation_no = b.data_point*10
      AND d.CONTRACT = contract_
      AND d.PART_NO = part_no_
      AND d.ROUTING_ALTERNATIVE_NO = '*'
      AND b.work_center_no = workcenter_old_);
   
   --UPDATE  Analysis_Type_Norm_Tab 
   INSERT INTO ANALYSIS_TYPE_NORM_TAB (ANALYSIS_TYPE, DATA_POINT, NORM_TYPE, NORM_VALUE, OUTER_MIN, INNER_MIN, OUTER_MAX, INNER_MAX, NOTE_ID, NOTE_TEXT, "METHOD", TEST_OPERATION_NO, CONTROL_CHART_TYPE, ENG_DRAWING_REF, NUMBER_NORM_VALUE, NUMBER_OUTER_MIN, NUMBER_OUTER_MAX, NUMBER_INNER_MIN, NUMBER_INNER_MAX, ROWVERSION, ROWKEY) 
   SELECT   workcenter_new_||'.'||b.control_plan_no||'.'||to_char(b.ctrl_plan_revision_no),
            a.DATA_POINT, 
            a.NORM_TYPE, 
            a.NORM_VALUE, 
            a.OUTER_MIN, 
            a.INNER_MIN, 
            a.OUTER_MAX, 
            a.INNER_MAX, 
            a.NOTE_ID, 
            a.NOTE_TEXT, 
            "METHOD", 
            a.TEST_OPERATION_NO, 
            a.CONTROL_CHART_TYPE, 
            a.ENG_DRAWING_REF, 
            a.NUMBER_NORM_VALUE, 
            a.NUMBER_OUTER_MIN, 
            a.NUMBER_OUTER_MAX, 
            a.NUMBER_INNER_MIN, 
            a.NUMBER_INNER_MAX, 
            a.ROWVERSION, 
            a.ROWKEY
   FROM Analysis_Type_Norm_Tab A
   INNER JOIN Qman_Control_Plan_Line_Tab B ON a.analysis_type = b.analysis_type AND a.data_point = b.data_point
   INNER JOIN Qman_Control_Plan_Tab d ON d.CONTROL_PLAN_NO = b.CONTROL_PLAN_NO and d.CTRL_PLAN_REVISION_NO = b.CTRL_PLAN_REVISION_NO
   WHERE  d.CONTRACT = contract_
   AND d.PART_NO = part_no_
   AND d.ROUTING_ALTERNATIVE_NO = '*'
   AND b.work_center_no = workcenter_old_;
   
   DELETE FROM Analysis_Type_Norm_Tab a
   WHERE EXISTS (SELECT 1 
      FROM Qman_Control_Plan_Line_Tab b 
      INNER JOIN Qman_Control_Plan_Tab d ON d.CONTROL_PLAN_NO = b.CONTROL_PLAN_NO and d.CTRL_PLAN_REVISION_NO = b.CTRL_PLAN_REVISION_NO
      WHERE a.analysis_type = b.analysis_type 
      AND a.data_point = b.data_point
      AND d.CONTRACT = contract_
      AND d.PART_NO = part_no_
      AND d.ROUTING_ALTERNATIVE_NO = '*'
      AND b.work_center_no = workcenter_old_); 
   
   INSERT INTO ANALYSIS_TYPE_TAB (ANALYSIS_TYPE, DESCRIPTION, ANALYSIS_SOURCE, ROWVERSION) 
   SELECT   workcenter_new_||'.'||control_plan_no||'.'||to_char(ctrl_plan_revision_no),
            contract_||'.'||workcenter_new_||'.'||control_plan_no||'.'||to_char(ctrl_plan_revision_no),
            'CONTROLPLAN',
            SYSDATE
   FROM Qman_Control_Plan_Tab
   WHERE CONTRACT = contract_
   AND PART_NO = part_no_
   AND ROUTING_ALTERNATIVE_NO = '*';
   
   DELETE FROM Analysis_Type_Tab a
   WHERE EXISTS (SELECT 1 
      FROM Qman_Control_Plan_Line_Tab b 
      INNER JOIN Qman_Control_Plan_Tab d ON d.CONTROL_PLAN_NO = b.CONTROL_PLAN_NO and d.CTRL_PLAN_REVISION_NO = b.CTRL_PLAN_REVISION_NO
      WHERE a.analysis_type = b.analysis_type 
      AND d.CONTRACT = contract_
      AND d.PART_NO = part_no_
      AND d.ROUTING_ALTERNATIVE_NO = '*'
      AND b.work_center_no = workcenter_old_);
   
   --Update Qman_Control_Plan_Line_Tab
   UPDATE Qman_Control_Plan_Line_Tab qcpl 
   SET qcpl.work_center_no = workcenter_new_,
       qcpl.ANALYSIS_TYPE = (workcenter_new_||'.'||control_plan_no||'.'||to_char(ctrl_plan_revision_no))
   WHERE EXISTS (SELECT 1
              FROM QMAN_CONTROL_PLAN_MANUF qcpm 
              INNER JOIN ROUTING_OPERATION rot ON qcpm.PART_NO = rot.PART_NO AND qcpm.ROUTING_ALTERNATIVE_NO = rot.ALTERNATIVE_NO 
              WHERE 
			      rot.OPERATION_NO = qcpl.ROUTING_OPERATION_NO
               AND qcpm.control_plan_no = qcpl.control_plan_no
               AND qcpl.work_center_no = workcenter_old_
               AND rot.contract = contract_
               AND rot.PART_NO = part_no_
               AND rot.ALTERNATIVE_NO = '*');   
   
   UPDATE ROUTING_OPERATION_TAB
   SET WORK_CENTER_NO = workcenter_new_
   WHERE CONTRACT = contract_
   AND PART_NO = part_no_
   AND WORK_CENTER_NO = workcenter_old_
   AND ALTERNATIVE_NO = '*';
   
END;

