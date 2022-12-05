import java.util.Collections;
String[] inp;
ArrayList<Integer> numbers;

void setup() {
  inp = loadStrings("input.txt");

  Integer[] temp = {1, 3, 2};


  numbers = new ArrayList<Integer>();
  for (Integer q : temp) {
    numbers.add(q);
  }

  for (int i = numbers.size()-1; i<2030; i++) {
    numbers.add(nextNumber(numbers.get(i), numbers));
    //printArray(numbers);
  }
  printArray(numbers);
  println(numbers.get(2020));
  println(numbers.get(2021));
}

Integer nextNumber(Integer current, ArrayList<Integer> list) {
  //printArray(list);
  if (list.lastIndexOf(current) == list.indexOf(current) && list.indexOf(current) != -1) {
    // ther is only one entry with the number.
    return 0;
  } else {
    //println(list.size(), "-", secondLastIndexOf(current, list));
    return list.size() -  secondLastIndexOf(current, list);
  }
}

int secondLastIndexOf(Integer cur, ArrayList<Integer> li) {
  ArrayList<Integer> indexes = new ArrayList<Integer>();
  
  Collections.reverse(li);
  
  for (int i = 0; i<li.size(); i++) {
    // TODO: write this
    
  }

  //println(indexes.get(0)-indexes.get(1));
  return indexes.get(1)+1;
  
}
