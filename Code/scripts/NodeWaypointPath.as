package
{
   public class NodeWaypointPath
   {
       
      
      public var dist:Number;
      
      public var nodes:uint;
      
      public var path:String;
      
      public function NodeWaypointPath(_path:*, _nodesOb:Object)
      {
         super();
         this.path = _path;
         this.nodes = this.path.length;
         this.dist = 0;
         for(var i:uint = 0; i < this.nodes - 1; i++)
         {
            this.dist += UT.getDist(_nodesOb[this.path.charAt(i)].x,_nodesOb[this.path.charAt(i)].y,_nodesOb[this.path.charAt(i + 1)].x,_nodesOb[this.path.charAt(i + 1)].y);
         }
      }
   }
}
