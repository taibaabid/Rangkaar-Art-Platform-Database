CREATE DATABASE Rangkaar_Art_Platform;
USE Rangkaar_Art_Platform;

-----------------------
-- ARTISTS TABLE
-----------------------
CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    ArtistName VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    City VARCHAR(50),
    Specialty VARCHAR(100)
);
INSERT INTO Artists VALUES
(1, 'Sadequain', 'sadequain@art.pk', 'Karachi', 'Calligraphy'),
(2, 'Ismail Gulgee', 'gulgee@art.pk', 'Karachi', 'Abstract'),
(3, 'A.R. Chughtai', 'chughtai@art.pk', 'Lahore', 'Miniature'),
(4, 'Zahoor ul Akhlaq', 'zahoor@art.pk', 'Lahore', 'Modern Art'),
(5, 'Nadia Jamil', 'nadia@art.pk', 'Islamabad', 'Digital Art');

INSERT INTO Artists VALUES
(6, 'Mahir Fahad', 'mahir@art.pk', 'Faisalabad', 'Interior Designer');

-----------------------
-- STUDENTS TABLE
-----------------------
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Institute VARCHAR(100),
    City VARCHAR(50)
);
INSERT INTO Students VALUES
(1, 'Taiba Abid', 'taiba@student.pk', 'NCA Lahore', 'Lahore'),
(2, 'Ayesha Khan', 'ayesha@student.pk', 'KU Karachi', 'Karachi'),
(3, 'Hassan Raza', 'hassan@student.pk', 'Punjab University', 'Lahore'),
(4, 'Sara Ahmed', 'sara@student.pk', 'BNU Lahore', 'Lahore'),
(5, 'Hamza Ali', 'hamza@student.pk', 'Iqra University', 'Karachi');

-----------------------
-- CUSTOMERS
-----------------------
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    City VARCHAR(50)
);
INSERT INTO Customers VALUES
(1, 'Bilal Hussain', 'bilal@customer.pk', '03001234567', 'Karachi'),
(2, 'Maha Sheikh', 'maha@customer.pk', '03016748392', 'Lahore'),
(3, 'Umar Farooq', 'umar@customer.pk', '03329874510', 'Islamabad'),
(4, 'Hiba Saeed', 'hiba@customer.pk', '03214567098', 'Faisalabad'),
(5, 'Ahmed Hassan', 'ahmed@customer.pk', '03087651234', 'Rawalpindi');

-----------------------
-- CATEGORIES
-----------------------
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);
INSERT INTO Categories VALUES
(1, 'Fine Arts'),
(2, 'Digital Arts'),
(3, 'Graphic Design'),
(4, 'Interior & Décor Arts'),
(5, 'Product & Furniture Design'),
(6, 'Handicrafts & Craft Arts'),
(7, 'Textile & Fashion Art'),
(8, 'Animation & Media Arts'),
(9, 'Architecture & Spatial Art'),
(10, 'Specialized Customized Services');

-----------------------
-- SUBCATEGORIES
-----------------------
CREATE TABLE Subcategories (
    SubcategoryID INT PRIMARY KEY,
    SubcategoryName VARCHAR(100),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- YOU ALREADY INSERTED ALL SUBCATEGORIES (KEEP SAME)

INSERT INTO Subcategories VALUES
(1, 'Portrait Drawings', 1),
(2, 'Calligraphy', 1),
(3, 'Abstract Paintings', 1),
(4, 'Digital Portraits', 2),
(5, 'Character Designing', 2),
(6, 'Digital Illustrations', 2),
(7, 'Logo Design', 3),
(8, 'Brand Identity', 3),
(9, 'Posters & Flyers', 3),
(10, 'Mural Painting', 4),
(11, 'Customized Wall Art', 4),
(12, 'Room Décor', 4),
(13, 'Furniture Painting', 5),
(14, 'Resin Art Pieces', 5),
(15, 'Custom Tables', 5),
(16, 'Resin Jewellery', 6),
(17, 'Clay Pottery', 6),
(18, 'Embroidery Art', 6),
(19, 'Textile Prints', 7),
(20, 'Pattern Design', 7),
(21, 'Fashion Illustration', 7),
(22, '2D Animation', 8),
(23, 'Motion Graphics', 8),
(24, 'Storyboard Art', 8),
(25, 'Architectural Sketches', 9),
(26, '3D Visualization', 9),
(27, 'Space Planning', 9),
(28, 'Wedding Artworks', 10),
(29, 'Kids Room Décor', 10),
(30, 'Event Custom Décor', 10);

-----------------------
-- UPDATED ARTWORKS TABLE
-- ONLY SUBCATEGORY LINKED
-- STUDENTS CAN ALSO CREATE ARTWORKS
-----------------------
CREATE TABLE Artworks (
    ArtworkID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    ArtistID INT NULL,
    StudentID INT NULL,
    SubcategoryID INT,
    Price DECIMAL(10,2),
    YearCreated INT,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubcategoryID) REFERENCES Subcategories(SubcategoryID)
);

