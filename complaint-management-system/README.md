# 📋 Complaint Management System
**Java Servlets + JSP + MySQL JDBC — No Frameworks**

---

## ⚙️ Prerequisites
| Tool | Version |
|------|---------|
| JDK  | 17+     |
| Maven | 3.6+   |
| MySQL | 8.x    |

---

## 🗄️ Step 1 — Set up the Database
```bash
mysql -u root -p < src/main/resources/schema.sql
```
This creates the `complaint_db` database, tables, and seeds:
- **Admin**: `admin@cms.com` / `admin123`
- **Demo User**: `user@cms.com` / `user123`

---

## 🔧 Step 2 — Configure DB credentials
Edit `src/main/java/com/cms/util/DBConnection.java`:
```java
private static final String DB_USER = "root";   // ← your MySQL user
private static final String DB_PASS = "root";   // ← your MySQL password
```

---

## 🚀 Step 3 — Run the Application
```bash
mvn tomcat7:run
```
Then open: **http://localhost:8080/cms**

---

## 🗂️ Project Structure
```
src/main/
├── java/com/cms/
│   ├── dao/          — UserDAO, ComplaintDAO (raw JDBC)
│   ├── filter/       — AuthFilter (session guard)
│   ├── model/        — User, Complaint POJOs
│   ├── servlet/      — 10 Servlets
│   └── util/         — DBConnection, PasswordUtil (SHA-256)
├── resources/
│   └── schema.sql    — DB schema + seed data
└── webapp/
    ├── css/style.css — Dark glassmorphism stylesheet
    ├── index.jsp
    └── WEB-INF/
        ├── web.xml
        └── jsp/      — 8 JSP pages
```

---

## 🌐 URL Routes
| URL | Description |
|-----|-------------|
| `/cms/` | → redirect to login or dashboard |
| `/cms/login` | Login page |
| `/cms/register` | Registration |
| `/cms/dashboard` | User dashboard |
| `/cms/complaint/submit` | Submit new complaint |
| `/cms/complaint/list` | My complaints |
| `/cms/complaint/detail?id=X` | View complaint detail |
| `/cms/admin/dashboard` | Admin overview |
| `/cms/admin/complaints` | Manage all complaints |
| `/cms/admin/complaint-detail?id=X` | Update status & remark |
| `/cms/logout` | Logout |

---

## 🔐 Security
- Passwords stored as **SHA-256** hex hashes
- All DB calls use **PreparedStatements** (SQL injection safe)
- `AuthFilter` blocks unauthenticated/unauthorised access
- JSP outputs use `<c:out>` (XSS safe)
