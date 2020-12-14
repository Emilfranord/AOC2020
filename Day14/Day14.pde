import java.util.*;
String[] inp;
Hashtable<Integer, Long> hash;
void setup() {
  inp = loadStrings("input.txt");
  hash = new Hashtable<Integer, Long>();

  //println(applyMask("XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X", 0));
  // println();

  println(initialization(inp));
}

long applyMask(String mask, long number) {
  String strRep = Long.toBinaryString(number);
  char[] temp = new char[36];

  for (int i = 0; i<temp.length; i++) {
    temp[i] = '0';
  }

  int index = strRep.length()-1;
  for (int i = temp.length - 1; i >= 0 && index >=0; i--) {
    temp[i] = strRep.charAt(index);
    index --;
  }

  for (int i = 0; i<mask.length(); i++) {
    if (mask.charAt(i) == 'X') {
    }

    if (mask.charAt(i) == '0') {
      temp[i] = '0';
    }

    if (mask.charAt(i) == '1') {
      temp[i] = '1';
    }
  }

  return Long.parseLong(new String(temp), 2);
}

long initialization(String[] inp) {

  String mask = "";

  for (String q : inp) {
    String[] spl = q.split(" = ");
    //printArray(spl);

    if (spl[0].contains("mask")) {
      mask = spl[1];
    }

    if (spl[0].contains("mem")) {
      int adress;
      String sub = spl[0].substring(4, spl[0].length()-1);
      //println(sub);
      adress  = Integer.parseInt(sub);

      long num = Long.parseLong(spl[1]);
      hash.put(adress, applyMask(mask, num));
    }
  }
  return sum(hash);
}


long sum(Hashtable<Integer, Long> hashTable) {
  long count = 0; 

  Set<Integer> counts = hashTable.keySet();
  //Iterator<Integer> iterator = counts.iterator();

  for (Integer q : counts) {

    count += hashTable.get(q);
  }


  return count;
}
