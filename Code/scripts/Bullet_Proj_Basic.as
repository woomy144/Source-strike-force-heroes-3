package
{
   public class Bullet_Proj_Basic extends Bullet
   {
       
      
      var countDistX:Number;
      
      var countDistY:Number;
      
      public function Bullet_Proj_Basic(_game:Game, _unit:Unit, _rotation:Number, _x:Number, _y:Number, _dist:Number, _gun:Stats_Guns, _extra:Object = null)
      {
         super(_game,_unit,_rotation,_x,_y,_dist,_gun,true,_extra);
         doHitEffect();
         xVel *= 0.5;
         yVel *= 0.5;
         this.countDistX = _dist * Math.abs(xVel);
         this.countDistY = _dist * Math.abs(yVel);
      }
      
      public function EnterFrame() : void
      {
         yVel += stats.params[2] * 0.1;
         for(var i:uint = 0; i < stats.params[1]; i++)
         {
            game.createEffect(x,y,stats.params[0]);
            x += xVel;
            y += yVel;
            if(SD.graphPart)
            {
               game.createEffect(x,y,stats.params[0]);
            }
            x += xVel;
            y += yVel;
            this.countDistX += Math.abs(xVel) * 2;
            this.countDistY += Math.abs(yVel) * 2;
            if(hitObject = hitTestAll())
            {
               break;
            }
         }
         doHitEffect();
         if(UT.getPythagorean(this.countDistX,this.countDistY) >= maxDist)
         {
            removeMe();
         }
         if(x < 0 || x > game.arena.wall.width || y < 0 || y > game.arena.wall.height)
         {
            removeMe();
         }
      }
   }
}
