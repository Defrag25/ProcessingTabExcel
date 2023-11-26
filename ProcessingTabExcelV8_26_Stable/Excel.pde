////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
cExcel Excel;// = new cExcel( "Excel", 10 , 80, 700 , 400);
class cExcel {
 int nbSheet = 10;
 float x; float lastX; 
 float y; float lastY;
 float w; float lastW;
 float h; float lastH;
  color colCellFillRect;  // color rect fill  
  color colCellStroke;    // color rect outline
  color colCellFillText;  // color text
  color colCellSelectedText;  // color selectedtext
  boolean selected;
  String currentFilename;
  boolean readyToResiseX;
  boolean readyToResiseY;
  boolean activatedFunction;
  boolean resisingX;
  boolean resisingY;
  float deltaXWhenWinIsDragging;
  boolean bisOnTOP;
  boolean isAlive;
  float  leftBarWidth=10;
  float  menuBarheigth=15;
  int    sizeMode;  
  final int MODE_MAXIMISED=2;
  final int MODE_MINIMISED=1;
  final int MODE_NORMAL=0;
  cSheet[] sheet=new cSheet[this.nbSheet];
  boolean bshowHelp; 

 
 cExcel( String _text, float _x, float _y, float _w , float _h ){
 currentFilename= _text;
 x =_x; lastX=x;
 y= _y; lastY=y;
 w =_w; lastW=w;
 h =_h; lastH=h;
 colCellFillRect=color (50);  // color rect fill  
 colCellStroke=color (251, 255, 31);    // color rect outline
 colCellFillText=color(200);  // color text
 colCellSelectedText=color(250,0,0);  // color selectedtext
 selected=true;
 readyToResiseX=false;
 activatedFunction=false;
 resisingX=false;
 deltaXWhenWinIsDragging=0;
 bisOnTOP=false;
 isAlive=true;
 sizeMode =MODE_NORMAL;
bshowHelp=false;
 float dx=0,dy=0;  

 for (int i = 0; i < sheet.length; i++)     
  { 
   sheet[i] = new cSheet ( str(char(i+0x41)) ,this.leftBarWidth+dx*20 , this.menuBarheigth+12+ dy*20 , 300 ,200  );
   sheet[i].newTab(i);
   sheet[i].createSeq();
   sheet[i].unFocus();   
   dx++; if((dx*20+100+this.leftBarWidth)>(this.x+this.w)) {dx=this.leftBarWidth;}
   dy++; if((dy*20+12+100)>(this.h-this.menuBarheigth)) {dy=0;}
  }
 }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

 
 // Renvoie les caractéristique de la fenetre Excel //
 float getx(){return(this.x);}
 float gety(){return(this.y);}
 float getw(){return(this.w);}
 float geth(){return(this.h);}
 float getBarWidth(){return(this.leftBarWidth);}
 float getMenuBarHeigth(){return(this.menuBarheigth);}  
 
// ////
 void draw() {
   textSize(12);
   if (this.isAlive==false) return;
  
    if (isOverTOP()) {stroke(colCellStroke);}else {stroke(10);}
    if(this.selected==true)
     { //selectionné
      fill(100);
      stroke(colCellStroke);
      rect(x, y-12, w, h);    
      fill(255);
      text(this.currentFilename, this.x+3, this.y-2);
      fill(100);   rect(x+this.w-48, y-12, 12,12);fill(0,255,0);  text("?", this.x+this.w-9-36, this.y-2);
      fill(100);   rect(x+this.w-36, y-12, 12,12);    fill(255);  text("-", this.x+this.w-9-24, this.y-2);
      fill(100);   rect(x+this.w-24, y-12, 12,12);    noFill();   rect(x+this.w-24+3, y-9, 12-6,12-5);
      fill(100);   rect(x+this.w-12, y-12, 12,12);    fill(255);  text("X",    this.x+this.w-9, this.y-2);
     }
    else
     {//non sélectionné
      fill(200);
      stroke(colCellStroke);
      rect(x, y-12, w, 12);    
      fill(0);
      text(this.currentFilename, this.x+3, this.y-2);
     }
    fill(0);//colCellFillRect);
    stroke(colCellStroke);
    rect(x, y, w, h);
    fill(201, 201, 201);
    stroke(colCellStroke);
    rect(x, y, this.leftBarWidth, h);
  this.isOverTOP();
  
  
  //this.selected=isOverTab();
  this.update();
     if(this.sizeMode==MODE_MINIMISED){return;}
    fill(201, 201, 201);
    stroke(colCellStroke);
    rect(x, y, this.w, menuBarheigth);

///////////////////////////////////////////////////////////////////////////
// rafraichissement des sheets
///////////////////////////////////////////////////////////////////////////
     int foc=-1;
  int n=sheet.length;
  if (needToUnslectAll==true)
   {
    for (int i=sheet.length-1;i>=0;i--)
     {
      if (sheet[i].fromMe==false) { sheet[i].unFocus();}
      else                        { }
      sheet[i].fromMe=false;
     }
    needToUnslectAll=false;
   }

    for (int i =sheet.length-1;i>=0;i--)
   {
     if (sheet[i].isFocused()&&(foc<0)) { foc=n-1;sheet[i].update();}//break;}
     else                          { sheet[i].unFocus();}
     n--;
   }
   
  for (int i =0 ;i<(sheet.length);i++)
   {
     //sheet[i].drawWithoutUpgrade();
          sheet[i].draw(false);
   }
  if (foc>=0) 
   {
    cSheet copie;
    copie=sheet[foc]; 
    copie.draw(true);//this.x,this.y);
    cSheet[] newsheet = new cSheet[sheet.length];// ( str(char(foc+0x41)) ,   sheet[foc].x ,  sheet[foc].y , sheet[foc].w ,sheet[foc].h  );
    System.arraycopy(sheet, 0, newsheet, 0, foc);
    System.arraycopy(sheet, foc + 1, newsheet, foc, sheet.length - foc -1);
    sheet = newsheet;
    sheet[sheet.length-1]=copie;
    // Affiche l'ordre des elements du tableau trié
    //for (int i =0 ;i<(sheet.length);i++)
    // {
    //  print(sheet[i].textTab+" ");
    // }
    //println("  ");  
   }
   
    for (cSheet sheet:Excel.sheet)
   {   
    if ( (sheet.tSeqCreated==true)&&(sheet.tSeq.isRunning==true) ) {   sheet.tSeq.process(sheet);  } else {printStatusBar();}
   }
    showHelp();
}  

 
 
