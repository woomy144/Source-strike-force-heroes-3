package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class MuzzleFlash_Pistol_444 extends MovieClip
   {
       
      
      public function MuzzleFlash_Pistol_444()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         gotoAndStop(UT.irand(1,totalFrames));
      }
   }
}
