package
{
   import flash.geom.Point;
   
   public class Bullet_Line_Bend extends Bullet
   {
       
      
      private var linePath:Array;
      
      private var alpha:Number = 1;
      
      private var mid:Point;
      
      private var mid1:Point;
      
      private var mid1to:Point;
      
      private var mid2:Point;
      
      private var mid2to:Point;
      
      public function Bullet_Line_Bend(_game:Game, _unit:Unit, _rotation:Number, _x:Number, _y:Number, _dist:Number, _gun:Stats_Guns, _extra:Object = null)
      {
         super(_game,_unit,_rotation,_x,_y,_dist,_gun,false,_extra);
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
         curDist = Math.round(UT.getDist(ox,oy,x,y));
         this.mid = new Point((ox + x) / 2,(oy + y) / 2);
         this.mid1 = new Point((ox + this.mid.x) / 2,(oy + this.mid.y) / 2);
         this.mid2 = new Point((this.mid.x + x) / 2,(this.mid.y + y) / 2);
         var midRand:Point = new Point(UT.rand(-90,90),UT.rand(-90,90));
         this.mid1to = new Point(this.mid1.x + midRand.x,this.mid1.y + midRand.y);
         this.mid2to = new Point(this.mid2.x - midRand.x,this.mid2.y - midRand.y);
         for(var j:uint = 0; j < (stats.params.length - 1) / 3; j++)
         {
            game.lineCont.graphics.lineStyle(stats.params[j * 3 + 1],stats.params[j * 3 + 2],stats.params[j * 3 + 3]);
            game.lineCont.graphics.moveTo(ox,oy);
            game.lineCont.graphics.curveTo(this.mid1.x,this.mid1.y,this.mid.x,this.mid.y);
            game.lineCont.graphics.curveTo(this.mid2.x,this.mid2.y,x,y);
         }
      }
      
      public function EnterFrame() : void
      {
         this.alpha -= 0.1;
         this.mid1.x += (this.mid1to.x - this.mid1.x) * 0.1;
         this.mid1.y += (this.mid1to.y - this.mid1.y) * 0.1;
         this.mid2.x += (this.mid2to.x - this.mid2.x) * 0.1;
         this.mid2.y += (this.mid2to.y - this.mid2.y) * 0.1;
         for(var j:uint = 0; j < (stats.params.length - 1) / 3; j++)
         {
            game.lineCont.graphics.lineStyle(stats.params[j * 3 + 1],stats.params[j * 3 + 2],stats.params[j * 3 + 3] * this.alpha);
            game.lineCont.graphics.moveTo(ox,oy);
            game.lineCont.graphics.curveTo(this.mid1.x,this.mid1.y,this.mid.x,this.mid.y);
            game.lineCont.graphics.curveTo(this.mid2.x,this.mid2.y,x,y);
         }
         if(this.alpha <= 0)
         {
            removeMe();
         }
      }
   }
}
