////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Classe Excel ////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import controlP5.*;

import java.util.Arrays;
import java.util.List;
import java.io.File;


public class cExcel {
 boolean bisVisible;
 boolean bisResizable;
 boolean bisDragable;
 int nbSheet = 1;
// int nbOsc = 2;
 float x; float lastX; 
 float y; float lastY;
 float w; float lastW;
 float h; float lastH;
  color colCellFillRect = c_background;  // color rect fill  
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
  float  leftBarWidth=20;
  float  startButtonXPos=this.leftBarWidth;
  float  menuBarheigth=15;
  int    sizeMode;  
  final int MODE_MAXIMISED=2;
  final int MODE_MINIMISED=1;
  final int MODE_NORMAL=0;
  final float GUI_Height = 50;
  
  
  cSheet[] sheet=new cSheet[this.nbSheet];
 
  boolean bshowHelp;
  
  String newVal;
  int nbButtons;
  final float buttonWidth;
  color buttonBodyColor;
  color buttonTextColor;
  color buttonExtColor;
//  boolean bneedToRemoveSheet;  
  

 
public cExcel( String _text){
 bisVisible=true;
 currentFilename= _text;
 x = 0; lastX=x;
 y = 0; lastY=y;
 w = 500; lastW=w;
 h = 400; lastH=h;
 //colCellFillRect=color (50);  // color rect fill  
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
 newVal="";
 //startButtonXPos=10;
 nbButtons=0; // s'incrémente à chaque création d'un bouton
 buttonWidth=60;
 buttonBodyColor = color(0,0,255);
 buttonTextColor = color(0,255,0);;
 buttonExtColor  = color(255,0,0);;
// bneedToRemoveSheet = false;
 bisResizable = true;
 bisDragable = true;
 

 for (int i = 0; i < sheet.length; i++)     
  { 
   sheet[i] = new cSheet ( str(char(i+0x41)) ,this.leftBarWidth+dx*20 , this.menuBarheigth+12+ dy*20 , 500 ,200  );
   sheet[i].newTab(i);
   if(sheet[i].nbCol>=6)   sheet[i].createSeq();
   sheet[i].unFocus();   
   dx++; if((dx*20+100+this.leftBarWidth)>(this.x+this.w)) {dx=this.leftBarWidth;}
   dy++; if((dy*20+12+100)>(this.h-this.menuBarheigth)) {dy=0;}
  }
 this.selectLastsheet();
 
 
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
 // permet les déclarations fluides
 public cExcel hide()                 { this.bisVisible=false; return(this); }
 public cExcel show()                 { this.bisVisible=true; return(this); }
 public cExcel isResizable(boolean r) {this.bisResizable=r; return(this); }
 public cExcel isDragable(boolean d)  {this.bisDragable=d; return(this); }
 public cExcel setPosition(float _x, float _y)  {this.x=_x; this.y=_y;return(this); }
 public cExcel setSize(float _w, float _h)  {this.w=_w; this.h=_h;return(this); }
 
 boolean isVisible(){ return(this.bisVisible);}
//Insertion boutons (nbButtons)
void updateButtons(){
   textSize(12);
   rectMode(CORNER);
   textAlign(CENTER, BASELINE);
   fill(201, 201, 201);
   stroke(colCellStroke);
   rect(x, y, 20, menuBarheigth);
   if (isOverTOP()) {stroke(colCellStroke);}else {stroke(10);}      
   drawButton(   "LOAD",this.selected,this.x+startButtonXPos+ 0*this.buttonWidth,this.y,this.buttonWidth,this.menuBarheigth,buttonBodyColor, buttonTextColor);
   drawButton(   "SAVE",this.selected,this.x+startButtonXPos+ 1*this.buttonWidth,this.y,this.buttonWidth,this.menuBarheigth,buttonBodyColor, buttonTextColor);
   drawButton(    "NEW",this.selected,this.x+startButtonXPos+ 2*this.buttonWidth,this.y,this.buttonWidth,this.menuBarheigth,buttonBodyColor, buttonTextColor);
   drawButton( "REMOVE",this.selected,this.x+startButtonXPos+ 3*this.buttonWidth,this.y,this.buttonWidth,this.menuBarheigth,buttonBodyColor, buttonTextColor);
   drawButton(   "----",this.selected,this.x+startButtonXPos+ 4*this.buttonWidth,this.y,this.buttonWidth,this.menuBarheigth,buttonBodyColor, buttonTextColor);
   drawButton("PR:SAVE",this.selected,this.x+startButtonXPos+ 5*this.buttonWidth,this.y,this.buttonWidth,this.menuBarheigth,buttonBodyColor, buttonTextColor);
   nbButtons=6;  
   textAlign(LEFT, BASELINE);
   this.highLigthBouton();
}

void buttonClicked(int n)
{
  if ( (n<1)||(n>nbButtons) ) {return;}
 switch (n)
 {
  case 1 :{// OPEN Button
           this.openButton(); 
           //println("Button 1");
           break;}
  case 2 :{// SAVE Button
           this.saveButton();
           //println("Button 2");
           break;}
  case 3 :{// NEW Button
           this.addButton(); 
           //println("Button 3");
           break;}
  case 4 :{// NEW Remove
           this.removeButton(); 
           //println("Button 3");
           break;}
 
  case 5 :{// VAL/EQU Affiche soit les valeurs des celulles soit leurs &quations  
           //println("Button 3");
           break;}
  case 6 :{// PR:SAVE
           //this.removeButton(); 
           //println("Button 3");
           break;}
 }
}



 void drawButton(String _text,boolean _b,float _x,float _y,float _w,float _h,color cbody, color ctext)
  {
  //float mx=mouseX-this.x;
  //float my=mouseY-this.y;
  if((_x+_w)>(this.x+this.w)) return;
  //  if()
   textAlign(CENTER, BASELINE);
   if(_b)
    {
     fill(cbody);
     stroke(cbody);
     rect(_x, _y, _w, _h,_h/3);    
     fill(ctext);
     text(_text, _x+_w/2, _y+_h/2+4);
    }
   else
    {
     stroke(cbody);
     rect(_x, _y, _w, _h,_h/5);    
     fill(ctext);//fill(0);
     text(_text, _x+_w/2, _y+_h/2+4);
    }
   textAlign(LEFT, BASELINE);
 }

/////////////////////////
// gestion des boutons
/////////////////////////
boolean isOverButtonBar(){
 if ( (this.selected==false)||(this.sizeMode==MODE_MINIMISED) ) { return(false); }
  boolean res=false;
  float mx=mouseX-this.x;
  float my=mouseY-this.y;
  if((my>0)&&(my<this.menuBarheigth)&&(mx>0)&&(mx<this.w)) {res=true;}
  return (res);
}

int highLigthBouton(){
  if (isOverButtonBar()==false) {return (-1);}
  int res=-1;
  float mx=mouseX-this.x-this.startButtonXPos;
  float _nbButtons=floor(mx/this.buttonWidth)+1;
  if ( (_nbButtons<=0) || ( _nbButtons>nbButtons) ) {return(-1);}
  fill(200,200,200,100);
  rect(this.x+this.startButtonXPos+((_nbButtons-1)*buttonWidth),this.y,this.buttonWidth,this.menuBarheigth,this.menuBarheigth/3);  
  return (int(_nbButtons));
}


boolean tabSelected()
 {//renvoie true uniquement au moins une sheet est selectionnée
 boolean res=false;
 for (cSheet sheet:this.sheet)
  {
   if(sheet.selected) {res=true; break;}       
  }
 if (res==false){      println("Aucune feuille sélectionnée"); } 
 return(res);
 }
 

 void openButton() {
   // création d'une nouvelle sheet si 
   // aucune sheet ou aucune sélectionnée

   boolean somethingSelected=false;
  for (cSheet sheet:Excel.sheet)  {    if ( (sheet.selected==true)) {  somethingSelected=true;}   }
  if ( (!somethingSelected)||(Excel.sheet.length==0)) {this.addButton();}

  selectInput( "Ouvrir fichier CSV :", "fileOpenSelected"); 
 
 }
// void fileOpenSelected(File selection) {
//  println(selection.getAbsolutePath());
//  if (selection == null) {
//    println("Window was closed or the user hit cancel.");
//  } else {
//    println("User selected " + selection.getAbsolutePath());
//    for (cSheet sheet:this.sheet)
//     {
//      sheet.load( selection.getAbsolutePath());
//     } 
//  }
//}
void saveButton()  {   if (tabSelected()) { selectOutput("Sauver fichier CSV :", "fileSaveSelected",dataFile(cheminDeLApplication)); } }

void addButton()
 {
  cSheet n = new cSheet ( "New Sheet" ,this.leftBarWidth , this.menuBarheigth*2 , 500 ,200  );  
  Excel.add(n); 
  this.selectLastsheet();
 }
 
 void removeButton()
 {
   if (tabSelected()) { this.removeSelected(); }
 }
 
 
 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
void updateColors(){
    colCellFillRect = c_background;
 //   colCellStroke   = c_tabbar;
    colCellFillText = c_terminal_text;
    colCellSelectedText = c_message_text;
}

 
 // Renvoie les caractéristique de la fenetre Excel //
 float getx(){return(this.x);}
 float gety(){return(this.y);}
 float getw(){return(this.w);}
 float geth(){return(this.h);}
 float getBarWidth(){return(this.leftBarWidth);}
 float getMenuBarHeigth(){return(this.menuBarheigth);}  
 
// ////
 void draw() {
   if (!this.bisVisible){return;}

   textSize(12);
   rectMode(CORNER);
   textAlign(LEFT, BASELINE);
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
      fill(100);   rect(x+this.w-24, y-12, 12,12);    noFill();   rect(     this.x+this.w-24+3, this.y-9, 12-6,12-5);
      fill(100);   rect(x+this.w-12, y-12, 12,12);    fill(255);  text("X", this.x+this.w-9   , this.y-2);
     }
    else
     {//non sélectionné
      fill(200);
      stroke(colCellStroke);
      rect(x, y-12, w, 12);    
      fill(colCellFillRect);//fill(0);
      text(this.currentFilename, this.x+3, this.y-2);
     }
    //fill(0);//colCellFillRect);
    fill(colCellFillRect);//fill(0);
    stroke(colCellStroke);
    rect(x, y, w, h);
    fill(201, 201, 201);
    //fill(colCellFillRect);//fill(0);
    stroke(colCellStroke);
    rect(x, y, this.leftBarWidth, h);
 
    this.isOverTOP();
  
  
  //this.selected=isOverTab();
   this.update();
   if(this.sizeMode==MODE_MINIMISED){return;}
   fill(201, 201, 201);
   stroke(colCellStroke);
   rect(x, y, this.w, menuBarheigth);
 updateButtons();
///////////////////////////////////////////////////////////////////////////
// rafraichissement des sheets
///////////////////////////////////////////////////////////////////////////

// Test les sheets pour savoir si l'une d'elles demande sa suppression
   int r=0,j=-1;
   for ( r=0;r<Excel.sheet.length;r++)
    {
     sheet[r].updateFromParent(this.x,this.y,this.w,this.h,this.leftBarWidth,this.menuBarheigth);
     if (sheet[r].bneeToRemoveSheet==true) {j=r;}     
    }
   if (j>=0) {this.remove(j);}

// Test toutes les sheets pour.....................................................................................................
   int foc=-1;
   int n=Excel.sheet.length;
   if (needToUnslectAll==true)
    {
     for (int i=sheet.length-1;i>=0;i--)
      {
       if (sheet[i].fromMe==false) { sheet[i].unFocus();}
       else                        { }
       sheet[i].fromMe=false;
  if (sheet[i].isFocused()&&(foc<0)) { foc=n-1;sheet[i].update();}//break;}
  else                               { sheet[i].unFocus();}
  n--;
      }
     needToUnslectAll=false;
    }
    
// Test toutes les sheets en ordre inverse pour.....................................................................................................
   // for (int i =sheet.length-1;i>=0;i--)
   //{
   //  if (sheet[i].isFocused()&&(foc<0)) { foc=n-1;sheet[i].update();}//break;}
   //  else                               { sheet[i].unFocus();}
   //  n--;
   //}
   
// Rafraichit les sheets ( sans affichage sauf pour la deniere)
  for (int i =0 ;i<(sheet.length);i++)
   {
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

// Exécute la sequence interne à la feuille sélectionnée
    for (cSheet sheet:Excel.sheet)
   { //  println("Test seq ");  
    if ( (sheet.tSeqCreated==true)&&(sheet.tSeq.isRunning==true) ) {   sheet.tSeq.process(sheet);  } else {printStatusBar();}
   }
    showHelp();
}  

 
 
 void update()

   {if (!this.bisVisible){return;}
    this.leftBarWidth=valeur1;
     if(this.sizeMode==MODE_MINIMISED){return;}
    float mx=mouseX-this.x;
    float my=mouseY-this.y;

     if ( (my>0)&&(my<this.h) &&
          (mx>(this.w-3)) &&(mx<(this.w+3))&&
          this.bisResizable==true)
           {
            this.readyToResiseX=true; 
            fill(255,0,0);
            stroke(10);
            line(this.x+this.w,this.y,
            this.x+this.w,this.y+this.h);
           }
      else { this.readyToResiseX=false;}
     if ( (mx>0)&&(mx<this.w) &&
          (my>(this.h-3)) &&(my<(this.h+3))&&
          this.bisResizable==true)          
           {
            this.readyToResiseY=true; 
            fill(255,0,0);
            stroke(10);
            line(this.x,this.y+this.h,
            this.x+this.w,this.y+this.h);
           }
      else { this.readyToResiseY=false;}
      //if (this.bneedToRemoveSheet==true) // suppression de la fenetre selectionnée (provoqué par la fenetre elle mem)
      // {
      //  this.removeSelected();
      //  this.bneedToRemoveSheet=false;  
      //  this.selectLastsheet();
      // }       
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
  if (!this.bisVisible){return;}
  for(cSheet sheet:Excel.sheet){sheet.mouseWheel(event); } 
 
}

void mouseClicked() {
  if (!this.bisVisible){return;}
  for(cSheet sheet:Excel.sheet){sheet.mouseClicked(); }
 
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
    this.buttonClicked(this.highLigthBouton());
}

void mousePressed(){
  if (!this.bisVisible){return;}
  bshowHelp=false;
  for(cSheet sheet:Excel.sheet){sheet.mousePressed(); }
 
  float mx=mouseX-this.x;
  float my=mouseY-this.y;
  if (this.isOverTOP() && this.bisDragable) 
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
  if (!this.bisVisible){return;}
  
  for(cSheet sheet:Excel.sheet){sheet.mouseReleased();}
 
 this.resisingX=false;this.readyToResiseX=false;
 this.resisingY=false;this.readyToResiseY=false;
 this.bisOnTOP=false;
}

void mouseDragged(){
  if (!this.bisVisible){return;}
  for(cSheet sheet:Excel.sheet){sheet.mouseDragged(); }
 
 if (this.resisingX==true)
  {
   this.w=mouseX-this.x;
  // for(cSheet sheet:Excel.sheet){sheet.updateFromParent(this.x,this.y,this.w,this.h,this.leftBarWidth,this.menuBarheigth);    }         // NE FONCTIONNE PAS
   if(this.w<(100+this.leftBarWidth)){this.w=100+this.leftBarWidth;}
  }
 if (this.resisingY==true)
  {
   this.h=mouseY-this.y;
   if(this.h<100){this.h=100;}
  }
  if(this.bisOnTOP==true)
   {
     this.x=mouseX-this.deltaXWhenWinIsDragging;    if(this.x<0) {this.x=0;}
     this.y=mouseY;                                 if(this.y<GUI_Height+12) {this.y=GUI_Height+12;}

   }
 }
void keyPressed() 
{
  if (!this.bisVisible){return;}
 for(cSheet sheet:Excel.sheet){sheet.keyPressed();   } 
 
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
    if(sheet[sheet.length-1].nbCol>6) sheet[sheet.length-1].createSeq();
   sheet[sheet.length-1].unFocus();   
  println("add new sheet");
  }
  
  //void neeToRemoveSheet(boolean state)
  //{
  // bneedToRemoveSheet=state;
  //}
  
  void removeSelected()
  {
   for ( int i=0;i<Excel.sheet.length;i++)
    {
     if (sheet[i].selected) {this.remove(i);}
    }
  }
  
 void remove(int selected)
  {
   int n=sheet.length;
   if ( (selected >=n )||(n<0) ) return;
   cSheet[] newsheet = new cSheet[n-1];// ( str(char(foc+0x41)) ,   sheet[foc].x ,  sheet[foc].y , sheet[foc].w ,sheet[foc].h  );
   System.arraycopy(         sheet,             0,       newsheet,           0,selected);
   System.arraycopy(         sheet,    selected+1,       newsheet,    selected,n-selected-1);
   sheet = newsheet;
   newsheet=null;
   println("Remove sheet "+selected);
   this.selectLastsheet();
  }
  
 void selectLastsheet()
 {
    for (int i = 0; i < sheet.length; i++)     
  { 
   sheet[i].selected = false;
  }
  if (sheet.length!=0) {sheet[sheet.length-1].selected=true;}   
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
   this.y=32;
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
 
 void showHelp() {}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Fin Classe Excel ////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}



/// Hors classe !!!
 void fileOpenSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    for (cSheet sheet:Excel.sheet)
     {
      sheet.load( selection.getAbsolutePath());
     } 
  }
}

void fileSaveSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    for (cSheet sheet:Excel.sheet)
     {
       sheet.save(selection.getAbsolutePath());       
     }
  }
}
