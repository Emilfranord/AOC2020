import java.util.Collections;
String[] inp;
ArrayList<Integer> numbers;

void setup() {
  inp = loadStrings("input.txt");

  Integer[] temp = {0, 3, 6};
  numbers = new ArrayList<Integer>();
  for (Integer q : temp) {
    numbers.add(q);
  }
  printArray(numbers);
  for (int i = numbers.size(); i<10; i++) {
    //println(i-1);
    numbers.add(nextNumber(numbers.get(i-1), numbers));
  }
  //println(numbers.get(2019));
  //println(numbers.get(2020));
  //println(numbers.get(2021));
  printArray(numbers);
}





int nextNumber(Integer current, ArrayList<Integer> list) {
  //print(current + " ");
  //println(list.indexOf(current));
  if ((list.indexOf(current) ==(list.size()-1))) {
    return 0;
    
  } else {
    println(current);
    printArray(list);
    return abs(secondLastIndexOf(current, list) - list.lastIndexOf(current));
    
  }

  //println("Error");
  //return -1;
}


int secondLastIndexOf(Integer cur, ArrayList<Integer> li) {
  ArrayList<Integer> indexes = new ArrayList<Integer>();

  for (int i = 0; i <li.size(); i++) {
    if (li.get(i) == cur) {
      indexes.add(i);
    }
  }
  //printArray(indexes);
  return li.get(li.size()-2);
}
