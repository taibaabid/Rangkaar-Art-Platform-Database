# 🎨 Rangkaar Art Platform Database System

A comprehensive, production-ready Relational Database Management System (RDBMS) designed to power **Rangkaar**, an innovative digital ecosystem bridging traditional artists, art students, and global art customers. Built using **T-SQL (Microsoft SQL Server)**, this system handles marketplace transactions, multi-tier creator management, student educational internships, and exhibition curation.

---

## 🚀 Key Architectural Features

* **Multi-Tier Creator Hierarchy**: Features a separate yet unified architecture tracking established professional **Artists** alongside academic **Students**, enabling both demographics to showcase and monetize their artworks simultaneously.
* **Many-to-Many Bridge Implementations**: Successfully normalizes complex, real-world business scenarios such as tracking multiple student applications to various gallery **Internships** and mapping multi-artist participation in **Exhibitions**.
* **Advanced Automation & Safety Controls**: Implements complex algorithmic data handling through modular User-Defined Functions (UDFs), Stored Procedures, and highly responsive transactional Triggers.

---

## 📊 Enhanced Entity-Relationship Diagram (EERD)

This database design utilizes proper crow's foot cardinality notation to maintain strict relational integrity across all modules. 

> 💡 **Tip:** GitHub automatically renders the interactive visual diagram below!

```mermaid
%%{init: {'theme': 'base', 'themeVariables': { 'primaryColor': '#ffffff', 'primaryTextColor': '#1e293b', 'primaryBorderColor': '#0284c7', 'lineColor': '#475569', 'secondaryColor': '#f8fafc', 'tertiaryColor': '#334155'}}}%%
erDiagram
    ARTISTS {
        int ArtistID PK
        string ArtistName
        string Email
        string ArtistCity
        string ArtistDomain
    }

    STUDENTS {
        int StudentID PK
        string StudentName
        string Email
        string Institute
        string City
        string Phone
    }

    CUSTOMERS {
        int CustomerID PK
        string CustomerName
        string Email
        string Phone
        string City
    }

    CATEGORIES {
        int CategoryID PK
        string CategoryName
    }

    SUBCATEGORIES {
        int SubcategoryID PK
        string SubcategoryName
        int CategoryID FK
    }

    ARTWORKS {
        int ArtworkID PK
        string Title
        int ArtistID FK "Null"
        int StudentID FK "Null"
        int SubcategoryID FK
        decimal Price
        decimal FinalPrice
        int YearCreated
        string Status
    }

    ORDERS {
        int OrderID PK
        int CustomerID FK
        int ArtworkID FK
        date OrderDate
        string Status
    }

    PAYMENTS {
        int PaymentID PK
        int OrderID FK
        decimal Amount
        string PaymentMethod
        date PaymentDate
        string PaymentStatus
    }

    INTERNSHIPS {
        int InternshipID PK
        string Organization
        int DurationMonths
        string Status
    }

    STUDENT-INTERNSHIPS {
        int StudentID PK, FK
        int InternshipID PK, FK
        date ApplicationDate
        date StartDate
        string Status
    }

    EXHIBITIONS {
        int ExhibitionID PK
        string ExhibitionName
        string Venue
        date ExhibitionDate
    }

    ARTIST-EXHIBITIONS {
        int ArtExhID PK
        int ArtistID FK
        int ExhibitionID FK
    }

    ARTISTS ||--oM ARTWORKS : "creates"
    STUDENTS ||--oM ARTWORKS : "creates"
    SUBCATEGORIES ||--oM ARTWORKS : "has"
    CATEGORIES ||----oM SUBCATEGORIES : "has"
    
    CUSTOMERS ||--oM ORDERS : "places"
    ARTWORKS ||--oM ORDERS : "are ordered"
    ORDERS ||--|| PAYMENTS : "has"

    ARTISTS ||--oM ARTIST-EXHIBITIONS : "participates"
    EXHIBITIONS ||--oM ARTIST-EXHIBITIONS : "hosts"

    STUDENTS ||--oM STUDENT-INTERNSHIPS : "applies to"
    INTERNSHIPS ||--oM STUDENT-INTERNSHIPS : "offers"
