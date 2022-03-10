package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class SlotMachineSpin_292 extends MovieClip
   {
       
      
      public var icon:MovieClip;
      
      public function SlotMachineSpin_292()
      {
         super();
         addFrameScript(0,this.frame1,3,this.frame4,16,this.frame17);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame4() : *
      {
         gotoAndPlay(UT.irand(6,16));
      }
      
      function frame17() : *
      {
         gotoAndPlay("spin");
      }
   }
}
