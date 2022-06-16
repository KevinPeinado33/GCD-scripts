------------------------------------- archivo monitor.sh pc1 crontab linux ver conf, tareas 
#!/bin/bash

echo "Variable recibida -> " $1
echo "[Info] iniciando ... "

touch backup/backup-$1.txt

while true
do
	#limpiamos el archivo 	
	cat /dev/null > backup/backup-$1.txt
	
	echo "---------------" >> backup/backup-$1.txt
	
	date >> backup/backup-$1.txt
	
	free -h | grep -wi "Mem" >> backup/backup-$1.txt
	
	df -h | grep -wi "/dev/mapper/ubuntu--vg-ubuntu--lv" >> backup/backup-$1.txt
	
	sleep 2
	
	echo "[Info] volviendo a ejecutar resultados ..."

	cd backup
	sshpass -p '123456' scp backup-$1.txt qbin@172.17.8.39:/GCD/backup
	echo 123456
	cd ..
done

-- ejecutamos el script
bash monitor.sh pc-1


----------------------------------- archivo monitorserv.sh
#!/bin/bash

# el servidor solo se apagara cuando lo hagamos manual
while true
do

	#validamos si el directorio tiene contenido
	if [ -z "$(ls -A backup)" ];
	then	
		echo "Directorio vacio"
	else
		
		cd backup
		
		# leemos los archivos de la carpeta backup
		for file in $(ls -alh | grep backup | awk '{print $9}'); 
		do 
			echo " "
			echo "[Archivo] imprimiendo archivo $file"
			cat $file; 
		done
		
		echo "----------------------------------"
		
		cd ..
		
	fi

done


bash monitor.sh pc1
bash monitor.sh pc2
bash monitor.sh pc3
bash monitor.sh pc4

----- organizar archivos monitorInfo.sh memoria/ disco
#!/bin/bash

# el servidor solo se apagara cuando lo hagamos manual
while true
do

	tipoInfo = "info"
	
	#asignamos el valor del tipo dato
	if [[ $1 == "memoria" ]];
	then
	
		$tipoInfo = "memoria"
	
	elif [[ $1 == "disco" ]]
	then
		$tipoInfo = "disco"
	fi
	
	echo "Estamos imprimiendo información de => "$tipoInfo
	echo " "
	
	#validamos si el directorio tiene contenido
	if [ -z "$(ls -A backup)" ];
	then	
		echo "Directorio vacio"
	else
		
		cd backup
		
		# leemos los archivos de la carpeta backup
		for file in $(ls -alh | grep backup | awk '{print $9}'); 
		do 
			echo " "
			echo "[Archivo] imprimiendo archivo $file"
			cat $file; 
		done
		
		echo "----------------------------------"
		
		cd ..
		
	fi

done