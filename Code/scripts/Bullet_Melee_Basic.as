package
{
   public class Bullet_Melee_Basic extends Bullet
   {
       
      
      public function Bullet_Melee_Basic(_game:Game, _unit:Unit, _rotation:Number, _x:Number, _y:Number, _dist:Number, _gun:Stats_Guns, _extra:Object = null)
      {
         super(_game,_unit,_rotation,_x,_y,_dist,_gun,true,_extra);
         for(var i:uint = 0; i < uint(maxDist / 10); i++)
         {
            x += xVel;
            y += yVel;
            if(hitObject = hitTestAll())
            {
               break;
            }
         }
         doHitEffect();
         removeMe();
      }
      
      public function EnterFrame() : void
      {
      }
   }
}
