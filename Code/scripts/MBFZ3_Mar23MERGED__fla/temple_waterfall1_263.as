package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class temple_waterfall1_263 extends MovieClip
   {
       
      
      public function temple_waterfall1_263()
      {
         super();
         addFrameScript(0,this.frame1,24,this.frame25);
      }
      
      function frame1() : *
      {
         gotoAndPlay(int(Math.random() * totalFrames) + 1);
      }
      
      function frame25() : *
      {
         gotoAndPlay(2);
      }
   }
}
