package Box2D.Collision
{
   public class b2SimplexCache
   {
       
      
      public var metric:Number;
      
      public var count:uint;
      
      public var indexA:Array;
      
      public var indexB:Array;
      
      public function b2SimplexCache()
      {
         this.indexA = new Array(3);
         this.indexB = new Array(3);
         super();
      }
   }
}
