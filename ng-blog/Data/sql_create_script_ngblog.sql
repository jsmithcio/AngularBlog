USE [ngBlog]
GO
/****** Object:  Table [dbo].[BlogHeaders]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BlogHeaders]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BlogHeaders](
	[BlogId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](150) NOT NULL,
	[Author] [nvarchar](150) NOT NULL,
	[Image] [nvarchar](150) NOT NULL,
	[Summary] [nvarchar](1500) NOT NULL,
	[Link] [nvarchar](150) NOT NULL,
	[Created] [smalldatetime] NOT NULL,
	[Modified] [smalldatetime] NULL,
	[Deleted] [smalldatetime] NULL,
 CONSTRAINT [PK_BlogHeaders] PRIMARY KEY CLUSTERED 
(
	[BlogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BlogPost]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BlogPost]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BlogPost](
	[PostId] [int] IDENTITY(1,1) NOT NULL,
	[BlogId] [int] NOT NULL,
	[Title] [nvarchar](150) NOT NULL,
	[Author] [nvarchar](150) NOT NULL,
	[Image] [nvarchar](150) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[Created] [smalldatetime] NOT NULL,
	[Modified] [smalldatetime] NULL,
	[Deleted] [smalldatetime] NULL,
 CONSTRAINT [PK_BlogPost] PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categories]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
	[Created] [smalldatetime] NOT NULL,
	[Modified] [smalldatetime] NULL,
	[Deleted] [smalldatetime] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Widgets]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Widgets]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Widgets](
	[WidgetId] [int] IDENTITY(1,1) NOT NULL,
	[WidgetTitle] [nvarchar](50) NOT NULL,
	[WidgetBody] [nvarchar](150) NOT NULL,
	[Created] [smalldatetime] NOT NULL,
	[Modified] [smalldatetime] NULL,
	[Deleted] [smalldatetime] NULL,
 CONSTRAINT [PK_Widgets] PRIMARY KEY CLUSTERED 
(
	[WidgetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[del_delete_blog_header]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[del_delete_blog_header]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[del_delete_blog_header] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[del_delete_blog_header] 5
ALTER PROCEDURE [dbo].[del_delete_blog_header] @blog_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update Blogheaders set deleted = (convert(smalldatetime, getdate())) where BlogId = @blog_id
END
GO
/****** Object:  StoredProcedure [dbo].[ins_add_blog_header]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ins_add_blog_header]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ins_add_blog_header] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[ins_add_blog_header] 'new title', 'j.s.', 'image900x300.jpg', 'sumarical propahties here blah bla', 'whatever.com'
ALTER PROCEDURE [dbo].[ins_add_blog_header] @title nvarchar(150), @author nvarchar(150) = null,
	@image nvarchar(150), @summary nvarchar(1500), @link nvarchar(150)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @auth nvarchar(150)

	if @author is null or ltrim(rtrim(@author)) = ''
		set @auth = 'js'
	else
		set @auth = @author
	

	--select @auth = case @author when null then 'js' else @author end
	--case @type when 2 then 1 else 0 end

    -- Insert statements for procedure here yyyy-mm-dd hh:mm:ss
	insert into BlogHeaders(Title, Author, Image, Summary, Link, created, modified, deleted)
	values (@title, @auth, @image, @summary, @link, CONVERT(SMALLDATETIME, GETDATE()), null, null)
END
GO
/****** Object:  StoredProcedure [dbo].[ins_add_blog_post]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ins_add_blog_post]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ins_add_blog_post] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[ins_add_blog_post] 3, 'new title', 'j.s.', './assets/img/900x300.jpg', 'body here'
ALTER PROCEDURE [dbo].[ins_add_blog_post] @blog_id int, @title nvarchar(150), @author nvarchar(150) = null, @image nvarchar(150), @body nvarchar(max)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @auth nvarchar(150)

	if @author is null or ltrim(rtrim(@author)) = ''
		set @auth = 'js'
	else
		set @auth = @author

	--select @auth = case @author when null then 'js' else @author end
	--case @type when 2 then 1 else 0 end

    -- Insert statements for procedure here yyyy-mm-dd hh:mm:ss
	insert into BlogPost(blogid, title, author, image, body, created)
	values (@blog_id, @title, @auth, @image, @body, CONVERT(SMALLDATETIME, GETDATE()))
END
GO
/****** Object:  StoredProcedure [dbo].[ins_add_category]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ins_add_category]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ins_add_category] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[ins_add_category] 'Angular'
ALTER PROCEDURE [dbo].[ins_add_category] @category_name nvarchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into Categories (categoryname, created) values (@category_name, CONVERT(smalldatetime, getdate()))


end
GO
/****** Object:  StoredProcedure [dbo].[ins_add_widget]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ins_add_widget]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ins_add_widget] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[ins_add_widget] 'Side Widget', 'This is a test widget from the db'
ALTER PROCEDURE [dbo].[ins_add_widget] @widget_title nvarchar(50), @widget_body nvarchar(150)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into widgets (widgettitle, widgetbody, created) values (@widget_title, @widget_body, CONVERT(smalldatetime, getdate()))


end
GO
/****** Object:  StoredProcedure [dbo].[ins_copy_summary_to_headers]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ins_copy_summary_to_headers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ins_copy_summary_to_headers] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[addTestData] 'asdfasdfgasgwqegr'
ALTER PROCEDURE [dbo].[ins_copy_summary_to_headers] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[BlogHeaders] ([Title],[Author],[Image],[Summary],[Link],[Created],[Modified],[Deleted])
     select Title, Author, BlogImage, Summary, Link, Created, null, null	
	 from BlogSummary
	 order by blogid asc
END
GO
/****** Object:  StoredProcedure [dbo].[sel_get_blog_header_by_blog_id]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sel_get_blog_header_by_blog_id]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sel_get_blog_header_by_blog_id] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[sel_get_blog_header_by_blog_id] 5
ALTER PROCEDURE [dbo].[sel_get_blog_header_by_blog_id] @blog_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from BlogHeaders where BlogId = @blog_id and deleted is null
END
GO
/****** Object:  StoredProcedure [dbo].[sel_get_blog_headers]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sel_get_blog_headers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sel_get_blog_headers] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[sel_get_blog_headers] --2
ALTER PROCEDURE [dbo].[sel_get_blog_headers] --@page_number int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	/*
	declare @page_size int = 3
	declare @recs_served int = @page_number * @page_size
	declare @total_recs int = (select count(blogid) from BlogHeaders where Deleted is null)
	declare @remaining_recs int = @total_recs - @recs_served
	declare @next_three int = ?
	*/

    -- Insert statements for procedure here
	select * from BlogHeaders  where deleted is null order by BlogId asc
