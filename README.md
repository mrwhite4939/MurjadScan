# MurjadScan - Network Security Scanner

A powerful and user-friendly network security scanner optimized for both Termux (Android) and Kali Linux environments. MurjadScan provides an intuitive command-line interface for conducting various types of network scans using nmap.

## Key Features

- **Cross-Platform Support**: Works seamlessly on Termux (no root) and Kali Linux (with root)
- **Multiple Scan Types**: Quick scan, full TCP scan, service detection, vulnerability scanning, and more
- **User-Friendly Interface**: Beautiful CLI with colored output and clear menu options
- **Flexible Output Formats**: Save results in Normal Text, Grepable, or XML format
- **Safety First**: Built-in warnings and validation to prevent unauthorized scanning
- **Lightweight**: Minimal dependencies (only nmap required)

## Supported Scan Types

### Termux (No Root Required)
- Quick Scan
- Full TCP Scan
- Service Version Detection
- Top 1000 Ports Scan
- Custom Port Selection
- NSE Script Scanning
- Host Discovery

### Kali Linux (Root Required)
- SYN Stealth Scan
- Aggressive Scan
- UDP Scan
- OS Detection
- Full Stealth Scan
- ACK Scan (Firewall Detection)
- FIN Scan
- Vulnerability Scan
- All Termux features

## Use Cases

- Network security auditing
- Penetration testing
- Network discovery and mapping
- Service and version detection
- Vulnerability assessment
- Educational purposes

## Requirements

- Termux (Android) or Kali Linux
- nmap package
- Bash shell

## Installation

### Termux
```
pkg update && pkg upgrade
pkg install nmap git
git clone https://github.com/mrwhite4939/murjadscan
cd murjadscan
chmod +x murjadscan.sh
./murjadscan.sh
```
### Kali Linux
```
sudo apt update
sudo apt install nmap git
git clone https://github.com/mrwhite4939/murjadscan
cd murjadscan
chmod +x murjadscan.sh
sudo ./murjadscan.sh
```
Legal Disclaimer
IMPORTANT: Only use this tool on networks and systems you own or have explicit written permission to test. Unauthorized network scanning may be illegal in your jurisdiction and could result in criminal charges. The authors assume no liability for misuse of this tool.
Version
Current Version: 2.8 FINAL
Author
Created by [Ren/MrWhite4939]
Support
For issues, questions, or contributions, please visit the GitHub repository.
---


markdown
# 🔍 MurjadScan - Network Security Scanner

<div align="center">

