import java.util.*;
String[] inp; 

void setup() {
  inp = loadStrings("input.txt");

  println(partOne(inp));

  tester();
}

void draw() {
}

void tester() {
}


int partOne(String[] inp) {
  ArrayList <String> temp = new ArrayList <String>();
  temp.add("shiny gold");

  for (int z = 0; z<10; z++) {
    for (int i = 0; i<inp.length; i++) {
    inner:
      for (int j =0; j<temp.size(); j++) {
        if (inp[i].contains(temp.get(j))) {
          if (inp[i].indexOf(temp.get(j))!=0) {
            temp.add(getBagColor(inp[i]));
          }
          break inner;
        }
      }
    }
  }

  LinkedHashSet<String> hashSet = new LinkedHashSet<String>(temp);
  println(hashSet);
  return hashSet.size()-1;
}

String getBagColor(String inp) {
  int index = inp.indexOf("bags");
  return inp.substring(0, index);
}
