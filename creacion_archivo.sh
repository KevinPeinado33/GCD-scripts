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

	sshpass -p '123' scp backup/backup-$1.txt user@172.17.8.35:/home/user/prueba

done