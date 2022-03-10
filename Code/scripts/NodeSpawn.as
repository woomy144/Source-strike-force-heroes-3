package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class NodeSpawn extends MovieClip
   {
       
      
      public var txt_id:TextField;
      
      public var id:String;
      
      public var team:uint;
      
      public var waypoint:NodeWaypoint;
      
      public var initialSpawned:Boolean;
      
      public function NodeSpawn()
      {
         super();
         var tstr:Array = name.split("_");
         this.id = tstr[0];
         if(tstr[1] != "")
         {
            this.team = tstr[1];
         }
         else
         {
            this.team = 0;
         }
         this.txt_id.text = this.id.toUpperCase();
         visible = false;
      }
      
      public function setWaypoint(_wp:NodeWaypoint) : void
      {
         this.waypoint = _wp;
      }
   }
}
