String[] load; //= {"1-3 a: abcde","1-3 b: cdefg", "2-9 c: ccccccccc"};
void setup() {
  load = loadStrings("t.txt");

  tester();
}

void draw() {
}

void tester() {
  int count =0;
  for (String q : load) {
    Password p = new Password(q);

    if (p.isValidTwo()) {
      count++;
    }
  }
  println(count);
}


class Password {

  Password(String inp) {
    //// LLLL-HHHHH C: SSSSSSSSSS
    
    int colonIndex = inp.indexOf(":");
    this.search = inp.charAt(colonIndex-1);
    this.word = inp.substring(colonIndex+1);
    
    int dashIndex = inp.indexOf("-");
    
    String lowS =  inp.substring(0, dashIndex);
    this.low = Integer.parseInt(lowS);
    
    String hiS = inp.substring(dashIndex+1, colonIndex-2);
    this.hi = Integer.parseInt(hiS);
    
    
  }


  int low;
  int hi;
  char search;

  String word;



  boolean isValid() {
    char[] temp = word.toCharArray();
    int count = 0;
    for (char q : temp) {
      if (q == search) {
        count++;
      }
    }
    return count >=low && count <= hi;
  }
  
  
   boolean isValidTwo() {
    char[] temp = word.toCharArray();
    int count= 0;
    if(temp[low] == search){count++;}
    if(temp[hi] == search){count++;}
    
    return count == 1;
   }
}
