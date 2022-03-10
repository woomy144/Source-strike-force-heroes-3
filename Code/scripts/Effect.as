package
{
   public class Effect
   {
       
      
      private var game:Game;
      
      public var remove:Boolean;
      
      private var name:String;
      
      private var sub:String;
      
      private var x:Number;
      
      private var y:Number;
      
      private var stats:Object;
      
      private var frame:uint;
      
      private var rotation:uint;
      
      public function Effect(_game:Game, _x:Number, _y:Number, _name:String, _sub:String, _frame:uint)
      {
         super();
         this.game = _game;
         this.x = _x;
         this.y = _y;
         this.name = _name;
         this.sub = _sub;
         this.stats = BH.getBitAniStats(this.name + 0,this.sub);
         this.rotation = UT.irand(0,this.stats.rotAmt - 1);
         this.frame = _frame;
         this.name += this.rotation;
      }
      
      public function EnterFrame() : void
      {
         if(this.remove)
         {
            return;
         }
         this.game.bitscreen.paint(this.x + this.game.arena.x,this.y + this.game.arena.y,true,this.name,this.sub,this.frame);
         ++this.frame;
         if(this.frame > this.stats.frames)
         {
            this.remove = true;
         }
      }
   }
}
