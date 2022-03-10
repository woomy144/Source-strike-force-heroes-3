package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class NodeWaypoint extends MovieClip
   {
       
      
      public var txt_con:TextField;
      
      public var txt_id:TextField;
      
      public var arena:Arena;
      
      public var id:String;
      
      public var con:String;
      
      public var connects:Array;
      
      public var actionBoxes:Array;
      
      public function NodeWaypoint()
      {
         super();
         this.actionBoxes = new Array();
         this.connects = new Array();
         var tname:Array = name.split("_");
         this.id = tname[0];
         this.con = tname[1];
         this.txt_id.text = this.id.toUpperCase();
         this.txt_con.text = this.con;
         visible = false;
      }
      
      public function setConnectors(_ob:Object) : void
      {
         for(var i:uint = 0; i < this.con.length; i++)
         {
            this.connects.push(_ob[this.con.charAt(i)]);
         }
      }
      
      public function showConnectors(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         if(param1)
         {
            for(_loc2_ = 0; _loc2_ < this.connects.length; _loc2_++)
            {
               this.arena.botCont.graphics.lineStyle(3,16776960,0.3);
               this.arena.botCont.graphics.moveTo(x,y - 20);
               this.arena.botCont.graphics.lineTo((x + this.connects[_loc2_].x) * 0.5,(y + this.connects[_loc2_].y) * 0.5 - 20);
            }
            for(_loc2_ = 0; _loc2_ < this.actionBoxes.length; _loc2_++)
            {
               this.arena.botCont.graphics.lineStyle(3,16751103,0.3);
               this.arena.botCont.graphics.moveTo(x,y - 20);
               this.arena.botCont.graphics.lineTo(this.actionBoxes[_loc2_].x + this.actionBoxes[_loc2_].width / 2,this.actionBoxes[_loc2_].y + this.actionBoxes[_loc2_].height / 2);
            }
         }
         else
         {
            this.arena.botCont.graphics.clear();
         }
      }
      
      public function setActionBox(_ab:NodeAiAction) : void
      {
         this.actionBoxes.push(_ab);
      }
   }
}
