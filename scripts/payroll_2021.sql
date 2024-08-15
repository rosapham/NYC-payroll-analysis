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

CREATE EXTERNAL TABLE dbo.NYC_Payroll_Data_2021 (
	[FiscalYear] [int] NULL,
    [PayrollNumber] [int] NULL,
    [AgencyCode] [varchar](10) NULL,
    [AgencyName] [varchar](50) NULL,
    [EmployeeID] [varchar](10) NULL,
    [LastName] [varchar](20) NULL,
    [FirstName] [varchar](20) NULL,
    [AgencyStartDate] [date] NULL,
    [WorkLocationBorough] [varchar](50) NULL,
    [TitleCode] [varchar](10) NULL,
    [TitleDescription] [varchar](100) NULL,
    [LeaveStatusasofJune30] [varchar](50) NULL,
    [BaseSalary] [float] NULL,
    [PayBasis] [varchar](50) NULL,
    [RegularHours] [float] NULL,
    [RegularGrossPaid] [float] NULL,
    [OTHours] [float] NULL,
    [TotalOTPaid] [float] NULL,
    [TotalOtherPay] [float] NULL
	)
	WITH (
	LOCATION = 'dirpayrollfiles/nycpayroll_2021.csv',
	DATA_SOURCE = [adlsnycpayroll-rosa-p_adlsnycpayrollrosa_dfs_core_windows_net],
	FILE_FORMAT = [CsvFormatWithHeader]
	)
GO


SELECT TOP 100 * FROM dbo.NYC_Payroll_Data_2021
GO