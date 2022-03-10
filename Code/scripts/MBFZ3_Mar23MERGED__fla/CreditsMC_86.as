package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class CreditsMC_86 extends MovieClip
   {
       
      
      public var logo1:Logo_LogoBox;
      
      public var logo2:Logo_LogoBox;
      
      public function CreditsMC_86()
      {
         super();
         addFrameScript(20,this.frame21,1820,this.frame1821);
      }
      
      function frame21() : *
      {
         SH.playSound(S_Powerup);
         SH.playMusic(M_Rush,false,16.4 * 1000);
      }
      
      function frame1821() : *
      {
         stop();
      }
   }
}
