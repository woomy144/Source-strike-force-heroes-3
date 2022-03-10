package
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   
   public class BH extends MovieClip
   {
      
      private static var BitAr:Array;
      
      public static var BITS:Object;
       
      
      public var MC:MovieClip;
      
      public var complete:Boolean;
      
      private var main:Main;
      
      private var curFrame:uint;
      
      private var _rotAmt:uint;
      
      private var _rotDgr:Number;
      
      private var r:uint;
      
      private var newBit:BitmapData;
      
      public var rotate:int;
      
      public function BH(_main:Main)
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,3,this.frame4,4,this.frame5,5,this.frame6,6,this.frame7,7,this.frame8,8,this.frame9,9,this.frame10,10,this.frame11,11,this.frame12,12,this.frame13,13,this.frame14,14,this.frame15,15,this.frame16,16,this.frame17,17,this.frame18,18,this.frame19,19,this.frame20,20,this.frame21,21,this.frame22,22,this.frame23,23,this.frame24,24,this.frame25,25,this.frame26,26,this.frame27,27,this.frame28,28,this.frame29,29,this.frame30,30,this.frame31,31,this.frame32,32,this.frame33,33,this.frame34,34,this.frame35,35,this.frame36,36,this.frame37,37,this.frame38,38,this.frame39,39,this.frame40,40,this.frame41,41,this.frame42,42,this.frame43,43,this.frame44,44,this.frame45,45,this.frame46,46,this.frame47,47,this.frame48,48,this.frame49,49,this.frame50,50,this.frame51,51,this.frame52,52,this.frame53,53,this.frame54,54,this.frame55,55,this.frame56,56,this.frame57,57,this.frame58,58,this.frame59,59,this.frame60,60,this.frame61,61,this.frame62,62,this.frame63,63,this.frame64);
         trace("THIS IS THE PROPPER BH");
         this.main = _main;
         BitAr = new Array();
         BITS = new Object();
         this.complete = false;
         this.curFrame = 1;
         this.r = 0;
      }
      
      public static function getBitAniStats(name:String, sub:String) : Object
      {
         if(!BITS[name] || !BITS[name].sub[sub])
         {
            trace("Bit",name,sub,"not found!");
         }
         return {
            "name":name,
            "sub":sub,
            "width":BITS[name].width,
            "height":BITS[name].height,
            "frames":BITS[name].sub[sub].frames,
            "pos":BITS[name].sub[sub].pos,
            "rotAmt":BITS[name].rotAmt
         };
      }
      
      public static function getBit(name:String, sub:String = "", frame:uint = 1) : BitmapData
      {
         try
         {
            if(!sub)
            {
               return BitAr[BITS[name].pos];
            }
            return BitAr[BITS[name].sub[sub].pos + (frame - 1)];
         }
         catch(e:Error)
         {
            trace("Error: Could not find bit: " + name + ", " + sub + ", " + frame);
            return BitAr[BITS["error"].pos];
         }
      }
      
      public function setup() : *
      {
         var subOb:Object = null;
         var curLabel:String = null;
         var j:uint = 0;
         if(this.MC)
         {
            this._rotAmt = this.rotate > 0 ? uint(this.rotate - 1) : uint(this.rotate);
            this._rotDgr = 360 / this._rotAmt;
            this.MC.rotation = this.r * this._rotDgr;
            subOb = new Object();
            curLabel = "";
            for(j = 1; j <= this.MC.totalFrames; j++)
            {
               this.MC.gotoAndStop(j);
               if(this.MC.currentLabel != curLabel)
               {
                  curLabel = this.MC.currentLabel;
                  subOb[curLabel] = {
                     "pos":BitAr.length,
                     "frames":0
                  };
               }
               ++subOb[curLabel].frames;
               this.newBit = new BitmapData(width,height,true,0);
               this.newBit.draw(this);
               BitAr.push(this.newBit);
            }
            BITS[currentLabel + "" + this.r] = {
               "sub":subOb,
               "width":width,
               "height":height,
               "rot":this.rotate,
               "rotAmt":this._rotAmt
            };
            trace("BH","Finished",currentLabel + "" + this.r);
            if(this.r < this._rotAmt)
            {
               ++this.r;
            }
            else
            {
               this.r = 0;
               if(this.curFrame == totalFrames)
               {
                  this.doComplete();
               }
               else
               {
                  ++this.curFrame;
                  gotoAndStop(1);
                  gotoAndStop(this.curFrame);
               }
            }
         }
         else
         {
            trace("ERROR: No MC at " + currentLabel);
         }
      }
      
      public function doComplete() : void
      {
         this.complete = true;
         this.main.renderDone();
      }
      
      function frame1() : *
      {
         this.rotate = 0;
      }
      
      function frame2() : *
      {
         this.rotate = 3;
      }
      
      function frame3() : *
      {
         this.rotate = 3;
      }
      
      function frame4() : *
      {
         this.rotate = 0;
      }
      
      function frame5() : *
      {
         this.rotate = 4;
      }
      
      function frame6() : *
      {
         this.rotate = 4;
      }
      
      function frame7() : *
      {
         this.rotate = 3;
      }
      
      function frame8() : *
      {
         this.rotate = 3;
      }
      
      function frame9() : *
      {
         this.rotate = 3;
      }
      
      function frame10() : *
      {
         this.rotate = 3;
      }
      
      function frame11() : *
      {
         this.rotate = 3;
      }
      
      function frame12() : *
      {
         this.rotate = 3;
      }
      
      function frame13() : *
      {
         this.rotate = 4;
      }
      
      function frame14() : *
      {
         this.rotate = 4;
      }
      
      function frame15() : *
      {
         this.rotate = 4;
      }
      
      function frame16() : *
      {
         this.rotate = 4;
      }
      
      function frame17() : *
      {
         this.rotate = 3;
      }
      
      function frame18() : *
      {
         this.rotate = 4;
      }
      
      function frame19() : *
      {
         this.rotate = 3;
      }
      
      function frame20() : *
      {
         this.rotate = 3;
      }
      
      function frame21() : *
      {
         this.rotate = 3;
      }
      
      function frame22() : *
      {
         this.rotate = 0;
      }
      
      function frame23() : *
      {
         this.rotate = 4;
      }
      
      function frame24() : *
      {
         this.rotate = 0;
      }
      
      function frame25() : *
      {
         this.rotate = 0;
      }
      
      function frame26() : *
      {
         this.rotate = 0;
      }
      
      function frame27() : *
      {
         this.rotate = 0;
      }
      
      function frame28() : *
      {
         this.rotate = 0;
      }
      
      function frame29() : *
      {
         this.rotate = 0;
      }
      
      function frame30() : *
      {
         this.rotate = 0;
      }
      
      function frame31() : *
      {
         this.rotate = 0;
      }
      
      function frame32() : *
      {
         this.rotate = 0;
      }
      
      function frame33() : *
      {
         this.rotate = 0;
      }
      
      function frame34() : *
      {
         this.rotate = 0;
      }
      
      function frame35() : *
      {
         this.rotate = 0;
      }
      
      function frame36() : *
      {
         this.rotate = 0;
      }
      
      function frame37() : *
      {
         this.rotate = 0;
      }
      
      function frame38() : *
      {
         this.rotate = 0;
      }
      
      function frame39() : *
      {
         this.rotate = 0;
      }
      
      function frame40() : *
      {
         this.rotate = 0;
      }
      
      function frame41() : *
      {
         this.rotate = 0;
      }
      
      function frame42() : *
      {
         this.rotate = 0;
      }
      
      function frame43() : *
      {
         this.rotate = 0;
      }
      
      function frame44() : *
      {
         this.rotate = 0;
      }
      
      function frame45() : *
      {
         this.rotate = 0;
      }
      
      function frame46() : *
      {
         this.rotate = 0;
      }
      
      function frame47() : *
      {
         this.rotate = 0;
      }
      
      function frame48() : *
      {
         this.rotate = 0;
      }
      
      function frame49() : *
      {
         this.rotate = 0;
      }
      
      function frame50() : *
      {
         this.rotate = 0;
      }
      
      function frame51() : *
      {
         this.rotate = 0;
      }
      
      function frame52() : *
      {
         this.rotate = 3;
      }
      
      function frame53() : *
      {
         this.rotate = 3;
      }
      
      function frame54() : *
      {
         this.rotate = 0;
      }
      
      function frame55() : *
      {
         this.rotate = 0;
      }
      
      function frame56() : *
      {
         this.rotate = 0;
      }
      
      function frame57() : *
      {
         this.rotate = 0;
      }
      
      function frame58() : *
      {
         this.rotate = 3;
      }
      
      function frame59() : *
      {
         this.rotate = 3;
      }
      
      function frame60() : *
      {
         this.rotate = 3;
      }
      
      function frame61() : *
      {
         this.rotate = 3;
      }
      
      function frame62() : *
      {
         this.rotate = 0;
      }
      
      function frame63() : *
      {
         this.rotate = 0;
      }
      
      function frame64() : *
      {
         this.rotate = 0;
      }
   }
}
