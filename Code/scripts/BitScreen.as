package
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BitScreen extends Bitmap
   {
       
      
      public var data:BitmapData;
      
      private var game:Game;
      
      public var rect:Rectangle;
      
      private var useBit:BitmapData;
      
      private var usePoint:Point;
      
      public function BitScreen(_game:Game)
      {
         this.data = new BitmapData(Main.WIDTH,Main.HEIGHT,true,0);
         super(this.data);
         this.game = _game;
         this.rect = new Rectangle(0,0,this.data.width,this.data.height);
      }
      
      public function EnterFrame() : void
      {
         this.data.fillRect(this.rect,0);
      }
      
      public function paint(_x:Number, _y:Number, _centered:Boolean, _name:String, _sub:String = "idle", _frame:uint = 1) : void
      {
         if(this.game.destroyed)
         {
            return;
         }
         this.useBit = BH.getBit(_name,_sub,_frame);
         this.usePoint = !!_centered ? new Point(_x - this.useBit.width / 2,_y - this.useBit.height / 2) : new Point(_x,_y);
         this.data.copyPixels(this.useBit,new Rectangle(0,0,this.useBit.width,this.useBit.height),this.usePoint,null,null,true);
      }
      
      public function destroy() : void
      {
         this.data.dispose();
      }
   }
}
