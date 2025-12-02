#!/data/data/com.termux/files/usr/bin/bash
#
# MurjadScan - Network Security Scanner
# Optimized for Kali Linux and Termux
# Termux: Works without root (non-root scans only)
# Kali: Requires root (full scan capabilities)
#
# SAFETY NOTICE: Only scan systems you own or have explicit permission to scan.
# Unauthorized network scanning may be illegal in your jurisdiction.
#
# Dependencies: nmap
# License: Use at your own risk. Educational purposes only.

set -euo pipefail

# Color definitions for terminal output
BLUE='\033[1;34m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# ASCII Logo
print_logo() {
    clear
    echo -e "${CYAN}===============================================================${NC}"
    echo -e "${CYAN}                                                               ${NC}"
    echo -e "${BLUE}              __  __            _           _                  ${NC}"
    echo -e "${BLUE}             |  \\/  |_   _ _ __(_) __ _  __| |                 ${NC}"
    echo -e "${CYAN}             | |\\/| | | | | '__| |/ _\` |/ _\` |                 ${NC}"
    echo -e "${CYAN}             | |  | | |_| | |  | | (_| | (_| |                 ${NC}"
    echo -e "${BLUE}             |_|  |_|\\__,_|_| _/ |\\__,_|\\__,_|                 ${NC}"
    echo -e "${BLUE}                             |__/                              ${NC}"
    echo -e "${WHITE}                          S C A N                              ${NC}"
    echo -e "${CYAN}                                                               ${NC}"
    echo -e "${CYAN}               Network Security Scanner Tool                   ${NC}"
    echo -e "${BLUE}                     Version 2.8 FINAL                         ${NC}"
    echo -e "${CYAN}                                                               ${NC}"
    echo -e "${CYAN}===============================================================${NC}"
    echo ""
}

# Global variables
RESULTS_DIR="$HOME/murjadscan_results"
IS_TERMUX=false
IS_ROOT=false

# Check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        IS_ROOT=true
    fi
}

# Detect environment
detect_environment() {
    if [[ -d "/data/data/com.termux" ]] || [[ "$PREFIX" == *"com.termux"* ]]; then
        IS_TERMUX=true
        RESULTS_DIR="$HOME/storage/shared/MurjadScan"
    fi
}

# Function to display help
show_help() {
    clear
    print_logo
    echo -e "${CYAN}===============================================================${NC}"
    echo -e "${WHITE}                    MurjadScan - Help Guide${NC}"
    echo -e "${CYAN}===============================================================${NC}"
    echo ""
    echo -e "${BLUE}USAGE:${NC}"
    echo -e "  ${GREEN}$0${NC}              ${WHITE}Launch Scanner${NC}"
    echo -e "  ${GREEN}$0 --help${NC}       ${WHITE}Show help${NC}"
    echo ""
    echo -e "${BLUE}TERMUX (No Root):${NC}"
    echo -e "  ${WHITE}- TCP Connect Scan${NC}"
    echo -e "  ${WHITE}- Service Version Detection${NC}"
    echo -e "  ${WHITE}- Port Scanning${NC}"
    echo -e "  ${WHITE}- Script Scanning${NC}"
    echo ""
    echo -e "${BLUE}KALI LINUX (Root Required):${NC}"
    echo -e "  ${WHITE}- SYN Stealth Scan${NC}"
    echo -e "  ${WHITE}- UDP Scan${NC}"
    echo -e "  ${WHITE}- OS Detection${NC}"
    echo -e "  ${WHITE}- Aggressive Scan${NC}"
    echo -e "  ${WHITE}- All Termux features${NC}"
    echo ""
    echo -e "${BLUE}INSTALLATION:${NC}"
    if [[ "$IS_TERMUX" == true ]]; then
        echo -e "  ${GREEN}pkg update && pkg upgrade${NC}"
        echo -e "  ${GREEN}pkg install nmap${NC}"
        echo -e "  ${GREEN}termux-setup-storage${NC}"
    else
        echo -e "  ${GREEN}sudo apt update${NC}"
        echo -e "  ${GREEN}sudo apt install nmap${NC}"
    fi
    echo ""
    echo -e "${YELLOW}SAFETY WARNING:${NC}"
    echo -e "  ${RED}Only scan systems you own or have permission to scan${NC}"
    echo ""
    echo -e "${CYAN}===============================================================${NC}"
    exit 0
}

# Check for help flag
if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
    show_help
fi

# Validate target
validate_target() {
    local target="$1"
    
    if [[ -z "$target" ]]; then
        return 1
    fi
    
    if [[ "$target" =~ [';''&''|''`''$''('')'] ]]; then
        return 1
    fi
    
    return 0
}

