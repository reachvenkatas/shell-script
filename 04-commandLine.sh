sample() {
  echo -e "i am in the function\n"
  a=10
  echo -e "values of a=$a, b=$b, $* \n"
  b=100
  echo -e "values of a=$a, b=$b, $* \n"

}

b=20
echo -e "i am in the main function\n"
echo -e "values of a=${a}, b=$b, $* \n"
sample ABC
a=100
echo -e "values of a=$a, b=$b, $* \n"