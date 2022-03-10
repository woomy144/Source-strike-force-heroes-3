package
{
   public class Bullet_Proj_Follow extends Bullet
   {
       
      
      var countDistX:Number;
      
      var countDistY:Number;
      
      public function Bullet_Proj_Follow(_game:Game, _unit:Unit, _rotation:Number, _x:Number, _y:Number, _dist:Number, _gun:Stats_Guns, _extra:Object = null)
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
         var _loc1_:uint = 0;
         yVel += stats.params[2] * 0.1;
         rotation = UT.getRotation(x,y,x + xVel,y + yVel);
         for(_loc1_ = 0; _loc1_ < game.units.length; _loc1_++)
         {
            if(game.units[_loc1_] != unit)
            {
               if(!game.units[_loc1_].dead)
               {
                  if(!(unit.team && unit.team == game.units[_loc1_].team))
                  {
                     if(UT.getDist(x,y,game.units[_loc1_].x,game.units[_loc1_].y - 40) < stats.params[3])
                     {
                        rotation += UT.rotateDirection(rotation,UT.getRotation(x,y,game.units[_loc1_].x,game.units[_loc1_].y - 40)) * stats.params[4];
                     }
                  }
               }
            }
         }
         xVel = UT.xMoveToRot(rotation,5);
         yVel = UT.yMoveToRot(rotation,5);
         for(_loc1_ = 0; _loc1_ < stats.params[1]; _loc1_++)
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
