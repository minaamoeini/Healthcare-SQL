import dash
from dash import dcc, html
import pandas as pd
import plotly.express as px

file_path = "/Users/mina/Models/Healthcare_Project_SQL/healthcare_SQL_Project/healthcare_dataset.csv"
df = pd.read_csv(file_path)

# Display the first few rows of the DataFrame
print(df.head())

# Calculate average billing amount grouped by Medical Condition
avg_billing = df.groupby("Medical Condition")["Billing Amount"].mean().reset_index()
avg_billing.rename(columns={"Billing Amount": "Average Billing Amount"}, inplace=True)

print(avg_billing.head())  # Display the calculated averages

import plotly.express as px

# Create a bar chart
fig = px.bar(
    avg_billing,
    x="Medical Condition",
    y="Average Billing Amount",
    title="Average Billing by Medical Condition"
)

# Show the chart
fig.show()
