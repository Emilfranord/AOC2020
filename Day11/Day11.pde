import java.util.*;
String[] inp;
char[][] inpc;

void setup() {
  inp = loadStrings("input.txt");
  inpc = changeFormat(inp);

  for (int i = 0; i<10; i++ ) {
    inpc = nextRound(inpc);
    println(countSeats(inpc));
  }
  
  //println("There are this many seats: "+countSeats(inpc));
}

char[][] changeFormat(String[] inp) {
  char[][] temp = new char[inp.length][inp[0].length() ];

  for (int i  = 0; i<inp.length; i++) {
    for (int j = 0; j<inp[0].length(); j++) {
      temp[i][j] = inp[i].charAt(j);
    }
  }
  print(temp[3][5]);
  return temp;
}

char[][] nextRound(char[][] inp ) {
  char[][] temp = new char[inp.length][inp[0].length];

  //for all elements in temp
  //find the amount of occupied seats adjacent in inp
  //change temp based on that information

  for (int i  = 0; i<inp.length; i++) {
    for (int j = 0; j<inp[0].length; j++) {
      if (inp[i][j] != '.') {

        int adj = countAdjacent(inp, i, j);

        if (adj == 0 && inp[i][j] == 'L') {
          temp[i][j] = '#';
        }

        if (adj >= 4 && inp[i][j] == '#') {
          temp[i][j] = 'L';
        }
      }
    }
  }

  return temp;
}

int countAdjacent(char[][] inp, int i, int j) {
  int count = 0;

  if (i!=0 && j!=0) {
    if (inp[i-1][j-1] == '#') {
      count++;
    }
  }

  if (j!=0) {
    if (inp[i][j-1]== '#') {
      count++;
    }
  }

  if (i!= inp.length-1 && j!=0) {
    if (inp[i+1][j-1]== '#') {
      count++;
    }
  }

  if (i!=0) {
    if (inp[i-1][j]== '#') {
      count++;
    }
  }

  if (i!= inp.length-1) {
    if (inp[i+1][j]== '#') {
      count++;
    }
  }

  if (i!=0 && j!= inp.length-1) {// changed from 2
    if (inp[i-1][j+1]== '#') {
      count++;
    }
  }

  if (j!= inp.length-1) { // changed from 2
    if (inp[i][j+1]== '#') {
      count++;
    }
  }

  if (i!= inp.length-1 && j!= inp.length-1) {
    if (inp[i+1][j+1]== '#') {
      count++;
    }
  }
  return count;
}


int countSeats(char[][] inp) {
  int count = 0; 
  //println(inp.length, inp[0].length);

  for (int i = 0; i<inp.length; i++) {
    for (int j = 0; j<inp[0].length; j++) {
      if (inp[i][j] == '#') {
        count++;
      }
    }
  }


  return count;
}
