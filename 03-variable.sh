a=10
echo ${a}
b=20
echo a = $(FALSE)
DATE=$(date +%D)
echo -e "today date is ${DATE}"
readonly b
unset b
echo ${b}