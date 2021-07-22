a=10
echo ${a}
b=
echo a = $(b)
DATE=$(date +%D)
echo -e "today date is ${DATE}"
readonly b
unset b
echo ${b}