-- FIXED INSERTS (Removed CategoryID & added NULL StudentID)
INSERT INTO Artworks VALUES
(1, 'The Eternal Script', 1, NULL, 2, 150000, 1988),
(2, 'Mystic Abstract', 2, NULL, 3, 120000, 1995),
(3, 'Miniature Glory', 3, NULL, 18, 250000, 1960),
(4, 'Digital Horizons', 5, NULL, 4, 60000, 2022),
(5, 'Modern Reflections', 4, NULL, 1, 80000, 1990);

-----------------------
-- ORDERS
-----------------------
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ArtworkID INT,
    OrderDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ArtworkID) REFERENCES Artworks(ArtworkID)
);
INSERT INTO Orders VALUES
(1, 1, 1, '2025-01-10', 'Completed'),
(2, 2, 4, '2025-01-11', 'Pending'),
(3, 3, 2, '2025-01-12', 'Shipped'),
(4, 4, 3, '2025-01-13', 'Completed'),
(5, 5, 5, '2025-01-14', 'Cancelled');

-----------------------
-- PAYMENTS
-----------------------
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    Amount DECIMAL(10,2) CHECK (Amount > 0),
    PaymentMethod VARCHAR(50),
    PaymentDate DATE,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
INSERT INTO Payments VALUES
(1, 1, 150000, 'Bank Transfer', '2025-01-10'),
(2, 2, 60000, 'JazzCash', '2025-01-11'),
(3, 3, 120000, 'EasyPaisa', '2025-01-12'),
(4, 4, 250000, 'Cash', '2025-01-13'),
(5, 5, 80000, 'Bank Transfer', '2025-01-14');

-----------------------
-- INTERNSHIPS TABLE (NO STUDENT ID NOW)
-----------------------
CREATE TABLE Internships (
    InternshipID INT PRIMARY KEY,
    Organization VARCHAR(100),
    DurationMonths INT,
    Status VARCHAR(50)
);
INSERT INTO Internships VALUES
(1, 'PNCA Islamabad', 3, 'Completed'),
(2, 'NCA Gallery Lahore', 6, 'Ongoing'),
(3, 'Alhamra Arts Council', 4, 'Completed'),
(4, 'VM Art Gallery Karachi', 2, 'Ongoing'),
(5, 'Khayal Creative Studio', 3, 'Completed');

