package
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Radar extends Sprite
   {
       
      
      public var radarcont:MovieClip;
      
      private var game:Game;
      
      private var bmp:Bitmap;
      
      private var dotbmp:Bitmap;
      
      private var data:BitmapData;
      
      private var dotdata:BitmapData;
      
      private var dotRect:Rectangle;
      
      private var scale:Number;
      
      public function Radar(_game:Game, _wallMC:MovieClip)
      {
         super();
         this.game = _game;
         x = Main.WIDTH - 160;
         y = 0;
         this.scale = 0.1;
         this.data = new BitmapData(_wallMC.width * this.scale,_wallMC.height * this.scale,true,0);
         this.bmp = new Bitmap(this.data);
         this.radarcont.addChild(this.bmp);
         this.dotdata = new BitmapData(160,120,true,0);
         this.dotbmp = new Bitmap(this.dotdata);
         addChild(this.dotbmp);
         this.dotRect = new Rectangle(0,0,160,120);
         var matrix:Matrix = new Matrix();
         matrix.scale(this.scale,this.scale);
         Main.STAGE.quality = "high";
         _wallMC.gotoAndStop(50);
         this.data.draw(_wallMC,matrix);
         _wallMC.gotoAndStop(1);
      }
      
      public function EnterFrame() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         this.dotdata.fillRect(this.dotRect,0);
         this.bmp.x = this.game.player.x * -this.scale + 80;
         this.bmp.y = this.game.player.y * -this.scale + 60;
         for(_loc2_ = 0; _loc2_ < this.game.units.length; _loc2_++)
         {
            if(this.game.units[_loc2_].human && !this.game.units[_loc2_].dead)
            {
               this.paint(this.game.units[_loc2_].x * this.scale + this.bmp.x + 2,this.game.units[_loc2_].y * this.scale + this.bmp.y - 4,true,"radar0","player");
            }
            else if(this.game.units[_loc2_].team == 1)
            {
               if(this.game.units[_loc2_].dead)
               {
                  this.paint(this.game.units[_loc2_].x * this.scale + this.bmp.x + 2,this.game.units[_loc2_].y * this.scale + this.bmp.y - 4,true,"radar0","allyskull");
               }
               else
               {
                  this.paint(this.game.units[_loc2_].x * this.scale + this.bmp.x + 2,this.game.units[_loc2_].y * this.scale + this.bmp.y - 4,true,"radar0","ally");
               }
            }
         }
         if(MatchSettings.useMode == "dom")
         {
            for(_loc2_ = 0; _loc2_ < this.game.arena.holdpoints.length; _loc2_++)
            {
               this.paint(this.game.arena.holdpoints[_loc2_].x * this.scale + this.bmp.x + 2,this.game.arena.holdpoints[_loc2_].y * this.scale + this.bmp.y - 3,true,"radar0","flag" + this.game.arena.holdpoints[_loc2_].curTeam);
            }
         }
         else if(MatchSettings.useMode == "ctf")
         {
            for(_loc2_ = 0; _loc2_ < this.game.arena.ctfflags.length; _loc2_++)
            {
               if(!this.game.arena.ctfflags[_loc2_].unitCaptured)
               {
                  this.paint(this.game.arena.ctfflags[_loc2_].x * this.scale + this.bmp.x + 2,this.game.arena.ctfflags[_loc2_].y * this.scale + this.bmp.y - 3,true,"radar0","flag" + this.game.arena.ctfflags[_loc2_].team);
               }
            }
         }
      }
      
      public function paint(_x:Number, _y:Number, _centered:Boolean, _name:String, _sub:String = "", _frame:uint = 1) : void
      {
         var useBit:BitmapData = BH.getBit(_name,_sub,_frame);
         var usePoint:Point = !!_centered ? new Point(_x - useBit.width / 2,_y - useBit.height / 2) : new Point(_x,_y);
         this.dotdata.copyPixels(useBit,new Rectangle(0,0,useBit.width,useBit.height),usePoint,null,null,true);
      }
   }
}
