# AWS 3-Tier Application Deployment using Terraform

## 📌 Project Overview

This project demonstrates the deployment of a **3-tier web application architecture on AWS** using **Terraform** as Infrastructure as Code (IaC).

The application is divided into three layers:

1. **Frontend (Presentation Layer)** – Hosted as a static website on **Amazon S3**
2. **Backend (Application Layer)** – Running on **Amazon EC2**
3. **Database (Data Layer)** – Managed using **Amazon RDS**

This setup follows real-world cloud architecture best practices with proper **security groups**, **network isolation**, and **scalability concepts**.

---

## 🏗️ Architecture Diagram (Logical)



---

## 🛠️ Technologies Used

* **AWS Services**

  * Amazon S3 (Static Website Hosting)
  * Amazon EC2 (Backend Server)
  * Amazon RDS (Relational Database)
  * Security Groups
  * IAM

* **Infrastructure as Code**

  * Terraform

* **Backend**

  * Node.js / API Server

* **Frontend**

  * Static Web Application (HTML, CSS, JS)

---

## 📂 Project Structure

```
project-root/
│
├── terraform/
│   ├── provider.tf
│   ├── s3.tf
│   ├── ec2.tf
│   ├── rds.tf
│   ├── security-groups.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── frontend/
│   └── build / static files
│
├── backend/
│   ├── server.js
│   ├── db.js
│   └── package.json
│
└── README.md
```

---

## 🔐 Security Groups Configuration

### EC2 Security Group

* Allows HTTP/HTTPS access from the internet
* Allows backend API access from S3 frontend
* Allows outbound traffic to RDS

### RDS Security Group

* Allows database access **only from EC2 security group**
* No public access (secure by design)

---

## 🚀 Deployment Steps

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name/terraform
```

### 2️⃣ Initialize Terraform

```bash
terraform init
```

### 3️⃣ Validate & Plan

```bash
terraform validate
terraform plan
```

### 4️⃣ Apply Infrastructure

```bash
terraform apply
```

---

## 🌐 Application Access

* **Frontend URL:** S3 Static Website Endpoint
* **Backend API:** EC2 Public IP / Domain
* **Database:** Amazon RDS (Private Access)

---

## ✅ Key Features

* Fully automated infrastructure using Terraform
* Secure 3-tier architecture
* Separation of frontend, backend, and database
* Cloud-native deployment
* Follows DevOps best practices

---

## 📈 Learning Outcomes

* Hands-on experience with AWS core services
* Practical understanding of 3-tier architecture
* Terraform modules and state management
* Security group design and network isolation
* Real-world DevOps deployment workflow

---

## 🔮 Future Enhancements

* Add Application Load Balancer (ALB)
* Use Auto Scaling Group for EC2
* Store Terraform state in S3 with DynamoDB locking
* CI/CD pipeline using GitHub Actions
* HTTPS using ACM & CloudFront

---

## 👨‍💻 Author

**Abhishek Rajendra Pawar**
Cloud & DevOps-focused Software Developer

---

## ⭐ Acknowledgement

If you find this project useful, feel free to ⭐ the repository!
