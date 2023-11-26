///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CLASS Sheet ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import java.util.Arrays;
import java.util.List;

class cSheet {
  final float minWidth = 100;
  final float minHeigth = 100;
  color colCellFillRect;  // color rect fill  
  color colCellStroke;    // color rect outline
  color colCellFillText;  // color text
  color colCellSelectedText;  // color selectedtext
  float cx;float x; float mx;  
  float cy;float y; float my;
  float w;float mw;float new_w;
  float h;  float mh;float new_h;
  int nbCol;
  int nbLines;
  float leftBarWidth;
  float menuBarHeigth;
  String textTab;
  boolean selected;
  String currentFilename;
  String currentPath;
  boolean resisingX;
  boolean resisingY;
  boolean readyToResiseX;
  boolean readyToResiseY;
  boolean bisOnTOP;
  float deltaXWhenWinIsDragging;
  boolean fromMe;
  boolean activatedFunction;
  int index;
  boolean bisVisible;

  //////////////////////////////////
  // Variables propres au tableur //
  //////////////////////////////////
  Cell[][] tgrid;
  final int spaceBetweenColumns = 0;
  final int cellHeight = 20;
  final int tminWidthColumn = 43;
  final char separator = ';';
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
  ctSeq  tSeq;
  boolean tSeqCreated;
  boolean winIsDragging;
  