 void update()
   {
     if(this.sizeMode==MODE_MINIMISED){return;}
    float mx=mouseX-this.x;
    float my=mouseY-this.y;

     if ( (my>0)&&(my<this.h) &&
          (mx>(this.w-3)) &&(mx<(this.w+3)))
           {
            this.readyToResiseX=true; 
            fill(255,0,0);
            stroke(10);
            line(this.x+this.w,this.y,
            this.x+this.w,this.y+this.h);
           }
      else { this.readyToResiseX=false;}
     if ( (mx>0)&&(mx<this.w) &&
          (my>(this.h-3)) &&(my<(this.h+3)))
           {
            this.readyToResiseY=true; 
            fill(255,0,0);
            stroke(10);
            line(this.x,this.y+this.h,
            this.x+this.w,this.y+this.h);
           }
      else { this.readyToResiseY=false;}
   }
  
boolean isOverTOP(){
//if(this.selected==false) { return; }

  boolean res=false;
  float mx=mouseX-this.x;
  float my=mouseY-this.y;
  if((my>-20)&&(my<0)&&(mx>0)&&(mx<this.w)) {res=true;}
  return (res);
} 

boolean isOverTab(){
//if(this.selected==false) { return; }

  boolean res=false;
  float mx=mouseX-this.x;
  float my=mouseY-this.y;
  if((my>-20)&&(my<this.h)&&(mx>0)&&(mx<this.w)) {res=true;}
  return (res);
}

void mouseWheel(MouseEvent event) {
  for(cSheet sheet:sheet){sheet.mouseWheel(event); } 
}

void mouseClicked() {
  for(cSheet sheet:sheet){sheet.mouseClicked(); } 
  float mx=mouseX-this.x;
  float my=mouseY-this.y;
   ///////////////////////////
   // Gestion des boutons haut de la fenetre
   if ( (mouseButton == LEFT)  && (this.isOverTOP() && (this.selected=true)) )
    {
      
  if ( (mx>(this.w-12))&&(mx<this.w- 0))  {  this.isAlive=false;  } // Bouton close
  if ( (mx>(this.w-24))&&(mx<this.w-12))  {  this.maximise();     } // Bouton maximise
  if ( (mx>(this.w-36))&&(mx<this.w-24))  {  this.minimise();     } // Bouton minimise
  if ( (mx>(this.w-48))&&(mx<this.w-36))  {  this.bpShowHelp();     } // Bouton ?
    }
}

void mousePressed(){
  bshowHelp=false;
  for(cSheet sheet:sheet){sheet.mousePressed(); }
  float mx=mouseX-this.x;
  float my=mouseY-this.y;
  if (this.isOverTOP()) 
   {
     this.bisOnTOP=true;
     this.deltaXWhenWinIsDragging=mouseX-this.x;
   }

  if(this.isOverTab()==true)
   {//this.selected=true;
    if(this.selected==true) { }//this.selected=false; }
     else {
     this.selected = true;
    }
   }
  
  if ( (mouseButton == LEFT) && (this.readyToResiseX==true) &&(this.selected=true))
   {
    this.resisingX=true;
    this.w=mouseX-this.x;
    this.sizeMode=MODE_NORMAL;
   }
  if ( (mouseButton == LEFT) && (this.readyToResiseY==true) &&(this.selected=true))
   {
    this.resisingY=true;
    this.h=mouseY-this.y;
    this.sizeMode=MODE_NORMAL;
   }
}

void mouseReleased(){
  for(cSheet sheet:sheet){sheet.mouseReleased();}
 this.resisingX=false;this.readyToResiseX=false;
 this.resisingY=false;this.readyToResiseY=false;
 this.bisOnTOP=false;
}

void mouseDragged(){
  for(cSheet sheet:sheet){sheet.mouseDragged(); }
 if (this.resisingX==true)
  {
   this.w=mouseX-this.x;
   if(this.w<100){this.w=100;}
  }
 if (this.resisingY==true)
  {
   this.h=mouseY-this.y;
   if(this.h<100){this.h=100;}
  }
  if(this.bisOnTOP==true)
   {
     this.x=mouseX-this.deltaXWhenWinIsDragging;
     this.y=mouseY;
     if(this.y<12) {this.y=12;}

   }
 }
void keyPressed() 
{
 for(cSheet sheet:sheet){sheet.keyPressed();   } 
}

boolean isFocused()        { return(this.selected);}
  void setFocus(boolean s)   { this.selected=s;       }
  void focus()               { this.selected=true;    }
  void unFocus()             { this.selected=false;   }

  
//  //Ajoute une feuille

