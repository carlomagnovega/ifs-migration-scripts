/**
UPDATE [dbo].[AnalysisResults$]
   SET [LBAL] = NULL
WHERE [LBAL] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBPB] = NULL
WHERE [LBPB] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBCU] = NULL
WHERE [LBCU] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBAG] = NULL
WHERE [LBAG] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBBI] = NULL
WHERE [LBBI] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBIN] = NULL
WHERE [LBIN] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBNI] = NULL
WHERE [LBNI] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBS] = NULL
WHERE [LBS] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBTI] = NULL
WHERE [LBTI] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBCO] = NULL
WHERE [LBCO] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBSN] = NULL
WHERE [LBSN] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBSB] = NULL
WHERE [LBSB] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBAU] = NULL
WHERE [LBAU] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBAS] = NULL
WHERE [LBAS] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBCD] = NULL
WHERE [LBCD] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBFE] = NULL
WHERE [LBFE] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBZN] = NULL
WHERE [LBZN] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBP] = NULL
WHERE [LBP] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBHG] = NULL
WHERE [LBHG] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBTE] = NULL
WHERE [LBTE] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBGE] = NULL
WHERE [LBGE] = 'BALANCE'
GO
UPDATE [dbo].[AnalysisResults$]
   SET [LBCR] = NULL
WHERE [LBCR] = 'BALANCE'
GO
*/

/*UPDATE [dbo].[AnalysisResults$]
   SET  [LBAL] = IIF(isnumeric([LBAL]) = 0 OR [LBAL] = '.', NULL, [LBAL]),
	    [LBPB] = IIF(isnumeric([LBPB]) = 0 OR [LBPB] = '.', NULL, [LBPB]),
	    [LBCU] = IIF(isnumeric([LBCU]) = 0 OR [LBCU] = '.', NULL, [LBCU]),
	    [LBAG] = IIF(isnumeric([LBAG]) = 0 OR [LBAG] = '.', NULL, [LBAG]),
	    [LBBI] = IIF(isnumeric([LBBI]) = 0 OR [LBBI] = '.', NULL, [LBBI]),
	    [LBIN] = IIF(isnumeric([LBIN]) = 0 OR [LBIN] = '.', NULL, [LBIN]),
	    [LBNI] = IIF(isnumeric([LBNI]) = 0 OR [LBNI] = '.', NULL, [LBNI]),
	    [LBS] = IIF(isnumeric([LBS]) = 0 OR [LBS] = '.', NULL, [LBS]),
	    [LBTI] = IIF(isnumeric([LBTI]) = 0 OR [LBTI] = '.', NULL, [LBTI]),
	    [LBCO] = IIF(isnumeric([LBCO]) = 0 OR [LBCO] = '.', NULL, [LBCO]),
	    [LBSN] = IIF(isnumeric([LBSN]) = 0 OR [LBSN] = '.', NULL, [LBSN]),
	    [LBSB] = IIF(isnumeric([LBSB]) = 0 OR [LBSB] = '.', NULL, [LBSB]),
	    [LBAU] = IIF(isnumeric([LBAU]) = 0 OR [LBAU] = '.', NULL, [LBAU]),
	    [LBAS] = IIF(isnumeric([LBAS]) = 0 OR [LBAS] = '.', NULL, [LBAS]),
	    [LBCD] = IIF(isnumeric([LBCD]) = 0 OR [LBCD] = '.', NULL, [LBCD]),
	    [LBFE] = IIF(isnumeric([LBFE]) = 0 OR [LBFE] = '.', NULL, [LBFE]),
	    [LBZN] = IIF(isnumeric([LBZN]) = 0 OR [LBZN] = '.', NULL, [LBZN]),
	    [LBP] = IIF(isnumeric([LBP]) = 0 OR [LBP] = '.', NULL, [LBP]),
	    [LBHG] = IIF(isnumeric([LBHG]) = 0 OR [LBHG] = '.', NULL, [LBHG]),
	    [LBTE] = IIF(isnumeric([LBTE]) = 0 OR [LBTE] = '.', NULL, [LBTE]),
	    [LBGE] = IIF(isnumeric([LBGE]) = 0 OR [LBGE] = '.', NULL, [LBGE]),
	    [LBCR] = IIF(isnumeric([LBCR]) = 0 OR [LBCR] = '.', NULL, [LBCR])
GO*/

