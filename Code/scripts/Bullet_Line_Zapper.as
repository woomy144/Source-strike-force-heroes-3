package
{
   import flash.geom.Point;
   
   public class Bullet_Line_Zapper extends Bullet
   {
       
      
      private var alpha:Number = 1;
      
      private var line1:Array;
      
      private var line2:Array;
      
      private var strength:Number;
      
      public function Bullet_Line_Zapper(param1:Game, param2:Unit, param3:Number, param4:Number, param5:Number, param6:Number, param7:Stats_Guns, param8:Object = null)
      {
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         super(param1,param2,param3,param4,param5,param6,param7,false,param8);
         this.line1 = [new Point(ox,oy)];
         this.line2 = [new Point(ox,oy)];
         for(_loc9_ = 0; _loc9_ < uint(maxDist / 10); _loc9_++)
         {
            x += xVel;
            y += yVel;
            this.line1.push(new Point(x + UT.rand(-1,1),y + UT.rand(-1,1)));
            this.line2.push(new Point(x + UT.rand(-1,1),y + UT.rand(-1,1)));
            if(hitObject = hitTestAll())
            {
               break;
            }
         }
         curDist = UT.getDist(ox,oy,x,y);
         doHitEffect();
         if(!hitObject)
         {
            this.alpha = 0.8;
            _loc10_ = this.line1.length;
            for(_loc9_ = 1; _loc9_ < _loc10_; _loc9_++)
            {
               this.line1[_loc9_].x += UT.rand(_loc9_ * -1,_loc9_ * 1);
               this.line1[_loc9_].y += UT.rand(_loc9_ * -1,_loc9_ * 1);
               this.line2[_loc9_].x += UT.rand(_loc9_ * -1,_loc9_ * 1);
               this.line2[_loc9_].y += UT.rand(_loc9_ * -1,_loc9_ * 1);
            }
            this.strength = 1.7;
         }
         else
         {
            this.strength = ((maxDist - curDist) / maxDist + 0.1) * 5;
         }
      }
      
      public function EnterFrame() : void
      {
         var _loc1_:uint = 0;
         game.lineCont.graphics.lineStyle(3 * this.strength,stats.params[0],this.alpha * 0.5);
         game.lineCont.graphics.moveTo(this.line1[0].x,this.line1[0].y);
         for(_loc1_ = 1; _loc1_ < this.line1.length; _loc1_++)
         {
            this.line1[_loc1_].x += UT.rand(-1,1);
            this.line1[_loc1_].y += UT.rand(-1,1);
            game.lineCont.graphics.lineTo(this.line1[_loc1_].x,this.line1[_loc1_].y);
         }
         game.lineCont.graphics.lineStyle(2 * this.strength,stats.params[1],this.alpha * 0.8);
         game.lineCont.graphics.moveTo(this.line2[0].x,this.line2[0].y);
         for(_loc1_ = 1; _loc1_ < this.line2.length; _loc1_++)
         {
            this.line2[_loc1_].x += UT.rand(-1,1);
            this.line2[_loc1_].y += UT.rand(-1,1);
            game.lineCont.graphics.lineTo(this.line2[_loc1_].x,this.line2[_loc1_].y);
         }
         removeMe();
      }
   }
}
