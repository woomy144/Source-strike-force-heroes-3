package
{
   public class Bullet_Line_Sniper extends Bullet
   {
       
      
      private var linePath:Array;
      
      private var alpha:Number = 1;
      
      public function Bullet_Line_Sniper(param1:Game, param2:Unit, param3:Number, param4:Number, param5:Number, param6:Number, param7:Stats_Guns, param8:Object = null)
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
         var _loc10_:Number = !!stats.params[0] ? Number(0.2) : Number(-0.2);
         var _loc11_:Number = !!stats.params[0] ? Number(0.5) : Number(0.2);
         this.linePath = new Array();
         this.linePath.push({
            "x":ox,
            "y":oy,
            "lift":UT.rand(_loc10_,_loc11_)
         });
         for(_loc9_ = 0; _loc9_ < curDist; _loc9_ += 30)
         {
            this.linePath.push({
               "x":ox + UT.xMoveToRot(rotation,_loc9_),
               "y":oy + UT.yMoveToRot(rotation,_loc9_),
               "lift":UT.rand(_loc10_,_loc11_)
            });
         }
         this.linePath.push({
            "x":x,
            "y":y,
            "lift":UT.rand(_loc10_,_loc11_)
         });
         for(var _loc12_:uint = 0; _loc12_ < (stats.params.length - 1) / 3; _loc12_++)
         {
            game.lineCont.graphics.lineStyle(stats.params[_loc12_ * 3 + 1],stats.params[_loc12_ * 3 + 2],stats.params[_loc12_ * 3 + 3]);
            for(_loc9_ = 0; _loc9_ < this.linePath.length; _loc9_++)
            {
               if(_loc9_ == 0)
               {
                  game.lineCont.graphics.moveTo(this.linePath[_loc9_].x,this.linePath[_loc9_].y);
               }
               else
               {
                  game.lineCont.graphics.lineTo(this.linePath[_loc9_].x,this.linePath[_loc9_].y);
               }
            }
         }
      }
      
      public function EnterFrame() : void
      {
         var _loc1_:uint = 0;
         this.alpha -= 0.03;
         for(_loc1_ = 0; _loc1_ < this.linePath.length; this.linePath[_loc1_].y -= this.linePath[_loc1_].lift,_loc1_++)
         {
         }
         for(var _loc2_:uint = 0; _loc2_ < (stats.params.length - 1) / 3; _loc2_++)
         {
            game.lineCont.graphics.lineStyle(stats.params[_loc2_ * 3 + 1],stats.params[_loc2_ * 3 + 2],stats.params[_loc2_ * 3 + 3] * this.alpha);
            for(_loc1_ = 0; _loc1_ < this.linePath.length; _loc1_++)
            {
               if(_loc1_ == 0)
               {
                  game.lineCont.graphics.moveTo(this.linePath[_loc1_].x,this.linePath[_loc1_].y);
               }
               else
               {
                  game.lineCont.graphics.lineTo(this.linePath[_loc1_].x,this.linePath[_loc1_].y);
               }
            }
         }
         if(this.alpha <= 0)
         {
            removeMe();
         }
      }
   }
}