/*UPDATE [dbo].[AnalysisResults$]
   SET  [LBAL] = IIF([LBAL] = 'BALANCE', NULL, [LBAL]),
	    [LBPB] = IIF([LBPB] = 'BALANCE', NULL, [LBPB]),
	    [LBCU] = IIF([LBCU] = 'BALANCE', NULL, [LBCU]),
	    [LBAG] = IIF([LBAG] = 'BALANCE', NULL, [LBAG]),
	    [LBBI] = IIF([LBBI] = 'BALANCE', NULL, [LBBI]),
	    [LBIN] = IIF([LBIN] = 'BALANCE', NULL, [LBIN]),
	    [LBNI] = IIF([LBNI] = 'BALANCE', NULL, [LBNI]),
	    [LBS] = IIF([LBS] = 'BALANCE', NULL, [LBS]),
	    [LBTI] = IIF([LBTI] = 'BALANCE', NULL, [LBTI]),
	    [LBCO] = IIF([LBCO] = 'BALANCE', NULL, [LBCO]),
	    [LBSN] = IIF([LBSN] = 'BALANCE', NULL, [LBSN]),
	    [LBSB] = IIF([LBSB] = 'BALANCE', NULL, [LBSB]),
	    [LBAU] = IIF([LBAU] = 'BALANCE', NULL, [LBAU]),
	    [LBAS] = IIF([LBAS] = 'BALANCE', NULL, [LBAS]),
	    [LBCD] = IIF([LBCD] = 'BALANCE', NULL, [LBCD]),
	    [LBFE] = IIF([LBFE] = 'BALANCE', NULL, [LBFE]),
	    [LBZN] = IIF([LBZN] = 'BALANCE', NULL, [LBZN]),
	    [LBP] = IIF([LBP] = 'BALANCE', NULL, [LBP]),
	    [LBHG] = IIF([LBHG] = 'BALANCE', NULL, [LBHG]),
	    [LBTE] = IIF([LBTE] = 'BALANCE', NULL, [LBTE]),
	    [LBGE] = IIF([LBGE] = 'BALANCE', NULL, [LBGE]),
	    [LBCR] = IIF([LBCR] = 'BALANCE', NULL, [LBCR])
		
/****** Script for SelectTopNRows command from SSMS  ******/
/*
UPDATE [AnalysisResults$]
SET LBAL = '0'
WHERE LBAL IS NOT NULL AND ISNUMERIC (LBAL) = 0
GO
UPDATE [AnalysisResults$]
SET LBPB = '0'
WHERE LBPB IS NOT NULL AND ISNUMERIC (LBPB) = 0
GO
UPDATE [AnalysisResults$]
SET LBCU = '0'
WHERE LBCU IS NOT NULL AND ISNUMERIC (LBCU) = 0
GO
UPDATE [AnalysisResults$]
SET LBAG = '0'
WHERE LBAG IS NOT NULL AND ISNUMERIC (LBAG) = 0
GO
UPDATE [AnalysisResults$]
SET LBBI = '0'
WHERE LBBI IS NOT NULL AND ISNUMERIC (LBBI) = 0
GO
UPDATE [AnalysisResults$]
SET LBIN = '0'
WHERE LBIN IS NOT NULL AND ISNUMERIC (LBIN) = 0
GO
UPDATE [AnalysisResults$]
SET LBNI = '0'
WHERE LBNI IS NOT NULL AND ISNUMERIC (LBNI) = 0
GO
UPDATE [AnalysisResults$]
SET LBS = '0'
WHERE LBS IS NOT NULL AND ISNUMERIC (LBS) = 0
GO
UPDATE [AnalysisResults$]
SET LBTI = '0'
WHERE LBTI IS NOT NULL AND ISNUMERIC (LBTI) = 0
GO
UPDATE [AnalysisResults$]
SET LBCO = '0'
WHERE LBCO IS NOT NULL AND ISNUMERIC (LBCO) = 0
GO
UPDATE [AnalysisResults$]
SET LBSN = '0'
WHERE LBSN IS NOT NULL AND ISNUMERIC (LBSN) = 0
GO
UPDATE [AnalysisResults$]
SET LBSB = '0'
WHERE LBSB IS NOT NULL AND ISNUMERIC (LBSB) = 0
GO
UPDATE [AnalysisResults$]
SET LBAU = '0'
WHERE LBAU IS NOT NULL AND ISNUMERIC (LBAU) = 0
GO
UPDATE [AnalysisResults$]
SET LBAS = '0'
WHERE LBAS IS NOT NULL AND ISNUMERIC (LBAS) = 0
GO
UPDATE [AnalysisResults$]
SET LBCD = '0'
WHERE LBCD IS NOT NULL AND ISNUMERIC (LBCD) = 0
GO
UPDATE [AnalysisResults$]
SET LBFE = '0'
WHERE LBFE IS NOT NULL AND ISNUMERIC (LBFE) = 0
GO
UPDATE [AnalysisResults$]
SET LBZN = '0'
WHERE LBZN IS NOT NULL AND ISNUMERIC (LBZN) = 0
GO
UPDATE [AnalysisResults$]
SET LBP = '0'
WHERE LBP IS NOT NULL AND ISNUMERIC (LBP) = 0
GO
UPDATE [AnalysisResults$]
SET LBHG = '0'
WHERE LBHG IS NOT NULL AND ISNUMERIC (LBHG) = 0
GO
UPDATE [AnalysisResults$]
SET LBTE = '0'
WHERE LBTE IS NOT NULL AND ISNUMERIC (LBTE) = 0
GO
UPDATE [AnalysisResults$]
SET LBGE = '0'
WHERE LBGE IS NOT NULL AND ISNUMERIC (LBGE) = 0
GO
UPDATE [AnalysisResults$]
SET LBCR = '0'
WHERE LBCR IS NOT NULL AND ISNUMERIC (LBCR) = 0
GO

	

UPDATE [dbo].[AnalysisResults$]
   SET 
       [LBAL] = CAST(ISNULL([LBAL], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBPB] = CAST(ISNULL([LBPB], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBCU] = CAST(ISNULL([LBCU], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBAG] = CAST(ISNULL([LBAG], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBBI] = CAST(ISNULL([LBBI], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBIN] = CAST(ISNULL([LBIN], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBNI] = CAST(ISNULL([LBNI], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBS] = CAST(ISNULL([LBS], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBTI] = CAST(ISNULL([LBTI], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBCO] = CAST(ISNULL([LBCO], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBSN] = CAST(ISNULL([LBSN], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBSB] = CAST(ISNULL([LBSB], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBAU] = CAST(ISNULL([LBAU], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBAS] = CAST(ISNULL([LBAS], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBCD] = CAST(ISNULL([LBCD], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBFE] = CAST(ISNULL([LBFE], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBZN] = CAST(ISNULL([LBZN], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBP] = CAST(ISNULL([LBP], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBHG] = CAST(ISNULL([LBHG], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBTE] = CAST(ISNULL([LBTE], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBGE] = CAST(ISNULL([LBGE], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
      ,[LBCR] = CAST(ISNULL([LBCR], 100.0 - (CAST(ISNULL([LBS],0 ) as float) + CAST(ISNULL([LBTI],0 ) as float) + CAST(ISNULL([LBCO],0 ) as float) + CAST(ISNULL([LBAU],0 ) as float) + CAST(ISNULL([LBP],0 ) as float) + CAST(ISNULL([LBHG],0 ) as float) + CAST(ISNULL([LBTE],0 ) as float) + CAST(ISNULL([LBGE],0 ) as float) + CAST(ISNULL([LBCR],0 ) as float) + CAST(ISNULL([LBAL],0 ) as float) + CAST(ISNULL([LBPB],0 ) as float) + CAST(ISNULL([LBCU],0 ) as float) + CAST(ISNULL([LBAG],0 ) as float) + CAST(ISNULL([LBBI],0 ) as float) + CAST(ISNULL([LBIN],0 ) as float) + CAST(ISNULL([LBNI],0 ) as float) + CAST(ISNULL([LBSN],0 ) as float) + CAST(ISNULL([LBSB],0 ) as float) + CAST(ISNULL([LBAS],0 ) as float) + CAST(ISNULL([LBCD],0 ) as float) + CAST(ISNULL([LBFE],0 ) as float) + CAST(ISNULL([LBZN],0) as float))) as float)
GO
*/


