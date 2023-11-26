// Gestion de la séquence du Tab
 
boolean running=false;




void execLine(cSheet sheet,int y){
  print("Step:"+sheet.tgrid[0][y-1].textCell+'\t');
  print("Volt:"+sheet.tgrid[1][y-1].textCell+'\t');
  print("Curr:"+sheet.tgrid[2][y-1].textCell+'\t');
  print("Time:"+sheet.tgrid[3][y-1].textCell+'\t');
  print("Ramp:"+sheet.tgrid[4][y-1].textCell+'\t');
  print("Repeat:"+sheet.tgrid[5][y-1].textCell);
}

void execLine2(cSheet sheet,int y){
  
  for (int i=0 ; i<sheet.tgridX;i++){
  print(sheet.tgrid[i][y].textCell+" | ");
  } 
}

  
public class ctSeq {
//  cTab TabTempo;
  int actualSeq;
  int totalSeq;
  boolean isRunning;
  int step;
  float volt;
  float current;
  int time;
  float ramp;
  int repeat;
  int totalRepeat;
  int go;
  int timeStart;
  int timeToGo;

  
  
ctSeq  (cSheet sheet)
  {
     this.actualSeq=0;
     this.step    = int  (sheet.tgrid[0][this.actualSeq].textCell);
     this.volt    = float(sheet.tgrid[1][this.actualSeq].textCell);
     this.current = float(sheet.tgrid[2][this.actualSeq].textCell);
     this.time    = int  (sheet.tgrid[3][this.actualSeq].textCell);
     this.ramp    = float(sheet.tgrid[4][this.actualSeq].textCell);
     this.repeat  = int  (sheet.tgrid[5][this.actualSeq].textCell);
     this.totalRepeat=this.repeat;     
     this.go      = int  (sheet.tgrid[6][this.actualSeq].textCell);
  }


String print(cSheet sheet,int n){
  String s;
  if (this.isRunning==true) {s="RUNNING ";} else {s="STOP ";}
  s+="Step:"+sheet.tgrid[0][n].textCell+"/" +sheet.tgridY +  
  " Volt:"+sheet.tgrid[1][n].textCell+'\t' + 
  " Curr:"+sheet.tgrid[2][n].textCell+'\t' +
  " Time:"+sheet.tgrid[3][n].textCell+'\t' +
  " Ramp:"+sheet.tgrid[4][n].textCell+'\t' +
  " Repeat:"+sheet.tgrid[5][n].textCell;
  return(s);
}

void start (cSheet sheet){
  maPile.clear();
  pointsClear();
  this.actualSeq=0; // placer ici la valeur de ligne de la premiere ligne utile du tableau --> pour éviter les commentaires
  sheet.selectLine (this.actualSeq+1);
  this.isRunning=true;
  this.totalSeq=sheet.tgridY;
  this.next(sheet);  
  println("Start Seq");
}

void stop (cSheet sheet){
//  println("STOP");
  this.actualSeq=1; 
  sheet.selectLine (this.actualSeq+1);
  this.isRunning=false;
  sheet.selected=true;
  sheet.load(sheet.currentFilename);
    println("Stop Seq");
}

 void process(cSheet sheet){
  if (this.isRunning==true)
   {
    sheet.selectLine (this.actualSeq+1); 
    printstack();
    printStatusBarString(this.print(sheet,this.actualSeq));
    if ( (millis()-this.timeStart)>this.timeToGo )
     { 
      //Test ici si la sequance est fini // nb repeat ...etc....
      if(this.repeat>0)
       {
          this.flush(sheet);     
        //if(this.repeat==0){
        this.actualSeq=this.go;
      sheet.selectLine (this.actualSeq+1);
    
       }
       else{
     boolean _finish=false;
     do{
      this.actualSeq++;
      sheet.selectLine (this.actualSeq+1);
      if(this.actualSeq>=sheet.tgridY){_finish=true;}
     }while((this.next(sheet)==true)&&(_finish==false));
     
   
     }
    }
      points.add(nPoints++,this.volt );
      plot1.setPoints(points);
   }  
  }
  
 
 
 void flush (cSheet sheet)
  {
//     this.step    = int  (sheet.tgrid[0][this.actualSeq].textCell);
     this.volt    += this.ramp;sheet.tgrid[1][this.actualSeq].textCell=nf(this.volt,0,2);
     MCP7425Write(this.volt);
   //   points.add(nPoints++,this.volt );
   //plot1.setPoints(points);

//     this.current = float(sheet.tgrid[2][this.actualSeq].textCell);
     this.time    = int  (sheet.tgrid[3][this.actualSeq].textCell);
     //this.ramp    = float(sheet.tgrid[4][this.actualSeq].textCell);
     this.repeat--;sheet.tgrid[5][this.actualSeq].textCell=nf(this.repeat,0,0);
     this.repeat  = int  (sheet.tgrid[5][this.actualSeq].textCell);
     //this.totalRepeat=this.repeat;
     //this.go      = int  (sheet.tgrid[6][this.actualSeq].textCell);
     //this.print(this.actualSeq);
     this.timeStart=millis();
     this.timeToGo=this.time;
   
  }
 
 boolean next(cSheet sheet){
   boolean ignore=false;
  if(this.actualSeq<this.totalSeq)
    {
        String s =sheet.tgrid[0][this.actualSeq].textCell;
        float temp= float(s);
        if(temp!=temp) //isNan
        {ignore=true;}
        if (ignore==false)
        {
        this.step    = int  (sheet.tgrid[0][this.actualSeq].textCell);
      
      
     this.volt    = float(sheet.tgrid[1][this.actualSeq].textCell);
     this.current = float(sheet.tgrid[2][this.actualSeq].textCell);
     this.time    = int  (sheet.tgrid[3][this.actualSeq].textCell);
     this.ramp    = float(sheet.tgrid[4][this.actualSeq].textCell);
     this.repeat  = int  (sheet.tgrid[5][this.actualSeq].textCell);
     this.go      = int  (sheet.tgrid[6][this.actualSeq].textCell)-1;
     if(this.repeat<=1){this.repeat=1;this.go=this.step;}  // ?????????????????????????????????????????????????????
 //  if ( this.repeat>0 ){     maPile.push(this.actualSeq,this.repeat,this.go);}
 
     //this.totalRepeat=this.repeat;
     
     //this.print(this.actualSeq);
     this.timeStart=millis();
     this.timeToGo=this.time;
     //int[] couple = maPile.pop();
     //if ( (this.repeat>1 && (couple!=null)) )
     // {        
     //  this.actualSeq = couple[0];
     //  this.repeat    = couple[1];
     //  this.go        = couple[2];
     // }
     //else
     // {
     //  maPile.push(this.actualSeq,this.repeat,this.go);
     // }
        }
    }
    else
    {
      this.stop(sheet);
    }
 return (ignore);
}

}
