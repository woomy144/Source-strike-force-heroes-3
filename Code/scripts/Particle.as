package
{
   public class Particle
   {
       
      
      private var game:Game;
      
      public var remove:Boolean;
      
      private var behave:String;
      
      private var name:String;
      
      private var sub:String;
      
      private var x:Number;
      
      private var y:Number;
      
      private var hitFrame:uint;
      
      private var stats:Object;
      
      private var frame:uint;
      
      private var holdFrame:Boolean;
      
      private var xSpd:Number;
      
      private var ySpd:Number;
      
      private var xVel:Number;
      
      private var yVel:Number;
      
      private var extra:Object;
      
      private var hitCount:uint;
      
      private var rotation:Number;
      
      private var fc:uint;
      
      public function Particle(_game:Game, _x:Number, _y:Number, _behave:String, _hitFrame:uint, _extra:Object, _name:String, _sub:String, _frame:uint)
      {
         super();
         this.game = _game;
         this.x = _x;
         this.y = _y;
         this.fc = 0;
         this.behave = _behave;
         this.hitFrame = _hitFrame;
         this.name = _name;
         this.sub = _sub;
         this.extra = !!_extra ? _extra : {};
         this.stats = BH.getBitAniStats(this.name + 0,this.sub);
         this.rotation = UT.irand(0,this.stats.rotAmt - 1);
         if(_frame)
         {
            this.frame = _frame;
            this.holdFrame = true;
         }
         else
         {
            this.frame = 1;
         }
         this.name += this.rotation;
         switch(this.behave)
         {
            case "loop":
               break;
            case "fairy":
               this.extra.rot1 = Math.random() * 360;
               this.extra.rot2 = Math.random() * 360;
               break;
            case "space":
               this.extra.rot1 = Math.random() * 360;
               this.extra.rot2 = Math.random() * 360;
               break;
            case "waterdrop":
               this.holdFrame = true;
               this.xSpd = UT.rand(-1,1);
               this.ySpd = UT.rand(0,1);
               break;
            case "water":
               this.xSpd = UT.rand(this.extra.min,this.extra.max);
               this.ySpd = UT.rand(-1,3);
               break;
            case "snow":
               this.xSpd = UT.rand(0,1);
               this.ySpd = UT.rand(3,5);
               break;
            case "rain":
               this.holdFrame = true;
               this.xSpd = UT.rand(0,1);
               this.ySpd = UT.rand(30,38);
               break;
            case "shell":
               this.xSpd = UT.xMoveToRot(this.extra.rot - 110 * this.extra.flip + UT.rand(-15,15),8);
               this.ySpd = UT.yMoveToRot(this.extra.rot - 110 * this.extra.flip + UT.rand(-15,15),8);
               break;
            case "spark":
               this.xSpd = UT.rand(-2,2);
               this.ySpd = UT.rand(-1,3);
               if(this.extra.xSpd)
               {
                  this.xSpd = this.extra.xSpd;
               }
               if(this.extra.ySpd)
               {
                  this.ySpd = this.extra.ySpd;
               }
               break;
            case "geiser":
               this.xSpd = UT.rand(-2,2);
               this.ySpd = UT.rand(-1,0);
               if(this.extra.xSpd)
               {
                  this.xSpd = this.extra.xSpd;
               }
               if(this.extra.ySpd)
               {
                  this.ySpd = this.extra.ySpd;
               }
               break;
            case "leaf":
               this.hitFrame = 10;
               this.xSpd = UT.rand(0,1);
               this.ySpd = UT.rand(0.5,3);
               this.rotation = Math.random() * 360;
               break;
            case "raise":
               this.ySpd = UT.rand(1,3) * _extra.ySpd;
               this.xSpd = !!(this.ySpd * this.extra.xSpd) ? Number(this.extra.xSpd) : Number(0);
               break;
            case "move":
               this.ySpd = this.extra.ySpd;
               this.xSpd = this.extra.xSpd;
               break;
            case "fish":
               this.extra.rot1 = Math.random() * 360;
               this.extra.rot2 = Math.random() * 360;
               break;
            case "text":
               this.ySpd = -1;
               this.yVel = 20;
               this.holdFrame = true;
               this.frame = 1;
               break;
            case "slowText":
               this.ySpd = -0.7;
               this.yVel = 35;
         }
      }
      
      public function EnterFrame() : void
      {
         var i:uint = 0;
         if(this.game.destroyed)
         {
            return;
         }
         if(this.remove)
         {
            return;
         }
         ++this.fc;
         switch(this.behave)
         {
            case "fairy":
               this.extra.rot1 += 1;
               this.extra.rot2 += 2;
               this.x += UT.xMoveToRot(this.extra.rot1,1);
               this.y += UT.yMoveToRot(this.extra.rot2,0.6);
               this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,this.frame);
               break;
            case "space":
               this.extra.rot1 += 0.3;
               this.extra.rot2 += 0.6;
               this.x += UT.xMoveToRot(this.extra.rot1,1);
               this.y += UT.yMoveToRot(this.extra.rot2,0.6);
               this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,this.frame);
               break;
            case "waterdrop":
               this.x += this.xSpd;
               this.y += this.ySpd;
               this.ySpd += 0.5;
               if(!this.hitCount && (this.hitTest() || this.hitTestPlayer()))
               {
                  this.y -= this.ySpd;
                  this.ySpd = 0;
                  this.hitCount = 1;
               }
               this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,this.frame);
               if(this.hitCount)
               {
                  ++this.frame;
                  if(this.frame == this.stats.frames)
                  {
                     this.remove = true;
                  }
               }
               break;
            case "water":
               this.x += this.xSpd;
               this.y += this.ySpd;
               this.ySpd += 0.5;
               if(!this.hitCount)
               {
                  if(this.fc >= this.hitFrame && this.hitTest())
                  {
                     this.hitCount = 1;
                  }
                  for(i = 0; i < this.game.units.length; i++)
                  {
                     if(!this.game.units[i].dead)
                     {
                        if(UT.inBox(this.x,this.y,this.game.units[i].x - 25,this.game.units[i].y - 70,50,50))
                        {
                           this.hitCount = 1;
                        }
                     }
                  }
               }
               if(this.hitCount == 1)
               {
                  this.xSpd *= 3;
                  this.y -= this.ySpd;
                  this.ySpd *= -UT.rand(0.2,0.5);
                  this.hitCount = 1;
               }
               if(this.hitCount)
               {
                  ++this.hitCount;
                  if(this.hitCount == 20)
                  {
                     this.remove = true;
                  }
                  this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,uint(this.hitCount / 10) + 2);
               }
               else
               {
                  this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,1);
               }
               break;
            case "snow":
               this.x += this.xSpd;
               this.y += this.ySpd;
               if(this.fc % 3 == 0 && this.hitTest())
               {
                  this.remove = true;
                  this.game.createEffect(this.x,this.y,"snowSplash");
               }
               this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,this.frame);
               break;
            case "rain":
               this.x += this.xSpd;
               this.y += this.ySpd;
               this.ySpd += 0.5;
               if(!this.hitCount && (this.hitTest() || this.hitTestPlayer()))
               {
                  this.y -= this.ySpd;
                  this.ySpd = 0;
                  this.hitCount = 1;
               }
               this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,this.frame);
               if(this.hitCount)
               {
                  ++this.frame;
                  if(this.frame == this.stats.frames)
                  {
                     this.remove = true;
                  }
               }
               break;
            case "leaf":
               if(this.hitCount)
               {
                  ++this.hitCount;
                  if(this.hitCount > 60)
                  {
                     this.frame = uint((this.hitCount - 60) / 10) + 4;
                     if(this.hitCount >= 90)
                     {
                        this.remove = true;
                     }
                  }
               }
               else
               {
                  this.rotation += 5;
                  this.x += UT.xMoveToRot(this.rotation,2);
                  this.x += this.xSpd;
                  this.y += this.ySpd;
                  if(this.fc % 3 == 0 && this.hitTest())
                  {
                     this.hitCount = 1;
                  }
               }
               this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,this.frame);
               break;
            case "loop":
               this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,this.frame);
               break;
            case "shell":
               this.x += this.xSpd;
               this.y += this.ySpd;
               this.ySpd += 1;
               if(!this.hitCount)
               {
                  if(this.hitTest())
                  {
                     this.hitCount = 1;
                     this.xSpd *= 0.6;
                     this.ySpd *= -0.3;
                     this.ySpd -= 5;
                  }
               }
               else
               {
                  if(this.hitTest())
                  {
                     this.ySpd *= -0.6;
                  }
                  ++this.hitCount;
                  if(this.hitCount > 20)
                  {
                     this.remove = true;
                  }
               }
               this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,this.frame);
               break;
            case "spark":
               this.x += this.xSpd;
               this.y += this.ySpd;
               this.ySpd += 0.5;
               if(!this.hitCount && (this.hitTest() || this.hitTestPlayer()))
               {
                  this.xSpd *= 3;
                  this.y -= this.ySpd;
                  this.ySpd *= -UT.rand(0.2,0.5);
                  this.hitCount = 1;
               }
               if(this.hitCount)
               {
                  ++this.hitCount;
                  if(this.hitCount == 20)
                  {
                     this.remove = true;
                  }
                  this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,uint(this.hitCount / 10) + 2);
               }
               else
               {
                  this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,1);
               }
               break;
            case "geiser":
               this.x += this.xSpd;
               this.y += this.ySpd;
               this.ySpd += 0.5;
               if(!this.hitCount && (this.hitTest() || this.hitTestPlayer()))
               {
                  this.xSpd *= 10;
                  this.ySpd = UT.rand(-2,2);
                  this.hitCount = 1;
               }
               if(!this.hitCount && this.ySpd > 0)
               {
                  this.hitCount = 1;
               }
               if(this.hitCount)
               {
                  ++this.hitCount;
                  if(this.hitCount >= 15)
                  {
                     this.remove = true;
                  }
                  this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,uint(this.hitCount / 10) + 2);
               }
               else
               {
                  this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,1);
               }
               break;
            case "raise":
               this.x += this.xSpd;
               this.y -= this.ySpd;
               if(this.fc == 20)
               {
                  this.remove = true;
               }
               this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,this.frame);
               break;
            case "move":
               this.x += this.xSpd;
               this.y += this.ySpd;
               if(this.frame == this.stats.frames)
               {
                  this.remove = true;
               }
               this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,this.frame);
               break;
            case "fish":
               this.extra.rot1 += 0.4;
               this.extra.rot2 += 2;
               this.xVel = UT.xMoveToRot(this.extra.rot1,1);
               this.yVel = UT.yMoveToRot(this.extra.rot2,0.1);
               this.x += this.xVel;
               this.y += this.yVel;
               this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,this.xVel > 0 ? uint(1) : uint(2));
               break;
            case "text":
            case "slowText":
               this.y += this.ySpd;
               this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,this.frame);
               if(this.fc > this.yVel)
               {
                  this.remove = true;
               }
         }
         if(!this.holdFrame)
         {
            ++this.frame;
            if(this.frame > this.stats.frames)
            {
               this.frame = 1;
            }
         }
      }
      
      private function hitTest(offX:Number = 0, offY:Number = 0) : uint
      {
         if(this.fc < this.hitFrame)
         {
            return 0;
         }
         var _pixel:uint = this.game.arena.wall.getPixel32(this.x + offX,this.y + offY);
         if(!_pixel)
         {
            return _pixel;
         }
         return _pixel.toString(16).substring(0,2) == "ff" ? uint(_pixel) : uint(0);
      }
      
      private function hitTestPlayer() : Boolean
      {
         if(this.game.player.dead)
         {
            return false;
         }
         if(this.fc < this.hitFrame)
         {
            return false;
         }
         return UT.inBox(this.x,this.y,this.game.player.x - 20,this.game.player.y - UT.rand(55,70),40,50);
      }
   }
}
