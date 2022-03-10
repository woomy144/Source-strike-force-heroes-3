package
{
   import flash.display.MovieClip;
   import flash.display.Shape;
   
   public class Water extends Shape
   {
       
      
      private var game:Game;
      
      private var dots:Array;
      
      private var waterSet:Boolean;
      
      private var MC:MovieClip;
      
      private var fc:uint;
      
      public function Water(_game:Game)
      {
         super();
         this.game = _game;
         this.fc = 0;
         blendMode = "hardlight";
      }
      
      public function setWater(_MC:MovieClip) : void
      {
         var ob:Object = null;
         this.MC = _MC;
         this.MC.visible = false;
         this.dots = [];
         for(var i:uint = 0; i < this.MC.width / 20; i++)
         {
            ob = {};
            ob.x = i * 20 + this.MC.x;
            ob.y = ob.oy = ob.toY = this.MC.y;
            ob.yVel = 0;
            ob.yAcc = 0;
            ob.mass = 10;
            this.dots.push(ob);
         }
         this.waterSet = true;
      }
      
      public function disableWater(_MC:MovieClip) : void
      {
         this.MC = _MC;
         this.MC.visible = false;
         this.dots = [];
         this.waterSet = false;
      }
      
      public function inWater(_x:Number, _y:Number) : Boolean
      {
         if(!this.waterSet)
         {
            return false;
         }
         return UT.inBox(_x,_y,this.MC.x,this.MC.y,this.MC.width,this.MC.height);
      }
      
      public function startWave(_dotNum:int, _pow:Number) : void
      {
         if(!this.waterSet)
         {
            return;
         }
         if(_dotNum < 0 || _dotNum >= this.dots.length)
         {
            return;
         }
         this.dots[_dotNum].yVel = _pow;
      }
      
      public function startWaveAtPos(_pos:Number, _pow:Number) : void
      {
         if(!this.waterSet)
         {
            return;
         }
         var dotNum:int = Math.round((_pos - this.MC.x) / 20);
         if(dotNum < 0 || dotNum >= this.dots.length)
         {
            return;
         }
         this.dots[dotNum].yVel = _pow;
      }
      
      public function EnterFrame() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(!this.waterSet)
         {
            return;
         }
         ++this.fc;
         for(_loc1_ = 0; _loc1_ < this.game.units.length; _loc1_++)
         {
            if(!this.game.units[_loc1_].dead)
            {
               if(this.inWater(this.game.units[_loc1_].x,this.game.units[_loc1_].y))
               {
                  _loc2_ = Math.round((this.game.units[_loc1_].x - this.MC.x) / 20);
                  if(this.game.units[_loc1_].mov.jumping && this.game.units[_loc1_].mov.yVel > 0)
                  {
                     this.startWave(_loc2_,4);
                  }
                  else if(this.game.units[_loc1_].mov.jumping && this.game.units[_loc1_].mov.yVel < 0)
                  {
                     this.startWave(_loc2_,-5);
                  }
                  else if(this.game.units[_loc1_].mov.xVel < 0)
                  {
                     this.startWave(_loc2_ - 1,2);
                     this.startWave(_loc2_ - 3,-2);
                     this.startWave(_loc2_ + 1,-1);
                  }
                  else if(this.game.units[_loc1_].mov.xVel > 0)
                  {
                     this.startWave(_loc2_ + 1,2);
                     this.startWave(_loc2_ + 3,-2);
                     this.startWave(_loc2_ - 1,-1);
                  }
                  else if(this.game.units[_loc1_].mov.crouching)
                  {
                     this.startWave(_loc2_,0.5);
                  }
               }
            }
         }
         for(_loc1_ = 0; _loc1_ < this.dots.length; _loc1_++)
         {
            _loc3_ = 0;
            _loc4_ = 0;
            _loc5_ = 5;
            _loc6_ = 1.05;
            _loc7_ = 0.7;
            if(_loc1_ > 0)
            {
               _loc3_ = this.dots[_loc1_ - 1].y - this.dots[_loc1_].y;
               _loc4_ += _loc3_ * -_loc7_;
            }
            if(_loc1_ < this.dots.length - 1)
            {
               _loc3_ = this.dots[_loc1_].y - this.dots[_loc1_ + 1].y;
               _loc4_ += _loc3_ * _loc7_;
            }
            _loc3_ = this.dots[_loc1_].y - this.dots[_loc1_].oy;
            _loc4_ += _loc7_ / _loc5_ * _loc3_;
            this.dots[_loc1_].yAcc = -_loc4_ / this.dots[_loc1_].mass;
            this.dots[_loc1_].yVel += this.dots[_loc1_].yAcc;
            this.dots[_loc1_].toY += this.dots[_loc1_].yVel;
            this.dots[_loc1_].yVel /= _loc6_;
         }
         for(_loc1_ = 0; _loc1_ < this.dots.length; _loc1_++)
         {
            this.dots[_loc1_].y = this.dots[_loc1_].toY;
         }
         graphics.clear();
         graphics.lineStyle(2,MatchSettings.useMap.water,1);
         graphics.beginFill(MatchSettings.useMap.water,0.8);
         graphics.moveTo(this.dots[0].x,this.dots[0].y);
         for(_loc1_ = 1; _loc1_ < this.dots.length; _loc1_++)
         {
            if(_loc1_ == 1)
            {
               graphics.lineTo((this.dots[_loc1_ - 1].x + this.dots[_loc1_].x) / 2,(this.dots[_loc1_ - 1].y + this.dots[_loc1_].y) / 2);
            }
            else if(_loc1_ < this.dots.length - 1)
            {
               graphics.curveTo(this.dots[_loc1_ - 1].x,this.dots[_loc1_ - 1].y,(this.dots[_loc1_ - 1].x + this.dots[_loc1_].x) / 2,(this.dots[_loc1_ - 1].y + this.dots[_loc1_].y) / 2);
            }
         }
         graphics.lineTo(this.dots[this.dots.length - 1].x,this.dots[this.dots.length - 1].y);
         graphics.lineTo(this.MC.x + this.MC.width,this.MC.y + this.MC.height);
         graphics.lineTo(this.MC.x,this.MC.y + this.MC.height);
         graphics.lineTo(this.dots[0].x,this.dots[0].y);
         graphics.endFill();
      }
   }
}
