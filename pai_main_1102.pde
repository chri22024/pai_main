


int[] rec;
boolean one = true;
String numStr = "";
int member1=0;
int member2=0;
int d=0;
int selectRect=1;
char input=' ';

int clickedIndex;

boolean clicked = false;
boolean isClickedNum = false;

boolean isMemberInputed = false; // member1,2が入力完了したかどうか






Staff[] staff;
Pai[] pai;




void setup() {


  size(1000, 800);
  textAlign(CENTER, CENTER);
  textSize(20);
}
void draw() {
  background(255);
  if (isMemberInputed) {      // member1,2が入力完了したあと
    if (one) {
      rec = new int[member1 + 3];
      staff = new Staff[member1 + 3];
      pai = new Pai[member1 + 3];
      initStaff(staff);
      initPai(pai);



      one = false;
    }
    //drawPai();
    
    for(int i = 0; i < pai.length; i ++){
      pai[i].display();
    }


    text(numStr, width / 2, height / 4);
    text("Clicked pai black is '" + clickedIndex + "'", width/2, height * 1/3);
    fill(0);

    // drawPai();

    // textSize(32);
    // text("Press a key:", 100, 100);
    // text(key, 250, 100);
  } else {                      // member1,2が入力されるまでここで待つ
    // println("Input member1 & member2");
  }
}



// パイを表示させる関数
void drawPai() {
  // int[] rec = new int[member1 + 3];
  for (int i=0; i<member1+3; i++) {
    int x=i*d;

    rec[i]=x;
    if (i != member2 && i != member2 + 1 && i != member1 + 2) {
      noFill();
      if (clickedIndex == i) {
        fill(255, 0, 0);
        ellipse(rec[i] + 25, 225, 18, 18);
        noFill();
      }
      if (drawSquare(rec[i], 10, 50, 200)) {
        clickedIndex = i;
      }
      if (i == selectRect) {
        fill(0);
        text(input, rec[i] + 25, 110); // キーボードからの入力を表示
      }
    } else if (i==member2) {
      fill(0, 0, 255); // 青色で先頭のぱいを表す

      if (drawSquare(rec[i], 10, 50, 200)) {
        clickedIndex = i;
      }
      if (clickedIndex == i) {
        fill(255, 0, 0);
        ellipse(rec[i] + 25, 225, 18, 18);
        noFill();
      }
    } else if (i==member2+1) {             // 壁を表す
      fill(0);
      drawSquare(rec[i], 10, 50, 200);
    } else {                                  // 青色
      fill(0, 0, 255);
      if (drawSquare(rec[i], 10, 50, 200)) {
        clickedIndex = i;
      }
      if (clickedIndex == i) {
        fill(255, 0, 0);
        ellipse(rec[i] + 25, 225, 18, 18);
        noFill();
      }
    }
  }
}

// 配列をコピー
int[] copyArray(int[] data1) {
  int[] data = new int[data1.length];
  for (int i = 0; i < data1.length; i++) {
    data1[i] = data[i];
  }

  return data;
}



boolean drawButton(int x, int y, int w, int h, String msg) {
  rect(x, y, w, h);
  fill(0);
  text(msg, x + w/2, y + h/2);
  fill(255);

  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
    return true;
  } else {
    return false;
  }
}

boolean drawButton_1(int x, int y, int w, int h) {

  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
    return true;
  } else {
    return false;
  }
}

void selectedIndexEllipse(){ // クリックされたパイに目印をつける関数
  
}


void keyPressed() {

  if (!isMemberInputed) {
    if (key >= '0' && key <= '9') {
      if (member1 == 0) {
        member1 = int(key - '0');
        d = width / (member1 + 3);
      } else {
        member2 = int(key - '0');
        isMemberInputed = true;
      }
    }
  }
  redraw();
}

void mousePressed() {

  if (!clicked) {
    isClickedNum = true;
    clicked = true;
  }
}

void mouseReleased() {
  clicked = false;
  isClickedNum = false;
}

void keyTyped() {
  if (selectRect >= 0) {
    input = key; // キーボードから入力された文字を inputChar に格納
  }
}

boolean drawSquare(int x, int y, int w, int h) {
  if (mousePressed && mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
    return true;
  }
  rect(x, y, w, h);
  return false;
}

// Staffオブジェクトを初期化する関数
void initStaff(Staff[] staff) {
  for (int i = 0; i < staff.length; i++) {
    staff[i] = new Staff();
  }
}


// Paiオブジェクトを初期化
void initPai(Pai[] pai) {
  int info = 0;
  int w = width / (member1 + 3);
  for (int i = 0; i < pai.length; i++) {

    if (member2 == i || member1 +  2== i) {  // パイが先頭のとき（青）
      info = 2;
    } else if (member2 + 1 == i ) { // パイが壁の時(黒)
      info = 3;
    } else {                      // 何もなし(白）
      info = 1;
    }
    pai[i] = new Pai(info, i * w);
  }
}
