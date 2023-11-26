/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CLASS Sheet ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Auteur : ERM
// Version: 1.1
// Date   : 2023/11/14

// Rev
//
// Ajout de la coloration syntaxique

//cEval eval;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Random;
import java.util.Stack;

public class cSheet {
    boolean debug =false;
//  String equation;


  final float  _version = 1.0;
  final String _author = "Eric MOREL-JEAN";
  final String _libName = "Cell";
  final float minWidth = 100;
  final float minHeigth = 100;
  final int MODE_MAXIMISED=2;
  final int MODE_MINIMISED=1;
  final int MODE_NORMAL=0;
  color colCellFillRect;  // color rect fill  
  color colCellStroke;    // color rect outline
  color colCellFillText;  // color text
  color colCellSelectedText;  // color selectedtext
  color colToolBar;           // ToolBar bk_color
  color coluToolBar;           // ToolBar bk_color
  color colBk;                // Bk color
  color coluBk;               // Bk color
  color colText;              // color Text xelexted
   color coluText;            // color text unselected
  float cx;float x; float mx;  float lastX; 
  float cy;float y; float my; float lastY;
  float w;float mw;float new_w; float lastW;
  float h;  float mh;float new_h; float lastH;
  int nbCol;
  int nbLines;
  float leftBarWidth;
  float menuBarHeigth;
  String textTab;
  String equation;
  String showString;
  String showVal;
  boolean selected;
  String currentFilename;
  String currentPath;
  boolean resisingX;
  boolean resisingY;
  boolean readyToResiseX;
  boolean readyToResiseY;
  boolean bisOnTOP;
  float deltaXWhenWinIsDragging;
  float deltaYWhenWinIsDragging;
  boolean fromMe;
  boolean activatedFunction;
  int index;
  boolean bisVisible;
  int    sizeMode;
  boolean syntaxColor;
  boolean editionEq;
  //////////////////////////////////
  // Variables propres au tableur //
  //////////////////////////////////
  Cell[][] tgrid;
  final int spaceBetweenColumns = 0;
  final int cellHeight = 20;
  final int tminWidthColumn = 65;
  final char separator = ';';
  final char numberFormat = '.';
  boolean ValidNewString;
  int   tCellX;
  int   tCellY;
  int   tstartX;
  int   tstartY;
  String tlines[] ;
  int    tgridX;
  int    tgridY;
  int    tgridXtempo;
  int    tgridYtempo;
  String tCellSelectedText;
  String tNewVal;
  
  int    tSelectedLine;
  int    tSelectedCol;
  boolean resising;
  ctSeq   tSeq;
  boolean tSeqCreated;
  boolean winIsDragging;
  boolean bneeToRemoveSheet;
  boolean bvalEqu;
  
  float startLeftCells=50;
  float cellLeftBarWidth=20;
  float startTopCells=50;
  float cellTopBarHeigth=20;
  
