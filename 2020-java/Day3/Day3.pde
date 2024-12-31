String[] inp;

void setup() {
  inp = loadStrings("input.txt");

  println(treeAmount(inp, 3, 1));
  println(treeMulti());

  tester();
}

void draw() {
}

void tester() {
}


int treeAmount(String[] inp, int deltaRight, int deltaDown) {
  int count = 0;
  int right =0;
  int down =0;

  while (down < inp.length-1) {
    right += deltaRight;
    if (right >= inp[0].length()) {
      right -= inp[0].length(); // perhaps remove one more
    }
    down+= deltaDown;

    //println(right);
    if (inp[down].charAt(right) == '#') {
      count++;
    }
  }

  return count;
}



int treeMulti() {


  println(treeAmount(inp, 1, 1), treeAmount(inp, 3, 1), treeAmount(inp, 5, 1), treeAmount(inp, 7, 1), treeAmount(inp, 1, 2));


  return treeAmount(inp, 1, 1)* treeAmount(inp, 3, 1)*treeAmount(inp, 5, 1)*treeAmount(inp, 7, 1)*treeAmount(inp, 1, 2);
}
