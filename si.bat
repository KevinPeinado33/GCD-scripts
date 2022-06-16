----- organizar archivos monitorInfo.sh memoria / disco
#!/bin/bash

# el servidor solo se apagara cuando lo hagamos manual
while true
do

	tipoInfo = "info"
	
	#asignamos el valor del tipo dato
	if [[ $1 == "memoria" ]];
	then
	
		$tipoInfo = "Mem"
	
	elif [[ $1 == "disco" ]]
	then
		$tipoInfo = "/dev/mapper/ubuntu--vg-ubuntu--lv"
	fi
	
	echo "Estamos imprimiendo información de => "$tipoInfo
	echo " "
	
	#validamos si el directorio tiene contenido
	if [ -z "$(ls -A backup)" ];
	then	
		echo "Directorio vacio"
	else
		
		cd backup
		
		#creamos una variable que va a concatenar
		info = "$1 => "
		
		# leemos los archivos de la carpeta backup
		for file in $(ls -alh | grep backup | awk '{print $9}'); 
		do 
			$info += grep $tipoInfo $file; 
		done
		
		echo "----------------------------------"
		
		cd ..
		
	fi

done