# Main function
main() {
    # Detect environment and root
    detect_environment
    check_root
    
    # Show logo
    print_logo
    
    # Check for nmap
    echo -e "${BLUE}Checking dependencies...${NC}"
    if ! command -v nmap >/dev/null 2>&1; then
        echo -e "${RED}ERROR: nmap not installed${NC}"
        echo ""
        if [[ "$IS_TERMUX" == true ]]; then
            echo -e "${YELLOW}To install in Termux:${NC}"
            echo -e "${GREEN}pkg install nmap${NC}"
        else
            echo -e "${YELLOW}To install:${NC}"
            echo -e "${GREEN}sudo apt install nmap${NC}"
        fi
        exit 1
    fi
    echo -e "${GREEN}nmap found${NC}"
    echo ""
    sleep 1
    
    # Check environment and root requirements
    if [[ "$IS_TERMUX" == true ]]; then
        echo -e "${GREEN}Running on Termux (No root required)${NC}"
        USE_ROOT_SCANS=false
    else
        # Kali Linux
        if [[ "$IS_ROOT" == true ]]; then
            echo -e "${GREEN}Running on Kali Linux with root privileges${NC}"
            USE_ROOT_SCANS=true
        else
            echo -e "${RED}ERROR: Kali Linux requires root privileges${NC}"
            echo -e "${YELLOW}Please run with: ${GREEN}sudo $0${NC}"
            exit 1
        fi
    fi
    
    sleep 1
    
    # Show menu and get choice
    while true; do
        clear
        print_logo
        echo -e "${CYAN}===============================================================${NC}"
        echo -e "${YELLOW}SAFETY WARNING${NC}"
        echo -e "${RED}Only scan systems you own or have permission to scan${NC}"
        echo -e "${CYAN}===============================================================${NC}"
        echo ""
        
        if [[ "$USE_ROOT_SCANS" == true ]]; then
            echo -e "${GREEN}KALI LINUX MODE - Root Privileges${NC}"
            echo -e "${BLUE}Select scan type:${NC}"
            echo ""
            echo -e "  ${CYAN}1)${NC}  ${WHITE}SYN Stealth Scan${NC}      ${GREEN}(Fast & stealthy)${NC}"
            echo -e "  ${CYAN}2)${NC}  ${WHITE}Aggressive Scan${NC}       ${GREEN}(Full detection)${NC}"
            echo -e "  ${CYAN}3)${NC}  ${WHITE}UDP Scan${NC}              ${GREEN}(UDP ports)${NC}"
            echo -e "  ${CYAN}4)${NC}  ${WHITE}OS Detection${NC}          ${GREEN}(Fingerprint OS)${NC}"
            echo -e "  ${CYAN}5)${NC}  ${WHITE}Full Stealth Scan${NC}     ${GREEN}(All ports)${NC}"
            echo -e "  ${CYAN}6)${NC}  ${WHITE}ACK Scan${NC}              ${GREEN}(Firewall detection)${NC}"
            echo -e "  ${CYAN}7)${NC}  ${WHITE}FIN Scan${NC}              ${GREEN}(Stealthy)${NC}"
            echo -e "  ${CYAN}8)${NC}  ${WHITE}Service Detection${NC}     ${GREEN}(Version detection)${NC}"
            echo -e "  ${CYAN}9)${NC}  ${WHITE}Vulnerability Scan${NC}    ${GREEN}(Security check)${NC}"
            echo -e "  ${CYAN}10)${NC} ${WHITE}Custom Ports${NC}          ${GREEN}(Specify ports)${NC}"
            echo -e "  ${CYAN}11)${NC} ${WHITE}Ping Sweep${NC}            ${GREEN}(Network discovery)${NC}"
            echo -e "  ${RED}0)${NC}  ${WHITE}Exit${NC}"
            echo ""
            echo -ne "${BLUE}Your choice [0-11]: ${NC}"
            read -r choice
            
            case "$choice" in
                0|1|2|3|4|5|6|7|8|9|10|11)
                    break
                    ;;
                *)
                    echo ""
                    echo -e "${RED}ERROR: Invalid selection. Please choose 0-11${NC}"
                    sleep 2
                    ;;
            esac
        else
            echo -e "${GREEN}TERMUX MODE - No Root Required${NC}"
            echo -e "${BLUE}Select scan type:${NC}"
            echo ""
            echo -e "  ${CYAN}1)${NC} ${WHITE}Quick Scan${NC}           ${GREEN}(Recommended)${NC}"
            echo -e "  ${CYAN}2)${NC} ${WHITE}Full TCP Scan${NC}        ${GREEN}(All ports)${NC}"
            echo -e "  ${CYAN}3)${NC} ${WHITE}Service Detection${NC}    ${GREEN}(Version detection)${NC}"
            echo -e "  ${CYAN}4)${NC} ${WHITE}Top 1000 Ports${NC}       ${GREEN}(Fast)${NC}"
            echo -e "  ${CYAN}5)${NC} ${WHITE}Custom Ports${NC}         ${GREEN}(Specify ports)${NC}"
            echo -e "  ${CYAN}6)${NC} ${WHITE}Script Scan${NC}          ${GREEN}(NSE scripts)${NC}"
            echo -e "  ${CYAN}7)${NC} ${WHITE}Host Discovery${NC}       ${GREEN}(Find hosts)${NC}"
            echo -e "  ${RED}0)${NC} ${WHITE}Exit${NC}"
            echo ""
            echo -ne "${BLUE}Your choice [0-7]: ${NC}"
            read -r choice
            
            case "$choice" in
                0|1|2|3|4|5|6|7)
                    break
                    ;;
                *)
                    echo ""
                    echo -e "${RED}ERROR: Invalid selection. Please choose 0-7${NC}"
                    sleep 2
                    ;;
            esac
        fi
    done
    
    # Exit if user chose 0
    if [[ "$choice" == "0" ]]; then
        echo -e "${CYAN}Goodbye!${NC}"
        exit 0
    fi
    
    # Get target
    echo ""
    echo -e "${BLUE}Enter target IP or CIDR:${NC}"
    echo -e "${CYAN}Examples:${NC}"
    echo -e "  - Single IP: ${WHITE}192.168.1.1${NC}"
    echo -e "  - Network: ${WHITE}192.168.1.0/24${NC}"
    echo -e "  - Range: ${WHITE}192.168.1.1-50${NC}"
    echo ""
    echo -ne "${BLUE}Target: ${NC}"
    read -r target
    
    if ! validate_target "$target"; then
        echo -e "${RED}ERROR: Invalid format${NC}"
        exit 1
    fi
    
    # Get output format with validation
    while true; do
        echo ""
        echo -e "${BLUE}Output format:${NC}"
        echo -e "  ${CYAN}1)${NC} ${WHITE}Normal Text${NC}    ${GREEN}(Easy to read)${NC}"
        echo -e "  ${CYAN}2)${NC} ${WHITE}Grepable${NC}       ${GREEN}(For parsing)${NC}"
        echo -e "  ${CYAN}3)${NC} ${WHITE}XML${NC}            ${GREEN}(For tools)${NC}"
        echo -ne "${BLUE}Choice [1-3]: ${NC}"
        read -r format_choice
        
        # إزالة المسافات
        format_choice=$(echo "$format_choice" | tr -d '[:space:]')
        
        case "$format_choice" in
            1) 
                output_format="normal"
                break
                ;;
            2) 
                output_format="grepable"
                break
                ;;
            3) 
                output_format="xml"
                break
                ;;
            *) 
                echo ""
                echo -e "${RED}ERROR: Invalid selection. Please choose 1, 2, or 3${NC}"
                sleep 1
                ;;
        esac
    done
    
    # Create results directory
    mkdir -p "$RESULTS_DIR"
    
    # Generate timestamp and output filename
    timestamp=$(date +%Y%m%d_%H%M%S)
    output_file="$RESULTS_DIR/scan_${timestamp}"
    
    # Build nmap command based on environment and choice
    nmap_cmd="nmap"
    scan_name=""
    
    if [[ "$USE_ROOT_SCANS" == true ]]; then
        # Kali Linux with root - full capabilities
        case "$choice" in
            1)
                nmap_cmd="$nmap_cmd -sS -T4 -F"
                scan_name="SYN Stealth Scan"
                ;;
            2)
                nmap_cmd="$nmap_cmd -A -T4"
                scan_name="Aggressive Scan"
                ;;
            3)
                nmap_cmd="$nmap_cmd -sU --top-ports 100"
                scan_name="UDP Scan"
                ;;
            4)
                nmap_cmd="$nmap_cmd -O"
                scan_name="OS Detection"
                ;;
            5)
                nmap_cmd="$nmap_cmd -sS -p-"
                scan_name="Full Stealth Scan"
                ;;
            6)
                nmap_cmd="$nmap_cmd -sA -T4"
                scan_name="ACK Scan"
                ;;
            7)
                nmap_cmd="$nmap_cmd -sF -T4"
                scan_name="FIN Scan"
                ;;
            8)
                nmap_cmd="$nmap_cmd -sV -T4"
                scan_name="Service Detection"
                ;;
            9)
                nmap_cmd="$nmap_cmd -sV --script vuln"
                scan_name="Vulnerability Scan"
                ;;
            10)
                echo ""
                echo -e "${BLUE}Enter ports (comma-separated):${NC}"
                echo -e "${CYAN}Examples: ${WHITE}80,443${NC} or ${WHITE}20-25,80,443,8080${NC}"
                echo -ne "${BLUE}Ports: ${NC}"
                read -r ports
                if [[ -z "$ports" ]]; then
                    echo -e "${RED}ERROR: No ports specified${NC}"
                    exit 1
                fi
                nmap_cmd="$nmap_cmd -sS -p $ports"
                scan_name="Custom Ports Scan"
                ;;
            11)
                nmap_cmd="$nmap_cmd -sn"
                scan_name="Ping Sweep"
                ;;
        esac
    else
        # Termux without root - TCP connect scans only
        case "$choice" in
            1)
                nmap_cmd="$nmap_cmd -sT -T4 -F"
                scan_name="Quick Scan"
                ;;
            2)
                nmap_cmd="$nmap_cmd -sT -p-"
                scan_name="Full TCP Scan"
                ;;
            3)
                nmap_cmd="$nmap_cmd -sT -sV -T4"
                scan_name="Service Detection"
                ;;
            4)
                nmap_cmd="$nmap_cmd -sT --top-ports 1000"
                scan_name="Top 1000 Ports"
                ;;
            5)
                echo ""
                echo -e "${BLUE}Enter ports (comma-separated):${NC}"
                echo -e "${CYAN}Examples: ${WHITE}80,443${NC} or ${WHITE}20-25,80,443,8080${NC}"
                echo -ne "${BLUE}Ports: ${NC}"
                read -r ports
                if [[ -z "$ports" ]]; then
                    echo -e "${RED}ERROR: No ports specified${NC}"
                    exit 1
                fi
                nmap_cmd="$nmap_cmd -sT -p $ports"
                scan_name="Custom Ports Scan"
                ;;
            6)
                nmap_cmd="$nmap_cmd -sT -sC"
                scan_name="Script Scan"
                ;;
            7)
                nmap_cmd="$nmap_cmd -sT -Pn --top-ports 10"
                scan_name="Host Discovery"
                ;;
        esac
    fi
    
    # Add output format
    case "$output_format" in
        grepable)
            nmap_cmd="$nmap_cmd -oG ${output_file}.gnmap"
            output_file="${output_file}.gnmap"
            ;;
        xml)
            nmap_cmd="$nmap_cmd -oX ${output_file}.xml"
            output_file="${output_file}.xml"
            ;;
        *)
            nmap_cmd="$nmap_cmd -oN ${output_file}.txt"
            output_file="${output_file}.txt"
            ;;
    esac
    
    # Add target
    nmap_cmd="$nmap_cmd $target"
    
    # Execute scan
    echo ""
    echo -e "${CYAN}===============================================================${NC}"
    echo -e "${BLUE}Scan Type:${NC} ${WHITE}$scan_name${NC}"
    echo -e "${BLUE}Target:${NC} ${WHITE}$target${NC}"
    echo -e "${BLUE}Output:${NC} ${WHITE}$output_file${NC}"
    echo -e "${CYAN}===============================================================${NC}"
    echo -e "${BLUE}Executing:${NC} ${GREEN}$nmap_cmd${NC}"
    echo -e "${CYAN}===============================================================${NC}"
    echo ""
    
    # Run scan
    if eval "$nmap_cmd"; then
        echo ""
        echo -e "${GREEN}✓ Scan completed successfully!${NC}"
        echo -e "${BLUE}Results saved to:${NC} ${CYAN}$output_file${NC}"
        echo ""
        
        # Show file location info
        if [[ "$IS_TERMUX" == true ]]; then
            echo -e "${YELLOW}File Location:${NC}"
            echo -e "  ${WHITE}$output_file${NC}"
            echo -e "${YELLOW}Access in file manager or use:${NC}"
            echo -e "  ${GREEN}cat $output_file${NC}"
        fi
        
        echo ""
        echo -e "${CYAN}===============================================================${NC}"
        echo -e "${WHITE}Thank you for using MurjadScan!${NC}"
        echo -e "${CYAN}===============================================================${NC}"
    else
        echo ""
        echo -e "${RED}✗ Scan failed or interrupted${NC}"
        exit 1
    fi
}

# Run main function
main
