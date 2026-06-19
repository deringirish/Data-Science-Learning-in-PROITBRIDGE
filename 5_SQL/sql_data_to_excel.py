import pandas as pd
from sqlalchemy import create_engine, text

# Database connection
engine = create_engine(
    "mysql+pymysql://root:Derin%40123@localhost/sales_management_task"
)
# Get all table names
with engine.connect() as conn:
    tables = conn.execute(text("SHOW TABLES")).fetchall()

# Create Excel workbook
with pd.ExcelWriter("database_export.xlsx", engine="openpyxl") as writer:
    for table in tables:
        table_name = table[0]

        # Read table into DataFrame
        df = pd.read_sql(f"SELECT * FROM `{table_name}`", engine)

        # Write to a separate sheet
        df.to_excel(writer, sheet_name=table_name[:31], index=False)

print("Export completed!")
