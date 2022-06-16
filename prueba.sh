#!/bin/bash

# cramos variable pa mostrar la info mas adelante
tipoInfo=''

#asignamos el valor del tipo dato
if [[ $1 == "memoria" ]];
then	
    tipoInfo="Mem"
elif [[ $1 == "disco" ]]
then
    tipoInfo="/dev/mapper/ubuntu--vg-ubuntu--lv"
fi

echo "Estamos revisando la => "$1

# el servidor solo se apagara cuando lo hagamos manual
while true
do
	
	#validamos si el directorio tiene contenido
	if [ -z "$(ls -A backup)" ];
	then	
		echo "Directorio vacio"
	else
		
		cd backup
		
		#creamos una variable que va a concatenar		
        #capturamos la fecha
        info+="$(date) => "
		
        # leemos los archivos de la carpeta backup
		for file in $(ls -alh | grep backup | awk '{print $9}'); 
		do 
			info+="$(grep $tipoInfo $file) \t"
		done
	
		cd ..

        # le damos la info con el salto de linea
        echo -e "\n" $info 
        
        # limpiamos otra vez para la nueva impresion
        info=""
        
        sleep 2
		
	fi

done