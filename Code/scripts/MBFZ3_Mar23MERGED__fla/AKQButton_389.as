package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   
   public dynamic class AKQButton_389 extends MovieClip
   {
       
      
      public var bt_akq:SimpleButton;
      
      public function AKQButton_389()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      function frame1() : *
      {
         if(SD.stages.length <= 3)
         {
            visible = false;
         }
         stop();
         if(SD.gotAkq)
         {
            gotoAndStop(2);
         }
      }
      
      function frame2() : *
      {
         if(SD.stages.length <= 3)
         {
            visible = false;
         }
         stop();
         if(!SD.gotAkq)
         {
            gotoAndStop(1);
         }
      }
   }
}
