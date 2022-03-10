package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class GunFireFlash_82 extends MovieClip
   {
       
      
      public function GunFireFlash_82()
      {
         super();
         addFrameScript(0,this.frame1,3,this.frame4,6,this.frame7);
      }
      
      function frame1() : *
      {
         SH.playSound(S_Vulcan);
      }
      
      function frame4() : *
      {
         SH.playSound(S_Vulcan);
      }
      
      function frame7() : *
      {
         SH.playSound(S_Vulcan);
      }
   }
}
