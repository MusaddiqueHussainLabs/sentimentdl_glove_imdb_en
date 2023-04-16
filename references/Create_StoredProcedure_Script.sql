SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ApplicationLogs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Logged] [datetime] NULL,
	[Level] [varchar](200) NULL,
	[Message] [nvarchar](max) NULL,
	[Logger] [nvarchar](500) NULL,
 CONSTRAINT [PK_dbo.ApplicationLogs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO




SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[isp_ApplicationLogs] (
	@logged DATETIME
	,@level VARCHAR(5)
	,@message NVARCHAR(max)
	,@logger NVARCHAR(300)
	)
AS
/*
=======================================================================
Author:- 
Purpose:-
Script Date:- 
=======================================================================
*/
BEGIN
	DECLARE @Process VARCHAR(100) = OBJECT_NAME(@@PROCID)
		,@Step VARCHAR(MAX) = ''
		,@UpdatedDateTime DATETIME = GETDATE()
		,@UpdatedBy VARCHAR(50) = system_user
		,@IsInTransaction BIT = 0
 

	BEGIN TRY
		BEGIN TRAN

		SET @IsInTransaction = 1

		INSERT INTO [dbo].[ApplicationLogs] (
			[Logged]
			,[Level]
			,[Message]
			,[Logger]
			)
		SELECT @logged
			,@level
			,@message
			,@logger

		COMMIT TRAN

		SET @IsInTransaction = 0
	END TRY

	BEGIN CATCH
		IF @IsInTransaction = 1
			ROLLBACK TRAN

		SELECT @Step = 'DB Error-' + ERROR_MESSAGE()

	END CATCH
END
GO