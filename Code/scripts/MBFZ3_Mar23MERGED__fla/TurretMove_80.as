package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class TurretMove_80 extends MovieClip
   {
       
      
      public function TurretMove_80()
      {
         super();
         addFrameScript(19,this.frame20,36,this.frame37);
      }
      
      function frame20() : *
      {
         SH.playSound(S_Deploy);
      }
      
      function frame37() : *
      {
         stop();
      }
   }
}
