# Mock Power BI Report Pack (Build Guide)

Note: Power BI .pbix files are proprietary and can’t be generated directly in this environment.
This pack includes everything you need to recreate the report in Power BI in ~20–30 minutes:
- Visual mockups (PNG "screenshots")
- Data model + table schema
- Suggested DAX measures
- Page layout plan and slicers

## Report Pages
### 1) Executive Summary
Visuals:
- KPI Cards: Total Requests, Total Denials, Overall Denial Rate, Avg Turnaround
- Bar: Denial Rate by Payer
- Matrix: Payer Summary table

Slicers:
- Payer
- Service Line (optional)
- Date/Week (optional)

### 2) Turnaround Trends
Visuals:
- Line: Turnaround time trend by payer
- Bar: Avg turnaround by payer (optional)

### 3) Denial Drivers
Visuals:
- Stacked bar: Denials by reason and payer
- Table: Top CPT codes by denial count (optional)

## Data Model (Star Schema)
Tables:
- FactAuthorizations (auth_id, payer_id, cpt_code, status, denial_reason, request_date, decision_date, days_to_decision)
- DimPayer (payer_id, payer_name, payer_type)
- DimDate (date, week, month, year)

Relationships:
- FactAuthorizations[payer_id] -> DimPayer[payer_id]
- FactAuthorizations[request_date] -> DimDate[date]

## DAX Measures (Copy/Paste)
Total Requests = COUNTROWS(FactAuthorizations)

Total Denials =
CALCULATE(
    [Total Requests],
    FactAuthorizations[status] = "Denied"
)

Denial Rate % =
DIVIDE([Total Denials], [Total Requests])

Avg Turnaround (Days) =
AVERAGE(FactAuthorizations[days_to_decision])

## Employer Customization Notes
### Banner Medical
- Highlight front-end throughput: turnaround time, scheduling delays, auth approval rate
- Add a KPI: "Same-day Auth %" and "Rework %"

### Dignity Health
- Highlight revenue integrity: denial root causes, compliance categories, charge capture tie-ins
- Add a KPI: "Avoidable Denial %" and "Documentation Completeness %"