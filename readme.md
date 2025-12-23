 Linux User Manager
A production-ready automation system for Linux user provisioning, SSH key management, and access control in multi-team environments.

✨ Features
Automated User Creation: Create users with proper groups, permissions, and home directories

SSH Key Management: Deploy team and user-specific SSH keys automatically

Role-Based Access Control: Pre-defined roles (admin, developer, operator, viewer) with appropriate permissions

Audit Logging: Comprehensive logging of all user management activities

Backup System: Automated backups of user configurations with rotation

Systemd Integration: Runs as a service with scheduled backups

🛠️ Quick Start
bash
# Clone the repository
git clone https://github.com/yourusername/linux-user-manager.git
cd linux-user-manager

# Install
sudo ./install.sh

# Create your first user
sudo user-manager create-user alice development developer