  // constr 
  cSheet ( String text_,   float x_, float y_, float w_ , float h_ ) 
   {
    ValidNewString=false;
    textTab  = text_;
    currentPath= sketchPath("");
    x = this.cx   = this.mx  = x_;
    y = this.cy   = this.my  = y_;
    w             = w_;if(this.w<minWidth){this.w=minWidth;}
    h             = h_;if(this.h<minHeigth){this.h=minHeigth;}
    mw            = this.w;
    mh            = this.h;
    nbCol    = 6;   if(nbCol  >99) { nbCol=99;} if(nbCol<1) { nbCol=1;} 
    nbLines  = 10;   if(nbLines>99) { nbLines=99;} if(nbLines<1) { nbLines=1;}
    tstartX  = 0;
    tstartY  = 0;
    colCellFillRect = color (50);
    colCellStroke   = color (251, 255, 31);
    colCellFillText = color (200);
    colCellSelectedText = color(250,0,0);
    selected=true;
    resisingX =false;
    resisingY =false;
    readyToResiseX=false;
    readyToResiseY=false;
    bisOnTOP = false;
    deltaXWhenWinIsDragging=0;
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

   } 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
void updateParent(){
   this.leftBarWidth= Excel.getBarWidth();
   this.menuBarHeigth=Excel.getMenuBarHeigth();
   this.mx=Excel.getx();
   this.my=Excel.gety();
   this.mw=Excel.getw();
   this.mh=Excel.geth();    
   fill(0);
   text("Excel("+mx+";"+my+")" +"["+mw+";"+mh+"]",5,height-2);
 }
 

void createSeq(){
    tSeq= new ctSeq(this);
    this.tSeqCreated=true;
  }

void selectLine(int selected)  { this.tCellX=-1;this.tCellY=-1; this.tSelectedLine=selected; this.tSelectedCol=-1;       }
void selectCol(int selected)   { this.tCellX=-1;this.tCellY=-1; this.tSelectedLine=-1;       this.tSelectedCol=selected; }


String extractFileName(String chemin) {
  String[] parties = split(chemin, '\\');
  return parties[parties.length - 1];
}

void load(String filename) {
  if(this.selected==false) { return; }
  this.tlines = loadStrings(filename);
  this.currentFilename=filename;
  this.textTab=extractFileName(filename);
  this.tgridY = this.tlines.length;
  this.nbLines = this.tgridY; 
  String [] listTemp = split ( this.tlines[0], this.separator );
  this.tgridX =listTemp.length;
  listTemp = null;  // not in use anymore
  this.tgrid = new Cell[this.tgridX+1][this.tgridY+1];  
  for (int i = 0; i < this.tlines.length; i++) {
    String [] list2 = split ( this.tlines[i], this.separator );
    for (int i2 = 0; i2 < list2.length; i2++) {
      this.tgrid[i2] [i] = new Cell ( list2[i2],
                                i2 * (width/this.tgridX) + 12, (i) *  (this.cellHeight+0)+12,
                                color (50), color (251, 255, 31), color(200) ,color(200,200,200),color(70)  );
    }
  }
  // measure max width of each column 
  float [] widthOfColumns = new float [this.tgridX+1];
  for (int i = 0; i < this.tlines.length; i++) {
    String [] list2 = split ( this.tlines[i], this.separator );
    if (this.tgridX != list2.length) {
      println ("####### different numbers of columns encountered #########################");
    }
    for (int i2 = 0; i2 < list2.length; i2++) {
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
  int xCount = 21;
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
  void save(String filename){
   if(this.selected==false) { return; }
   if (filename==""){filename=this.currentFilename;} 
  for (int i = 0; i < this.tgridY; i++) {
    String s="";
    for (int i2 = 0; i2 < this.tgridX; i2++) {
      s+=this.tgrid[i2] [i].textCell; if(i2!=(this.tgridX-1)){s+=";";}
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
  for (int x =0 ; x<c-1;x++)  { ligne+=str(this.separator); }
  for (int y =0 ; y<l;y++)  { liste[y]=ligne;}
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
    createDir(cheminDeLApplication+"/data");
  createDir(cheminDeLApplication+"/data/Profiles");
  
  this.currentPath=cheminDeLApplication+"data/system/";
  this.textTab= "new"+index+".csv";
  this.currentFilename=this.currentPath+this.textTab;
  //println("nomFichier  = "+this.textTab);
  //println("nom complet = "+this.currentFilename);
   saveStrings(this.currentFilename, this.createList(nbCol, nbLines));  
  this.selected=true;
  load(this.currentFilename);  
}

void createNewTab()
{
  //Excel.
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


boolean isVisible(){   // retourne true si l'objet est affichable
 boolean res= true;
   this.updateParent();
   this.cx=this.mx+this.x;
   this.cy=this.my+this.y;
   this.new_w=this.w;
   this.new_h=this.h;
   if ( ((this.cx+20)>(this.mx+this.mw)) || (this.cx<(this.mx+this.leftBarWidth)) ) {res=false;}
   else 
    { 
      if ((this.cx+this.w)>(this.mx+this.mw))
       {
         this.new_w=this.mx+this.mw-this.cx;
       }  
    }
   if ( ((this.cy+12)>(this.my+this.mh)) || (this.cy<(this.my+this.menuBarHeigth)) ) {res=false;}
   else 
    { 
      if ((this.cy+this.h)>(this.my+this.mh))
       {
         this.new_h=this.my+this.mh-this.cy-2;
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

//void drawWithoutUpgrade()
// { 
//   if(!this.isVisible()) {return;}
//   this.updateParent();
//   this.cx=this.mx+this.x;
//   this.cy=this.my+this.y;
//   fill(200);
//   stroke(colCellStroke);
//   rect(this.cx, this.cy-12, new_w, 12);    
//   fill(0);
//   text(this.textTab, this.cx+3, this.cy-2);
//   fill(155);
//   stroke(colCellStroke);
//   rect(this.cx, this.cy, new_w, new_h);
// }



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// DRAW //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  public void draw (boolean modeLight) {
   if(!this.isVisible()) {return;}
   this.updateParent();
   if (!modeLight){
   if (isOverTOP()) {stroke(colCellStroke);}else {stroke(10);}

    if(this.selected==true)
     { //selectionné
      fill(100);
      stroke(colCellStroke);
      rect(this.cx, this.cy-12, new_w, new_h);
      fill(255);
      text(this.textTab, this.cx+3, this.cy-2);
     }
    else
     {//non sélectionné
      fill(200);
      stroke(colCellStroke);
      rect(this.cx, this.cy-12, new_w, 12);    
      fill(0);
      text(this.textTab, this.cx+3, this.cy-2);
     }
    
//if(this.selected==false) { return; }
  fill(100);
    rect(this.cx, this.cy, new_w, new_h);
//  this.isOverTOP();
 // this.selected=isOverTab();
 
  
  this.update();
  }
 ///////////// Gestion des celulles
   int k=0;
  
   int i2=0;
  for (int i = this.tstartY; i < this.tgridY; i++) 
   {
    // numbers on the left side 
 if (( ((k+1)*(this.cellHeight+0)+this.cellHeight/2+2)<(new_h) ))//&&( (k+1)*(this.cellHeight+0)<(-this.my+new_h)  ))
  {
    this.tgridYtempo=i-this.tstartY+1;
    fill(255);
    stroke(colCellStroke);
    text(i+1, this.cx+3, this.cy+k*(this.cellHeight+0)+28);
    line( this.cx+ 0 , this.cy+(k+1)*(this.cellHeight+0)+this.cellHeight/2+2,  
          this.cx+20 , this.cy+(k+1)*(this.cellHeight+0)+this.cellHeight/2+2 );
    // the inner for loop (x)
 
    float totalCellWidth=this.tminWidthColumn;  // Calcul de l'espacement des colonnes  
    for ( i2 = this.tstartX; i2 < this.tgridX; i2++) 
    {
     //test si la colonne affichée dépasse de la fenetre du Tab
     if ( ((totalCellWidth)<(new_w-20)))// &&( (totalCellWidth+this.cx+20)<(new_w+this.mx)  )) 
      {
       this.tgridXtempo=i2;
        boolean selected =false;
/////////////////////////////////////////////////////////////////////////////////////
// Gestion de la selection de la celulle ou de la lig,ne ou de la colonne
         if ( (i2==this.tCellX) && (i==this.tCellY) ) //Permet de surligner la cellule pointée 
          {  
           //if ((this.tNewVal!="")) // Permet de valider la nouvelle donnée dans la celulle pointée
           // { 
           //  this.tgrid[i2] [i].textCell=this.tNewVal;
           //  if(ValidNewString)
           //  {
           //   ValidNewString=false;
           //   this.tNewVal="";
           //  }
           // }
           if (ValidNewString&&(this.tNewVal!="")) // Permet de valider la nouvelle donnée dans la celulle pointée
            { 
             this.tgrid[i2] [i].textCell=this.tNewVal;
             ValidNewString=false;
             this.tNewVal="";
            }
           selected =true; this.tCellSelectedText=this.tgrid[i2] [i].textCell;
          }
         if (this.tSelectedLine==(i+1)) { selected=true; }
         if (this.tSelectedCol==(i2+1)) { selected=true; }
// fin de la gestion de la selection de la celulle ou de la lig,ne ou de la colonne
/////////////////////////////////////////////////////////////////////////////////////
         this.tgrid[i2][i].updateFromParent(this.mx,this.my,this.mw,this.mh); // echange Parent vers enfant
         this.tgrid[i2][i].tdisplay( -1 * int(this.tgrid[this.tstartX][i].x)+22+int(this.x), -this.tstartY*(this.cellHeight+0)+int(this.y),
                                                                                    this.cx,                                        this.w, selected);
     
       if (i == this.tstartY)
        { // first line --> draw A,B,C....
          fill(255);
          stroke(255);
          
          float _w=w;
   
          
          if ((totalCellWidth-1 * int(this.tgrid[this.tstartX][i].x)+22+int(this.cx))>(this.cx+this.w))
           { _w=this.w-(this.cx+ -1 * int(this.tgrid[this.tstartX][i].x)+22+int(this.x)-this.cx);}else {_w=w;}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        String refCol=""; 
      if (i2>(char('Z')-0x41)) {refCol=char(i2/(26)+0x40)+""+char(i2%26+0x41);}
      else{refCol=""+char(i2+0x41);}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//      
//          text(char(i2+0x41),this.x+ totalCellWidth-this.tminWidthColumn+18+(this.tgrid[i2][i].w)/2, this.y+this.cellHeight/2); // Place la lettre au centre dfe la colonne
          text(refCol,this.cx+ totalCellWidth-this.tminWidthColumn+18+(this.tgrid[i2][i].w)/2, this.cy+this.cellHeight/2); // Place la lettre au centre de la colonne
        }
       totalCellWidth+=this.tgrid[i2][i].w;    
     }
     
     }// for
    k++;
  }
 }// for  
 if(this.selected){    
  this.isOverLine();
  this.isOverCol();
  this.isOverTOP();
  this.update();
  
  // Affiche les coordonnées de la cellule en haut à gauche
  
  fill(255);
  if ( (this.tCellX==-1)||(this.tCellY==-1) ){  text("--",2+this.cx, 12+this.cy);}
  else                                       
   { 
    String refCol=""; 
    if (this.tCellX>(char('Z')-0x41)) {refCol=char(this.tCellX/(26)+0x40)+""+char(this.tCellX%26+0x41);}
    else{refCol=""+char(this.tCellX+0x41);}
    text(refCol+(this.tCellY+1),2+this.cx,12+ this.cy);
   }}
 }// func

   
 void update()
   {
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
   }  }


 float checkYExtrema(){
  float res=this.y;
  float _mouseY=mouseY+this.menuBarHeigth;
  
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
  float _mouseX=mouseX-this.deltaXWhenWinIsDragging+this.leftBarWidth;
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
     for (int i = this.tstartY; i < this.tgridY; i++) 
      {
       for (int i2 = this.tstartX; i2 < this.tgridX; i2++) 
        {
         boolean selected =false;
         selected = this.tgrid[i2][i].isOver( -1 * int(this.tgrid[this.tstartX][i].x)+22,
                                               -   this.tstartY*(this.cellHeight+0),this.x,this.y);
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
     this.x=this.checkXExtrema();
     this.y=this.checkYExtrema();
   }

  if(this.isOverTab()==true)
   {//this.selected=true;
    needToUnslectAll=true;
    this.fromMe=true;
     if(this.selected==true) {index = -1; }//this.selected=false; }
     else {
     this.selected = true;
      for (int i = 0; i < Excel.sheet.length; i++) {
        if (Excel.sheet[i] == this) {
          index = i; 
          break;
        }
      }
    }
   }
  
  if ( (mouseButton == LEFT) && (this.readyToResiseX==true) &&(this.selected=true))
   {
    this.resisingX=true;
    this.w=mouseX-this.cx;
   }
  if ( (mouseButton == LEFT) && (this.readyToResiseY==true) &&(this.selected=true))
   {
    this.resisingY=true;
    this.h=mouseY-this.cy;
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
  println(keyCode);
       if (keyCode==UP)     { if ( this.tCellY>0)                                    { this.tCellY--; }
                              if (( this.tstartY>0  ) && (this.tCellY!=this.tstartY) ) { if (this.tCellY<this.tstartY){this.tstartY--;} }
                            }
       if (keyCode==33)     { for(int i=0;i<10;i++)
                               {
                                if ( this.tCellY>0)                                    { this.tCellY--;  } // PAGE_UP
                                if (( this.tstartY>=0  ) && (this.tCellY!=this.tstartY) ) { if (this.tCellY<this.tstartY){this.tstartY--;} }
                               }
                            }
  else if (keyCode==DOWN)   { if ( this.tCellY<this.tgridYtempo)                                           { this.tCellY++; }
                              if ( ((this.tCellY+this.tstartY)>=(this.tgridYtempo-1) ) && ((this.tstartY+this.tgridYtempo)<this.tgridY) ) { this.tstartY++; this.tCellY++; } 
                            }                               
  //else if (keyCode==34)     { for(int i=0;i<10;i++)
  //                             {
  //                              if ( this.tCellY<this.tgridYtempo)                                           { this.tCellY++; }  // PAGE_DOWN
  //                              if ( ((this.tCellY+this.tstartY)>=(this.tgridYtempo-1) ) && ((this.tstartY+this.tgridYtempo)<this.tgridY) ) { this.tstartY++; this.tCellY++; }
  //                             } 
  //                          }                               

  else if (keyCode==LEFT)   { if(this.tCellX<=this.tstartX) { this.tCellX --;this.tstartX--;this.tNewVal=""; }
                              else                          { this.tCellX --; }
                            }  
  else if (keyCode==RIGHT)  {   if(this.tCellX>=(this.tgridXtempo)) { if (this.tCellX<(this.tgridX-1))this.tstartX++; }
                                this.tCellX++;
                                this.tNewVal="";
                            }
                          
  else if (keyCode==SHIFT)  {   if(this.activatedFunction==true)
                                {this.activatedFunction=false;}
                                else {this.activatedFunction=true;}
                            } // ce qui annule le SHIFT et permet les majuscules 
  else if (keyCode==144)    {   ;   } // ce qui annule la touche VERR NUM
  else if (keyCode==CONTROL){   ;   } // ce qui annule la touche CTRL
  else if (keyCode==20)     {   ;   } // ce qui annule la touche MAJ
  else if (keyCode==524)    {   ;   } // ce qui annule la touche WINDOWS
  else if (keyCode==ALT)    {   ;   } // ce qui annule la touche ALT
  else if (keyCode==DELETE) {   this.tNewVal=" ";this.ValidNewString=true;  } 
  else if (keyCode==ENTER)  {   if(this.tNewVal!="") {  this.ValidNewString=true;  }
                                else                 {  this.tCellY ++;             }
                            } 
  else if (key==this.separator)  {   ;   } // ce qui annule le 'separator' 
  else {
     // Saisie d'un nombre
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

 
  boolean isFocused()        { return(this.selected);} 
  void setFocus(boolean s)   { this.selected=s;       }
  void focus()               { this.selected=true;    }
  void unFocus()             { this.selected=false;   }
  

int isOverLine(){
     this.updateParent();
  //if(this.selected==false) { return; }
  float mx=mouseX-this.cx;
  float my=mouseY-this.cy;
  float sy=-1;
  if ((my<0) || (my>this.h) || (mx<0) || (mx>this.w)) return(0);
  if (((mx)>0) &&((mx)<22))
  {
    if ((my>12)&&(my<(this.h))){ sy=floor((my-12)/this.cellHeight);}
    if ((sy>=0)&&(sy<this.tgridYtempo))//tgridYtempo
     {
      fill(255,100); // avec mise en transparence
      rect(this.cx,this.cy+sy*this.cellHeight+12,22,this.cellHeight);
     }
  }
  
  if (sy<this.tgridY)
   {
     return(int(this.tstartY+sy+1));
   }
 // else 
 {
  return (-1);}  
}

int isOverCol(){
  this.updateParent();
  //if(this.selected==false) { return; }
  float mx=mouseX-this.cx;
  float my=mouseY-this.cy;
  if ((my<0) || (my>this.h) || (mx<0) || (mx>this.w)) return(0);
  int ntempo=-1;
  if (((mx)>22) &&((mx)<this.w) && ((my>0)&&(my<(this.cellHeight+0+2))))
   {
    float sx=0;
    float totalCellWidth=22;  // Calcul de l'espacement des colonnes
    for (int i=this.tstartX; i < this.tgridX; i++)
     {
      if ( (totalCellWidth<(this.w))  ) 
       {
        if(mx<(totalCellWidth+this.tgrid[i][0].w)){ntempo=i;break;}      
        totalCellWidth+=this.tgrid[i][0].w;
       }
     }
    sx=ntempo;//floor((mx-12)/43);
    if ((sx>=0)&&(sx<(this.tgridXtempo+1)))
     {
      fill(255,100);// avec mise en transparence
      rect(this.cx+totalCellWidth,this.cy,this.tgrid[ntempo][0].w,12);
     }
   }
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
  




///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SWITCH DES FENETRES ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//cFen fenetreAdeplacer = fenetres.get(5); // Récupérez la fenêtre à déplacer
//fenetres.remove(5); // Retirez la fenêtre de sa position actuelle
//fenetres.add(fenetreAdeplacer); // Ajoutez-la à la fin du tableau
//fenetres.add(0, fenetreAdeplacer); // Ajoutez-la en première position du tableau
//
// int position = Arrays.asList(Tab).indexOf(fenetre); permet de connaitre l'indice de la fenetre dans le tableau
//
void switchOnTOP(int index)
 { // Place la fenetre d'indice index en début du tableau
 }
 String getName(){ return(this.currentFilename);}
 void remove(int index){}
 void add(cSheet T){}
} 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CLASS TAB // FIN ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
