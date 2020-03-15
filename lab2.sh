handler()
{
sig_count=`expr $sig_count + 1`		
#увеличиваем счетчик на 1 (expr вычисляет арифметическое выражение)

if [ $sig_count -eq 1 -a $flag1 -eq 1 ]
#[] или test - проверка выражения, -а - логическое и
then echo Прерывание 1: `wc < $name1`
#во время прерывания происходит подстановка результата выполнения команды (``)
#echo - команда вывода
fi

if [ $sig_count -eq 1 -a $flag1 -eq 0 ]
then echo "Прерывание 1. Файл 1 не введен. Введите название файла 1:"
fi

if [ $sig_count -eq 2 -a $flag2 -eq 1 ]
then echo Прерывание 2: `wc < $name2` 
fi

if [ $sig_count -eq 2 -a $flag2 -eq 0 ]
then echo "Прерывание 2. Файл 2 не введен"
fi

if [ $sig_count -ge 2 ]
then echo "Конец программы"
exit 1
fi
}

trap "handler" SIGINT	
#устанавливаем обработчик прерывания (мб 2)

sig_count=0	
#счетчик прерываний

flag1=0
flag2=0		
#задаем флаг для того, чтобы определить было ли считано название	
echo "Введите название файла 1:"
read name1	
#считываем название файла
while ! [ -f "$name1" ]
do
echo "Файл 1 не существует, введите заново:"
read name1
done
flag1=1		
#изменяем флаг, тк файл считан

echo "Введите название файла 2:"
read name2
while ! [ -f "$name2" ]
do
echo "Файл 2 не существует, введите заново:"
read name2
done 
flag2=1

echo Результат выполнения: `cat $name1 $name2 | wc`	
#передаем объединенный файл через межпроцессный канал в параллельный процесс
sleep 5
sleep 5