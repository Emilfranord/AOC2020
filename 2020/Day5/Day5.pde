String[] inp;

void setup() {
  inp = loadStrings("input.txt");
  println(maxSeatID(inp));
  println(mySeatID(inp));
  //tester();
}

void draw() {
}

void tester() {
  println(seatID("FBFBBFFRLR"));
  println(seatID("BFFFBBFRRR"));
  println(seatID("FFFBBBFRRR"));
  println(seatID("BBFFBBFRLL"));
}

int maxSeatID(String[] inp) {
  int max = 0;

  for (String q : inp) {
    if (seatID(q) > max) {
      max = seatID(q);
    }
  }
  return max;
}

int mySeatID(String[] inp) {
  int[] IDs = new int[inp.length];

  for (int i= 0; i<inp.length; i++) {
    IDs[i] = seatID(inp[i]);
  }
  
  IDs = sort(IDs);
  
  for(int i= 0; i<inp.length; i++){
    if(IDs[i] +2 == IDs[i+1]) {
      return IDs[i]+1;
    }
  }
  return 0;
}

int seatID(String inp) {
  // step one: row
  int intervalUpper = 127;
  int intervalLower = 0;

  for (int i = 0; i<7; i++) {
    if (inp.charAt(i) =='F') {
      intervalUpper -= ceil((intervalUpper - intervalLower)/2.0);
    }
    if (inp.charAt(i) =='B') {
      intervalLower += ceil((intervalUpper - intervalLower)/2.0);
    }
  }

  int row = intervalUpper;

  int intervalRight = 7;
  int intervalLeft = 0;

  for (int i = 7; i<10; i++) {
    if (inp.charAt(i) =='L') {
      intervalRight -= ceil((intervalRight - intervalLeft)/2.0);
    }
    if (inp.charAt(i) =='R') {
      intervalLeft += ceil((intervalRight - intervalLeft)/2.0);
    }
  }

  int col = intervalLeft;


  return row * 8 + col;
}