---ORACLE
DROP TABLE MTK_ANALYSIS_RESULT_CF_TAB;

CREATE TABLE MTK_ANALYSIS_RESULT_CF_TAB
(
   PART_NO                VARCHAR2(25)        NOT NULL,
   CONTRACT               VARCHAR2(5)         NOT NULL,   
   LOT_BATCH_NO           VARCHAR2(25)        NOT NULL,
   CF$_AL                 NUMBER              NULL,
   CF$_PB                 NUMBER              NULL,
   CF$_CU                 NUMBER              NULL,
   CF$_AG                 NUMBER              NULL,
   CF$_BI                 NUMBER              NULL,
   CF$_IN                 NUMBER              NULL,
   CF$_NI                 NUMBER              NULL,
   CF$_S                  NUMBER              NULL,
   CF$_TI                 NUMBER              NULL,
   CF$_CO                 NUMBER              NULL,
   CF$_SN                 NUMBER              NULL,
   CF$_SB                 NUMBER              NULL,
   CF$_AU                 NUMBER              NULL,
   CF$_AS                 NUMBER              NULL,
   CF$_CD                 NUMBER              NULL,
   CF$_FE                 NUMBER              NULL,
   CF$_ZN                 NUMBER              NULL,
   CF$_P                  NUMBER              NULL,
   CF$_HG                 NUMBER              NULL,
   CF$_TE                 NUMBER              NULL,
   CF$_GE                 NUMBER              NULL,
   CF$_C                  NUMBER              NULL,
   CF$_CR                 NUMBER              NULL,
   CF$_TA                 NUMBER              NULL,   
   CF$_AL_V                 VARCHAR2(5)         NULL,
   CF$_PB_V                 VARCHAR2(5)              NULL,
   CF$_CU_V                 VARCHAR2(5)              NULL,
   CF$_AG_V                 VARCHAR2(5)              NULL,
   CF$_BI_V                 VARCHAR2(5)              NULL,
   CF$_IN_V                 VARCHAR2(5)              NULL,
   CF$_NI_V                 VARCHAR2(5)              NULL,
   CF$_S_V                  VARCHAR2(5)              NULL,
   CF$_TI_V                 VARCHAR2(5)              NULL,
   CF$_CO_V                 VARCHAR2(5)              NULL,
   CF$_SN_V                 VARCHAR2(5)              NULL,
   CF$_SB_V                 VARCHAR2(5)              NULL,
   CF$_AU_V                 VARCHAR2(5)              NULL,
   CF$_AS_V                 VARCHAR2(5)              NULL,
   CF$_CD_V                 VARCHAR2(5)              NULL,
   CF$_FE_V                 VARCHAR2(5)              NULL,
   CF$_ZN_V                 VARCHAR2(5)              NULL,
   CF$_P_V                  VARCHAR2(5)              NULL,
   CF$_HG_V                 VARCHAR2(5)              NULL,
   CF$_TE_V                 VARCHAR2(5)              NULL,
   CF$_GE_V                 VARCHAR2(5)              NULL,
   CF$_C_V                  VARCHAR2(5)              NULL,
   CF$_CR_V                 VARCHAR2(5)              NULL,
   CF$_TA_V                 VARCHAR2(5)              NULL
);