END
GO
/****** Object:  StoredProcedure [dbo].[sel_get_blog_post]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sel_get_blog_post]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sel_get_blog_post] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[sel_get_blog_post] 1
ALTER PROCEDURE [dbo].[sel_get_blog_post] @blog_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @max_post_id int = coalesce((select max(postid) from BlogPost where BlogId = @blog_id and deleted is null), 1)

    -- Insert statements for procedure here
	select * from BlogPost where PostId = @max_post_id and BlogId = @blog_id
END
GO
/****** Object:  StoredProcedure [dbo].[sel_get_categories]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sel_get_categories]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sel_get_categories] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[sel_get_categories]
ALTER PROCEDURE [dbo].[sel_get_categories]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from Categories where deleted is null order by CategoryId asc

end
GO
/****** Object:  StoredProcedure [dbo].[sel_get_category]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sel_get_category]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sel_get_category] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[sel_get_category] 1
ALTER PROCEDURE [dbo].[sel_get_category] @category_id int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from Categories where CategoryId = @category_id and deleted is null

end
GO
/****** Object:  StoredProcedure [dbo].[sel_get_rec_count]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sel_get_rec_count]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sel_get_rec_count] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[sel_get_rec_count] 2
ALTER PROCEDURE [dbo].[sel_get_rec_count] @blog_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	--declare @nextRecs int
	declare @totalRecs int = (select count(blogid) as totalrecs from BlogHeaders where deleted is null)
	select @totalRecs

END
GO
/****** Object:  StoredProcedure [dbo].[sel_get_widget]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sel_get_widget]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sel_get_widget] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[sel_get_widget] 1
ALTER PROCEDURE [dbo].[sel_get_widget] @widget_id int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from widgets where widgetId = @widget_id and deleted is null

end
GO
/****** Object:  StoredProcedure [dbo].[sel_get_widgets]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sel_get_widgets]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sel_get_widgets] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[sel_get_widgets]
ALTER PROCEDURE [dbo].[sel_get_widgets]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from widgets where deleted is null order by widgetid asc

end
GO
/****** Object:  StoredProcedure [dbo].[upd_update_blog_header]    Script Date: 10/15/2019 11:10:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[upd_update_blog_header]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[upd_update_blog_header] AS' 
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[upd_update_blog_header] 4, 'test title', null, 'image.jpg', 'asdfbvadgfa asdgfarg', 'whatever.net'
ALTER PROCEDURE [dbo].[upd_update_blog_header] @blog_id int, @title nvarchar(150), @author nvarchar(150) = null, 
	@image nvarchar(150), @summary nvarchar(1500), @link nvarchar(150)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here yyyy-mm-dd hh:mm:ss

	declare @auth nvarchar(150)

	if @author is null or ltrim(rtrim(@author)) = '' set @auth = 'j.ss'
	else set @auth = @author

	update BlogHeaders
		set Title = @title,
			Author = @auth,
			--Created = @created,
			Image = @image,
			Summary = @summary,
			Link = @link,
			modified = (CONVERT(smalldatetime, getdate()))
		where
			BlogId = @blog_id
END
GO
