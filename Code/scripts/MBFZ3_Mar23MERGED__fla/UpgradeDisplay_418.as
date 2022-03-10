package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class UpgradeDisplay_418 extends MovieClip
   {
       
      
      public function UpgradeDisplay_418()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,41,this.frame42,43,this.frame44,86,this.frame87);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame2() : *
      {
         MovieClip(parent).upgradebox.visible = false;
      }
      
      function frame42() : *
      {
         MovieClip(parent).upgradebox.visible = true;
         gotoAndStop(1);
      }
      
      function frame44() : *
      {
         MovieClip(parent).upgradebox.visible = false;
      }
      
      function frame87() : *
      {
         MovieClip(parent).upgradebox.visible = true;
         gotoAndStop(1);
      }
   }
}