---Generate Inserts SQLSERVER
/*
SELECT 'INSERT INTO MTK_ANALYSIS_RESULT_CF_TAB (PART_NO,CONTRACT,LOT_BATCH_NO,CF$_AL,CF$_PB,CF$_CU,CF$_AG,CF$_BI,CF$_IN,CF$_NI,CF$_S,CF$_TI,CF$_CO,CF$_SN,CF$_SB,CF$_AU,CF$_AS,CF$_CD,CF$_FE,CF$_ZN,CF$_P,CF$_HG,CF$_TE,CF$_GE,CF$_C,CF$_CR,CF$_TA,CF$_AL_V,CF$_PB_V,CF$_CU_V,CF$_AG_V,CF$_BI_V,CF$_IN_V,CF$_NI_V,CF$_S_V,CF$_TI_V,CF$_CO_V,CF$_SN_V,CF$_SB_V,CF$_AU_V,CF$_AS_V,CF$_CD_V,CF$_FE_V,CF$_ZN_V,CF$_P_V,CF$_HG_V,CF$_TE_V,CF$_GE_V,CF$_C_V,CF$_CR_V,CF$_TA_V) VALUES (''' 
+ ISNULL( [PART_NO], '') 
+ ''',''' + CONTRACT 
+ ''',''' + LOT_BATCH_NO 
+ ''',''' + ISNULL( cast( LBAL as varchar), '')
+ ''',''' + ISNULL( cast(LBPB as varchar), '')
+ ''',''' + ISNULL( cast(LBCU as varchar), '')
+ ''',''' + ISNULL( cast(LBAG as varchar), '')
+ ''',''' + ISNULL( cast(LBBI as varchar), '')
+ ''',''' + ISNULL( cast(LBIN as varchar), '')
+ ''',''' + ISNULL( cast(LBNI as varchar), '')
+ ''',''' + ISNULL( cast(LBS as varchar), '')
+ ''',''' + ISNULL( cast(LBTI as varchar), '')
+ ''',''' + ISNULL( cast(LBCO as varchar), '')
+ ''',''' + ISNULL( cast(LBSN as varchar), '')
+ ''',''' + ISNULL( cast(LBSB as varchar), '')
+ ''',''' + ISNULL( cast(LBAU as varchar), '')
+ ''',''' + ISNULL( cast(LBAS as varchar), '')
+ ''',''' + ISNULL( cast(LBCD as varchar), '')
+ ''',''' + ISNULL( cast(LBFE as varchar), '')
+ ''',''' + ISNULL( cast(LBZN as varchar), '')
+ ''',''' + ISNULL( cast(LBP as varchar), '')
+ ''',''' + ISNULL( cast(LBHG as varchar), '')
+ ''',''' + ISNULL( cast(LBTE as varchar), '')
+ ''',''' + ISNULL( cast(LBGE as varchar), '')
+ ''',''' + ISNULL( cast(an_C as varchar), '')
+ ''',''' + ISNULL( cast(LBCR as varchar), '')
+ ''',''' + ISNULL( cast(an_TA as varchar), '')

+ ''',''' + ISNULL( cast(LBALS as varchar), '')
+ ''',''' + ISNULL( cast(LBPBS as varchar), '')
+ ''',''' + ISNULL( cast(LBCUS as varchar), '')
+ ''',''' + ISNULL( cast(LBAGS as varchar), '')
+ ''',''' + ISNULL( cast(LBBIS as varchar), '')
+ ''',''' + ISNULL( cast(LBINS as varchar), '')
+ ''',''' + ISNULL( cast(LBNIS as varchar), '')
+ ''',''' + ISNULL( cast(LBSS as varchar), '')
+ ''',''' + ISNULL( cast(LBTIS as varchar), '')
+ ''',''' + ISNULL( cast(LBCOS as varchar), '')
+ ''',''' + ISNULL( cast(LBSNS as varchar), '')
+ ''',''' + ISNULL( cast(LBSBS as varchar), '')
+ ''',''' + ISNULL( cast(LBAUS as varchar), '')
+ ''',''' + ISNULL( cast(LBASS as varchar), '')
+ ''',''' + ISNULL( cast(LBCDS as varchar), '')
+ ''',''' + ISNULL( cast(LBFES as varchar), '')
+ ''',''' + ISNULL( cast(LBZNS as varchar), '')
+ ''',''' + ISNULL( cast(LBPS as varchar), '')
+ ''',''' + ISNULL( cast(LBHGS as varchar), '')
+ ''',''' + ISNULL( cast(LBTES as varchar), '')
+ ''',''' + ISNULL( cast(LBGES as varchar), '')
+ ''',''' + ISNULL( cast(an_CS as varchar), '')
+ ''',''' + ISNULL( cast(LBCRS as varchar), '')
+ ''',''' + ISNULL( cast(an_TaS as varchar), '')
+  ''');' aaa  
FROM ( SELECT  
       [PART_NO]
	  ,[CONTRACT]
	  ,LOT_BATCH_NO
      ,[LBAL]     
	  ,[LBPB]
      ,[LBCU] 
      ,[LBAG] 
      ,[LBBI] 
      ,[LBIN] 
      ,[LBNI] 
      ,[LBS]  
      ,[LBTI] 
      ,[LBCO] 
      ,[LBSN] 
      ,[LBSB] 
      ,[LBAU] 
      ,[LBAS] 
      ,[LBCD] 
      ,[LBFE]
      ,[LBZN] 
      ,[LBP]  
      ,[LBHG] 
      ,[LBTE] 
      ,[LBGE]
      ,'' [an_C]  
      ,[LBCR] 
      ,'' [an_Ta] 

	  ,[LBALS]     
	  ,[LBPBS]
      ,[LBCUS] 
      ,[LBAGS] 
      ,[LBBIS] 
      ,[LBINS] 
      ,[LBNIS] 
      ,[LBSS]  
      ,[LBTIS] 
      ,[LBCOS] 
      ,[LBSNS] 
      ,[LBSBS] 
      ,[LBAUS] 
      ,[LBASS] 
      ,[LBCDS] 
      ,[LBFES]
      ,[LBZNS] 
      ,[LBPS]  
      ,[LBHGS] 
      ,[LBTES] 
      ,[LBGES]
      ,'' [an_CS]  
      ,[LBCRS] 
      ,'' [an_TaS] 
  FROM [On-Hand Balances$] plt 
  INNER JOIN [AnalysisResults$] art ON ltrim(rtrim(plt.LOT_BATCH_NO)) = ltrim(rtrim(art.LBLOT)) AND ltrim(rtrim(plt.[PART_NO])) = ltrim(rtrim(art.LBPRO))) aaa;
  */

