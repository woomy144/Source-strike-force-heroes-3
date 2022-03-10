package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class LampSwing_225 extends MovieClip
   {
       
      
      public function LampSwing_225()
      {
         super();
         addFrameScript(0,this.frame1,102,this.frame103);
      }
      
      function frame1() : *
      {
         gotoAndPlay(int(Math.random() * totalFrames) + 1);
      }
      
      function frame103() : *
      {
         gotoAndPlay(2);
      }
   }
}
