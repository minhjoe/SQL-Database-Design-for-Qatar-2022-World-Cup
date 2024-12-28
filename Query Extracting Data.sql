-- 1. Capacity Optimization in Transportation
-- Query to calculate and analyze the ticket sales for each train in the context of the Qatar 2022 Football World Cup
SELECT
    T.Train_ID,
    T.Capacity AS Train_Capacity,
    COUNT(GDT.Game_day_train_ticket_ID) AS Game_Day_Train_Ticket,
    (T.Capacity - COUNT(GDT.Game_day_train_ticket_ID)) AS Remaining_Capacity
FROM
    Train T
LEFT JOIN
    Game_day_train GDT ON T.Train_ID = GDT.Train_ID
GROUP BY
    T.Train_ID, T.Capacity
HAVING
    (T.Capacity - COUNT(GDT.Game_day_train_ticket_ID)) >= 0;
    
-- Query to know the average capacity of train
SELECT Round(AVG(MaxTrainCapacity)) AS AverageTrainCapacity
FROM (
    SELECT Train_ID, MAX(Capacity) AS MaxTrainCapacity
    FROM Train
    GROUP BY Train_ID
) AS MaxCapacities;

-- 2. Ticket Holder Priority
-- Query to know how many ticketholder
SELECT COUNT(DISTINCT Customer_ID) AS NumberOfTicketHolders
FROM transaction
WHERE Ticket_type_bought > 0;

-- Query to know how many people have ticket as a customer
SELECT 'Ticket Holders' AS Category, COUNT(Customer_ID) AS TotalCount
FROM transaction
WHERE Ticket_type_bought > 0
UNION
SELECT 'Non-Ticket Holders' AS Category, COUNT(Customer_ID) AS TotalCount
FROM transaction
WHERE Ticket_type_bought = 0;

-- 3. Integration of Systems
-- Query to known total number of games
SELECT COUNT(*) AS TotalGames
FROM Game_match;

-- Query to know to solve issues in integrating various information systems and databases that manage transportation, fan camp bookings, and ticket sales, impacting the efficiency of operations
SELECT *
FROM transaction T
JOIN Game_ticket GT ON T.Ticket_type_ID = GT.Ticket_type_ID;

-- 4. Number of ticket_sold
---- Query to estimate total ticketsold for each game:
SELECT Team, COUNT(*) AS TicketCount
FROM Game_ticket
GROUP BY Team
Having Count(*) >2
Order by TicketCount asc;

-- Query to know how many ticket_sold at 1 stadium
SELECT Stadium_name, COUNT(*) AS TicketCount
FROM Game_ticket
WHERE Stadium_name = 'Lusail Stadium' OR Stadium_name = 'Ai Bayt Stadium'
GROUP BY Stadium_name;

-- Query to known total number of ticket_sold
SELECT SUM(Ticket_type_bought) AS TotalTicketsSold
FROM transaction;

-- 5. Room Management
-- Query to to get details about room bookings and the respective customers to address the issue of room overbooking and underutilization
SELECT
    room.Room_number,
    room_type.Room_type_name,
    room_type.Room_type_rate,
    customer.Customer_name,
    room_type.Capacity,
    room_type.Capacity - COUNT(room_type.Room_type_ID) AS RemainingCapacity
FROM
    room
JOIN
    Room_type  ON room.Room_type_ID = room_type.Room_type_ID
LEFT JOIN
    transaction ON room_type.Room_type_ID = transaction.Room_type_ID
Left JOIN
    Customer ON transaction.Customer_ID =customer.Customer_ID
GROUP BY
    room.Room_number, room_type.Room_type_name, room_type.Room_type_rate, customer.Customer_name, room_type.Capacity;

-- Query to know how many people is a ticketholder and just hold 1 ticket
SELECT COUNT(Distinct Customer_ID) AS NumberOfCustomersWithOneTicket
FROM transaction
WHERE  Ticket_type_bought = 1;









 
 