  void add(cSheet new1){
//public static void arraycopy(Object source_arr, int sourcePos, Object dest_arr, int destPos, int len)
//Parameters : 
//source_arr : array to be copied from
//sourcePos : starting position in source array from where to copy
//dest_arr : array to be copied in
//destPos : starting position in destination array, where to copy in
//len : total no. of components to be copied.

  cSheet[] newsheet = new cSheet[sheet.length+1];// ( str(char(foc+0x41)) ,   sheet[foc].x ,  sheet[foc].y , sheet[foc].w ,sheet[foc].h  );
  newsheet[newsheet.length-1]=new1;
 // System.arraycopy(sheet, 0, newsheet, 0, sheet.length);

//       arraycopy(Object source_arr, int sourcePos, Object dest_arr,   int destPos, int len)
  System.arraycopy(            sheet,             0,        newsheet,             0,sheet.length);

  sheet = newsheet;
   sheet[sheet.length-1].newTab(sheet.length-1);
   sheet[sheet.length-1].createSeq();
   sheet[sheet.length-1].unFocus();   
  println("add new sheet");
  }
  void removeSelected(){
  for ( int i=0;i<Excel.sheet.length;i++)
   {
   if (sheet[i].selected) {this.remove(i);}
 }
  }
  
 void remove(int selected){
//public static void arraycopy(Object source_arr, int sourcePos, Object dest_arr, int destPos, int len)
//Parameters : 
//source_arr : array to be copied from
//sourcePos : starting position in source array from where to copy
//dest_arr : array to be copied in
//destPos : starting position in destination array, where to copy in
//len : total no. of components to be copied.
  int n=sheet.length;
  if (selected >=n) return;
  cSheet[] newsheet = new cSheet[sheet.length-1];// ( str(char(foc+0x41)) ,   sheet[foc].x ,  sheet[foc].y , sheet[foc].w ,sheet[foc].h  );
 //       arraycopy(Object source_arr, int sourcePos, Object dest_arr,   int destPos, int len)
//  System.arraycopy(            sheet,             0,        newsheet,             0,selected);
  System.arraycopy(         sheet,             0,       newsheet,           0,selected);
  System.arraycopy(         sheet,    selected+1,       newsheet,    selected,n-selected-1);

  sheet = newsheet;
  println("Remove sheet "+selected);
  }

void minimise()
 {
  this.sizeMode=MODE_MINIMISED;
  if (this.sizeMode==MODE_NORMAL){
  this.lastX=this.x;
  this.lastY=this.y;
  this.lastW=this.w;
  this.lastH=this.h;}
  this.x=0;
  this.y=12;
  this.w=200;
   this.h=0;
 }


void maximise()
 {
   switch(this.sizeMode)
    {
  case MODE_MINIMISED: {
   this.sizeMode=MODE_NORMAL;
   this.x=this.lastX;
   this.y=this.lastY;
   this.w=this.lastW;
   this.h=this.lastH;

      break;}
 case MODE_NORMAL:   {
   this.sizeMode=MODE_MAXIMISED;
   this.x=0;
   this.y=12;
   this.w=width-2;
   this.h=height-12-2;
      break;}
 case MODE_MAXIMISED:  {
   this.sizeMode=MODE_NORMAL;
   this.x=this.lastX;
   this.y=this.lastY;
   this.w=this.lastW;
   this.h=this.lastH;

      break;}
      
    }
 }

 void bpShowHelp() {   bshowHelp=true;  }
 
 void showHelp()
 {

     if (this.bshowHelp) {
    fill(200);
    rect(50, 50, 300, 100);
    
    fill(0);
    //textAlign(CENTER, CENTER);
    textSize(20);
    text("Voulez-vous continuer ?", width/2, height/2 - 10);
    
    fill(0, 255, 0);
    rect(100, 150, 80, 30);
    fill(255);
    text("OK", 140, 165);
    
    fill(255, 0, 0);
    rect(220, 150, 80, 30);
    fill(255);
    text("Annuler", 260, 165);
leftBarWidth=100;  }
else{leftBarWidth=10;}
 
 
 }
}
