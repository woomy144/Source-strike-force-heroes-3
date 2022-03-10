package
{
   import flash.display.MovieClip;
   
   public dynamic class BgSky extends MovieClip
   {
       
      
      public function BgSky()
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
