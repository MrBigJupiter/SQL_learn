-- Select the Footwear Sales data from 2018-2026 --

USE FootwearSales;

-- Create the Database for the global_sales_data --

CREATE TABLE global_sales_data (
    order_id              varchar(15)  NOT NULL,
    order_date            date         NULL,
    brand                 varchar(15)  NULL,
    model_name            varchar(15)  NULL,
    category              varchar(15)  NULL,
    gender                varchar(15)  NULL,
    size                  int          NULL,
    color                 varchar(15)  NULL,
    base_price_usd        int          NULL,
    discount_percent      int          NULL,
    final_price_usd       decimal(5,2) NULL,
    units_sold            int          NULL,
    revenue_usd           decimal(5,2) NULL,
    payment_method        varchar(15)  NULL,
    sales_channel         varchar(15)  NULL,
    country               varchar(15)  NULL,
    customer_income_level varchar(15)  NULL,
    customer_rating       decimal(10,2) NULL,

    CONSTRAINT PK_global_sales_data PRIMARY KEY (order_id),
    CONSTRAINT CHK_discount_percent CHECK (discount_percent BETWEEN 0 AND 100)
);

-- Insert data into the create global_sales_table --

BULK INSERT dbo.global_sales_data
FROM 'folder_path'
WITH (
    FIRSTROW = 2,              -- fejléc kihagyása
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',         -- UTF-8
    TABLOCK
);

-- Check if the data and the amount that came through  -- 

SELECT TOP 50 * 
FROM global_sales_data;

SELECT COUNT(*) AS Counted_Columns
FROM global_sales_data;