-----------------------
-- NEW: NORMALIZATION TABLE (Many-to-Many)
-----------------------
CREATE TABLE StudentInternships (
    StudentID INT,
    InternshipID INT,
    ApplicationDate DATE,
    Status VARCHAR(50),
    PRIMARY KEY (StudentID, InternshipID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (InternshipID) REFERENCES Internships(InternshipID)
);

-- Insert previously existing pairs
INSERT INTO StudentInternships VALUES
(1, 1, '2024-01-01', 'Completed'),
(2, 2, '2024-02-01', 'Ongoing'),
(3, 3, '2024-03-01', 'Completed'),
(4, 4, '2024-04-01', 'Ongoing'),
(5, 5, '2024-05-01', 'Completed');

-----------------------
-- EXHIBITIONS
-----------------------
CREATE TABLE Exhibitions (
    ExhibitionID INT PRIMARY KEY,
    ExhibitionName VARCHAR(100),
    Venue VARCHAR(100),
    ExhibitionDate DATE
);
INSERT INTO Exhibitions VALUES
(1, 'Calligraphy Revival', 'PNCA Islamabad', '2024-12-05'),
(2, 'Abstract Expressions', 'Arts Council Karachi', '2025-01-12'),
(3, 'Miniature Heritage', 'NCA Lahore', '2025-02-10'),
(4, 'Modern Retrospective', 'Alhamra Lahore', '2025-03-05'),
(5, 'Digital Dimensions', 'PNCA Islamabad', '2025-04-01');

-----------------------
-- ARTIST EXHIBITIONS
-----------------------
CREATE TABLE ArtistExibitions (
    ArtExhID INT PRIMARY KEY,
    ArtistID INT,
    ExhibitionID INT,
    FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions(ExhibitionID),
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);
INSERT INTO ArtistExibitions VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

--- Alter Commands --- 
ALTER TABLE Students ADD Phone VARCHAR(15);
ALTER TABLE Artists ADD CONSTRAINT UQ_ArtistEmail UNIQUE (Email);
ALTER TABLE StudentInternships ADD StartDate DATE;
EXEC sp_rename 'Artists.City', 'ArtistCity', 'COLUMN';
ALTER TABLE Artworks ADD Status VARCHAR(50) DEFAULT 'Available';
ALTER TABLE Payments ADD PaymentStatus VARCHAR(50) DEFAULT 'Pending';
EXEC sp_rename 'Artists.Specialty', 'ArtistDomain', 'COLUMN';

--- Aggregate Functions --- 
SELECT SUM(Amount) AS Total_Sales FROM Payments;

SELECT AVG(Price) AS Average_Artwork_Price FROM Artworks;

SELECT MAX(Price) AS Highest_Artwork_Price FROM Artworks;

SELECT MIN(Price) AS Cheapest_Artwork_Price FROM Artworks;

SELECT SubcategoryID, COUNT(*) AS Total_Artworks FROM Artworks GROUP BY SubcategoryID;

SELECT ArtistID, COUNT(*) AS Total_Artworks FROM Artworks WHERE ArtistID IS NOT NULL GROUP BY ArtistID;

SELECT StudentID, COUNT(*) AS Total_Artworks FROM Artworks WHERE StudentID IS NOT NULL GROUP BY StudentID;

SELECT Status, COUNT(*) AS Total_Internships FROM StudentInternships GROUP BY Status;

SELECT AVG(DurationMonths) AS Avg_Internship_Duration FROM Internships;

SELECT PaymentMethod, SUM(Amount) AS Total_Collected FROM Payments GROUP BY PaymentMethod;

SELECT Status, COUNT(*) AS Total FROM Artworks GROUP BY Status;

--- Nested Queries --- 
Select StudentName, City From Students Where City IN (Select City From Artists);

SELECT CustomerName, City FROM Customers WHERE City NOT IN (SELECT City FROM Artists); 

SELECT ArtistName FROM Artists A WHERE EXISTS ( SELECT 1 FROM Artworks AW WHERE AW.ArtistID = A.ArtistID ); 

SELECT ArtistName FROM Artists A WHERE NOT EXISTS ( SELECT 1 FROM ArtistExibitions E WHERE E.ArtistID = A.ArtistID );

SELECT Title, Price FROM Artworks WHERE Price > ALL ( SELECT Price FROM Artworks WHERE ArtistID = 1 ); 

SELECT ArtistName FROM Artists WHERE ArtistID IN ( SELECT ArtistID FROM ArtistExibitions );  

SELECT ArtistName FROM Artists WHERE ArtistID IN ( SELECT ArtistID FROM Artworks WHERE ArtworkID IN 
( SELECT ArtworkID FROM Orders WHERE CustomerID IN 
( SELECT CustomerID FROM Customers WHERE CustomerName = 'Maha Sheikh') ) );

SELECT Title, Price FROM Artworks WHERE Price > ANY 
( SELECT Price FROM Artworks WHERE ArtistID = (SELECT ArtistID FROM Artists WHERE ArtistName = 'Sadequain') );

--- Joins --- 
SELECT A.Title, A.Price, AR.ArtistName FROM Artworks A INNER JOIN Artists AR ON A.ArtistID = AR.ArtistID; 

SELECT AR.ArtistName, A.Title, A.Price FROM Artists AR LEFT JOIN Artworks A ON AR.ArtistID = A.ArtistID;

SELECT A.Title, AR.ArtistName, A.Price FROM Artists AR RIGHT JOIN Artworks A ON AR.ArtistID = A.ArtistID; 

SELECT AR.ArtistName, A.Title, A.Price FROM Artists AR FULL OUTER JOIN Artworks A ON AR.ArtistID = A.ArtistID; 

SELECT AR.ArtistName, E.ExhibitionName FROM Artists AR CROSS JOIN Exhibitions E; 

SELECT S1.StudentName AS Student1, S2.StudentName AS Student2, S1.City FROM Students S1 INNER JOIN Students S2 
ON S1.City = S2.City AND S1.StudentID <> S2.StudentID;

SELECT A.Title, C.CategoryName, S.SubcategoryName FROM Artworks A inner JOIN Subcategories S ON A.SubcategoryID = S.SubcategoryID 
INNER JOIN Categories C ON S.CategoryID = C.CategoryID; 

SELECT CU.CustomerName, A.Title AS Artwork_Name, P.Amount, P.PaymentMethod FROM Payments P 
INNER JOIN Orders O ON P.OrderID = O.OrderID 
INNER JOIN Customers CU ON O.CustomerID = CU.CustomerID 
INNER JOIN Artworks A ON O.ArtworkID = A.ArtworkID; 

SELECT AR.ArtistName, E.ExhibitionName FROM Artists AR 
FULL OUTER JOIN ArtistExibitions AE ON AR.ArtistID = AE.ArtistID 
FULL OUTER JOIN Exhibitions E ON AE.ExhibitionID = E.ExhibitionID; 

--- Functions --- 

-- Useful for showing how old an artwork is
CREATE FUNCTION GetArtworkAge(@YearCreated INT)
RETURNS INT
AS
BEGIN
    RETURN (YEAR(GETDATE()) - @YearCreated);
END;

SELECT Title, YearCreated,
       dbo.GetArtworkAge(YearCreated) AS Artwork_Age
FROM Artworks;

--Get Total Payment Received for a Specific Order
CREATE FUNCTION GetOrderPayment(@OrderID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Amount DECIMAL(10,2);
    SELECT @Amount = Amount FROM Payments WHERE OrderID = @OrderID;
    RETURN ISNULL(@Amount, 0);
END;

SELECT OrderID, dbo.GetOrderPayment(OrderID) AS Paid_Amount
FROM Orders;

--Get All Artworks by Category
CREATE FUNCTION GetArtworksByCategory(@CategoryName VARCHAR(100))
RETURNS TABLE
AS
RETURN (
    SELECT A.ArtworkID, A.Title, A.Price, C.CategoryName
    FROM Artworks A
    INNER JOIN Subcategories S ON A.SubcategoryID = S.SubcategoryID
    INNER JOIN Categories C ON S.CategoryID = C.CategoryID
    WHERE C.CategoryName = @CategoryName
);

SELECT * FROM dbo.GetArtworksByCategory('Fine Arts');

    --Get All Payments Within a Date Range; Useful for financial report generation.
CREATE FUNCTION GetPaymentsBetweenDates(@StartDate DATE, @EndDate DATE)
RETURNS TABLE
AS
RETURN (
    SELECT P.PaymentID, P.Amount, P.PaymentMethod, P.PaymentDate
    FROM Payments P
    WHERE P.PaymentDate BETWEEN @StartDate AND @EndDate
);

SELECT * 
FROM dbo.GetPaymentsBetweenDates('2025-01-10', '2025-01-14');

--Get Student Internship Details (Student + Internship + Status)
CREATE FUNCTION GetStudentInternshipDetails(@StudentID INT)
RETURNS @Result TABLE (
    StudentName VARCHAR(100),
    InternshipName VARCHAR(100),
    DurationMonths INT,
    ApplicationDate DATE,
    Status VARCHAR(50)
)
AS
BEGIN
    INSERT INTO @Result
    SELECT S.StudentName, I.Organization, I.DurationMonths,
           SI.ApplicationDate, SI.Status
    FROM StudentInternships SI
    INNER JOIN Students S ON SI.StudentID = S.StudentID
    INNER JOIN Internships I ON SI.InternshipID = I.InternshipID
    WHERE S.StudentID = @StudentID;
    RETURN;
END;

SELECT * FROM dbo.GetStudentInternshipDetails(1);

--Get Customer Order Summary (Customer + Artwork + Payment)
CREATE FUNCTION GetCustomerOrderSummary(@CustomerID INT)
RETURNS @Result TABLE (
    CustomerName VARCHAR(100),
    ArtworkTitle VARCHAR(100),
    Amount DECIMAL(10,2),
    PaymentMethod VARCHAR(50),
    OrderDate DATE,
    Status VARCHAR(50)
)
AS
BEGIN
    INSERT INTO @Result
    SELECT CU.CustomerName, A.Title, P.Amount, P.PaymentMethod,
           O.OrderDate, O.Status
    FROM Orders O
    INNER JOIN Customers CU ON O.CustomerID = CU.CustomerID
    INNER JOIN Artworks A ON O.ArtworkID = A.ArtworkID
    LEFT JOIN Payments P ON O.OrderID = P.OrderID
    WHERE CU.CustomerID = @CustomerID;
    RETURN;
END;

SELECT * FROM dbo.GetCustomerOrderSummary(2);

---Return all orders with a specific status ("Completed", "Pending", "Cancelled").

CREATE FUNCTION GetOrdersByStatus(@Status VARCHAR(50))
RETURNS TABLE
AS
RETURN (
    SELECT O.OrderID, C.CustomerName, A.Title AS Artwork,
           O.OrderDate, O.Status
    FROM Orders O
    INNER JOIN Customers C ON O.CustomerID = C.CustomerID
    INNER JOIN Artworks A ON O.ArtworkID = A.ArtworkID
    WHERE O.Status = @Status
);
SELECT * FROM dbo.GetOrdersByStatus('pending');

--Function: GetArtistTotalRevenue
--Purpose: Calculates the total revenue generated by a specific artist from all sold artworks. Useful for tracking artist performance.

CREATE FUNCTION GetArtistTotalRevenue(@ArtistID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(10,2);

    SELECT @TotalRevenue = SUM(P.Amount)
    FROM Artworks A
    INNER JOIN Orders O ON A.ArtworkID = O.ArtworkID
    INNER JOIN Payments P ON O.OrderID = P.OrderID
    WHERE A.ArtistID = @ArtistID AND O.Status = 'Completed';

    RETURN ISNULL(@TotalRevenue, 0);
END;

-- Example usage:
SELECT dbo.GetArtistTotalRevenue(1) AS TotalRevenue;

--FUNCTION 9: CalculateDiscountPrice
--Purpose: Apply a discount to an artwork price (very useful for promotions).
CREATE FUNCTION CalculateDiscountPrice(@Price DECIMAL(10,2), @DiscountPercent INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Price - (@Price * @DiscountPercent / 100);
END;

-- Example
SELECT dbo.CalculateDiscountPrice(20000, 15) AS DiscountedPrice;


--store procedures
--Artist/admin can track sales of a specific artwork.
CREATE PROCEDURE GetTotalSalesByArtwork
    @ArtworkID INT
AS
BEGIN
    SELECT COUNT(O.OrderID) AS TotalOrders, SUM(P.Amount) AS TotalRevenue
    FROM Orders O
    LEFT JOIN Payments P ON O.OrderID = P.OrderID
    WHERE O.ArtworkID = @ArtworkID;
END;

-- Usage
EXEC GetTotalSalesByArtwork 1;

--Admin checks students assigned to a specific internship.

CREATE PROCEDURE GetStudentsByInternship
    @InternshipID INT
AS
BEGIN
    SELECT S.StudentID, S.StudentName, S.Email, S.Institute, SI.ApplicationDate, SI.Status
    FROM StudentInternships SI
    INNER JOIN Students S ON SI.StudentID = S.StudentID
    WHERE SI.InternshipID = @InternshipID;
END;

-- Usage
EXEC GetStudentsByInternship 2;
--Admin or users can check upcoming exhibitions.
CREATE PROCEDURE GetExhibitionsByDate
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT ExhibitionID, ExhibitionName, Venue, ExhibitionDate
    FROM Exhibitions
    WHERE ExhibitionDate BETWEEN @StartDate AND @EndDate;
END;

-- Usage
EXEC GetExhibitionsByDate '2025-01-01', '2025-03-01';
---Admin or customers can view student-created artworks.
CREATE PROCEDURE GetStudentArtworks
AS
BEGIN
    SELECT ArtworkID, Title, StudentID, SubcategoryID, Price, YearCreated, Status
    FROM Artworks
    WHERE StudentID IS NOT NULL;
END;

-- Usage
EXEC GetStudentArtworks;
---Customers/students search artists by city.
CREATE PROCEDURE GetArtistsByCity
    @City VARCHAR(50)
AS
BEGIN
    SELECT ArtistID, ArtistName, ArtistDomain, ArtistCity, Email
    FROM Artists
    WHERE ArtistCity = @City;
END;

-- Usage
EXEC GetArtistsByCity 'Karachi';

--Customer views order history with payment info.
CREATE PROCEDURE GetCustomerOrderSummary
    @CustomerID INT
AS
BEGIN
    SELECT O.OrderID, A.Title AS Artwork, O.Status, O.OrderDate, P.Amount, P.PaymentMethod
    FROM Orders O
    INNER JOIN Artworks A ON O.ArtworkID = A.ArtworkID
    LEFT JOIN Payments P ON O.OrderID = P.OrderID
    WHERE O.CustomerID = @CustomerID;
END;

-- Usage
EXEC GetCustomerOrderSummary 2;

--Customer filters artworks by type (Calligraphy, Portraits, etc.).
CREATE PROCEDURE GetArtworksBySubcategory
    @SubcategoryID INT
AS
BEGIN
    SELECT ArtworkID, Title, ArtistID, StudentID, Price, Status
    FROM Artworks
    WHERE SubcategoryID = @SubcategoryID;
END;

-- Usage
EXEC GetArtworksBySubcategory 2;

--Customer searches artworks by price range.
CREATE PROCEDURE GetAvailableArtworksByPrice
    @MinPrice DECIMAL(10,2),
    @MaxPrice DECIMAL(10,2)
AS
BEGIN
    SELECT ArtworkID, Title, ArtistID, StudentID, Price, Status
    FROM Artworks
    WHERE Status = 'Available' AND Price BETWEEN @MinPrice AND @MaxPrice;
END;

-- Usage
EXEC GetAvailableArtworksByPrice 50000, 150000;
---Customer can browse artworks of a specific artist.
CREATE PROCEDURE GetArtworksByArtist
    @ArtistID INT
AS
BEGIN
    SELECT ArtworkID, Title, SubcategoryID, Price, YearCreated, Status
    FROM Artworks
    WHERE ArtistID = @ArtistID;
END;

-- Usage
EXEC GetArtworksByArtist 1;

---- storeprocedure 2
-- Artist/admin can track sales of a specific artwork
CREATE PROCEDURE sp_GetTotalSalesByArtwork
    @ArtworkID INT
AS
BEGIN
    SELECT COUNT(O.OrderID) AS TotalOrders, SUM(P.Amount) AS TotalRevenue
    FROM Orders O
    LEFT JOIN Payments P ON O.OrderID = P.OrderID
    WHERE O.ArtworkID = @ArtworkID;
END;

-- Usage
EXEC sp_GetTotalSalesByArtwork 1;

-- Admin checks students assigned to a specific internship
CREATE PROCEDURE sp_GetStudentsByInternship
    @InternshipID INT
AS
BEGIN
    SELECT S.StudentID, S.StudentName, S.Email, S.Institute, SI.ApplicationDate, SI.Status
    FROM StudentInternships SI
    INNER JOIN Students S ON SI.StudentID = S.StudentID
    WHERE SI.InternshipID = @InternshipID;
END;

-- Usage
EXEC sp_GetStudentsByInternship 2;

-- Admin or users can check upcoming exhibitions
CREATE PROCEDURE sp_GetExhibitionsByDate
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT ExhibitionID, ExhibitionName, Venue, ExhibitionDate
    FROM Exhibitions
    WHERE ExhibitionDate BETWEEN @StartDate AND @EndDate;
END;

-- Usage
EXEC sp_GetExhibitionsByDate '2025-01-01', '2025-03-01';

-- Admin or customers can view student-created artworks
INSERT INTO Artworks (ArtworkID, Title, ArtistID, StudentID, SubcategoryID, Price, YearCreated, Status)
VALUES
(6, 'Student Sketch', NULL, 1, 1, 50000, 2025, 'Available'),
(7, 'Student Drawing', NULL, 2, 2, 60000, 2024, 'Available');

CREATE PROCEDURE sp_GetStudentArtworks
AS
BEGIN
    SELECT ArtworkID, Title, StudentID, SubcategoryID, Price, YearCreated, Status
    FROM Artworks
    WHERE StudentID IS NOT NULL;
END;

-- Usage
EXEC sp_GetStudentArtworks;

-- Customers/students search artists by city
CREATE PROCEDURE sp_GetArtistsByCity
    @City VARCHAR(50)
AS
BEGIN
    SELECT ArtistID, ArtistName, ArtistDomain, ArtistCity, Email
    FROM Artists
    WHERE ArtistCity = @City;
END;

-- Usage
EXEC sp_GetArtistsByCity 'Karachi';

-- Customer views order history with payment info
CREATE PROCEDURE sp_GetCustomerOrderSummary
    @CustomerID INT
AS
BEGIN
    SELECT O.OrderID, A.Title AS Artwork, O.Status, O.OrderDate, P.Amount, P.PaymentMethod
    FROM Orders O
    INNER JOIN Artworks A ON O.ArtworkID = A.ArtworkID
    LEFT JOIN Payments P ON O.OrderID = P.OrderID
    WHERE O.CustomerID = @CustomerID;
END;

-- Usage
EXEC sp_GetCustomerOrderSummary 2;

-- Customer filters artworks by type (Calligraphy, Portraits, etc.)
CREATE PROCEDURE sp_GetArtworksBySubcategory
    @SubcategoryID INT
AS
BEGIN
    SELECT ArtworkID, Title, ArtistID, StudentID, Price, Status
    FROM Artworks
    WHERE SubcategoryID = @SubcategoryID;
END;

-- Usage
EXEC sp_GetArtworksBySubcategory 2;
---Admin can see artworks that have never been sold.
CREATE PROCEDURE sp_GetArtworksWithoutOrders
AS
BEGIN
    SELECT A.ArtworkID, A.Title, A.Price, A.Status
    FROM Artworks A
    LEFT JOIN Orders O ON A.ArtworkID = O.ArtworkID
    WHERE O.OrderID IS NULL;
END;

-- Usage
EXEC sp_GetArtworksWithoutOrders;


-- Customer can browse artworks of a specific artist
CREATE PROCEDURE sp_GetArtworksByArtist
    @ArtistID INT
AS
BEGIN
    SELECT ArtworkID, Title, SubcategoryID, Price, YearCreated, Status
    FROM Artworks
    WHERE ArtistID = @ArtistID;
END;

-- Usage
EXEC sp_GetArtworksByArtist 1;


--views 

--View: vw_CustomerOrderDetails   Purpose: Shows each customer’s orders with artwork details and payment info.Useful for admins or customers to see a summary of purchases.

CREATE VIEW vw_CustomerOrderDetails
AS
SELECT CU.CustomerID,
       CU.CustomerName,
       CU.Email,
       A.ArtworkID,
       A.Title AS ArtworkTitle,
       O.OrderID,
       O.OrderDate,
       O.Status AS OrderStatus,
       P.Amount AS PaymentAmount,
       P.PaymentMethod,
       P.PaymentDate
FROM Customers CU
INNER JOIN Orders O ON CU.CustomerID = O.CustomerID
INNER JOIN Artworks A ON O.ArtworkID = A.ArtworkID
LEFT JOIN Payments P ON O.OrderID = P.OrderID;

SELECT * FROM vw_CustomerOrderDetails;

----vw_ArtworksWithArtistStudent   
--Purpose: Displays artworks along with the creator info (Artist or Student) and subcategory.Useful for customers browsing artworks or admin reports.

CREATE VIEW vw_ArtworksWithArtistStudent
AS
SELECT A.ArtworkID,
       A.Title,
       COALESCE(Ar.ArtistName, S.StudentName) AS CreatorName,
       CASE WHEN Ar.ArtistID IS NOT NULL THEN 'Artist' ELSE 'Student' END AS CreatorType,
       Sub.SubcategoryName,
       A.Price,
       A.YearCreated,
       A.Status
FROM Artworks A
LEFT JOIN Artists Ar ON A.ArtistID = Ar.ArtistID
LEFT JOIN Students S ON A.StudentID = S.StudentID
INNER JOIN Subcategories Sub ON A.SubcategoryID = Sub.SubcategoryID;

SELECT * FROM vw_ArtworksWithArtistStudent;

--. View: vw_StudentInternshipStatus
---Purpose: Shows each student with all internships they applied to, including application date and status.Useful for admin or student tracking.

CREATE VIEW vw_StudentInternshipStatus
AS
SELECT S.StudentID,
       S.StudentName,
       I.InternshipID,
       I.Organization,
       I.DurationMonths,
       SI.ApplicationDate,
       SI.Status AS InternshipStatus
FROM StudentInternships SI
INNER JOIN Students S ON SI.StudentID = S.StudentID
INNER JOIN Internships I ON SI.InternshipID = I.InternshipID;

SELECT * FROM vw_StudentInternshipStatus;

--CURSOR

--Ensures that all completed orders properly mark artworks as Sold and payments as completed.

DECLARE @OrderID INT, @ArtworkID INT, @PaymentAmount DECIMAL(10,2);

DECLARE ArtworkCursor CURSOR FOR
SELECT O.OrderID, O.ArtworkID, P.Amount
FROM Orders O
INNER JOIN Payments P ON O.OrderID = P.OrderID
WHERE O.Status = 'Completed' AND P.PaymentStatus = 'Pending';

OPEN ArtworkCursor;

FETCH NEXT FROM ArtworkCursor INTO @OrderID, @ArtworkID, @PaymentAmount;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Update artwork status to Sold
    UPDATE Artworks
    SET Status = 'Sold'
    WHERE ArtworkID = @ArtworkID;

    -- Mark payment as completed
    UPDATE Payments
    SET PaymentStatus = 'Completed'
    WHERE OrderID = @OrderID;

    FETCH NEXT FROM ArtworkCursor INTO @OrderID, @ArtworkID, @PaymentAmount;
END

CLOSE ArtworkCursor;
DEALLOCATE ArtworkCursor;


-----Calculate Total Internship Duration per Student
---Scenario: Admin wants to calculate the sum of all internship months for each student.

DECLARE @StudentID INT, @StudentName VARCHAR(100), @TotalDuration INT;

DECLARE StudentCursor CURSOR FOR
SELECT DISTINCT S.StudentID, S.StudentName
FROM Students S
INNER JOIN StudentInternships SI ON S.StudentID = SI.StudentID;

OPEN StudentCursor;

FETCH NEXT FROM StudentCursor INTO @StudentID, @StudentName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @TotalDuration = SUM(I.DurationMonths)
    FROM StudentInternships SI
    INNER JOIN Internships I ON SI.InternshipID = I.InternshipID
    WHERE SI.StudentID = @StudentID;

    PRINT 'Student: ' + @StudentName + ' | Total Internship Duration: ' + CAST(@TotalDuration AS VARCHAR);

    FETCH NEXT FROM StudentCursor INTO @StudentID, @StudentName;
END

CLOSE StudentCursor;
DEALLOCATE StudentCursor;


----Notify Customers of Pending Orders

---Scenario: Admin wants to iterate over all pending orders and send reminders (simulation via PRINT).
DECLARE @CustomerName VARCHAR(100), @OrderID INT, @ArtworkTitle VARCHAR(100);

DECLARE PendingOrderCursor CURSOR FOR
SELECT CU.CustomerName, O.OrderID, A.Title
FROM Orders O
INNER JOIN Customers CU ON O.CustomerID = CU.CustomerID
INNER JOIN Artworks A ON O.ArtworkID = A.ArtworkID
WHERE O.Status = 'Pending';

OPEN PendingOrderCursor;

FETCH NEXT FROM PendingOrderCursor INTO @CustomerName, @OrderID, @ArtworkTitle;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Reminder: Customer ' + @CustomerName + ' has pending order #' + CAST(@OrderID AS VARCHAR) + ' for artwork: ' + @ArtworkTitle;

    FETCH NEXT FROM PendingOrderCursor INTO @CustomerName, @OrderID, @ArtworkTitle;
END

CLOSE PendingOrderCursor;
DEALLOCATE PendingOrderCursor;


-------------------------------
-- TRIGGERS WITH EXAMPLES
-------------------------------

-- 1. Backup Customers on Delete
CREATE TABLE IF NOT EXISTS Customers_Backup (
    CustomerID INT,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(50),
    DeletedOn DATETIME
);

CREATE TRIGGER trg_BackupCustomerOnDelete
ON Customers
AFTER DELETE
AS
BEGIN
    INSERT INTO Customers_Backup
    SELECT *, GETDATE()
    FROM deleted;
END;
GO

-- Example: Delete a customer to trigger backup
DELETE FROM Customers WHERE CustomerID = 5;
-- Check backup
SELECT * FROM Customers_Backup;


-- 2. Update Artwork Status when Order Completed
CREATE TRIGGER trg_UpdateArtworkStatusOnOrder
ON Orders
AFTER UPDATE
AS
BEGIN
    UPDATE A
    SET Status = 'Sold'
    FROM Artworks A
    INNER JOIN inserted I ON A.ArtworkID = I.ArtworkID
    WHERE I.Status = 'Completed';
END;
GO

-- Example: Complete an order to trigger artwork status update
UPDATE Orders SET Status = 'Completed' WHERE OrderID = 2;
-- Check artwork status
SELECT ArtworkID, Title, Status FROM Artworks;


-- 3. Auto-Set PaymentStatus = 'Paid' when Payment Added
-- Make sure Payments table has PaymentStatus column
ALTER TABLE Payments ADD PaymentStatus VARCHAR(20) DEFAULT 'Pending';

CREATE TRIGGER trg_PaymentStatusUpdate
ON Payments
AFTER INSERT
AS
BEGIN
    UPDATE P
    SET PaymentStatus = 'Paid'
    FROM Payments P
    INNER JOIN inserted I ON P.PaymentID = I.PaymentID;
END;
GO

-- Example: Insert a new payment
INSERT INTO Payments (PaymentID, OrderID, Amount, PaymentMethod, PaymentDate)
VALUES (6, 1, 20000, 'Bank Transfer', GETDATE());
-- Check payment status
SELECT * FROM Payments WHERE PaymentID = 6;


-- 4. Compute Artwork Final Price with 10% Commission
-- Make sure Artworks table has FinalPrice column
ALTER TABLE Artworks ADD FinalPrice DECIMAL(10,2);

CREATE TRIGGER trg_ComputeFinalPrice
ON Artworks
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE A
    SET FinalPrice = Price + (Price * 0.10)
    FROM Artworks A
    INNER JOIN inserted I ON A.ArtworkID = I.ArtworkID;
END;
GO

-- Example: Insert new artwork
INSERT INTO Artworks (ArtworkID, Title, ArtistID, StudentID, SubcategoryID, Price, YearCreated, Status)
VALUES (8, 'New Art', 1, NULL, 2, 100000, 2025, 'Available');
-- Check final price
SELECT ArtworkID, Title, Price, FinalPrice FROM Artworks WHERE ArtworkID = 8;


-- 5. Prevent Artist Deletion if Artworks Exist
CREATE TRIGGER trg_NoDeleteArtistIfArtworkExists
ON Artists
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM Artworks A
        INNER JOIN deleted D ON A.ArtistID = D.ArtistID
    )
    BEGIN
        RAISERROR('Artist cannot be deleted. Artworks exist for this artist.', 16, 1);
        RETURN;
    END

    DELETE FROM Artists
    WHERE ArtistID IN (SELECT ArtistID FROM deleted);
END;
GO

-- Example: Try deleting an artist with artworks
DELETE FROM Artists WHERE ArtistID = 1; -- Will raise error
-- Check remaining artists
SELECT * FROM Artists;


-- 6. Prevent Duplicate Student Applications to Same Internship
CREATE TRIGGER trg_NoDuplicateInternshipApplication
ON StudentInternships
FOR INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted I
        INNER JOIN StudentInternships S
            ON S.StudentID = I.StudentID
            AND S.InternshipID = I.InternshipID
    )
    BEGIN
        RAISERROR('Duplicate application not allowed for same internship.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Example: Insert duplicate application (will fail)
INSERT INTO StudentInternships (StudentID, InternshipID, ApplicationDate, Status)
VALUES (1, 1, GETDATE(), 'Ongoing'); -- Trigger prevents duplicate


-- 7. Limit Maximum One Session per User (Server Level)
-- Only works at server login level
CREATE TRIGGER trg_LimitSessionsToOne
ON ALL SERVER
FOR LOGON
AS
BEGIN
    DECLARE @User VARCHAR(200) = ORIGINAL_LOGIN();

    IF (SELECT COUNT(*) 
        FROM sys.dm_exec_sessions 
        WHERE login_name = @User) > 1
    BEGIN
        PRINT 'Multiple sessions not allowed for this user.';
        ROLLBACK;
    END
END;
GO

-- Example: Try logging in twice using the same SQL login
-- The second login will be blocked automatically

----8 Trigger: Log any changes to the Artworks table (DDL Trigger for ALTER, DROP)
-- Create a table to log DDL events
CREATE TABLE DDL_Log (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    EventType VARCHAR(100),
    EventTime DATETIME,
    EventDetails VARCHAR(MAX)
);

-- DDL trigger for Artworks table changes
CREATE TRIGGER trg_LogArtworksDDL
ON DATABASE
FOR ALTER_TABLE, DROP_TABLE
AS
BEGIN
    DECLARE @EventData XML = EVENTDATA();

    INSERT INTO DDL_Log (EventType, EventTime, EventDetails)
    VALUES (
        @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'VARCHAR(100)'),
        GETDATE(),
        @EventData.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]', 'VARCHAR(MAX)')
    );
END;
GO

-- Example: If someone tries to ALTER the Artworks table, it will log the event
ALTER TABLE Artworks ADD TempColumn INT;
-- Check the DDL log
SELECT * FROM DDL_Log;


-----9 Trigger: Prevent deletion of Categories if Subcategories exist
CREATE TRIGGER trg_PreventCategoryDelete
ON Categories
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Subcategories S
        INNER JOIN deleted D ON S.CategoryID = D.CategoryID
    )
    BEGIN
        RAISERROR('Cannot delete category. Subcategories exist under this category.', 16, 1);
        RETURN;
    END

    -- If no subcategories exist, delete the category
    DELETE FROM Categories
    WHERE CategoryID IN (SELECT CategoryID FROM deleted);
END;
GO

-- Example: Try deleting a category with subcategories
DELETE FROM Categories WHERE CategoryID = 1; -- Will raise error
-- Deleting a category with no subcategories works
DELETE FROM Categories WHERE CategoryID = 10; -- Will succeed

