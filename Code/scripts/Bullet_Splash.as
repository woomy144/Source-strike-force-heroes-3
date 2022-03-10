package
{
   public class Bullet_Splash extends Bullet
   {
       
      
      var countDistX:Number;
      
      var countDistY:Number;
      
      public function Bullet_Splash(_game:Game, _unit:Unit, _rotation:Number, _x:Number, _y:Number, _dist:Number, _id:Stats_Guns, _extra:Object = null)
      {
         super(_game,_unit,_rotation,_x,_y,_dist,_id,true,_extra);
         if(!stats.params[0])
         {
            hitType = "unit";
            hitObject = unit;
         }
         if(stats.effHit)
         {
            game.createEffect(x,y,stats.effHit);
         }
         checkSplash();
         removeMe();
      }
      
      public function EnterFrame() : void
      {
      }
   }
}
