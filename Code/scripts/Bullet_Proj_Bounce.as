package
{
   public class Bullet_Proj_Bounce extends Bullet
   {
       
      
      private var fc = 0;
      
      public function Bullet_Proj_Bounce(_game:Game, _unit:Unit, _rotation:Number, _x:Number, _y:Number, _dist:Number, _gun:Stats_Guns, _extra:Object = null)
      {
         super(_game,_unit,_rotation,_x,_y,_dist,_gun,true,_extra);
         extra.bounce = 0;
         doHitEffect();
         xVel *= 0.5;
         yVel *= 0.5;
      }
      
      public function EnterFrame() : void
      {
         ++this.fc;
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
            if(hitObject = hitTestAll(0,0,true))
            {
               break;
            }
            if(hitTestWall(0,0))
            {
               if(hitTestWall(0,15))
               {
                  ++extra.bounce;
                  y -= yVel * 4;
                  yVel *= -0.5;
                  xVel *= 0.8;
               }
               if(hitTestWall(0,-15))
               {
                  ++extra.bounce;
                  y -= yVel * 4;
                  yVel *= -0.5;
                  xVel *= 0.8;
               }
               if(hitTestWall(10,-10))
               {
                  ++extra.bounce;
                  x -= xVel * 2;
                  xVel *= -0.6;
                  yVel *= 0.7;
               }
               if(hitTestWall(-10,-10))
               {
                  ++extra.bounce;
                  x -= xVel * 2;
                  xVel *= -0.6;
                  yVel *= 0.7;
               }
            }
         }
         doHitEffect();
         if(this.fc == stats.params[3] * 30)
         {
            doHitEffect(true);
         }
         if(x < 0 || x > game.arena.wall.width || y < 0 || y > game.arena.wall.height)
         {
            removeMe();
         }
      }
   }
}
