package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class BloodSpurt_81 extends MovieClip
   {
       
      
      public function BloodSpurt_81()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,10,this.frame11);
      }
      
      function frame1() : *
      {
         gotoAndPlay(int(Math.random() * totalFrames) + 1);
      }
      
      function frame2() : *
      {
         rotation = Math.random() * 360;
      }
      
      function frame11() : *
      {
         gotoAndPlay(2);
      }
   }
}
