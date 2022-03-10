package
{
   public class Bullet_Line_Electric extends Bullet
   {
       
      
      private var line1Path:Array;
      
      private var line2Path:Array;
      
      private var line3Path:Array;
      
      private var alpha:Number = 1;
      
      public function Bullet_Line_Electric(param1:Game, param2:Unit, param3:Number, param4:Number, param5:Number, param6:Number, param7:Stats_Guns, param8:Object = null)
      {
         var _loc9_:uint = 0;
         super(param1,param2,param3,param4,param5,param6,param7,false,param8);
         for(_loc9_ = 0; _loc9_ < uint(maxDist / 10); _loc9_++)
         {
            x += xVel;
            y += yVel;
            if(hitObject = hitTestAll())
            {
               break;
            }
         }
         doHitEffect();
         curDist = Math.round(UT.getDist(ox,oy,x,y));
         var _loc10_:Number = -0.3;
         var _loc11_:Number = 0.3;
         this.line1Path = new Array();
         this.line1Path.push({
            "x":ox,
            "y":oy,
            "lift":UT.rand(_loc10_,_loc11_)
         });
         for(_loc9_ = 0; _loc9_ < curDist; _loc9_ += 30)
         {
            this.line1Path.push({
               "x":ox + UT.xMoveToRot(rotation,_loc9_),
               "y":oy + UT.yMoveToRot(rotation,_loc9_),
               "lift":UT.rand(_loc10_,_loc11_)
            });
         }
         this.line1Path.push({
            "x":x,
            "y":y,
            "lift":UT.rand(_loc10_,_loc11_)
         });
         this.line2Path = new Array();
         this.line2Path.push({
            "x":ox,
            "y":oy,
            "lift":UT.rand(_loc10_,_loc11_)
         });
         for(_loc9_ = 0; _loc9_ < curDist; _loc9_ += 30)
         {
            this.line2Path.push({
               "x":ox + UT.xMoveToRot(rotation,_loc9_),
               "y":oy + UT.yMoveToRot(rotation,_loc9_),
               "lift":UT.rand(_loc10_,_loc11_)
            });
         }
         this.line2Path.push({
            "x":x,
            "y":y,
            "lift":UT.rand(_loc10_,_loc11_)
         });
         this.line3Path = new Array();
         this.line3Path.push({
            "x":ox,
            "y":oy,
            "lift":UT.rand(_loc10_,_loc11_)
         });
         for(_loc9_ = 0; _loc9_ < curDist; _loc9_ += 30)
         {
            this.line3Path.push({
               "x":ox + UT.xMoveToRot(rotation,_loc9_),
               "y":oy + UT.yMoveToRot(rotation,_loc9_),
               "lift":UT.rand(_loc10_,_loc11_)
            });
         }
         this.line3Path.push({
            "x":x,
            "y":y,
            "lift":UT.rand(_loc10_,_loc11_)
         });
         if(stats.params[0])
         {
            for(_loc9_ = 0; _loc9_ < this.line1Path.length; _loc9_++)
            {
               this.line1Path[_loc9_].x += this.line1Path[_loc9_].lift * 10;
               this.line1Path[_loc9_].y += this.line1Path[_loc9_].lift * 10;
               this.line2Path[_loc9_].x += this.line2Path[_loc9_].lift * 10;
               this.line2Path[_loc9_].y += this.line2Path[_loc9_].lift * 10;
               this.line3Path[_loc9_].x += this.line2Path[_loc9_].lift * 10;
               this.line3Path[_loc9_].y += this.line2Path[_loc9_].lift * 10;
            }
         }
         game.lineCont.graphics.lineStyle(stats.params[1],stats.params[2],stats.params[3] * this.alpha);
         for(_loc9_ = 0; _loc9_ < this.line1Path.length; _loc9_++)
         {
            if(_loc9_ == 0)
            {
               game.lineCont.graphics.moveTo(this.line1Path[_loc9_].x,this.line1Path[_loc9_].y);
            }
            else
            {
               game.lineCont.graphics.lineTo(this.line1Path[_loc9_].x,this.line1Path[_loc9_].y);
            }
         }
         game.lineCont.graphics.lineStyle(stats.params[4],stats.params[5],stats.params[6] * this.alpha);
         for(_loc9_ = 0; _loc9_ < this.line2Path.length; _loc9_++)
         {
            if(_loc9_ == 0)
            {
               game.lineCont.graphics.moveTo(this.line2Path[_loc9_].x,this.line2Path[_loc9_].y);
            }
            else
            {
               game.lineCont.graphics.lineTo(this.line2Path[_loc9_].x,this.line2Path[_loc9_].y);
            }
         }
         game.lineCont.graphics.lineStyle(stats.params[4],stats.params[5],stats.params[6] * this.alpha);
         for(_loc9_ = 0; _loc9_ < this.line3Path.length; _loc9_++)
         {
            if(_loc9_ == 0)
            {
               game.lineCont.graphics.moveTo(this.line3Path[_loc9_].x,this.line3Path[_loc9_].y);
            }
            else
            {
               game.lineCont.graphics.lineTo(this.line3Path[_loc9_].x,this.line3Path[_loc9_].y);
            }
         }
      }
      
      public function EnterFrame() : void
      {
         var _loc1_:uint = 0;
         this.alpha -= 0.03;
         game.lineCont.graphics.lineStyle(stats.params[1],stats.params[2],stats.params[3] * this.alpha);
         for(_loc1_ = 0; _loc1_ < this.line1Path.length; _loc1_++)
         {
            this.line1Path[_loc1_].x += this.line1Path[_loc1_].lift;
            this.line1Path[_loc1_].y += this.line1Path[_loc1_].lift;
            if(_loc1_ == 0)
            {
               game.lineCont.graphics.moveTo(this.line1Path[_loc1_].x,this.line1Path[_loc1_].y);
            }
            else
            {
               game.lineCont.graphics.lineTo(this.line1Path[_loc1_].x,this.line1Path[_loc1_].y);
            }
         }
         game.lineCont.graphics.lineStyle(stats.params[4],stats.params[5],stats.params[6] * this.alpha);
         for(_loc1_ = 0; _loc1_ < this.line2Path.length; _loc1_++)
         {
            this.line2Path[_loc1_].x += this.line2Path[_loc1_].lift;
            this.line2Path[_loc1_].y += this.line2Path[_loc1_].lift;
            if(_loc1_ == 0)
            {
               game.lineCont.graphics.moveTo(this.line2Path[_loc1_].x,this.line2Path[_loc1_].y);
            }
            else
            {
               game.lineCont.graphics.lineTo(this.line2Path[_loc1_].x,this.line2Path[_loc1_].y);
            }
         }
         game.lineCont.graphics.lineStyle(stats.params[7],stats.params[8],stats.params[9] * this.alpha);
         for(_loc1_ = 0; _loc1_ < this.line3Path.length; _loc1_++)
         {
            this.line3Path[_loc1_].x += this.line3Path[_loc1_].lift;
            this.line3Path[_loc1_].y += this.line3Path[_loc1_].lift;
            if(_loc1_ == 0)
            {
               game.lineCont.graphics.moveTo(this.line3Path[_loc1_].x,this.line3Path[_loc1_].y);
            }
            else
            {
               game.lineCont.graphics.lineTo(this.line3Path[_loc1_].x,this.line3Path[_loc1_].y);
            }
         }
         if(this.alpha <= 0)
         {
            removeMe();
         }
      }
   }
}
