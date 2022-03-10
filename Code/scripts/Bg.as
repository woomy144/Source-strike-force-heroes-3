package
{
   import flash.display.MovieClip;
   
   public dynamic class Bg extends MovieClip
   {
       
      
      public var usebox:MovieClip;
      
      public function Bg()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
