SELECT PART_NO
      ,CONTRACT
      ,DESCRIPTION
      ,DATE_CRE
      ,DEFAULT_BUY_UNIT_MEAS
      ,STANDARD_PACK_SIZE
      ,BUYER_CODE
      ,technical_coordinator_id TECHNICAL_COORDINATOR
      ,STAT_GRP
      ,CLOSE_TOLERANCE
      ,OVER_DELIVERY_TOLERANCE
      ,TAXABLE_DB
      ,'*' MTK_MODE
      ,QC_CODE
      ,NOTE_TEXT
      ,QC_DATE
FROM PURCHASE_PART
WHERE CONTRACT = '41POL'


