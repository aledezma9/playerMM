#!/usr/bin/env bash

echo ""
echo "==========================================="
echo "Bienvenido a playerMM script de instalacion"
echo "El script requiere "sudo en algun punto", para instalar php5-cli"
echo "De todos modos, puede instalar todo manualmente siguiendo los pasos en"
echo "https://github.com/aledezma9/playerMM"
echo "Se instalara la ultima version estable para usted"
echo "Si desea la ultima actualizacion debe hacerlo manualmente"
echo "Deseas continuar? [y/n]"

read p
echo ""

if [ "$p" != "y" ] && [ "$p" != "Y" ] ; then
    echo "Aborted"
    exit 1
fi


echo ""
echo "==========================================="
echo "playerMMse ejecuta con la interfaz de línea de comandos php"
echo "No se requiere ni se recomienda un servidor web separado"
echo "Tal vez tengas algunos errores debido a paquetes no existentes, solo ignóralo"
echo "Quieres instalar php-cli now (sudo)? [y/n]"

read p
echo ""

if [ "$p" = "y" ] || [ "$p" = "Y" ] ; then
    sudo apt-get install -qq -y php-cli
    sudo apt-get install -qq -y php-mbstring
    sudo apt-get install -qq -y php5-cli
    sudo apt-get install -qq -y php5-mbstring
fi


echo ""
echo "==========================================="
echo "playerMM corre como un php-cli Servidor, que requiere definir un puerto."
echo "El puerto por default es 4321"
echo "Déjelo vacío si mantiene el valor predeterminado o lo cambia a un número que desee"

read p
echo ""

port=4321
if [ "$p" != "" ] ; then
    port=$p
fi

echo ""
echo "==========================================="
echo "Descargando y desempaquetando playerMM al disco"
echo "Elija la ruta del directorio, por defecto: ~/playerMM"
echo "Déjalo vacío si te quedas con el predeterminado"
echo "El directorio dado debe estar vacío o no existente"

read p
echo ""

path=~/playerMM
if [ "$p" != "" ] ; then
    path=$p
fi

if [ ! -d "$path" ] ; then
    mkdir $path
fi

mkdir "$path/tmp"

cd $path
wget https://raw.githubusercontent.com/aledezma9/playerMM/master/updater.php
php -f updater.php
chmod +x *.sh

echo ""
echo "==========================================="
echo "Habilitar inicio automático para el playerMM server"
echo "Esto agregará una nueva entrada a crontab."
echo "¿Quieres habilitar el inicio automático ahora?? [y/n]"

read p
echo ""

if [ "$p" = "y" ] || [ "$p" = "Y" ] ; then
    (crontab -l 2>/dev/null; echo "@reboot php -S 0.0.0.0:$port -t $path > /dev/null 2>&1 &") | crontab -
fi

echo ""
echo "==========================================="
echo "Iniciar el servidor playerMM ahora? [y/n]"

read p
echo ""

if [ "$p" = "y" ] || [ "$p" = "Y" ] ; then
    `php -S 0.0.0.0:$port -t $path > /dev/null 2>&1 &`
fi

echo ""
echo "==========================================="
echo "Todos los archivos han sido instalados!"
echo "Abra http: // iptoyourpi: $ port en su navegador"
echo "Diviértete con esta aplicación. Usted es maravilloso."