USE [IFSDEV-ManualUpload]
GO

UPDATE [dbo].[AnalysisResultsMEX$]
   SET [Uso] = replace([Uso], ' ', '')
 
GO

------
SELECT 'INSERT INTO MTK_ANALYSIS_RESULT_CF_TAB (PART_NO,CONTRACT,LOT_BATCH_NO,CF$_AL,CF$_PB,CF$_CU,CF$_AG,CF$_BI,CF$_IN,CF$_NI,CF$_S,CF$_TI,CF$_CO,CF$_SN,CF$_SB,CF$_AU,CF$_AS,CF$_CD,CF$_FE,CF$_ZN,CF$_P,CF$_HG,CF$_TE,CF$_GE,CF$_C,CF$_CR,CF$_TA,CF$_AL_V,CF$_PB_V,CF$_CU_V,CF$_AG_V,CF$_BI_V,CF$_IN_V,CF$_NI_V,CF$_S_V,CF$_TI_V,CF$_CO_V,CF$_SN_V,CF$_SB_V,CF$_AU_V,CF$_AS_V,CF$_CD_V,CF$_FE_V,CF$_ZN_V,CF$_P_V,CF$_HG_V,CF$_TE_V,CF$_GE_V,CF$_C_V,CF$_CR_V,CF$_TA_V) VALUES (''' 
+ ISNULL( [PART_NO], '') 
+ ''',''' + CONTRACT 
+ ''',''' + LOT_BATCH_NO 
+ ''',''' + ISNULL( cast( LBAL as varchar), '')
+ ''',''' + ISNULL( cast(LBPB as varchar), '')
+ ''',''' + ISNULL( cast(LBCU as varchar), '')
+ ''',''' + ISNULL( cast(LBAG as varchar), '')
+ ''',''' + ISNULL( cast(LBBI as varchar), '')
+ ''',''' + ISNULL( cast(LBIN as varchar), '')
+ ''',''' + ISNULL( cast(LBNI as varchar), '')
+ ''',''' + ISNULL( cast(LBS as varchar), '')
+ ''',''' + ISNULL( cast(LBTI as varchar), '')
+ ''',''' + ISNULL( cast(LBCO as varchar), '')
+ ''',''' + ISNULL( cast(LBSN as varchar), '')
+ ''',''' + ISNULL( cast(LBSB as varchar), '')
+ ''',''' + ISNULL( cast(LBAU as varchar), '')
+ ''',''' + ISNULL( cast(LBAS as varchar), '')
+ ''',''' + ISNULL( cast(LBCD as varchar), '')
+ ''',''' + ISNULL( cast(LBFE as varchar), '')
+ ''',''' + ISNULL( cast(LBZN as varchar), '')
+ ''',''' + ISNULL( cast(LBP as varchar), '')
+ ''',''' + ISNULL( cast(LBHG as varchar), '')
+ ''',''' + ISNULL( cast(LBTE as varchar), '')
+ ''',''' + ISNULL( cast(LBGE as varchar), '')
+ ''',''' + ISNULL( cast(an_C as varchar), '')
+ ''',''' + ISNULL( cast(LBCR as varchar), '')
+ ''',''' + ISNULL( cast(an_TA as varchar), '')

