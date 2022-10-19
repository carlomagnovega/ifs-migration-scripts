---DELETE
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcp.objid,
              qcp.objversion
      FROM MTK_CUST_INFO_COMM_METHOD_TAB qcpa
      INNER JOIN COMM_METHOD qcp ON qcp.ADDRESS_ID  = qcpa.ADDRESS_ID 
      AND qcp.IDENTITY  = qcpa.CUSTOMER_ID
      GROUP BY qcp.objid, qcp.objversion;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      
      COMM_METHOD_API.REMOVE__(info_, objid_, objversion_, 'DO');
      COMMIT;
   END LOOP;
   
END;
-----------------------------------

SET NOCOUNT ON;    
DECLARE @CUSTOMER_ID VARCHAR(80)
		,@CUSTOMER_ID_AUX VARCHAR(80)
		,@VALUE VARCHAR(80)
		,@COMM_ID INT
		,@DESCRIPTION VARCHAR(80)
		,@VALID_FROM VARCHAR(80)
		,@VALID_TO VARCHAR(80)
		,@METHOD_DEFAULT VARCHAR(80)
		,@ADDRESS_DEFAULT VARCHAR(80)
		,@METHOD_ID VARCHAR(80)
		,@ADDRESS_ID VARCHAR(80)
		,@NAME VARCHAR(80);

DECLARE vendor_cursor CURSOR FOR   
SELECT  [CUSTOMER_ID]
		,[VALUE]
		,[DESCRIPTION]
		,[VALID_FROM]
		,[VALID_TO]
		,[METHOD_DEFAULT]
		,[ADDRESS_DEFAULT]
		,[METHOD_ID]
		,[ADDRESS_ID]
		,[NAME]      
  FROM [IFSDEV-ManualUpload].[dbo].[CustomerInfoCommMethodPOL$]  
  WHERE [CUSTOMER_ID] IS NOT NULL AND [VALUE] IS NOT NULL
  ORDER BY [CUSTOMER_ID], [METHOD_ID], [METHOD_DEFAULT] DESC;
	
truncate table [dbo].[CustInfoCommMethod$];

OPEN vendor_cursor    
FETCH NEXT FROM vendor_cursor   
INTO  @CUSTOMER_ID,@VALUE,@DESCRIPTION,@VALID_FROM,@VALID_TO,@METHOD_DEFAULT,@ADDRESS_DEFAULT,@METHOD_ID,@ADDRESS_ID,@NAME;
  
SET @COMM_ID = 0;
SET @CUSTOMER_ID_AUX = '';
WHILE @@FETCH_STATUS = 0  
BEGIN  
	IF (@CUSTOMER_ID <> @CUSTOMER_ID_AUX) 
		BEGIN
			SET @COMM_ID = 0;
			SET @METHOD_DEFAULT = '1';
			SET @ADDRESS_DEFAULT = '1';
		END
	ELSE
		BEGIN
			SET @METHOD_DEFAULT = '0';
			SET @ADDRESS_DEFAULT = '0';
		END
	SET @COMM_ID = @COMM_ID + 1;
	SET @CUSTOMER_ID_AUX = @CUSTOMER_ID;

    INSERT INTO [dbo].[CustInfoCommMethod$]
           ([CUSTOMER_ID]
		  ,[COMM_ID]
		  ,[VALUE]
		  ,[DESCRIPTION]
		  ,[VALID_FROM]
		  ,[VALID_TO]
		  ,[METHOD_DEFAULT]
		  ,[ADDRESS_DEFAULT]
		  ,[METHOD_ID]
		  ,[ADDRESS_ID]
		  ,[NAME])
	VALUES (@CUSTOMER_ID,@COMM_ID,@VALUE,@DESCRIPTION,@VALID_FROM,@VALID_TO,@METHOD_DEFAULT,@ADDRESS_DEFAULT,@METHOD_ID,@ADDRESS_ID,@NAME);
    
        -- Get the next vendor.  
    FETCH NEXT FROM vendor_cursor   
    INTO @CUSTOMER_ID,@VALUE,@DESCRIPTION,@VALID_FROM,@VALID_TO,@METHOD_DEFAULT,@ADDRESS_DEFAULT,@METHOD_ID,@ADDRESS_ID,@NAME;  
END   
CLOSE vendor_cursor;  
DEALLOCATE vendor_cursor; 
GO
