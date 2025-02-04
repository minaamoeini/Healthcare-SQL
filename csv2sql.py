import sqlite3
import pandas as pd

# Load the dataset
file_path = r"/Users/mina/Models/Healthcare_Project_SQL/healthcare_SQL_Project/healthcare_dataset.csv"
data = pd.read_csv(file_path)

# Create SQLite database and load data
db_file = r"/Users/mina/Models/Healthcare_Project_SQL/healthcare_SQL_Project/healthcare_dataset.sqlite"
conn = sqlite3.connect(db_file)

# Write the DataFrame to the database
data.to_sql("healthcare", conn, if_exists="replace", index=False)

print("Data imported into SQLite database!")

# Close the connection
conn.close()

