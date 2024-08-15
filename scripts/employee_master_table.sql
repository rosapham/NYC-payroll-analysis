IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'CsvFormatWithHeader') 
	CREATE EXTERNAL FILE FORMAT [CsvFormatWithHeader] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 FIRST_ROW = 2,
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'adlsnycpayroll-rosa-p_adlsnycpayrollrosa_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [adlsnycpayroll-rosa-p_adlsnycpayrollrosa_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://adlsnycpayroll-rosa-p@adlsnycpayrollrosa.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.NYC_Payroll_EMP_MD (
	[EmployeeID] [varchar](10) NULL,
	[LastName] [varchar](20) NULL,
	[FirstName] [varchar](20) NULL
	)
	WITH (
	LOCATION = 'dirpayrollfiles/EmpMaster.csv',
	DATA_SOURCE = [adlsnycpayroll-rosa-p_adlsnycpayrollrosa_dfs_core_windows_net],
	FILE_FORMAT = [CsvFormatWithHeader]
	)
GO


SELECT TOP 100 * FROM dbo.NYC_Payroll_EMP_MD
GO