# Myapp



Terraform AWS Infrastructure with CI/CD and Monitoring .
Infrastructure Overview
This configuration provisions a complete AWS environment using Terraform, with a CI/CD pipeline (GitHub Actions) and CloudWatch monitoring.

📁 Project Structure
terraform-aws-infra/
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── compute/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── db/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   └── observability/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── backend.tf
├── terraform.tfvars
└── .github/workflows/deploy.yml

Part 1: Infrastructure Provisioning
Objective
Provision a complete AWS-based infrastructure using Terraform with modular, secure, and scalable design.
Steps Performed
    1. VPC Creation
        ◦ Created a custom VPC with a CIDR block 10.0.0.0/16.
        ◦ Configured public and private subnets across multiple availability zones for high availability.
        ◦ Associated Internet Gateway for public subnets and private subnet internet access.
        ◦ 
    2. EC2  Setup
        ◦ Provisioned compute resources using Terraform:
            ▪ Option 1: EC2 instances for manual app hosting.
        ◦ Configured IAM roles and instance profiles for secure access to AWS services.
    3. RDS PostgreSQL Database
        ◦ Created an RDS PostgreSQL instance in a private subnet for security.
        ◦ Enabled automated backups, multi-AZ, and encryption at rest.
        ◦ Used security groups to restrict database access only from application layer.
        ◦ 
    4. Security Groups
        ◦ Configured inbound and outbound rules:
            ▪ Allowed HTTP/HTTPS from the internet to Load Balancer.
            ▪ Allowed only internal communication between app instances and database.
    5. Load Balancer
        ◦ Deployed an Application Load Balancer (ALB) in public subnets.
        ◦ Configured listeners and target groups for the backend instances.
        ◦ Integrated health checks to ensure high availability.
    6. State Management
        ◦ Implemented Terraform remote state storage using AWS S3 and DynamoDB for state locking.
    7. Outputs
        ◦ Defined Terraform outputs for:
            ▪ VPC ID, Subnet IDs
            ▪ EC2 Public IP / ALB DNS
            ▪ RDS Endpoint
        ◦ Used these outputs for CI/CD pipeline integration.
        ◦ 
        ◦ 
        ◦ 

Part 2: Deployment Automation
Objective
Automate build, test, and deployment processes using a CI/CD pipeline GitHub Actions 
Steps Performed

    1. Pipeline Setup
        ◦ Integrated source repository with CI/CD platform.
        ◦ Defined pipeline stages for build, test, scan, deploy.
    2. Pull Request Validation
        ◦ Configured automatic testing on pull request creation.
        ◦ Ensured code quality and formatting checks before merging.
    3. Build & Push Docker Images
        ◦ On merging to main branch:
            ▪ Built Docker image of the application.
            ▪ Tagged and pushed the image to a  Docker Hub.
            ▪ 
    4. Staging Deployment
        ◦ Deployed the newly built image automatically to staging environment EC2
        ◦ Verified functionality and health checks before proceeding to production.
    5. Manual Approval for Production
        ◦ Implemented a manual approval gate before production deployment.
        ◦ Production deployment triggered only after human verification.
    6. Testing & Scanning
        ◦ Added unit and integration test stages.
        ◦ Integrated vulnerability scanning for dependencies and containers using open-source scanners.
    7. Notification System
        ◦ Configured email notifications for:
            ▪ Build success/failure
            ▪ Test results
            ▪ Deployment approvals
            ▪ 

Part 3: Monitoring and Logging
Objective
Implement observability through centralized monitoring and logging.
Steps Performed
    1. Monitoring Setup
        ◦ Installed and configured Prometheus for infrastructure metrics:
            ▪ CPU, Memory, Disk Utilization.
        ◦ Integrated application metrics (request rate, latency, error rate) using Prometheus exporters.
    2. Logging Configuration
        ◦ Centralized application logs and system logs using CloudWatch Logs.
        ◦ Configured access logs for Load Balancer and API endpoints.
    3. Dashboards
        ◦ Created visual dashboards for:
            ▪ Application performance (request count, latency, errors)
            ▪ Infrastructure health (CPU, memory, disk, network)
    4. Alerting
        ◦ Set up alert rules for:
            ▪ High CPU usage
            ▪ Database connection failures
            ▪ Application error spikes
        ◦ Integrated alert delivery via email.
        ◦ 

Part 4: Documentation and Best Practices
    1. README Documentation
        ◦ Created a detailed README.md containing:
            ▪ Infrastructure setup and execution steps.
            ▪ Deployment and rollback instructions.
            ▪ Architecture explanation and design decisions.
            ▪ Troubleshooting guide.
    2. Architecture Decisions
        ◦ Chose modular Terraform structure for reusability.
        ◦ Used least-privilege IAM roles for resources.
        ◦ Adopted containerized deployment for portability.

Conclusion
This setup provides a complete DevOps ecosystem covering:
    • Automated infrastructure provisioning
    • Continuous deployment pipelines
    • Centralized monitoring & logging
    • Secure and optimized architecture
