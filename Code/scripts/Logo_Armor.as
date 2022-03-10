package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.KeyboardEvent;
   
   public class Logo_Armor extends MovieClip
   {
       
      
      public var skip:SimpleButton;
      
      private var main:Main;
      
      public function Logo_Armor(_main:Main, _extra:Object = null)
      {
         super();
         addFrameScript(206,this.frame207);
         this.main = _main;
         this.skip.visible = Main.SPONSORSITE;
         buttonMode = this.clickable();
      }
      
      public function logoDone() : void
      {
         this.main.logoArmorDone();
         stop();
      }
      
      public function MouseDown() : void
      {
         if(this.skip.visible && this.skip.hitTestPoint(mouseX,mouseY,false))
         {
            this.logoDone();
         }
         else if(this.clickable())
         {
            SD.urlArmor(true);
         }
      }
      
      public function clickable() : Boolean
      {
         return !Main.SPONSORSITE;
      }
      
      public function MouseUp() : void
      {
      }
      
      public function KeyDown(e:KeyboardEvent) : void
      {
      }
      
      public function KeyUp(e:KeyboardEvent) : void
      {
      }
      
      public function flashActivate() : void
      {
      }
      
      public function flashDeactivate() : void
      {
      }
      
      public function EnterFrame() : void
      {
      }
      
      function frame207() : *
      {
         this.logoDone();
      }
   }
}