  // constr 
//  cSheet ()   {}
  cSheet ( String text_,   float x_, float y_, float w_ , float h_ ) 
   {
    ValidNewString=false;
    textTab       = text_;
    equation      = "";
    showString    = "";
    showVal       = "";
    currentPath= sketchPath("");
    x = this.cx   = this.mx  = x_;
    y = this.cy   = this.my  = y_;
    w             = w_;if(this.w<minWidth){this.w=minWidth;}
    h             = h_;if(this.h<minHeigth){this.h=minHeigth;}
    mw            = this.w;
    mh            = this.h;
    lastX         = this.cx;
    lastY         = this.cy;
    lastW         = this.w;
    lastH         = this.h;
    nbCol    = 7;   if(nbCol  >99) { nbCol=99;} if(nbCol<1) { nbCol=1;} 
    nbLines  = 7;   if(nbLines>99) { nbLines=99;} if(nbLines<1) { nbLines=1;}
    tstartX  = 0;
    tstartY  = 0;
    colCellFillRect = color (0);
    colCellStroke   = color (251, 255, 31);
    colCellFillText = color (200);
    colCellSelectedText = color(250,0,0);
    colToolBar          = color(50,50,50);
    coluToolBar         = color(10,10,10);
    colBk               = color(100,100,100);
    coluBk              = color(100,100,100);
    colText             = color(255,255,255);
    coluText            = color(0,0,0);
    selected=true;
    resisingX =false;
    resisingY =false;
    readyToResiseX=false;
    readyToResiseY=false;
    bisOnTOP = false;
    deltaXWhenWinIsDragging=0;
    deltaYWhenWinIsDragging=0;
    needToUnslectAll=false;
    fromMe=false;
    activatedFunction=false;
    index=0;
    bisVisible= true;
    new_w=0;
    new_h=0;
    
    tCellSelectedText="";
    tNewVal = "";

    tgridXtempo=0;
    tgridYtempo=0;
    tSelectedLine=-1;
    tSelectedCol=-1;
    tSeqCreated=false;
    winIsDragging=false;
    sizeMode=MODE_NORMAL;
    syntaxColor=true;
    bneeToRemoveSheet=false;
    bvalEqu= false;
    editionEq =false;
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


void updateFromParent(float mx_,float my_,float mw_,float mh_,float leftbw_,float menubh_){
   this.leftBarWidth  = leftbw_; 
   this.menuBarHeigth = menubh_;
   this.mx=mx_;
   this.my=my_;
   this.mw=mw_;
   this.mh=mh_;    
 } 

void createSeq(){
    tSeq= new ctSeq(this);
    this.tSeqCreated=true;
  }

void selectLine(int selected)  { this.tCellX=-1;this.tCellY=-1; this.tSelectedLine=selected; if(selected>=1){this.tSelectedCol=-1;}       }
void selectCol(int selected)   { this.tCellX=-1;this.tCellY=-1; this.tSelectedCol=selected;  if(selected>=1){this.tSelectedLine=-1;}}


String extractFileName(String chemin) {
  String[] parties = split(chemin, '\\');
  return parties[parties.length - 1];
}
// Gestion lignes colonnes des sheet ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

String[] removeLine(String[] array, int lineToRemove) {
  if (lineToRemove < 0 || lineToRemove >= array.length) {
    println("Erreur : L'indice de ligne est hors des limites.");
    return array;
  }
  
  String[] newArray = new String[array.length - 1];
  int newArrayIndex = 0;  
  for (int i = 0; i < array.length; i++) {
    if (i != lineToRemove) {
      newArray[newArrayIndex] = array[i];
      newArrayIndex++;
    }
  }
  return newArray;
}

String[] addLine(String[] array, String newLine, int insertPosition) {
  if (insertPosition < 0 || insertPosition > array.length) {
    println("Erreur : Position d'insertion invalide.");
    return array;
  }
  
  String[] newArray = new String[array.length + 1];
  
  for (int i = 0; i < insertPosition; i++) {
    newArray[i] = array[i];
  }
  
  newArray[insertPosition] = newLine;
  
  for (int i = insertPosition + 1; i < newArray.length; i++) {
    newArray[i] = array[i - 1];
  }
  
  return newArray;
}


void printMatrix(String[] matrix) {
  for (String row : matrix) {
    String[] columns = row.split(";");
    for (String cell : columns) {
      print(cell + ".\t");
    }
    println();
  }
}

String[] addColumn(String[] matrix, String[] newColumn, int insertColumnPosition) {
  int numRows=this.tgridY;
  int numCols = this.tgridX;
  if (insertColumnPosition < 0 || insertColumnPosition > numCols) {
    println("Erreur : Position d'insertion de colonne invalide.");
    return matrix;
  }
  
  String[] newMatrix = new String[numRows];
  
  for (int i = 0; i < numRows; i++) {
    String[] columns = matrix[i].split(";");
    StringBuilder newRow = new StringBuilder();
    for (int j = 0; j < columns.length; j++) {
      if (j == insertColumnPosition) {
        for (String newCol : newColumn) {
          newRow.append(newCol).append(""+this.separator);
        }
      }
      if (j==columns.length-1) { newRow.append(columns[j]); }
      else                     { newRow.append(columns[j]).append(";"); }
    }
    newMatrix[i] = newRow.toString();
  }
  
  numCols = numCols + 1;
  
  return newMatrix;
}

String[] removeColumn(String[] matrix, int columnToRemove) {
  int numRows=this.tgridY;
  int numCols = this.tgridX;
  if (columnToRemove < 0 || columnToRemove >= numCols) {
    if (debug) println("Erreur : L'indice de colonne à supprimer est hors des limites.");
    return matrix;
  }
  
  String[] newMatrix = new String[numRows];
  
  for (int i = 0; i < numRows; i++) {
    
    String[] columns = matrix[i].split(";");
    StringBuilder newRow = new StringBuilder();
    
    for (int j = 0; j < columns.length; j++) {
      if (j != columnToRemove) 
       {    //println(j);
        if (j==columns.length-1) { newRow.append(columns[j]); }
        else                     { newRow.append(columns[j]).append(";"); }
       }
    }
    newMatrix[i] = newRow.toString();
  }
  numCols = numCols - 1;
  return newMatrix;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void load(String filename) {  
  if(this.selected==false) { return; }
  if (debug) println("Opening :"+filename);
  this.tlines = loadStrings(filename);  
  this.currentFilename=filename;
  this.textTab=extractFileName(filename);
  this.reload(this.tlines);
 }
 

 void reload(String[] s) {
  // reload(this.currentFilename);
  this.tlines = s;  
  this.tgridY = this.tlines.length;
  this.nbLines = this.tgridY; 
  //println("Lignes "+this.nbLines);
  String [] listTemp= split ( this.tlines[0], this.separator );  
  int nbColonnesMax = listTemp.length-1;
//  println("Nombre de colonne ligne 1="+nbColonnesMax);
  for (int n=0;n<this.tgridY;n++)
   {
    listTemp = split ( this.tlines[n], this.separator );
    println("Nombre de colonne ligne "+(n+1)+"="+(listTemp.length-1));
    if(listTemp.length-1!=nbColonnesMax)
     { // ici , une des lignes n'a pas la meme taille que la premiere
      println("Nombre de colonne ligne "+(n+1)+" différent de la ligne 1"); 
      if(listTemp.length-1>nbColonnesMax)
       {
        nbColonnesMax=listTemp.length-1;
        println("Nombre max de colonnes ="+nbColonnesMax); 
       }
     }
   }
   
  this.tgridX = nbColonnesMax;
  println("Col "+this.tgridX);
  listTemp = null;  // not in use anymore
  this.tgrid = new Cell[this.tgridX+1][this.tgridY+1];  
  for (int i = 0; i < this.tlines.length; i++) {
    String [] list2 = split ( this.tlines[i], this.separator );
    for (int i2 = 0; i2 < nbColonnesMax; i2++) {
  //println("Col= "+this.tgridX);
    String sl="";
    if (i2<list2.length-1)     { sl=list2[i2];}
    else         { sl=""+this.separator;}   // réajustement du nombre de ligne
     
     
      this.tgrid[i2] [i] = new Cell ( sl,
                                      i2 * (this.tgridX) ,
                                      i  * (this.cellHeight),
                                      color (50),
                                      color (251, 255, 31),
                                      color(200) ,
                                      color(200,200,200),
                                      color(10,70,10)  );
     
    }
  }
  // measure max width of each column 
  float [] widthOfColumns = new float [this.tgridX+1];
  for (int i = 0; i < this.tlines.length-1; i++) {
    String [] list2 = split ( this.tlines[i], this.separator );
    //println("Col encore "+this.tgridX+"   "+list2.length);

    if (this.tgridX != list2.length-1) {
      println ("####### different numbers of columns encountered #########################");
    }
    for (int i2 = 0; i2 < list2.length-1; i2++) {
      // find the longest text 
      if (widthOfColumns[i2] < textWidth(list2[i2])+14) {  widthOfColumns[i2] = textWidth(list2[i2])+14;}
    }
  }

  // assign the width from above to the columns cells
  for (int j = 0; j<this.tgridY; j++) {
    for (int i = 0; i<this.tgridX; i++) {
      // make sure all columns are at least minWidthColumn wide
      widthOfColumns[i] = max (widthOfColumns[i], this.tminWidthColumn); 
      this.tgrid[i][j].w = widthOfColumns[i];
      this.tgrid[i][j].h = this.cellHeight;
    }
  }
  // assign the x values to cells. 
  int xCount = 0;
  for (int i = 0; i<this.tgridX; i++) {
    for (int j = 0; j<this.tgridY; j++) {
      this.tgrid[i][j].x = xCount;
    }
    xCount += widthOfColumns[i] + this.spaceBetweenColumns;
  }
  this.tCellX=0;
  this.tCellY=0;
  this.tstartX=0;
  this.tstartY=0;
  this.tgridXtempo=0;
  this.tgridYtempo=0;
  this.tSelectedLine=-1;
  this.tSelectedCol=-1;
 }
 //void reload(String[] s) {
 // // reload(this.currentFilename);
 // this.tlines = s;  
 // this.tgridY = this.tlines.length;
 // this.nbLines = this.tgridY; 
 // //println("Lignes "+this.nbLines);
 // String [] listTemp = split ( this.tlines[0], this.separator );
 // this.tgridX =listTemp.length;
 // //println("Col "+this.tgridX);
 // listTemp = null;  // not in use anymore
 // this.tgrid = new Cell[this.tgridX+1][this.tgridY+1];  
 // for (int i = 0; i < this.tlines.length; i++) {
 //   String [] list2 = split ( this.tlines[i], this.separator );
 //   for (int i2 = 0; i2 < list2.length; i2++) {
 // //println("Col= "+this.tgridX);
 //     this.tgrid[i2] [i] = new Cell ( list2[i2],
 //                                     i2 * (this.tgridX) ,
 //                                     (i) *  (this.cellHeight),
 //                                     color (50),
 //                                     color (251, 255, 31),
 //                                     color(200) ,
 //                                     color(200,200,200),
 //                                     color(10,70,10)  );
 //   }
 // }
 // // measure max width of each column 
 // float [] widthOfColumns = new float [this.tgridX+1];
 // for (int i = 0; i < this.tlines.length; i++) {
 //   String [] list2 = split ( this.tlines[i], this.separator );
 //   //println("Col encore "+this.tgridX+"   "+list2.length);

 //   if (this.tgridX != list2.length) {
 //     println ("####### different numbers of columns encountered #########################");
 //   }
 //   for (int i2 = 0; i2 < list2.length; i2++) {
 //     // find the longest text 
 //     if (widthOfColumns[i2] < textWidth(list2[i2])+14) {  widthOfColumns[i2] = textWidth(list2[i2])+14;}
 //   }
 // }

 // // assign the width from above to the columns cells
 // for (int j = 0; j<this.tgridY; j++) {
 //   for (int i = 0; i<this.tgridX; i++) {
 //     // make sure all columns are at least minWidthColumn wide
 //     widthOfColumns[i] = max (widthOfColumns[i], this.tminWidthColumn); 
 //     this.tgrid[i][j].w = widthOfColumns[i];
 //     this.tgrid[i][j].h = this.cellHeight;
 //   }
 // }
 // // assign the x values to cells. 
 // int xCount = 0;
 // for (int i = 0; i<this.tgridX; i++) {
 //   for (int j = 0; j<this.tgridY; j++) {
 //     this.tgrid[i][j].x = xCount;
 //   }
 //   xCount += widthOfColumns[i] + this.spaceBetweenColumns;
 // }
 // this.tCellX=0;
 // this.tCellY=0;
 // this.tstartX=0;
 // this.tstartY=0;
 // this.tgridXtempo=0;
 // this.tgridYtempo=0;
 // this.tSelectedLine=-1;
 // this.tSelectedCol=-1;
 //}
 
  void save(String filename){
   if(this.selected==false) { return; }
   
   if (filename==""){filename=this.currentFilename;}
   else
    {
     this.currentFilename=filename;
//     this.textTab=cheminDeLApplication+extractFileName(filename);
     this.textTab=extractFileName(filename);
    } 
   if (debug) println("Saving " + filename);
  for (int i = 0; i < this.tgridY; i++) {
    String s="";
    for (int i2 = 0; i2 < this.tgridX; i2++) {
      s+=this.tgrid[i2] [i].textCell;// if(i2!=(this.tgridX-1)) { s+=";"; }
      s+=";";
    }
    this.tlines[i]=s;
   }
   saveStrings(filename, this.tlines);
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// New TAB /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

String[] createList(int c, int l){
  // [c;l] = [colonnes;lignes] avec  separator
  String liste[] = new String[l];
  String ligne=str(this.separator);
  for (int x =0 ; x<c-1;x++)  { ligne+=""+str(this.separator); }
  for (int y =0 ; y<l;y++)  { liste[y]=ligne;}
  for (int t=0;t<l;t++)
   {
       println(liste[t]);
   }

  return(liste);  
}

boolean createDir(String nomRepertoire) {
  boolean success=false;
  File repertoire = new File(nomRepertoire);
  if (!repertoire.exists()) {    
    success = repertoire.mkdir(); // create Dir
  } 
 return( success ); 
}

void newTab(int index){ 
  String s =cheminDeLApplication = sketchPath("");
    createDir(cheminDeLApplication+"\\data");
  createDir(cheminDeLApplication+"\\data\\Profiles");
  
  this.currentPath=cheminDeLApplication+"data\\system\\";
//  this.textTab= "new"+index+".csv";
  
  
  this.currentFilename=this.currentPath+"new"+index+".csv";
  println(this.currentFilename);
  this.textTab=extractFileName(this.currentFilename);
  //println("nomFichier  = "+this.textTab);
  //println("nom complet = "+this.currentFilename);
   saveStrings(this.currentFilename, this.createList(nbCol, nbLines));  
  if (debug) println("création  :"+this.currentFilename);
  this.selected=true;
  load(this.currentFilename);  
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


boolean isVisible(){   // retourne true si l'objet est affichable
 boolean res= true;

   this.cx=this.mx+this.x;
   this.cy=this.my+this.y;
   this.new_w=this.w;
   this.new_h=this.h;
//   if ( ((this.cx+this.cellLeftBarWidth)                    >(this.mx+this.mw)) || (this.cx<(this.mx+this.leftBarWidth)) ) {res=false;}
   if ( ((this.cx+this.startLeftCells+this.cellLeftBarWidth)>(this.mx+this.mw)) || (this.cx<(this.mx+this.leftBarWidth)) ) {res=false;}
   else 
    { 
      if ((this.cx+this.w)>(this.mx+this.mw))
       {
         this.new_w=this.mx+this.mw-this.cx;
       }  
    }
   if ( ((this.cy+this.cellTopBarHeigth+this.startTopCells)>(this.my+this.mh)) || (this.cy<(this.my+this.menuBarHeigth)) ) {res=false;}
   else 
    { 
      if ((this.cy+this.h)>(this.my+this.mh))
       {
         this.new_h=this.my+this.mh-this.cy;
       }  
    }   
   return(res);   
}


boolean isOverTab(){
  if(!this.isVisible()) {return(false);}
  boolean res=false;  
  float mx=mouseX-this.cx;
  float my=mouseY-this.cy;
  if((my>-12)&&(my<this.h)&&(mx>0)&&(mx<this.w)) {res=true;}
  return (res);
}

 boolean isOverTOP(){
   if(!this.isVisible()) {return(false);}  
  boolean res=false;
  if (!this.selected) return(res);
  float mx=mouseX-this.cx;
  float my=mouseY-this.cy;
  if((my>-12)&&(my<0)&&(mx>0)&&(mx<this.w)) {res=true;}
  return (res);
}




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// DRAW //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  public void draw (boolean modeLight) {     
   if(!this.isVisible()) {return;}
   printstack("x="+this.x+" y="+this.y+" cx="+this.cx+" cy="+this.cy +" "+
              "w="+this.w+" h="+this.h+" new_w"+new_w+" new_h"+new_h   ) ;
  // println(tSelectedLine+" "+tSelectedCol+"   "+tCellX+" "+tCellY);
   if (!modeLight){
   if (isOverTOP()) {stroke(colCellStroke);}else {stroke(10);}

    if(this.selected==true) 
     { //selectionnée
      fill(colBk);
      stroke(colCellStroke);
      rect(this.cx, this.cy-12, new_w, new_h);
      fill(colText);
      if ((this.textTab.length()*7+this.cx+3)>new_w+this.cx-36) { text("...", this.cx+3, this.cy-2);} else                           { text(this.textTab, this.cx+3, this.cy-2);}
      if ( (this.w)<=(new_w+48) ) {fill(100);   rect(cx+this.w-60, cy-12, 12,12); if(syntaxColor)fill(0,0,255);else fill(200,200,200); text("S", this.cx+this.w-9-48, this.cy-2);}// Coloration syntaxique
      String s; if(bvalEqu) s="E"; else s="V";
      if ( (this.w)<=(new_w+36) ) {fill(100);   rect(cx+this.w-48, cy-12, 12,12);    fill(255);  text(  s, this.cx+this.w-9-36, this.cy-2);            } // Valeur/Equation
      if ( (this.w)<=(new_w+24) ) {fill(100);   rect(cx+this.w-36, cy-12, 12,12);    fill(255);  text("-", this.cx+this.w-9-24, this.cy-2);            } // Minimise
      if ( (this.w)<=(new_w+12) ) {fill(100);   rect(cx+this.w-24, cy-12, 12,12);    noFill();   rect(     this.cx+this.w-24+3, this.cy-9, 12-6,12-5); } // Maximise
      if ( (this.w)<=(new_w+ 0) ) {fill(100);   rect(cx+this.w-12, cy-12, 12,12);    fill(255);  text("X", this.cx+this.w-9-0 , this.cy-2);            } // Close
      fill(colBk);
      rect(this.cx+this.cellLeftBarWidth, this.cy, new_w-this.cellLeftBarWidth, new_h);
      fill(colToolBar); // Left Tools Bar
      rect(this.cx, this.cy,   this.cellLeftBarWidth, new_h);
      fill(colToolBar); // TOP Tools bar
      rect(this.cx+this.cellLeftBarWidth, this.cy,   new_w-this.cellLeftBarWidth, this.cellTopBarHeigth);
      //fill(colText);
      textSize(16);
      fill(0,120,215,255);
      text(this.showString,                         this.cx+this.cellLeftBarWidth, this.cy+this.cellTopBarHeigth-5); 
      fill(18,118,34,255);
      text(this.showVal, textWidth(this.showString)+this.cx+this.cellLeftBarWidth, this.cy+this.cellTopBarHeigth-5);
      textSize(12);
     }
    else
     {//non sélectionnée
      fill(coluBk);
      stroke(colCellStroke);
      rect(this.cx, this.cy-12, new_w, new_h);
      fill(coluText);
      text(this.textTab, this.cx+3, this.cy-2);
      fill(coluBk);
      rect(this.cx+this.cellLeftBarWidth, this.cy, new_w-this.cellLeftBarWidth, new_h);
      fill(coluToolBar);
      rect(this.cx, this.cy,   this.cellLeftBarWidth, new_h);
      fill(coluToolBar); // TOP Tools bar
      rect(this.cx+this.cellLeftBarWidth, this.cy,   new_w-this.cellLeftBarWidth, this.cellTopBarHeigth);
     }
    
    this.update();
    if(this.sizeMode==MODE_MINIMISED){return;}
   }
  
  this.evalAllCells();
  ///////////// Gestion des celulles
  int k=0;  
  int i2=0;

  for (int i = this.tstartY; i < this.tgridY; i++) 
   {
    // numbers on the left side 
    if (( ((k+1)*(this.cellHeight))<(new_h-(this.cellTopBarHeigth+this.startTopCells)) ))//&&( (k+1)*(this.cellHeight+0)<(-this.my+new_h)  ))
     {
      this.tgridYtempo=i-this.tstartY+1;
      fill(255);
      stroke(colCellStroke);
      textAlign(RIGHT, BASELINE);
      text(i+1, this.cx+this.startLeftCells+this.cellLeftBarWidth-2, this.cy+(k+1)*(this.cellHeight)+this.cellTopBarHeigth+this.startTopCells-5);
      textAlign(LEFT, BASELINE);
      stroke(255,255,255);//color ligne separator
      line( this.cx+this.cellLeftBarWidth                       , this.cy+(k+1)*(this.cellHeight)+this.cellTopBarHeigth+this.startTopCells,  
            this.cx+this.startLeftCells+this.cellLeftBarWidth   , this.cy+(k+1)*(this.cellHeight)+this.cellTopBarHeigth+this.startTopCells );

      float totalCellWidth=this.startLeftCells+this.cellLeftBarWidth;//fgthis.tminWidthColumn;  // Calcul de l'espacement des colonnes  
      for ( i2 = this.tstartX; i2 < this.tgridX; i2++) 
       {
            
            //test si la colonne affichée dépasse de la fenetre du Tab
        if ( ((totalCellWidth)<(new_w-(this.startLeftCells+this.cellLeftBarWidth))))//-20)))// &&( (totalCellWidth+this.cx+20)<(new_w+this.mx)  )) 
         {
          if (i2!=tgridX-1) { this.tgridXtempo=(i2+1); }
          else              { this.tgridXtempo=(i2); }
//printStatusBarString(this.tstartX+" "+this.tCellX+"  "+this.tgridXtempo+" "+this.tgridX);
/////////////////////////////////////////////////////////////////////////////////////
// Gestion de la selection de la celulle ou de la ligne ou de la colonne
          boolean selected =false;
          if ( (i2==this.tCellX) && (i==this.tCellY) ) //Permet de surligner la cellule pointée 
           {  
            if (ValidNewString&&(this.tNewVal!="")) // Permet de valider la nouvelle donnée dans la celulle pointée
             {
              if (this.editionEq) {
                                    this.tNewVal = this.tNewVal.replaceAll(" ", ""); 
                                    if(this.tNewVal.length()>1)
                                     {
                                      this.tgrid[i2] [i].equation=this.tNewVal;this.tgrid[i2] [i].textCell="";
                                     }
                                    else
                                     {
                                      this.tgrid[i2] [i].equation="";
                                      this.tgrid[i2] [i].textCell="";
                                     }
                                   }   
              else                { this.tgrid[i2] [i].textCell=this.tNewVal;}
              this.ValidNewString=false;
              this.editionEq=false;
              this.tNewVal="";
             }
            selected =true; this.tCellSelectedText=this.tgrid[i2] [i].textCell;
            Excel.newVal=this.tNewVal;
           }
          if (this.tSelectedLine==(i+1)) { selected=true; }
          if (this.tSelectedCol==(i2+1)) { selected=true; }
          
          if (selected)
           { String sequ="";
             String sval="";
             if (this.tgrid[i2] [i].equation!="") { sequ=this.tgrid[i2] [i].equation+"= ";}
             if (this.tgrid[i2] [i].textCell!="") { sval+=this.tgrid[i2] [i].textCell; }
            this.showString=sequ;
            this.showVal=sval;
           }
// fin de la gestion de la selection de la celulle , de la ligne ou de la colonne
/////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
// Affichagdes celulles
          //this.tgrid[i2][i].updateFromParent(  this.mx+this.startLeftCells+this.cellLeftBarWidth,
          //                                     this.my+this.cellTopBarHeigth+this.startTopCells,
          //                                     this.w,
          //                                     this.h,
          //                                     this.syntaxColor,
          //                                     this.bvalEqu); // echange Parent vers enfant
          this.tgrid[i2][i].updateFromParent(  this.startLeftCells+this.cellLeftBarWidth,
                                               this.cellTopBarHeigth+this.startTopCells,
                                               this.w,
                                               this.h,
                                               this.syntaxColor,
                                               this.bvalEqu); // echange Parent vers enfant
          //affiche temporairement le nouveau texte
          this.tgrid[i2][i].tdisplay(          this.tNewVal,
                                             - this.tgrid[this.tstartX][i].x+this.cx,
//                                               this.cx,
                                               -this.tstartY*(this.cellHeight)+this.cy,
                                               this.cx,
                                               this.new_w,
                                               selected);
// Fin Affichagdes celulles
/////////////////////////////////////////////////////////////////////////////////////
         
         //réaffecte le texte d'origine si pas de validation
      if (i == this.tstartY)   
        { // first line --> draw A,B,C....
          fill(255);
          stroke(255);          
          float _w;
          if ((totalCellWidth-1 * int(this.tgrid[this.tstartX][i].x)+20+int(this.cx))>(this.cx+this.w))
           { _w=this.w-(this.cx+ -1 * int(this.tgrid[this.tstartX][i].x)+20+int(this.x)-this.cx);}
          else {_w=this.w;}
// création des noms des colonnes A,B .... AA,AB... ////////////////////////////////////////////////////////////////////////////////////////////////////////
          String refCol=""; 
          if (i2>(char('Z')-0x41)) {refCol=char(i2/(26)+0x40)+""+char(i2%26+0x41);}
          else{refCol=""+char(i2+0x41);}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          //float tmp_w=tminWidthColumn;
          //if ( (this.cx+totalCellWidth+this.tgrid[i2][i].w)<(this.cx+min(this.w,this.mw-this.cx)+20) ) { tmp_w = this.tgrid[i2][i].w; }
          //else                                                                                         { tmp_w = min(this.w,this.mw-this.cx)+20-totalCellWidth; }
          //text(refCol,this.cx+ totalCellWidth-this.tminWidthColumn/2-5+ tmp_w/2, this.cy+11); // Place la lettre au centre de la colonne
          float tmp_w=tminWidthColumn;
          if ( (this.cx+totalCellWidth+this.tgrid[i2][i].w)<(this.cx+new_w) ) { tmp_w = this.tgrid[i2][i].w; }
          else    
        { tmp_w = min(this.w,new_w)-totalCellWidth; }
          textAlign(CENTER, BOTTOM);
          text(refCol,this.cx+ totalCellWidth+tmp_w/2, this.cy+this.cellTopBarHeigth+this.startTopCells); // Place la lettre au centre de la colonne
          textAlign(LEFT, BASELINE);

          //printStatusBarString(this.cx+this.startLeftCells+" "+this.w+" "+this.mw+" "+totalCellWidth+" "+this.tminWidthColumn+" "+tmp_w/2);
//        startTopCells     cellTopBarHeigth

          stroke(255,255,255);//color col separator
          //line( this.cx+ totalCellWidth-22, this.cy,  
          //      this.cx+ totalCellWidth-22, this.cy+12);
          line( this.cx+ totalCellWidth, this.cy+this.cellTopBarHeigth,
                this.cx+ totalCellWidth, this.cy+this.cellTopBarHeigth+this.startTopCells); // Ligne de separation des colonnes
         // println(this.cx+" "+ totalCellWidth);
         }
         totalCellWidth+=this.tgrid[i2][i].w;   
        }
     
     }// for X
    k++;
  }
 }// for Y
 
 
 if(this.selected){    
  this.isOverLine();
  this.isOverCol();
  this.isOverTOP();
  this.update();
  
  // Affiche les coordonnées de la cellule en haut à gauche
  
  fill(255);
  if ( (this.tCellX==-1)||(this.tCellY==-1) )
   {
     textAlign(RIGHT, BOTTOM);
     text("--",this.cx+this.startLeftCells+this.cellLeftBarWidth-2, this.cy+this.cellTopBarHeigth+this.startTopCells);
     textAlign(LEFT, BASELINE);
   }
  else                                       
   { 
    String refCol=""; 
    if (this.tCellX>(char('Z')-0x41)) {refCol=char(this.tCellX/(26)+0x40)+""+char(this.tCellX%26+0x41);}
    else{refCol=""+char(this.tCellX+0x41);}
    textAlign(RIGHT, BOTTOM);
    text(refCol+(this.tCellY+1),this.cx+this.startLeftCells+this.cellLeftBarWidth-2,this.cy+this.cellTopBarHeigth+this.startTopCells);
    textAlign(LEFT, BASELINE);
//    if (debug) println("texte de la celulle "+this.tgrid[this.tCellX] [this.tCellY].textCell);
    this.tgrid[this.tCellX] [this.tCellY].savedText=this.tgrid[this.tCellX] [this.tCellY].textCell;
   }}
    this.evalAllCells();
 }// func

   
 void update()
   {
     
     this.cellLeftBarWidth = valeur2;
     this.cellTopBarHeigth = valeur3;
     this.startLeftCells   = valeur4;
     this.startTopCells    = valeur5;
     
  //     if(this.sizeMode==MODE_MINIMISED){return;}
     if(this.selected){
////////////////////////////////////////// Solution à la con pour éviter le redimensionnement     
    float tmp_w=this.w;                 // de la fenetre si elle est tronquée 
    float tmp_h=this.h;                 //
    if(!this.isVisible()) {return;}     //
    if (tmp_w!=this.new_w)    {return;} // tronqué en X
    if (tmp_h!=this.new_h)    {return;} // tronqué en Y
//////////////////////////////////////////
    float mx=mouseX-this.cx;
    float my=mouseY-this.cy;

     if ( (my>0)&&(my<this.h) &&
          (mx>(this.w-3)) &&(mx<(this.w+3)))
           {
            this.readyToResiseX=true; 
            fill(255,0,0);
            stroke(10);
            line(this.cx+this.w,this.cy,
            this.cx+this.w,this.cy+this.h);
           }
      else { this.readyToResiseX=false;}
     if ( (mx>0)&&(mx<this.w) &&
          (my>(this.h-3)) &&(my<(this.h+3)))
           {
            this.readyToResiseY=true; 
            fill(255,0,0);
            stroke(10);
            line(this.cx,this.cy+this.h,
            this.cx+this.w,this.cy+this.h);
           }
      else { this.readyToResiseY=false;}
   }  
   
 }


 float checkYExtrema(){
  float res=this.y;
  float _mouseY=mouseY-this.deltaYWhenWinIsDragging+this.menuBarHeigth-1;
  
        if((_mouseY+this.h)>(this.my+this.mh+this.menuBarHeigth))
      {
         res=this.mh-this.h-1;
      }
     else if((_mouseY-12-2*this.menuBarHeigth)  <(this.my  ))
      {
        res=12+this.menuBarHeigth;
      }
     else
      {
       res=_mouseY-this.my+1-this.menuBarHeigth;      
      }
      if (res<this.menuBarHeigth+12) res=this.menuBarHeigth+12;
return(res);
}

float checkXExtrema(){
  float res=this.x;
  float _mouseX=mouseX-this.deltaXWhenWinIsDragging+this.leftBarWidth-1;
        if((_mouseX+this.w-this.leftBarWidth)>(this.mx+this.mw))
      {
         res=this.mw-this.w-1;
      }
     else if((_mouseX-this.leftBarWidth)  <(this.mx+this.leftBarWidth  ))
      {
        res=this.leftBarWidth;
      }
     else
      {
       res=_mouseX-this.mx+1-this.leftBarWidth;      
      }
 if (res<this.leftBarWidth) res=this.leftBarWidth;     
 return(res);
}
  
void mouseWheel(MouseEvent event) {
  if(this.selected==false) { return; }
  float e = event.getCount();  
  if ( (this.tstartY+this.tgridYtempo)<(this.tgridY) ){this.tstartY+=e;}
  if (e<0) {this.tstartY+=e;}
  if (this.tstartY<=0){this.tstartY=0;}
}

  
void mouseClicked() {

  //if(this.selected==false) { return; }

  if (mouseButton == LEFT) 
   {
    if(this.readyToResiseX==true)
    {
     this.resisingX=false;
     this.w=mouseX-this.cx;
    }
     for (int i = this.tstartY; i < (this.tgridY); i++) 
      {
       for (int i2 = this.tstartX; i2 < this.tgridXtempo+1; i2++) 
        {
         boolean selected =false;
         selected = this.tgrid[i2][i].isOver( this.tgrid[this.tstartX][i].x,
                                              -this.tstartY*(this.cellHeight),this.cx,this.cy);
//                                              this.tstartY*(1),this.cx,this.cy);
                                              

         if ( (this.selected)&&(selected==true) )
          {
           this.tCellX=i2;this.tCellY=i;//tabSelected=;
           this.tSelectedLine=-1;
           this.tSelectedCol=-1;
           return;
          }  
         else
          {this.tCellX=-1;this.tCellY=-1;}
        }    
      }
     int l=this.isOverLine();  if( l>0){this.selectLine(l);} else if(l==-1) {this.selectLine(-1);}
     int c=this.isOverCol ();  if( c>0){this.selectCol(c);}  else if(l==-1) {this.selectCol(-1);}   
       if ( (mouseButton == LEFT)  && (this.isOverTOP() && (this.selected=true)) )
      {      
     //  stroke(100);
     //  rect(mx,my,this.w,this.w-h);
     fill(200);
       if ( ((mouseX-this.cx)>(this.w-12))&&((mouseX-this.cx)<this.w- 0))  {  this.bneeToRemoveSheet=true;  }                   // Bouton close --> Provoque une suppression de la sheet selectionnée (dans Excel)
       if ( ((mouseX-this.cx)>(this.w-24))&&((mouseX-this.cx)<this.w-12))  {  this.maximise();     } // Bouton maximise
       if ( ((mouseX-this.cx)>(this.w-36))&&((mouseX-this.cx)<this.w-24))  {  this.minimise();     } // Bouton minimise
       if ( ((mouseX-this.cx)>(this.w-48))&&((mouseX-this.cx)<this.w-36))  {  this.valEqu();       } // Bouton Valeur/Equation
       if ( ((mouseX-this.cx)>(this.w-60))&&((mouseX-this.cx)<this.w-48))  {  changeSyntaxColor(); }                   // Bouton close --> Provoque une suppression de la sheet selectionnée (dans Excel)
     //println((mouseX-this.cx)+" "+ (this.w-36));
      }
   } 
}

void valEqu(){
 if(this.bvalEqu) { this.bvalEqu=false;}
 else             { this.bvalEqu=true; } 
}

void changeSyntaxColor()
{
  if (this.syntaxColor == true) { this.syntaxColor=false; }
  else                          { this.syntaxColor=true;  }
}

void minimise()
 {
   println("Minimise sheet ");
  this.sizeMode=MODE_MINIMISED;
  if (this.sizeMode==MODE_NORMAL){
  this.lastX=this.cx;
  this.lastY=this.cy;
  this.lastW=this.w;
  this.lastH=this.h;}
  this.cx=200;
  this.cy=20;
  this.w=200;
   this.h=12;
 }


void maximise()
 {
   println("Maximise sheet ");
   switch(this.sizeMode)
    {
  case MODE_MINIMISED: {
   this.sizeMode=MODE_NORMAL;
   this.cx=this.lastX;
   this.cy=this.lastY;
   this.w=this.lastW;
   this.h=this.lastH;

      break;}
 case MODE_NORMAL:   {
     if (this.sizeMode==MODE_NORMAL){
  this.lastX=this.cx;
  this.lastY=this.cy;
  this.lastW=this.w;
  this.lastH=this.h;}
   this.sizeMode=MODE_MAXIMISED;
   this.cx=20;
   this.cy=20;
   this.w=mw-this.leftBarWidth;
   this.h=mh-menuBarHeigth-2;
      break;}
 case MODE_MAXIMISED:  {
   this.sizeMode=MODE_NORMAL;
   this.cx=this.lastX;
   this.cy=this.lastY;
   this.w=this.lastW;
   this.h=this.lastH;

      break;}
      
    }
 }
void mousePressed(){
  ///////////////////////////////////////////// Solution à la con pour éviter le redimensionnement     
    float tmp_w=this.w;                    // de la fenetre si elle est tronquée 
    if(!this.isVisible()) {return;}        //
    if (tmp_w!=this.new_w)                 // tronqué en X    
     {if (mouseX>(this.mx+this.mw)) return;//
   }                                       //
/////////////////////////////////////////////

  if (this.isOverTOP()) 
   {
     this.bisOnTOP=true;
     this.deltaXWhenWinIsDragging=mouseX-this.cx;
     this.deltaYWhenWinIsDragging=mouseY-this.cy;
     this.x=this.checkXExtrema();
     this.y=this.checkYExtrema();
   }

  if(this.isOverTab()==true)                                                                                            // Quelle bordel cette référence vers Excel
   {//this.selected=true;                                                                                               //
    needToUnslectAll=true;                                                                                              //
    this.fromMe=true;                                                                                                   //
     if(this.selected==true) {index = -1; }//this.selected=false; }                                                     //
     else {                                                                                                             //  
     this.selected = true;                                                                                              //
      for (int i = 0; i < Excel.sheet.length; i++) {                                                                    //  
        if (Excel.sheet[i] == this) {                                                                                   //
          index = i;                                                                                                    //
          break;                                                                                                        //
        }                                                                                                               //
      }                                                                                                                 //
    }                                                                                                                   //
   }                                                                                                                    //
  
  if ( (mouseButton == LEFT) && (this.readyToResiseX==true) &&(this.selected=true))
   {
    this.resisingX=true;
    this.w=mouseX-this.cx;
    this.sizeMode=MODE_NORMAL;
   }
  if ( (mouseButton == LEFT) && (this.readyToResiseY==true) &&(this.selected=true))
   {
    this.resisingY=true;
    this.h=mouseY-this.cy;
    this.sizeMode=MODE_NORMAL;
   }
  //int l=this.isOverLine();  if( l>0){this.selectLine(l);} else if(l==-1) {this.selectLine(-1);}
  //int c=this.isOverCol ();  if( c>0){this.selectCol(c);}  else if(l==-1) {this.selectCol(-1);} 

}




void mouseReleased(){
 this.resisingX=false;this.readyToResiseX=false;
 this.resisingY=false;this.readyToResiseY=false;
 this.bisOnTOP=false;
}

void mouseDragged(){
 if(this.selected==false) { return; }
 if (this.resisingX==true)
  {
   if ((mouseX)>(this.mx+this.mw-1))  { this.w=this.mx+this.mw-this.cx; }
   else                               { this.w= mouseX-this.cx;  }
   if (this.w<100){this.w=100;}
  }
   if (this.resisingY==true)
  {
   if ((mouseY)>(this.my+this.mh-1))  { this.h=this.my+this.mh-this.cy; }
   else                               { this.h= mouseY-this.cy;  }
   if (this.h<100){this.h=100;}
  }
   if(this.bisOnTOP==true)
   {     
     this.x=this.checkXExtrema(); 
     this.y=this.checkYExtrema();
   }  
 }
 
 
 

void keyPressed() {
  if(this.selected==false)  { return; }
//  println(keyCode);
       if (keyCode==UP)     { if ( this.tCellY>0)                                      { this.tCellY--; }
                              if (( this.tstartY>0  ) && (this.tCellY!=this.tstartY) ) { if (this.tCellY<this.tstartY){this.tstartY--;} }
                              this.tNewVal="";
                              this.editionEq=false;
                            }
  else if (keyCode==33)     { for(int i=0;i<10;i++) // PAGE_UP
                               {
                                if ( this.tCellY>0)                                      { this.tCellY--;  } 
                                if (( this.tstartY>=0  ) && (this.tCellY!=this.tstartY) ) { if (this.tCellY<this.tstartY){this.tstartY--;} }
                               }
                               this.tNewVal="";
                               this.editionEq=false;
                            }
  else if (keyCode==DOWN)   { if ( this.tCellY<this.tgridYtempo)                                           { this.tCellY++; }
                              if ( ((this.tCellY+this.tstartY)>=(this.tgridYtempo-1) ) && ((this.tstartY+this.tgridYtempo)<this.tgridY) ) { this.tstartY++; this.tCellY++; }
                              this.tNewVal="";
                              this.editionEq=false;
                            }                               
  else if (keyCode==34)     { for(int i=0;i<10;i++)// PAGE_DOWN
                               {                                 
                                if ( this.tCellY<this.tgridYtempo)                                           { this.tCellY++; }  
                                if ( ((this.tCellY+this.tstartY)>=(this.tgridYtempo-1) ) && ((this.tstartY+this.tgridYtempo)<this.tgridY) ) { this.tstartY++; this.tCellY++; }
                               }
                               this.tNewVal="";
                               this.editionEq=false;
                            }                               

  else if (keyCode==36)     { this.tCellX=0; // touche HOME
                              this.tstartX=0;
                              this.tNewVal="";
                              this.editionEq=false;
                            }
  else if (keyCode==35)     { this.tCellX=this.tgridX; //touche FIN  
                              this.tstartX=this.tgridX-this.tgridXtempo-1;
                              this.tNewVal="";
                              this.editionEq=false;
                            }
  else if (keyCode==LEFT)   { if(this.tCellX<=this.tstartX) { this.tCellX --;this.tstartX--;this.tNewVal=""; }
                              else                          { this.tCellX --; }
                              this.tNewVal="";
                              this.editionEq=false;
                            } 
 
  else if (keyCode==RIGHT)  {   if(this.tCellX>=(this.tgridXtempo-1)) 
                                 {print(" A");
                                 if ( (this.tCellX<(this.tgridX-1)) &&(this.tCellX!=this.tgridX-1))
                                 //printStatusBarString(this.tstartX+" "+this.tCellX+"  "+this.tgridXtempo+" "+this.tgridX);
                                  { print(" B");
                                    this.tstartX++;this.tCellX++; 
                                  }
                                 
                                } else
                                  {this.tCellX++;}
                                //this.tCellX++;
                                this.tNewVal="";
                                this.editionEq=false;
                                println();
                            }
                          
  else if (keyCode==SHIFT)  {   // inhibition de la touche SHIFT si la chaine n'est pas vide
                              if ( ( this.tNewVal=="")||( this.tNewVal==" "))
                               { if(this.activatedFunction==true)
                                {this.activatedFunction=false;}
                                else {this.activatedFunction=true;}
                                this.tNewVal="";
                               }
                            } // ce qui annule le SHIFT et permet les majuscules 
  else if (keyCode==144)    {   ;   } // ce qui annule la touche VERR NUM
  else if (keyCode==CONTROL){   ;   } // ce qui annule la touche CTRL
  else if (keyCode==20)     {   ;   } // ce qui annule la touche MAJ
  else if (keyCode==524)    {   ;   } // ce qui annule la touche WINDOWS
  else if (keyCode==ALT)    {   ;   } // ce qui annule la touche ALT
  else if (keyCode==130)    {   this.tNewVal+='^';   } // ^
  else if (keyCode==DELETE) {   this.tNewVal="";this.equation="";this.ValidNewString=true; println("DEL"); } 
  else if (keyCode==ENTER)  {   if(this.tNewVal!="") {  this.ValidNewString=true;    }
                                else                 
                                 {  //this.tCellY ++; 
                                this.tNewVal="";              
                                if ( this.tCellY<this.tgridYtempo)                                                                          { this.tCellY++; }
                                if ( ((this.tCellY+this.tstartY)>=(this.tgridYtempo-1) ) && ((this.tstartY+this.tgridYtempo)<this.tgridY) ) { this.tstartY++; this.tCellY++; }
                                }
                            } 
  else if (key==this.separator)  {   ;   } // ce qui annule le 'separator' 
  else if (keyCode==8)      { //touche BackSupp
                             if (this.tNewVal.length() > 0) 
                              {
                               this.tNewVal=this.tNewVal.substring(0, this.tNewVal.length() - 1);
                              }
                              this.tNewVal="";
                            }
  else if (key=='-')        { // inhibition du - si la chaine  n'est pas vide
                              if ( ( this.tNewVal=="")||( this.tNewVal==" "))
                               {                                
                                // suppression de la ligne selectionnée
                                if ((this.tSelectedLine>0)&&(this.tlines.length>1)) 
                                 {
                                  reload(removeLine(this.tlines,this.tSelectedLine-1));
                                 }
                                // SUPPRESSION COLONNE
                                else if ((this.tSelectedCol>0)&&((this.tgridX-1)>0)) // insertion colonne
                                 {
                                  //String[] newCol= new String[this.tgridY];
                                  //for (int y =0 ; y<this.tgridY-1;y++)  { newCol[y]=str(this.separator); }
                                  reload(removeColumn(this.tlines,  this.tSelectedCol-1));
                                 }
                                else{this.tNewVal+=key;}
                                //this.tNewVal="";
                              } else{this.tNewVal+=key;}
                            }
  else if (key=='+')        { // inhibition du + si la chaine  n'est pas vide
                              if ( ( this.tNewVal=="")||( this.tNewVal==" "))
                               {
                              // INSERTION LIGNE
                              if ((this.tSelectedLine>0)&&(this.tlines.length>0)) 
                               {// insere une ligne avant la ligne selectionnée
                                 String newLine="";
                                //println(this.tlines[0]);
                                 for (int x =0 ; x<this.tgridX-1;x++)  { newLine+=str(this.separator); }
                               //println(newLine);
                                 //println(this.tgridX);
                                 reload(addLine(this.tlines,newLine,this.tSelectedLine-1));
      //                          printLines(this.tlines);
                               }
                              // INSERTION COLONNE
                              else if ((this.tSelectedCol>0)&&((this.tgridX)>0)) // insertion colonne
                               {
                                  String[] newColumn = {""};
                                 //String[] newCol= new String[this.tgridY];
                                 //for (int y =0 ; y<this.tgridY-1;y++)  { newCol[y]=str(this.separator); }
                                 reload(addColumn(this.tlines, newColumn, this.tSelectedCol-1));
                               }
                              else{this.tNewVal+=key;}
                              this.tNewVal="";
                              } else{this.tNewVal+=key;}
                             }
  else if(key=='=')          { // Si la string commence par = alors il y a début d'édition d'une equation
                              if ( (this.tNewVal=="")||(this.tNewVal==" ") )
                               { // début d'édition équation
                                this.editionEq=true;
                                this.tNewVal+=key;
                               }
                               else {this.editionEq=false;
                                  this.tNewVal+=key;
                                 }
                             }
  else {
     this.tNewVal+=key;
   }
  //--------------------------
  // boundaries 
  if (this.tCellX<0)  this.tCellX=0;
  if (this.tCellY<0)  this.tCellY=0;
  if (this.tCellX>=(this.tgridX-1))  this.tCellX=this.tgridX-1;
  if (this.tCellY>=(this.tgridY-1))  this.tCellY=this.tgridY-1;
  if (this.tstartX<0) this.tstartX=0;
  
} // func 

 void printLines(String[] lines) {
  for (String line : lines) {
    println(line);
  }
}
  boolean isFocused()        { return(this.selected);} 
  void setFocus(boolean s)   { this.selected=s;       }
  void focus()               { this.selected=true;    }
  void unFocus()             { this.selected=false;   }
  

int isOverLine(){
 //if(this.selected==false) { return; }
 float mx=mouseX-this.cx-this.cellLeftBarWidth;
 float my=mouseY-this.cy-(this.cellTopBarHeigth+this.startTopCells);
 float sy=-1;
 if ((my<0) || (my>this.h) || (mx<0) || (mx>this.new_w)) return(0);
 if (((mx)>0) &&((mx)<this.startLeftCells))
  {
   if ((my>0)&&(my<(this.h))){ sy=floor((my)/this.cellHeight);}
   if ((sy>=0)&&(sy<this.tgridYtempo))//tgridYtempo
    {
     fill(255,100); // avec mise en transparence
     rect( this.cx+this.cellLeftBarWidth,
           this.cy+sy*this.cellHeight+this.cellTopBarHeigth+this.startTopCells,
           this.startLeftCells,
           this.cellHeight);
    }
  }
// printStatusBarString(this.cx+" ["+mx+";"+my+"]" +sy+" "+this.w+" "+this.mw+" "+this.tminWidthColumn);
 if (sy<this.tgridY)
  {    
   return(int(this.tstartY+sy+1));
  }
 return (-1);  
}

int isOverCol(){

  //if(this.selected==false) { return; }
  //this.isVisible();
  
//     line( this.cx+this.cellLeftBarWidth                       , this.cy+(k+1)*(this.cellHeight)+this.cellTopBarHeigth+this.startTopCells,  
  //         this.cx+this.startLeftCells+this.cellLeftBarWidth   , this.cy+(k+1)*(this.cellHeight)+this.cellTopBarHeigth+this.startTopCells );

//  float _mx=mouseX-this.cx;
//  float _my=mouseY-this.cy;
 float mx=mouseX-this.cx-(this.cellLeftBarWidth+this.startLeftCells);
 float my=mouseY-this.cy-(this.cellTopBarHeigth);//+this.startTopCells);

  if ((my<0) || (my>this.startTopCells) || (mx<0) || (mx>new_w-(this.cellLeftBarWidth+this.startLeftCells))) return(0);
  int ntempo=-1;
  float sx=0;
  float totalCellWidth=this.cellLeftBarWidth;//+this.startLeftCells;
  float valTempo=0;
  if (((mx)>0) &&((mx)<new_w-(this.cellLeftBarWidth+this.startLeftCells)) && ((my>0)&&(my<(this.startTopCells)))) // (_my<(this.cellHeight+0))
   {
    
    sx=0;
    totalCellWidth=0;
    
    for (int i=this.tstartX; i < this.tgridX; i++)
     {
      if ( (totalCellWidth<new_w-(this.cellLeftBarWidth+this.startLeftCells))  ) 
       {
         
        if(mx<(totalCellWidth+this.tgrid[i][0].w)){ntempo=i;valTempo=totalCellWidth+this.tgrid[i][0].w;break;}      
         totalCellWidth+=this.tgrid[i][0].w;
       }
     }//rtuhj
    sx=ntempo;//floor((mx-12)/43);
    if ((sx>=0)&&(sx<(this.tgridXtempo+1)))     
     {
      float tmp_w=tminWidthColumn;
      if ( (valTempo)<new_w)  { tmp_w=this.tgrid[ntempo][0].w; }
      else                    { tmp_w=min(this.w,new_w)-totalCellWidth;}//min(this.w,this.mw-this.cx)-totalCellWidth;}
      fill(255,100);// avec mise en transparence
      rect(this.cx+totalCellWidth+(this.cellLeftBarWidth+this.startLeftCells),this.cy+this.cellTopBarHeigth,tmp_w,this.startTopCells);
     }
   }
//  printStatusBarString(this.cx+" ["+mx+";"+my+"]" +ntempo+" "+valTempo+" "+totalCellWidth);

  return (ntempo+1);
  }
  
  void exportLine(int line)
  {
    if(this.selected==false) { return; }
    if (line>0)
    {
      print("Export line "+line +" --> ");
      for (int i=0;i<this.tgridX;i++)
      {
        print(tgrid[i][line-1].textCell+";");        
      }      
      println();
    } 
  }
  



 boolean clearLine(int index){   return (false); }
 boolean deleteLine(int index){  return (false); }
 boolean insertLine(int index){  return (false); }

 boolean clearCol(int index){   return (false); }
 boolean deleteCol(int index){  return (false); }
 boolean insertCol(int index){  return (false); }


 void setCell(String s,int col, int ligne)
  { col-=1; ligne-=1;
   if ( (col<0)||(col>=this.tgridX)||(ligne<0)||(ligne>=this.tgridY) ) return;
   tgrid[col][ligne].textCell=s;
  }
  
 void setEquation(String eq,int col, int ligne)
  { col-=1; ligne-=1;
   if ( (col<0)||(col>=this.tgridX)||(ligne<0)||(ligne>=this.tgridY) ) return;
   tgrid[col][ligne].equation=eq;
  }
  
  void setCell(int i,int col, int ligne)
  { col-=1; ligne-=1;
   if ( (col<0)||(col>=this.tgridX)||(ligne<0)||(ligne>=this.tgridY) ) return;
   tgrid[col][ligne].textCell=str(i);
  }
  
 void setCell(float f,int col, int ligne)
  { col-=1; ligne-=1;
   if ( (col<0)||(col>=this.tgridX)||(ligne<0)||(ligne>=this.tgridY) ) return;
   tgrid[col][ligne].textCell=str(f);
  }

 String getCell(int col, int ligne)
  { col-=1; ligne-=1;
   if ( (col<0)||(col>=this.tgridX)||(ligne<0)||(ligne>=this.tgridY) ) return(null);
   return(tgrid[col][ligne].textCell);
  }

String getEquation(int col, int ligne)
  { col-=1; ligne-=1;
   if ( (col<0)||(col>=this.tgridX)||(ligne<0)||(ligne>=this.tgridY) ) return(null);
   return(tgrid[col][ligne].equation);
  }

int[] getSheetInfo()
 {
  // retourne [nbcol,nblignes]
   int[] res = {this.nbCol+1,this.nbLines};
   return res;
  }
  
//  String evalCell(String textCell){
//    //evalue l'equation textCell
//    try{
//     this.equation = textCell;
     
//     HashSet<String> nomsCellules = this.trouverNomsCellules(this.equation);
//     // place les valeurs des celulles dans valeurs
//      HashMap<String, Float> valeurs = new HashMap<String, Float>();
//    //Random rand = new Random();
//    for (String nom : nomsCellules) {
//      //float n=rand.nextFloat() * 100;
      
//      //avec processing3 j'ai un programme qui me donne une chaine string s="A1",
//      //je veux un programme qui décompose cette chaine pour me donner 2 index ,
//      //le premier recherche la lettre A et renvoie 1 car A est la premiere lettre de l'alphabet ,
//      //et me revoie 1 car apres le A il y a 1,
//      //et dans le cas d'une chaine s="C32",il renverra 3,32
//      //et je veux un résultat sous forme int[]
      
        
        
        
//        //valeurs.put(nom, n);
//    //    println (nom+":"+n);
//    }
//      float resultat = this.evaluerExpression(this.equation, valeurs);
////    println(eval.equation+"="+ resultat);
  
    
//    //tente d'évaluer toutes les celulles d'une sheet
    
    
//    return(str(resultat));
//   }
//    catch (NumberFormatException e) {
//        return("#REF");}    
//  }
  

  

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Classe d'évaluation de l'équation des celulles ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//cEval eval;






float evaluerExpression(String expression, HashMap<String, Float> valeurs) {
    for (String nomCellule : valeurs.keySet()) {
        expression = expression.replaceAll(nomCellule, String.valueOf(valeurs.get(nomCellule)));
    }
    
    // Vérifie si toutes les cellules nécessaires sont présentes
    HashSet<String> nomsCellules = trouverNomsCellules(expression);
    for (String cellule : nomsCellules) {
        if (!valeurs.containsKey(cellule)) {
            return  Float.NaN;//"#REF"; // si tu préfères une chaîne //Float.NaN;
    }
    }
    return eval(expression);
}

//float eval(String expression) {
  
//    expression = expression.replaceAll(" ", "").toUpperCase();

//    Stack<Float> nombres = new Stack<Float>();
//    Stack<Character> operateurs = new Stack<Character>();
//    boolean estDernierCaractereUnOperateur = true; // Pour détecter les nombres négatifs

//    for (int i = 0; i < expression.length(); i++) {
//        char caractere = expression.charAt(i);

//        if ((caractere >= '0' && caractere <= '9') || (caractere == '-' && estDernierCaractereUnOperateur)) {
//            StringBuilder nombreStr = new StringBuilder();
//            int j = i;
//            // Gérer les nombres négatifs
//            if (caractere == '-') {
//                nombreStr.append(caractere);
//                j++;
//            }
//            while (j < expression.length() && ((expression.charAt(j) >= '0' && expression.charAt(j) <= '9') || expression.charAt(j) == '.')) {
//                nombreStr.append(expression.charAt(j));
//                j++;
//            }
//            i = j - 1;
//            nombres.push(Float.parseFloat(nombreStr.toString()));
//            estDernierCaractereUnOperateur = false;
//        } else if (caractere == '(') {
//            operateurs.push(caractere);
//            estDernierCaractereUnOperateur = true;
//        } else if (caractere == ')') {
//            while (operateurs.peek() != '(') {
//                nombres.push(appliquerOperation(operateurs.pop(), nombres.pop(), nombres.pop()));
//            }
//            operateurs.pop();
//            estDernierCaractereUnOperateur = false;
//        } else if (caractere == '+' || caractere == '-' || caractere == '*' || caractere == '/' || caractere == '^') {
//            while (!operateurs.empty() && hasPrecedence(caractere, operateurs.peek())) {
//                nombres.push(appliquerOperation(operateurs.pop(), nombres.pop(), nombres.pop()));
//            }
//            operateurs.push(caractere);
//            estDernierCaractereUnOperateur = true;
//        }
//    }

//    while (!operateurs.empty()) {
//        nombres.push(appliquerOperation(operateurs.pop(), nombres.pop(), nombres.pop()));
//    }

//    return nombres.pop();
//}
float eval(String expression) {
    expression = expression.replaceAll(" ", ""); // Supprimer les espaces (tu peux le garder ou le modifier selon tes besoins)

    Stack<Float> nombres = new Stack<Float>();
    Stack<Character> operateurs = new Stack<Character>();
    boolean estDernierCaractereUnOperateur = true; // Pour détecter les nombres négatifs

    for (int i = 0; i < expression.length(); i++) {
        char caractere = expression.charAt(i);

        if ((caractere >= '0' && caractere <= '9') || (caractere == '-' && estDernierCaractereUnOperateur)) {
            StringBuilder nombreStr = new StringBuilder();
            int j = i;
            // Gérer les nombres négatifs
            if (caractere == '-') {
                nombreStr.append(caractere);
                j++;
            }
            while (j < expression.length() && ((expression.charAt(j) >= '0' && expression.charAt(j) <= '9') || expression.charAt(j) == '.')) {
                nombreStr.append(expression.charAt(j));
                j++;
            }
            i = j - 1;
            nombres.push(Float.parseFloat(nombreStr.toString()));
            estDernierCaractereUnOperateur = false;
        } else if (caractere == '(') {
            operateurs.push(caractere);
            estDernierCaractereUnOperateur = true;
        } else if (caractere == ')') {
            while (operateurs.peek() != '(') {
                nombres.push(appliquerOperation(operateurs.pop(), nombres.pop(), nombres.pop()));
            }
            operateurs.pop();
            estDernierCaractereUnOperateur = false;
        } else if (caractere == '+' || caractere == '-' || caractere == '*' || caractere == '/' || caractere == '^') {
            while (!operateurs.empty() && hasPrecedence(caractere, operateurs.peek())) {
                nombres.push(appliquerOperation(operateurs.pop(), nombres.pop(), nombres.pop()));
            }
            operateurs.push(caractere);
            estDernierCaractereUnOperateur = true;
        }
    }

    while (!operateurs.empty()) {
        nombres.push(appliquerOperation(operateurs.pop(), nombres.pop(), nombres.pop()));
    }
    float n=nombres.pop();
 if (debug) println(" eval="+n);
    return n;
}

boolean hasPrecedence(char operateur1, char operateur2) {
    if (operateur2 == '(' || operateur2 == ')') {
        return false;
    }
    if ((operateur1 == '^' && operateur2 != '^')
            || ((operateur1 == '*' || operateur1 == '/') && (operateur2 == '+' || operateur2 == '-'))) {
        return false;
    }
    return true;
}

float appliquerOperation(char operateur, float b, float a) {
    switch (operateur) {
        case '+':
            return a + b;
        case '-':
            return a - b;
        case '*':
            return a * b;
        case '/':
            if (b == 0) {
                throw new ArithmeticException("Division par zéro.");
            }
            return a / b;
        case '^':
            return pow(a, b);
        default:
            return 0;
    }
}

HashSet<String> trouverNomsCellules(String expression) {
    HashSet<String> nomsCellules = new HashSet<String>();   
    String[] mots = expression.split("[^a-zA-Z0-9]+");
    for (String mot : mots) {
        if (mot.matches("[a-zA-Z]+[0-9]+")) {
            nomsCellules.add(mot);
        }
    }
    
    return nomsCellules;
}


int[] extraireIndices(String s) {
  
  int[] indices = new int[2];
  try {
    if (s == null || s.isEmpty()) {
      throw new IllegalArgumentException("La chaîne est vide ou nulle.");
    }
     if (s == "#REF") {
      throw new IllegalArgumentException("#REF : Référence celulle invalide.");
    }
    int indexLettre = 0;
    while (indexLettre < s.length() && Character.isLetter(s.charAt(indexLettre))) {
      indexLettre++;
    }
    
    if (indexLettre == 0) {
      throw new IllegalArgumentException("Aucune lettre trouvée au début de la chaîne.");
    }
    
    String lettres = s.substring(0, indexLettre);
    int indiceLettres = 0;
    for (int i = 0; i < lettres.length(); i++) {
      indiceLettres = indiceLettres * 26 + (lettres.charAt(i) - 'A' + 1);
    }
    indices[1] = indiceLettres;
    
    if (indexLettre >= s.length()) {
      throw new IllegalArgumentException("Aucun nombre trouvé après les lettres.");
    }
    
    String nombre = s.substring(indexLettre);
    nombre = nombre.replaceAll("[^0-9]", "");
    
    if (nombre.isEmpty()) {
      throw new IllegalArgumentException("Aucun chiffre trouvé après les lettres.");
    }
    
    int indiceNombre = Integer.parseInt(nombre);
    indices[0] = indiceNombre;
    
    // Vérifier s'il y a des lettres après le nombre
    String rest = s.substring(indexLettre + nombre.length());
    for (int i = 0; i < rest.length(); i++) {
      if (Character.isLetter(rest.charAt(i))) {
        throw new IllegalArgumentException("Des lettres trouvées après le nombre.");
      }
    }
    
  } catch (IllegalArgumentException e) {
    System.out.println("ERREUR: " + e.getMessage());
    indices[0] = indices[1] = -1; // Marquer les indices comme invalides
  } catch (Exception e) {
    System.out.println("Une erreur inattendue s'est produite.");
    indices[0] = indices[1] = -1; // Marquer les indices comme invalides
  }
  
  return indices;
}


////////////////////////////////////////////////
String Evaluate(String eq) {
  float resultat=0;
  // efface ici tous les espaces de la formule
  String eq2 = eq.replaceAll("\\s", "").toUpperCase();
  // vérifie si l'équation commence bien par '=' et le supprimer
  if (!eq2.isEmpty() && eq2.charAt(0) == '=') {
            eq2 = eq2.substring(1);
        }
        else {return("#REF");}
//   println("continue with "+eq2);
   
////  cEval eval=new cEval();
// 
////="A1+B2"  
  this.equation = eq2;//"((A1+2-0.85/(A23*sqrt(C54))) * (AE12+A1+A.23) - (C54^2))/(A1+0.0023)";
  HashSet<String> nomsCellules = this.trouverNomsCellules(this.equation);
//nomsCellules= "A1","B2"    
    //if (debug) 
    // { println("Cellules demandées :");
    //  for (String nom : nomsCellules) 
    //   {
    //    println(nom);
    //   }
    // }
    
    HashMap<String, Float> valeurs = new HashMap<String, Float>();
    //Random rand = new Random();
    for (String nom : nomsCellules) 
     {
      int[] indices=this.extraireIndices(nom) ;
      int col   = indices[1];//colonne
      int ligne = indices[0];//ligne
      //vérifier ici si le pointage est dans le tableau
      if ( (col>0)&&(col<tgridX)&&(ligne>0)&&(ligne<tgridY) )
      {
//        String c =Excel.sheet[0].getCell(col,ligne);
        String c =this.getCell(col,ligne);
        float val=0;
        if ( (c=="")||(c==" ") ){return("#REF"); }
        else
         {
      try{val=Float.parseFloat(c);}
      catch (NumberFormatException e) {
    return("#REF"); }
         }
  
      
      //// gérer ici les execptions si le texte n'est pas un nombre
      ////float n=rand.nextFloat() * 100;
        valeurs.put(nom, val);
      //  println (nom+":"+val);
     if(debug)         println (nom+"["+col+";"+ligne+"]="+c);

       }
     }
    resultat = this.evaluerExpression(this.equation, valeurs);
 if (debug)  println(this.equation+"="+ resultat);
    return(str(resultat));    
 }

void evalAllCells(){
 for ( int y=0 ; y<this.tgridY;y++)
  {
   for ( int x=0 ; x<this.tgridX;x++)   
    {
      String equ =this.getEquation(x+1,y+1).toUpperCase();
      if ( (equ!="")&&(equ!=" ") )
       {
  //       print ("Cell["+(x+1)+";"+(y+1)+"]="+equ+ "  |  ");
        String res=this.Evaluate(equ);
        if((res=="#REF")||Float.isNaN(Float.parseFloat(res))){this.setCell("#REF",x+1,y+1);}
       float f=330;
      try {  f =Float.parseFloat(res);this.setCell(f,x+1,y+1); }  catch (NumberFormatException e) { this.setCell("#REF",x+1,y+1); }
       //this.setCell(f,x+1,y+1);
      }
 //     else {this.setCell("#REF",x+1,y+1);}
  //   println();  
  }
}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Fin de Classe d'évaluation de l'équation des celulles ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CLASS CELL /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//  (mx;my)_________________mw____________________
//     |                                          |         Caractéristique d'une celulle
//     |            (x;y)____w_____               |          > textCell : text de la celulle
//     |              |            |              |          > is
//     |              |  textCell  h              |
//     |              |____________|              |
//     |                                          mh
//     |                                          |
//     |                                          |
//     |                                          |
//     |                                          |
//     |__________________________________________|
//
//      
//
//
//
//



public class Cell {
  //
  final float  _version = 1.0;
  final String _author = "Eric MOREL-JEAN";
  final String _libName = "Cell";
  float x;float  cx;   float mx;  
  float y;float  cy;   float my;
  float w ;float mw;float new_w;
  float h ;float mh;float new_h;

  // 
  color colCellFillRect;      // color rect fill  
  color colCellStroke;        // color rect outline
  color colCellFillText;      // color text
  color colCellSelectedText;  // color selectedtext
  color colCellSelectedRect;  // color selected cell
  
  String textCell = "";   // content
  String equation ;
  String savedText;

////// Coloration sytaxique
 color colorIsText;
 color colorIsNumber;
 boolean syntaxColor;
 boolean bisNumber; 
 boolean bvalEqu; 
  // constr 
  Cell ( String text_,  
  float x_, float y_, 
  color cf_, color cs_, color ct_ ,color csel_, color cr_) {

    x = this.cx   = this.mx  = x_;
    y = this.cy   = this.my  = y_;
//    w             = w_;if(this.w<minWidth){this.w=minWidth;}
//    h             = h_;if(this.h<minHeigth){this.h=minHeigth;}
    mw            = this.w;
    mh            = this.h;

    textCell = text_;
    equation = "";
    savedText ="";
    colCellFillRect = cf_;
    colCellStroke   = cs_;
    colCellFillText = ct_;
    colCellSelectedRect = cr_;
    colCellSelectedText = csel_;
    color colorIsNumber = color(0,120,215,255);
    color colorIsText = color (18,118,34,255);
    syntaxColor = true;
    bvalEqu = false;
   // bisNumber = isFloat(text_);
   
    
  } // constr 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

  void updateFromParent(float mx_,float my_,float mw_,float mh_,boolean syntax,boolean eq){
   if (syntax) this.syntaxColor=true; else this.syntaxColor=false;
   this.bvalEqu=eq;
   this.mx=mx_;
   this.my=my_;
   this.mw=mw_;
   this.mh=mh_;; 
   this.cx=this.mx+this.x;
   this.cy=this.my+this.y;
 }



 boolean isFloat(String s)
  {
   try {
    float f1 =Float.parseFloat(s);
    return true; }
   catch (NumberFormatException e) {
    s.replace(',','.');
    try {
     float f2 = Float.parseFloat(s);
     return true; }
    catch (NumberFormatException e2) {
    return(false); } }
  } 
     
 boolean isInteger(String s)
  {
   try {
    int i = Integer.parseInt(s);
    return true; }
   catch (NumberFormatException e) {
    return(false); }
  } 
  
  void tdisplay (String replaceString, float offsetX, float offsetY , float tx, float tw, boolean selected ) 
   {
    fill(colCellFillRect);
    stroke(colCellStroke);
    float _w=w;
    boolean truncate=false;
    if ((this.cx+offsetX+this.w)>(tw+tx))  { _w=tw-(this.cx+offsetX-tx);truncate=true; } // Cell tronquée
    else                                   { _w=w; }
    
    if (selected==true)  { fill(colCellFillRect,100);}    else                 { fill(colCellFillRect)    ;}
    
    rect(this.cx+offsetX, this.cy+offsetY, _w, this.h);
    //println(this.cx+" "+this.cy);
    if (selected==true)  { fill(colCellSelectedText);}    else                 { fill(colCellFillText);}
                
// Affiche le texte de la celulle
 String newText;
 if (this.bvalEqu==false)
   {
    if ( (replaceString!="")&&(selected) ){newText=replaceString;} else{newText= textCell;}
    if (syntaxColor)
    { 
      if(isFloat(textCell))      { fill(0,120,215,255);}//this.colorIsNumber);}
      else                       { fill(18,118,34,255);}//this.colorIsText);}
    }    
    if ( (truncate) && ((textCell.length()*8)>(_w-10)) )   {if  (textCell!="") newText="";} // textWidth(text)
//    if ( (truncate) && ((textCell.length()*8)>(_w-30)) )   {if  (textCell!="") newText="...";}
   }
  else // Affiche la formule de la celulle
   { 
     newText= this.equation;
   }
    text ( newText, cx+5+offsetX, cy+3+offsetY, w, h );
    
  }
 
  boolean isOver ( float offsetX, float offsetY  ,float superX, float superY) {
    boolean res=false;
    //rect(   (cx+offsetX+superX),  (cy+offsetY+superY),
    //        (cx+offsetX+w+superX)-(cx+offsetX+superX),(cy+offsetY+h+superY)-(cy+offsetY+superY));
    if ( ((mouseX)>(cx+offsetX+superX)) && ((mouseX)<(cx+offsetX+this.w+superX)) &&
         ((mouseY)>(cy+offsetY+superY)) && ((mouseY)<(cy+offsetY+this.h+superY)) )
     {res = true;}
//       printstack2(i2+" "+i+" "+ this.tgrid[this.tstartX][i].x+" "+this.tstartY*(this.cellHeight)+" "+this.cx+" "+this.cy+" "+selected);
       //printstack2(offsetX+" "+offsetY+" "+superX+" "+superY+" "+cx+" "+cy+"     "+
       //            (cx+offsetX+superX)+" > "+mouseX+" < "+(cx+offsetX+this.w+superX)+"    "+
       //            (cy+offsetY+superY)+" > "+mouseY+" < "+(cy+offsetY+this.h+superY)+"  "+res);


   return(res);
  }
  


  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // CLASS CELL // FIN //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  }   // fin cCell


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CLASS TAB // FIN ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}  // fin cSheet


//////////////////////////////////
// acceptation des copier/coller
//import controlP5.*;

//ControlP5 cp5;
//Textfield textField;

//void setup() {
//  size(400, 200);
//  cp5 = new ControlP5(this);
  
//  textField = cp5.addTextfield("textField")
//                .setPosition(20, 20)
//                .setSize(200, 30);
//}

//void draw() {
//  background(240);
//}

//void controlEvent(ControlEvent event) {
//  if (event.isAssignableFrom(Textfield.class)) {
//    if (event.getController().getName().equals("textField")) {
//      String inputText = event.getStringValue(); // Obtient le texte du champ de texte
//      println("Texte entré : " + inputText);
//    }
//  }
//}

//void keyEvent(KeyEvent e) {
//  if (textField.isFocus()) {
//    if (e.getAction() == KeyEvent.PRESS && e.getKey() == 'v' && e.isMetaDown()) {
//      String clipboardText = getClipboard(); // Récupère le texte du presse-papiers
//      textField.setText(clipboardText); // Définit le texte du champ de texte avec le contenu du presse-papiers
//    }
//  }
//}

//String getClipboard() {
//  Transferable t = Toolkit.getDefaultToolkit().getSystemClipboard().getContents(null);
//  try {
//    if (t != null && t.isDataFlavorSupported(DataFlavor.stringFlavor)) {
//      return (String) t.getTransferData(DataFlavor.stringFlavor);
//    }
//  } catch (UnsupportedFlavorException | IOException e) {
//    e.printStackTrace();
//  }
//  return "";
//}