+ ''',''' + ISNULL( cast(LBALS as varchar), '')
+ ''',''' + ISNULL( cast(LBPBS as varchar), '')
+ ''',''' + ISNULL( cast(LBCUS as varchar), '')
+ ''',''' + ISNULL( cast(LBAGS as varchar), '')
+ ''',''' + ISNULL( cast(LBBIS as varchar), '')
+ ''',''' + ISNULL( cast(LBINS as varchar), '')
+ ''',''' + ISNULL( cast(LBNIS as varchar), '')
+ ''',''' + ISNULL( cast(LBSS as varchar), '')
+ ''',''' + ISNULL( cast(LBTIS as varchar), '')
+ ''',''' + ISNULL( cast(LBCOS as varchar), '')
+ ''',''' + ISNULL( cast(LBSNS as varchar), '')
+ ''',''' + ISNULL( cast(LBSBS as varchar), '')
+ ''',''' + ISNULL( cast(LBAUS as varchar), '')
+ ''',''' + ISNULL( cast(LBASS as varchar), '')
+ ''',''' + ISNULL( cast(LBCDS as varchar), '')
+ ''',''' + ISNULL( cast(LBFES as varchar), '')
+ ''',''' + ISNULL( cast(LBZNS as varchar), '')
+ ''',''' + ISNULL( cast(LBPS as varchar), '')
+ ''',''' + ISNULL( cast(LBHGS as varchar), '')
+ ''',''' + ISNULL( cast(LBTES as varchar), '')
+ ''',''' + ISNULL( cast(LBGES as varchar), '')
+ ''',''' + ISNULL( cast(an_CS as varchar), '')
+ ''',''' + ISNULL( cast(LBCRS as varchar), '')
+ ''',''' + ISNULL( cast(an_TaS as varchar), '')
+  ''');' aaa  
FROM (SELECT  
       c.[IFS_PART_NO] [PART_NO]
	  ,'20MEX' [CONTRACT]
	  ,b.[LOT_BATCH_NO] LOT_BATCH_NO
      ,[AL] [LBAL]     
	  ,[PB] [LBPB]
      ,[CU] [LBCU] 
      ,[AG] [LBAG] 
      ,[BI] [LBBI] 
      ,[INd] [LBIN] 
      ,[NI] [LBNI] 
      ,ISNULL([S],0) [LBS]  
      ,'0' [LBTI] 
      ,'0' [LBCO] 
      ,ISNULL([SN],0) [LBSN] 
      ,ISNULL([SB],0) [LBSB] 
      ,ISNULL([AU],0) [LBAU] 
      ,ISNULL([ARS],0) [LBAS] 
      ,ISNULL([CD],0) [LBCD] 
      ,ISNULL([FE],0) [LBFE]
      ,ISNULL([ZN],0) [LBZN] 
      ,ISNULL([P],0) [LBP]  
      ,'0' [LBHG] 
      ,'0' [LBTE] 
      ,ISNULL([GE],0) [LBGE]
      ,'0' [an_C]  
      ,'0' [LBCR] 
      ,'0' [an_Ta] 

	  ,'' [LBALS]     
	  ,'' [LBPBS]
      ,'' [LBCUS] 
      ,'' [LBAGS] 
      ,'' [LBBIS] 
      ,'' [LBINS] 
      ,'' [LBNIS] 
      ,'' [LBSS]  
      ,'' [LBTIS] 
      ,'' [LBCOS] 
      ,'' [LBSNS] 
      ,'' [LBSBS] 
      ,'' [LBAUS] 
      ,'' [LBASS] 
      ,'' [LBCDS] 
      ,'' [LBFES]
      ,'' [LBZNS] 
      ,'' [LBPS]  
      ,'' [LBHGS] 
      ,'' [LBTES] 
      ,'' [LBGES]
      ,'' [an_CS]  
      ,'' [LBCRS] 
      ,'' [an_TaS] 
  FROM [AnalysisResultsMEX$] a
  INNER JOIN [dbo].[AnalysisTranslation$] c ON a.[Codigo] = c.[AS400_PART_NO]
  INNER JOIN [OnHandQuantityMEX$] b ON b.[IFS_PART_NO] = c.[IFS_PART_NO] AND b.[LOT_BATCH_NO] like  '%' + a.USO
  ) aaa;

-----ORACLE

--Allow insert float values
alter session set NLS_NUMERIC_CHARACTERS = '.,';

---Delete invalid records  
DELETE FROM MTK_ANALYSIS_RESULT_CF_TAB T1
WHERE EXISTS (SELECT *
               FROM MTK_ANALYSIS_RESULT_CF_TAB ART
               LEFT JOIN MTK_ONHAND_QUANTITY_TAB OQT ON ART.PART_NO = OQT.PART_NO AND ART.CONTRACT = OQT.CONTRACT AND ART.LOT_BATCH_NO = OQT.LOT_BATCH_NO
               WHERE OQT.PART_NO IS NULL
               AND ART.PART_NO = T1.PART_NO
               AND ART.CONTRACT = T1.CONTRACT 
               AND ART.LOT_BATCH_NO = T1.LOT_BATCH_NO)

----Generate Analysis Request
BEGIN
	ANL_REQ_AIM_API.Generate_Inventory_Analysis;
END;