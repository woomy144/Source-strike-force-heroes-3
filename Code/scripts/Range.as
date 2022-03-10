package
{
   public class Range
   {
       
      
      public var min:Number;
      
      public var max:Number;
      
      public var cur:Number;
      
      public var old:Number;
      
      public var x:Number;
      
      public var y:Number;
      
      public function Range(_min:Number = 0, _max:Number = 0, _cur:Number = 0)
      {
         super();
         this.min = _min;
         this.max = _max;
         this.cur = _cur;
      }
   }
}