![Version](https://img.shields.io/badge/version-2.8-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Platform](https://img.shields.io/badge/platform-Termux%20%7C%20Kali-orange.svg)
![Shell](https://img.shields.io/badge/shell-bash-lightgrey.svg)

**A powerful network security scanner for Termux and Kali Linux**

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Screenshots](#-screenshots) • [Legal](#%EF%B8%8F-legal-disclaimer)

</div>

---

## 📋 Table of Contents

- [About](#-about)
- [Features](#-features)
- [Requirements](#-requirements)
- [Installation](#-installation)
- [Usage](#-usage)
- [Scan Types](#-scan-types)
- [Examples](#-examples)
- [Output Formats](#-output-formats)
- [Troubleshooting](#-troubleshooting)
- [Legal Disclaimer](#%EF%B8%8F-legal-disclaimer)
- [Contributing](#-contributing)
- [License](#-license)
- [Author](#-author)

---

## 🎯 About

MurjadScan is a comprehensive network security scanning tool designed to work efficiently on both Android (via Termux) and Kali Linux. It provides a user-friendly command-line interface for conducting various types of network reconnaissance and security assessments using the powerful nmap engine.

### Why MurjadScan?

- ✅ **Easy to Use**: Intuitive menu-driven interface
- ✅ **Cross-Platform**: Works on mobile (Termux) and desktop (Kali Linux)
- ✅ **No Root Required**: Termux version works without root access
- ✅ **Professional**: Supports advanced scanning techniques
- ✅ **Safe**: Built-in validation and warnings
- ✅ **Flexible**: Multiple output formats for different use cases

---

## ✨ Features

### 🎨 User Interface
- Beautiful ASCII art logo
- Colorized output for better readability
- Clear menu structure
- Input validation and error handling
- Progress indicators

### 🔧 Technical Features
- Multiple scan types (TCP, SYN, UDP, etc.)
- Service version detection
- OS fingerprinting (Kali only)
- NSE script support
- Custom port specification
- Multiple output formats (Normal, Grepable, XML)
- Automatic results organization

### 🛡️ Security Features
- Target validation
- Permission warnings
- Safe defaults
- Command injection prevention

---

## 📦 Requirements

### Minimum Requirements
- **Termux**: Android 7.0+ (No root required)
- **Kali Linux**: Root access required for advanced scans
- **Storage**: ~50MB free space
- **Network**: Active internet/network connection

### Dependencies
- `bash` (usually pre-installed)
- `nmap` (will guide you to install)

---

## 🚀 Installation

### Option 1: Termux (Android)

# Update packages
pkg update && pkg upgrade -y

# Install required packages
pkg install nmap git -y

# Setup storage access (optional but recommended)
termux-setup-storage

# Clone the repository
git clone https://github.com/mrwhite4939/murjadscan

# Navigate to directory
cd murjadscan

# Make executable
chmod +x murjadscan.sh

# Run the scanner
./murjadscan.sh

### Option 2: Kali Linux
# Update system
sudo apt update && sudo apt upgrade -y

# Install required packages
sudo apt install nmap git -y

# Clone the repository
git clone https://github.com/mrwhite4939/murjadscan.git

# Navigate to directory
cd murjadscan

# Make executable
chmod +x murjadscan.sh

# Run with root privileges
sudo ./murjadscan.sh
Option 3: Direct Download
# Download script directly
wget https://raw.githubusercontent.com/mrwhite4939/murjadscan/main/murjadscan.sh

# Or using curl
curl -O https://raw.githubusercontent.com/mrwhite4939/murjadscan/main/murjadscan.sh

# Make executable
chmod +x murjadscan.sh

# Run
./murjadscan.sh  # Termux
sudo ./murjadscan.sh  # Kali Linux
📖 Usage
Basic Usage
# Launch the scanner
./murjadscan.sh

# Show help
./murjadscan.sh --help
Step-by-Step Guide
Launch the script
./murjadscan.sh
Select scan type from the menu (1-7 for Termux, 1-11 for Kali)
Enter target
Single IP: 192.168.1.1
Network: 192.168.1.0/24
Range: 192.168.1.1-50
Choose output format
Normal Text (recommended)
Grepable (for scripting)
XML (for tools)
Wait for scan to complete
View results in the specified output file
🔍 Scan Types
Termux Scans (No Root)

---

💡 Examples
Example 1: Quick Network Scan
./murjadscan.sh
# Select: 1 (Quick Scan)
# Target: 192.168.1.0/24
# Output: 1 (Normal Text)
Example 2: Service Detection on Specific Host
./murjadscan.sh
# Select: 3 (Service Detection)
# Target: 192.168.1.100
# Output: 1 (Normal Text)
Example 3: Custom Port Scan
./murjadscan.sh
# Select: 5 (Custom Ports)
# Target: 192.168.1.1
# Ports: 80,443,8080,8443
# Output: 2 (Grepable)
Example 4: Full Network Discovery
sudo ./murjadscan.sh  # Kali Linux
# Select: 11 (Ping Sweep)
# Target: 192.168.1.0/24
# Output: 1 (Normal Text)
📊 Output Formats
1. Normal Text (.txt)
Best for: Human reading
Features: Formatted, easy to read
Use case: Reports, documentation
2. Grepable (.gnmap)
Best for: Scripting and parsing
Features: Single-line results
Use case: Automation, data extraction
3. XML (.xml)
Best for: Tool integration
Features: Structured data
Use case: Import to other security tools
Results Location
Termux:
/data/data/com.termux/files/home/storage/shared/MurjadScan/
Kali Linux:
~/murjadscan_results/
🔧 Troubleshooting
Common Issues
Issue: "nmap not found"
# Termux
pkg install nmap

# Kali Linux
sudo apt install nmap
Issue: "Permission denied"
# Make script executable
chmod +x murjadscan.sh

# Kali: Run with sudo
sudo ./murjadscan.sh
Issue: "Invalid target"
Check IP format: 192.168.1.1
Check CIDR notation: 192.168.1.0/24
Avoid special characters
Issue: "Scan failed"
Check network connectivity
Verify target is reachable
Ensure you have permission to scan
Try with -Pn flag for firewall issues
Getting Help
# Show help
./murjadscan.sh --help

# Check nmap version
nmap --version

# Test connectivity
ping 192.168.1.1
⚖️ Legal Disclaimer
⚠️ IMPORTANT - READ CAREFULLY
This tool is provided for educational and authorized security testing purposes only.
Legal Usage
✅ ALLOWED:
Scanning your own networks and devices
Authorized penetration testing with written permission
Educational purposes in controlled lab environments
Security research with proper authorization
❌ PROHIBITED:
Scanning networks without explicit permission
Unauthorized access attempts
Malicious activities
Violating local, state, or federal laws
Liability
The authors and contributors of MurjadScan:
Are NOT responsible for misuse of this tool
Do NOT encourage illegal activities
Provide this tool "AS IS" without warranty
Assume NO liability for damages or legal consequences
Your Responsibility
By using this tool, you agree to:
Use it only on authorized targets
Comply with all applicable laws
Take full responsibility for your actions
Not hold the authors liable for any consequences
If in doubt, DON'T scan it!
🤝 Contributing
Contributions are welcome! Here's how you can help:
Reporting Bugs
Check if the issue already exists
Create a detailed bug report
Include steps to reproduce
Provide system information
Suggesting Features
Describe the feature clearly
Explain the use case
Consider implementation complexity
Pull Requests
Fork the repository
Create a feature branch
Make your changes
Test thoroughly
Submit a pull request
Code Style
Follow existing code style
Add comments for complex logic
Update documentation
Test on both Termux and Kali
