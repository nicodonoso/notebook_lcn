#!/bin/bash
# V0.1 5/julio/2020, instalaciones/desinstalaciones 
#útiles para computadores viejos con esteroides.
#por ndonoso nicolasdonosocastro@gmail.com


# ----------------------------------------------------------------------------
# "LA LICENCIA BEER-WARE" (Versión 42):
# nico donoso escribió este archivo. Siempre y cuando usted mantenga este aviso,
# puede hacer lo que quiera con este programa. Si nos encontramos algún día, y usted piensa
# que esto vale la pena, me puede comprar una cerveza a cambio. Nicolas Donoso
# ----------------------------------------------------------------------------


echo "Electronica LCN sctipt $0"
echo "Instalaciones en notebook nuevos"

display_usage() {
  echo
  echo "Usage: sudo $0"
  echo
  echo " -h, --help   Muestra las instrucciones de uso"
  echo " -t, --todo   Instala todos los software"
  echo " -a, --anydesk Instala el escritorio remoto Anydesk"
  echo " -z, --zoom Instala zoom 64 bit"
  echo " -j, --juegos Instala juegos al compu"
  echo " -v, --veyon Desisntala el programa Veyon"
  echo " -u, --usuario Crea usuario nuevo, preguntando por nombre y password"
  echo " -r, --remmina Elimina remmina del sistema"
}

raise_error() {
  local error_message="$@"
  echo "${error_message}" 1>&2;
}

argument="$1"

if [[ -z $argument ]] ; then
  raise_error "Es necesario dar una argumento a este Script"
  display_usage
else
  case $argument in
    -h|--help)
      display_usage
      ;;
    -t|--todo)
      echo "Instala todo!"
############################################################################################
      echo "Instalando anydesk"
      wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
      echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
      apt update
      apt install anydesk -y
      echo "Prueba anydesk, recuerda anotar la Address"
############################################################################################

      ;;
    -a|--anydesk)
      echo "Instalando anydesk"
      wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
      echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
      apt update
      apt install anydesk -y
      echo "Prueba anydesk, recuerda anotar la Address"
      ;;
     -v|--veyon)
     echo "Desisntalando Veyon"
     apt purge veyon -y
     ;;
     -z|--zoom)
     wget https://zoom.us/client/latest/zoom_amd64.deb
     apt install ./zoom_amd64.deb -y 
     ;;
     -j|--juegos)
     apt install gcompris -y
     apt install tuxpaint -y
     apt install scratch -y
     apt install tuxmath -y
     ;;
     -u|--usuario)
     echo "Creando nuevo usuario, ingrese Nombre: "
     read nombre
     echo "Ingrese Password"
     read clave
     echo "Se creara un usuaro: " $nombre
     echo "Con password: " $clave
     useradd -m $nombre
     echo -e $clave"\n"$clave"\n" | passwd $nombre 
    ;;
    -r|--remmina)
    apt purge remmina -y
    ;;
    *)
      raise_error "Argumento desconocido: ${argument}"
      display_usage
      ;;
  esac
fi

echo "Fin del  Script $0"

