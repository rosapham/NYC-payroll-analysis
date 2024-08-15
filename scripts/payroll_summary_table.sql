-- Use the same file format as used for creating the External Tables during the LOAD step.
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
FORMAT_OPTIONS (
FIELD_TERMINATOR = ',',
USE_TYPE_DEFAULT = FALSE
))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'adlsnycpayroll-rosa-p_adlsnycpayrollrosa_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [adlsnycpayroll-rosa-p_adlsnycpayrollrosa_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://adlsnycpayroll-rosa-p@adlsnycpayrollrosa.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE [dbo].[NYC_Payroll_Summary](
    [AgencyName] [varchar](50) NULL,
    [FiscalYear] [int] NULL,
    [TotalPaid] [float] NULL
)
WITH (
LOCATION = 'dirstaging',
DATA_SOURCE = [adlsnycpayroll-rosa-p_adlsnycpayrollrosa_dfs_core_windows_net],
FILE_FORMAT = [SynapseDelimitedTextFormat]
)
GO