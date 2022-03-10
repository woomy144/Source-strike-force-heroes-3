package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.KeyboardEvent;
   
   public class Logo_NotDoppler extends MovieClip
   {
       
      
      public var introbutton:SimpleButton;
      
      public var skip:SimpleButton;
      
      private var main:Main;
      
      public function Logo_NotDoppler(_main:Main, _extra:Object = null)
      {
         super();
         addFrameScript(188,this.frame189);
         this.main = _main;
         this.skip.visible = Main.SPONSORSITE;
         buttonMode = this.clickable();
         this.introbutton.visible = this.clickable();
      }
      
      public function logoDone() : void
      {
         this.main.logoDopplerDone();
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
            SD.urlNotDoppler(true);
         }
      }
      
      public function clickable() : Boolean
      {
         return !Main.ARMORFIRST || !Main.SPONSORSITE;
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
      
      function frame189() : *
      {
         stop();
         this.logoDone();
      }
   }
}
