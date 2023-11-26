///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CLASS CELL /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Cell {
  //
    float cx;float x; float mx;  
  float cy;float y; float my;
  float w;float mw;float new_w;
  float h;  float mh;float new_h;

  // 
  color colCellFillRect;  // color rect fill  
  color colCellStroke;    // color rect outline
  color colCellFillText;  // color text
  color colCellSelectedText;  // color selectedtext
  color colCellSelectedRect;  // color selected cell

  String textCell = "";   // content 

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
    colCellFillRect = cf_;
    colCellStroke   = cs_;
    colCellFillText = ct_;
    colCellSelectedRect = cr_;
    colCellSelectedText = csel_;
    
  } // constr 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

  void updateFromParent(float mx_,float my_,float mw_,float mh_){
//   this.leftBarWidth= Excel.getBarWidth();
//   this.menuBarHeigth=Excel.getMenuBarHeigth();
   this.mx=mx_;
   this.my=my_;
   this.mw=mw_;
   this.mh=mh_;; 
   this.cx=this.mx+this.x;
   this.cy=this.my+this.y;
 }
  void updateParent(){
//   this.leftBarWidth= Excel.getBarWidth();
//   this.menuBarHeigth=Excel.getMenuBarHeigth();
   this.mx=Excel.getx();
   this.my=Excel.gety();
   this.mw=Excel.getw();
   this.mh=Excel.geth(); 
   this.cx=this.mx+this.x;
   this.cy=this.my+this.y;
 }



  
  void tdisplay ( int offsetX, int offsetY , float tx, float tw, boolean selected ) {
   // updateParent();
    fill(colCellFillRect);
    stroke(colCellStroke);
    float _w=w;
    boolean trunc=false;
    if ((this.cx+offsetX+this.w)>(tw+tx))  { _w=tw-(this.cx+offsetX-tx);trunc=true; } // Cell tronquée
    else                                   { _w=w; }
    
    if (selected==true)  { fill(colCellSelectedRect);rect(this.cx+offsetX, this.cy+offsetY, _w, this.h);  fill(colCellSelectedText);}
    else                 { fill(colCellFillRect)    ;rect(this.cx+offsetX, this.cy+offsetY, _w, this.h);  fill(colCellFillText);}
    String newText = textCell;
    if ( (trunc) && ((textCell.length()*7)>_w) )   {if  (textCell!="") newText="...";}
    text ( newText, cx+5+offsetX, cy+3+offsetY, w, h );
  }
 
  boolean isOver ( int offsetX, int offsetY  ,float superX, float superY) {
    boolean res=false;
    if ( ((mouseX-superX)>(cx+offsetX)) && ((mouseX-superX)<(cx+offsetX+w)) &&
         ((mouseY-superY)>(cy+offsetY)) && ((mouseY-superY)<(cy+offsetY+h)) )
     {res = true;}
   return(res);
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CLASS CELL // FIN //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
