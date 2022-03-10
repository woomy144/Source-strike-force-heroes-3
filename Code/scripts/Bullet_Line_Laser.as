package
{
   import flash.geom.Point;
   
   public class Bullet_Line_Laser extends Bullet
   {
       
      
      private var line1:Array;
      
      private var line2:Array;
      
      public function Bullet_Line_Laser(_game:Game, _unit:Unit, _rotation:Number, _x:Number, _y:Number, _dist:Number, _gun:Stats_Guns, _extra:Object = null)
      {
         super(_game,_unit,_rotation,_x,_y,_dist,_gun,false,_extra);
         this.line1 = [new Point(ox,oy)];
         this.line2 = [new Point(ox,oy)];
         for(var i:uint = 0; i < uint(maxDist / 10); i++)
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
         doHitEffect();
      }
      
      public function EnterFrame() : void
      {
         var _loc1_:uint = 0;
         game.lineCont.graphics.lineStyle(stats.params[0],stats.params[1],stats.params[2]);
         game.lineCont.graphics.moveTo(this.line1[0].x,this.line1[0].y);
         for(_loc1_ = 1; _loc1_ < this.line1.length; _loc1_++)
         {
            this.line1[_loc1_].x += UT.rand(-1,1);
            this.line1[_loc1_].y += UT.rand(-1,1);
            game.lineCont.graphics.lineTo(this.line1[_loc1_].x,this.line1[_loc1_].y);
         }
         game.lineCont.graphics.lineStyle(stats.params[3],stats.params[4],stats.params[5]);
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
