package
{
   public class Bullet_Proj_Frames extends Bullet
   {
       
      
      private var frame:uint = 0;
      
      private var name:String;
      
      private var bitstats:Object;
      
      public function Bullet_Proj_Frames(_game:Game, _unit:Unit, _rotation:Number, _x:Number, _y:Number, _dist:Number, _gun:Stats_Guns, _extra:Object = null)
      {
         super(_game,_unit,_rotation,_x,_y,_dist,_gun,true,_extra);
         doHitEffect();
         this.bitstats = BH.getBitAniStats(stats.params[0] + 0,"idle");
         this.name = stats.params[0] + UT.irand(0,this.bitstats.rotAmt - 1);
         this.frame = 1;
      }
      
      public function EnterFrame() : void
      {
         var i:uint = 0;
         yVel += stats.params[2] * 0.1;
         if(this.frame >= this.bitstats.frames)
         {
            removeMe();
         }
         else
         {
            for(i = 0; i < stats.params[1]; i++)
            {
               x += xVel;
               y += yVel;
               game.bitscreen.paint(x + game.arena.x,y + game.arena.y,true,this.name,"idle",this.frame);
               if(this.frame < this.bitstats.frames)
               {
                  ++this.frame;
               }
               x += xVel;
               y += yVel;
               if(SD.graphPart)
               {
                  game.bitscreen.paint(x + game.arena.x,y + game.arena.y,true,this.name,"idle",this.frame);
               }
               if(this.frame < this.bitstats.frames - stats.params[3] && (hitObject = hitTestAll()))
               {
                  game.createEffectAtFrame(x,y,stats.params[0],"idle",this.frame);
                  doHitEffect();
                  break;
               }
            }
         }
         if(x < 0 || x > game.arena.wall.width || y < 0 || y > game.arena.wall.height)
         {
            removeMe();
         }
      }
   }
}
