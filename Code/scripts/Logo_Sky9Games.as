package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.KeyboardEvent;
   
   public class Logo_Sky9Games extends MovieClip
   {
       
      
      public var skip:SimpleButton;
      
      private var main:Main;
      
      public function Logo_Sky9Games(_main:Main, _extra:Object = null)
      {
         super();
         addFrameScript(153,this.frame154);
         this.main = _main;
         this.skip.visible = Main.SPONSORSITE;
         SH.playMusic(M_Epic);
         buttonMode = this.clickable();
      }
      
      public function logoDone() : void
      {
         this.main.logoSky9Done();
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
            SD.urlSky9Games(true);
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
      
      function frame154() : *
      {
         stop();
         this.logoDone();
      }
   }
}
