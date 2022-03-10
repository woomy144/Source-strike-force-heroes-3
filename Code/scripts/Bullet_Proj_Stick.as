package
{
   public class Bullet_Proj_Stick extends Bullet
   {
       
      
      private var fc:uint = 0;
      
      private var xOff:Number = 0;
      
      private var yOff:Number = 0;
      
      public function Bullet_Proj_Stick(_game:Game, _unit:Unit, _rotation:Number, _x:Number, _y:Number, _dist:Number, _gun:Stats_Guns, _extra:Object = null)
      {
         super(_game,_unit,_rotation,_x,_y,_dist,_gun,true,_extra);
         xVel *= 0.5;
         yVel *= 0.5;
      }
      
      public function EnterFrame() : void
      {
         var i:uint = 0;
         if(!hitObject)
         {
            yVel += stats.params[2] * 0.1;
            for(i = 0; i < stats.params[1]; i++)
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
               if(hitObject = hitTestAll())
               {
                  if(hitType == "unit")
                  {
                     this.xOff = x - hitObject.x;
                     this.yOff = y - hitObject.y;
                  }
                  if(hitType == "corpse")
                  {
                     this.xOff = x - hitObject.rdBody.GetDefinition().userData.x;
                     this.yOff = y - hitObject.rdBody.GetDefinition().userData.y;
                     extra.corpseStick = true;
                  }
                  break;
               }
            }
         }
         else
         {
            ++this.fc;
            if(hitType == "unit")
            {
               x = hitObject.x + this.xOff;
               y = hitObject.y + this.yOff;
               if(hitObject.dead)
               {
                  hitObject = hitObject.dead;
                  hitType = "corpse";
                  extra.corpseStick = true;
               }
            }
            if(hitType == "corpse")
            {
               x = hitObject.rdBody.GetDefinition().userData.x + this.xOff;
               y = hitObject.rdBody.GetDefinition().userData.y + this.yOff;
            }
            game.createEffect(x,y,stats.params[0]);
            if(this.fc == stats.params[3] * 30)
            {
               doHitEffect();
            }
         }
         if(x < 0 || x > game.arena.wall.width || y < 0 || y > game.arena.wall.height)
         {
            removeMe();
         }
      }
   }
}
