import java.util.Collections;
String[] inp;
ArrayList<Integer> numbers;

void setup() {
  inp = loadStrings("input.txt");

  Integer[] temp = {3,1,2};
  numbers = new ArrayList<Integer>();
  for (Integer q : temp) {
    numbers.add(q);
  }
  //printArray(numbers);
  for (int i = numbers.size(); i<2030; i++) {

    numbers.add(nextNumber(numbers.get(i-1), numbers));
    //printArray(numbers);
  }
  printArray(numbers);
  println(numbers.get(2020));
}

Integer nextNumber(Integer current, ArrayList<Integer> list) {
  if ((list.indexOf(current) == (list.size()-1)) && list.lastIndexOf(current) == (list.size()-1) ) {
    return 0;
  } else {

    return list.lastIndexOf(current) - secondLastIndexOf(current, list);
  }
}


int secondLastIndexOf(Integer cur, ArrayList<Integer> li) {
  ArrayList<Integer> indexes = new ArrayList<Integer>();

  for (int i = li.size()-1; i >= 0; i--) {
    if (li.get(i) == cur) {
      indexes.add(i);
    }
    if (indexes.size() >=3) {
      break;
    }
  }

  //printArray(indexes);
  if (indexes.size() == 1) {
    return 0;
  }

  println(indexes.get(0)-indexes.get(1));
  return indexes.get(1);
}
