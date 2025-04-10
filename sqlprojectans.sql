use jan23;
select * from dwt;
create table ut as
select * from dwt;
select * from ut;
create table mt as
select * from dwt;
select * from mt;
alter table ut
drop column Merchant_Id, drop column Merchant_Name, drop column Transaction_Fees, drop column Cashback,
drop column Loyalty_Points, drop column Transaction_Status;
select * from ut;
alter table mt
drop column Transaction_Id, drop column User_Id, drop column Transaction_Date, drop Payment_method,
drop column Device_Type, drop column Location, drop column Cashback;
alter table mt drop column Cashback;
alter table mt drop column Transaction_Fees;
select * from mt;

# Top 5 user with the highest spent
select cd.Name,ut.Payment_Method,
sum(ut.Product_Amount) as Total_Amount from ut
join cd on cd.Transaction_Id = ut.Transaction_Id
group by cd.Name,ut.Payment_Method order by Total_Amount desc limit 5;

# Top 5 Product category contribute the most to Merchant revenue
select Product_Category,Merchant_Name, sum(Product_Amount) as Total_Sales
from mt group by Product_Category,Merchant_Name order by Total_Sales desc limit 5;

# Find the cities which are the highest revenue
select cd.City,
SUM(ut.Product_Amount) as Total_Revenue from cd
join ut on cd.Transaction_Id = ut.Transaction_Id
group by cd.City order by Total_Revenue desc limit 5;

# Find the avg price for per order transaction
select avg(Product_Amount) as Avg_Amount from ut;
select Transaction_Id,avg(Product_Amount) as Avg_Amount from ut
group by Transaction_ID order by Avg_Amount desc limit 5;

# Most used product by customer
select Product_Name, count(Transaction_Id) as Product_Count
from ut group by Product_Name order by Product_Count desc limit 5;

# Which payment method have the highest success rates for each merchant
select mt.Merchant_Name,ut.Payment_Method,
count(ut.Transaction_Id) as Total_Count from ut
join mt on mt.Transaction_Id = ut.Transaction_Id
group by mt.Merchant_Name,ut.Payment_Method order by Total_Count desc limit 5;

# Which device type have the highest no. of transaction
select Device_Type,count(Transaction_Id) as Total_Count from ut
group by Device_Type order by Total_Count desc limit 3;

# Which users perform the highest value transaction and at which merchants
select mt.Merchant_Name,ut.User_Id,
SUM(ut.Product_Amount) as Total_Revenue from mt
join ut on mt.Transaction_Id = ut.Transaction_Id
group by mt.Merchant_Name,ut.User_id order by Total_Revenue desc limit 5;

select User_id, sum(Product_Amount) as Total_Revenue from ut
group by User_Id order by Total_Revenue desc limit 5;
select * from ut;
select * from dwt;

# Find the no. of total successful,failed and pending transaction status
select Transaction_Status,count(Transaction_Id) as Total_Count from mt
group by Transaction_Status order by Total_Count desc limit 5;

# Which customers have the highest loyalty points
select cd.Name,sum(mt.Loyalty_Points) as Total_Points from cd
join mt on mt.Transaction_Id = cd.Transaction_Id
group by cd.Name order by Total_Points desc limit 5;

# Which location have the highest revenue
select Location,sum(Product_Amount) as Total_Revenue from ut
group by Location order by Total_Revenue desc limit 5;









