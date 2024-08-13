#!/bin/bash

#   Author      :       Tkemza

#   Github      :       https://github.com/tkemza

#   Discord     :       n11kol1c

#   MIT LICENSE :       (C) 2024 tkemza 

#   About Tool  :       Made for new Linux users for easier usage and downloading pkgs > More about > README.md

function reset_color() {
    # Reset color 
	tput sgr0   # reset attributes
	tput op     # reset color
	return      # return attribute
}

function colors() {
    ## ANSI colors (FG & BG)
    RED="$(printf '\033[31m')"  
    GREY="$(printf '\033[2;37m')"
    DARKGREEN="$(printf '\033[2;32m')"
    YELLOW="$(printf '\033[1;33m')"
    GREEN="$(printf '\033[32m')"  
    ORANGE="$(printf '\033[33m')"  
    BLUE="$(printf '\033[34m')"
    MAGENTA="$(printf '\033[35m')"  
    CYAN="$(printf '\033[36m')"  
    WHITE="$(printf '\033[37m')" 
    BLACK="$(printf '\033[30m')"
    REDBG="$(printf '\033[41m')"  
    GREENBG="$(printf '\033[42m')"  
    ORANGEBG="$(printf '\033[43m')"  
    BLUEBG="$(printf '\033[44m')"
    MAGENTABG="$(printf '\033[45m')"  
    CYANBG="$(printf '\033[46m')"  
    WHITEBG="$(printf '\033[47m')" 
    BLACKBG="$(printf '\033[40m')"
    RESETBG="$(printf '\e[0m\n')" # Color reset
    RESET="$(printf '\033[0m')" # Reset
}

function textAttributes() {
    ## ANSI Attributes
    BOLD="$(printf '\033[1m')"
    ITALIC="$(printf '\033[3m')"
    DIM="$(printf '\033[2m')"
    RESET="$(printf '\033[0m')"
}

function sysUpdate() {
    { colors; reset_color; textAttributes; } # Define colors and reset attributes
    SYSUPDT=1
    if [[ $SYSUPDT -eq 1 ]]; then
        apt-get update -y # System update command
    else
        printf "${RED}[${RESETBG}!${RED}]${RESETBG} System update has been ocurrapted." # Error message
    fi
}

function toolUpdate() {
    { colors; reset_color; textAttributes; } # Define colors and reset attributes
    UPDT=1 # Setting attribute
    __newsr__="https://github.com/tkemza/safepass.git" # Git cloning repository
    if [[ $UPDT -eq 1 ]]; then
        git pull https://github.com/tkemza/safepass.git # Git cloning repository
        sleep 3.5
    fi
}

function mainBanner() {
    { colors; reset_color; textAttributes; }

    cat << "EOF" | lolcat
    
         __        __        ___              
        / _\ __ _ / _| ___  / _ \__ _ ___ ___ 
        \ \ / _` | |_ / _ \/ /_)/ _` / __/ __|
        _\ \ (_| |  _|  __/ ___/ (_| \__ \__ \
        \__/\__,_|_|  \___\/    \__,_|___/___/      
                                      
EOF
}


# Function to check password strength
function checkPass() {
    local password=$1
    local score=0

    # Check length
    if [ ${#password} -ge 8 ]; then
        score=$((score+1))
    fi

    # Check for lowercase letters
    if [[ $password =~ [a-z] ]]; then
        score=$((score+1))
    fi

    # Check for uppercase letters
    if [[ $password =~ [A-Z] ]]; then
        score=$((score+1))
    fi

    # Check for digits
    if [[ $password =~ [0-9] ]]; then
        score=$((score+1))
    fi

    # Check for special characters
    if [[ $password =~ [\!\@\#\$\%\^\&\*\(\)\_\+\-\=\[\]\{\}\;\'\:\"\,\<\.\>\/\?\`\~] ]]; then
        score=$((score+1))
    fi

    # Determine the strength and store it
    local strength=""
    case $score in
        5)
            strength="${GREEN}Very Strong${RESETBG}"
            sleep 1
            ;;
        4)
            strength="${DARKGREEN}Strong${RESETBG}"
            sleep 1
            ;;
        3)
            strength="${YELLOW}Medium${RESETBG}"
            sleep 1
            ;;
        2)
            strength="${ORANGE} Weak${RESETBG}"
            sleep 1
            ;;
        *)
            strength="${RED}Very Weak${RESETBG}"
            sleep 1
            ;;
    esac

    # Display the password strength
    echo -e "${GREY} Password strength: ${strength}${RESET}"
    local dirName="txtauth"  # Define directory name
    sudo mkdir -p "$dirName"  # Create the directory if it doesn't exist
    sudo touch "$dirName/auth.txt"

    # Save password and strength to auth.txt within txtauth directory
    echo "Password: $password" | sudo tee -a "${dirName}/auth.txt" > /dev/null
    echo "Strength: $strength" | sudo tee -a "${dirName}/auth.txt" > /dev/null
    echo "" | sudo tee -a "${dirName}/auth.txt" > /dev/null
    echo "" | sudo tee -a "${dirName}/auth.txt" > /dev/null
    echo "Details saved in ${dirName}/auth.txt"
    sleep 1
    mainMenu
}

function mainMenu() {
    clear
    { colors; reset_color; textAttributes; }
    mainBanner
    echo ""
    read -p " ${DARKGREEN}[${RESETBG}>${DARKGREEN}]${RESETBG} Enter a password that you want to check : " password
    if [[ $password == "" ]]; then
        echo ""
        printf " ${RED}[${RESETBG}!${RED}]${RESETBG} Blank passwords arent allowed."
        echo ""
        sleep 2
        clear
        mainMenu
    elif [[ $password == " " ]]; then
        echo ""
        printf " ${RED}[${RESETBG}!${RED}]${RESETBG} Blank passwords arent allowed."
        echo ""
        sleep 2
        clear
        mainMenu
    else  
        checkPass "$password"
    fi
}

function main() {
    { colors; reset_color; textAttributes; }
    sleep .1
    mainMenu
}

# Main
main