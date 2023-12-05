#!/bin/bash

# Verificar si el usuario tiene privilegios de administrador
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run with administrator privileges (sudo)." 1>&2
   exit 1
fi

# Verificar el estado actual del servicio CUPS
if systemctl is-active --quiet cups; then
    current_status="enabled"
else
    current_status="disabled"
fi

# Mostrar el estado actual del servicio
echo "Current status of CUPS service: $current_status"

# Determinar la acción a realizar
if [ "$current_status" == "enabled" ]; then
    read -p "Do you want to disable the CUPS service? (y/n): " answer
    if [ "$answer" == "y" ]; then
        echo "Disabling the CUPS service..."
        systemctl stop cups
        systemctl disable cups
        echo "The CUPS service has been disabled."
    else
        echo "No changes made. The CUPS service remains enabled."
    fi
else
    read -p "Do you want to enable the CUPS service? (y/n): " answer
    if [ "$answer" == "y" ]; then
        echo "Enabling the CUPS service..."
        systemctl enable cups
        systemctl start cups
        echo "The CUPS service has been enabled."
    else
        echo "No changes made. The CUPS service remains disabled."
    fi
fi

# Mostrar mensaje de salida
read -p "Press Enter to exit..."
