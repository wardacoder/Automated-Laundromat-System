# Automated Laundromat System

**Software Engineering SDLC project covering requirements (FRs & NFRs), design and analysis (UML diagrams: Use Case, Class, Domain Model, Sequence), full-stack implementation (Flutter frontend + Firebase database and hosting), testing (plans & cases), and deployment of a smart laundromat web system.**

---

## Project Overview
The **Automated Laundromat System** is a web-based application that automates common laundromat operations while demonstrating a complete **Software Development Life Cycle (SDLC)** from requirements to deployment.

**User roles:**
- **Visitor:** one-time user who can browse and book machines.
- **Client:** registered user with booking history and reward points.
- **Admin:** manages machines, monitors usage & revenue, and responds to client feedback.

**Key capabilities**   
- Registration & login for clients; visitor can book as guest.
- Machine **booking & scheduling** (up to two consecutive cycles).
- **Online card** and **on-site coin** payment options.
- **Reward points** program for frequent clients.
- **Feedback module** with separate client and admin responses.
- **Admin dashboard** for revenue reports and machine monitoring.
- Real-time data storage and updates via **Firebase Realtime Database**.
- **Deployed prototype** for demonstration using **Firebase Hosting**.

---

## Requirements
The project began with eliciting and documenting:
- **Functional requirements:**  
  booking and cancellation of machines, payments, reward accumulation, client feedback, admin response, etc.  
- **Non-functional requirements:**  
  system reliability, responsiveness, scalability, maintainability, and basic security constraints.
- Defined **system scope, primary actors, and constraints**.

Full details are available in [Final Project Report](docs/Final_Project_Report.pdf).

---

## Design & Analysis
A set of **UML artifacts** was produced to move from requirements to system design:
- **Use Case Diagram** – shows how Visitor, Client, and Admin interact with the system.
- **Domain Model Diagram** – conceptual view of laundromat entities (User, Machine, Booking, Payment, Reward, Feedback).
- **Class Diagram** – planned software-level structure of classes, attributes, and methods  
  *(design reference — final Flutter widget structure differs, as is common in web/mobile apps)*.
- **Sequence Diagrams** – depict runtime interaction flows for key scenarios (Booking, Payment, Scheduling).

All diagrams are in [Diagrams](docs/diagrams).

---

## Full-Stack Implementation
- **Frontend:**  
  Built entirely in **Flutter Web** for a responsive interface.  
  Main modules/pages:
  - Visitor and Client: Login & Registration, Booking Page, Payment Page, Feedback Page, User Dashboard  
  - Admin: Feedback Management

- **Backend / Database:**  
  Implemented using **Firebase Realtime Database**.  
  Designed and maintained structured nodes for Users, Machines, Bookings, Payments, Rewards, and Feedback.  
  Application logic updates database entries in real-time on booking, payment confirmation, feedback submission, and admin responses.

---

## Testing
- Designed a comprehensive **Testing Plan** and prepared **Test Cases** covering:
  - User registration / login flow
  - Machine booking
  - Payment processing
  - Reward points calculation
  - Client feedback submission
  - Admin response submission
  - Data update checks in the database

---

## Deployment:
  Web app deployed using **Firebase Hosting** as a part of demonstration.

---

## My Contributions
- Served as **Team Lead** – coordinated weekly deliverables and managed milestone tracking.
- **Implemented the entire web application frontend** (all pages listed above).
- **Designed and integrated the Firebase Realtime Database** including booking/payment/reward/feedback logic.
- Set up **Firebase Hosting deployment**.
- Led **requirements documentation** (FRs & NFRs) and **UML design** (Use Case, Domain Model, Class, Sequence).
- Authored and executed **testing plans and cases**.
- Co-authored the **41-page final project report**.

---

## Repository Structure
```
Automated-Laundromat-System/
│
├── docs/
│   ├── Final_Project_Report.pdf 
│   └── diagrams/
│       ├── use_case_diagram.png
│       ├── domain_model_diagram.png
│       ├── class_diagram.png
│       ├── sequence_diagram_booking.png
│       └── sequence_diagram_payment.png
├── lib/
│   ├── main.dart
│   ├── LoginPage.dart
│   ├── RegistrationPage.dart
│   ├── Feedback.dart
│   ├── FeedbackListPage.dart
│   ├── FeedbackListAdminPage.dart
│   ├── firebase_options.dart
│   ├── RegularPage.dart
│   ├── VisitorPage.dart
│   ├── BookingPage.dart
│   ├── PaymentPage.dart
│   └── featurewidget.dart
├── README.md              
└── LICENSE                       
```

---

## Tech Stack
- **Process:** Semester-long SDLC with iterative weekly deliverables 
- **Modeling:** UML (Use Case, Class, Domain Model, Sequence)  
- **Frontend:** Flutter Web  
- **Backend:** Firebase Realtime Database
- **Testing:** Manual test plans and cases  
- **Deployment:** Firebase Hosting  

---

## Documentation & Additional Details

For complete project documentation, including:
- All **SDLC deliverables** (requirements, design, implementation, and testing phases)
- Detailed **UML diagrams** (Use Case, Class, Domain Model, Sequence)
- Full **database structure** and **system workflows**
- And **screenshots** of the deployed web application interface

please refer to the [Final Project Report](docs/Final_Project_Report.pdf).

