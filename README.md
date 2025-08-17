# Automated Laundromat System

A smart laundromat application built with **Flutter** and **Firebase**. This project automates machine booking, payments, feedback, and loyalty rewards, while enabling smart monitoring of washers and dryers.   

> This repository highlights the **Software Engineering process** completed as part of COE 420, covering requirements analysis, design, implementation, and testing.

---

## 🧭 Project Overview
- **Goal:** Automate a laundromat through a web/app interface with real-time status, booking, and payments.
- **Scope:** Smart appliance monitoring (on/off, door lock, power usage), booking up to 2 cycles, coin + online payments, notifications, rewards, and admin-managed feedback.
- **Stack:** Flutter (Dart) · Firebase (Auth, Realtime DB, Storage, Cloud Functions)

---

### 1) Requirements Engineering
- **Functional requirements**:
  - Machine booking (washer/dryer) with up to 2 consecutive cycles
  - Payments: coin interface and online (credit/debit)
  - Payment confirmation required before machine use
  - Database for machines, clients, and utility bills
  - Reward system with points & discounts for loyal members
  - Feedback system with admin responses
  - Machine availability/status updates (sensors: on/off, door lock, power usage)
  - Notifications for reservations & machine availability
- **Non-functional requirements**:
  - Role-based access (visitors, members, admins)
  - Accessible via all browsers & devices
  - Responsive UI
  - High availability with uninterrupted internet
  - Data retrieval within performance targets
  - 24/7 service availability (except maintenance)

---

### 2) Use Cases
Documented and analyzed with **normal, alternative, and exception flows**:
- Login / Logout
- View Available Machines
- Book a Machine (1–2 cycles)
- Pay for Booked Machine(s)
- Pay Online
- Pay by Coin
- Provide Feedback
- Admin Respond to Feedback

---

### 3) System Design
- **Class Diagram & Domain Model** describing relations between:
  - `Machine` (Bookings, Usage_Statistics, Maintenance_Schedules, Revenue_Generated)
  - `Client` (Client_ID, Client_Type, Name, Contact_Details, Reward_Points)
  - `Utility_Bills` (Bill_Type, Amount, Billing_Date)
- **Sequence Diagrams** for:
  - Scheduling a booking
  - Payment processing

---

### 4) Implementation
Developed using **Flutter + Firebase**, with modular and role-based functionality.  
Key modules include:
- `main.dart` — App entry point, Firebase init, routing
- `LoginPage.dart` & `RegistrationPage.dart` — Authentication and registration
- `RegularPage.dart` / `VisitorPage.dart` — Role-specific dashboards
- `BookingPage.dart` — Calendar/time selection, machine availability, cycle booking
- `PaymentPage.dart` — Coin & online payment handling
- `Feedback.dart` — Feedback submission
- `FeedbackListPage.dart` & `FeedbackListAdminPage.dart` — Public reviews + admin responses
- `DefaultFirebaseOptions.dart` — Platform Firebase configuration

---

### 5) Testing
**Test Plan** included cases TC001–TC007:
- TC001: Login validation  
- TC002: Booking (success)  
- TC003: Booking unavailable machine (error handling)  
- TC004: Payment confirmation & revenue update  
- TC005: Reward points allocation  
- TC006: Submit feedback  
- TC007: Admin-only responses to feedback  

**Results:** Verified all cases; correct database updates for bookings, payments, rewards, and feedback access.

---

### 6) Team & Methodology
- **Led a team of 5** for this **course project (COE 420: Software Engineering)**  
- Followed a **hybrid Scrum–Waterfall model**:  
  - Scrum elements for iterative progress (sprint-style work, regular check-ins)  
  - Waterfall structure for major deliverables and documentation milestones  
- Deliverables were scheduled and completed in phases:  
  - Requirements → Use Cases → Diagrams → Implementation → Testing → Final Report  
- Ensured collaboration, coordination, and timely completion of project milestones

---

## 📂 Repository Structure 

```text
Automated-Laundromat-System/
│── lib/                          # Main Flutter source code
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
│── docs/                         # Documentation & project artifacts
│   ├── report/
│   │   └── Automated_Laundromat_System.pdf   # Full project report
│   ├── diagrams/                 # Visual models
│       ├── use_case_diagram.png
│       ├── class_diagram.png
│       ├── domain_model.png
│       ├── sequence_scheduling.png
│       └── sequence_payment.png
│
└── README.md                     # Project showcase
```

---

## 📊 Project Highlights
- Applied **full Software Development Life Cycle (SDLC)**:
  - Requirements gathering
  - Use case modeling
  - System & database design
  - Implementation in Flutter + Firebase
  - Testing with structured cases & results
- Delivered a **complete prototype** simulating real-world laundromat automation
- Emphasis on **structured engineering practices, documentation, and validation**
