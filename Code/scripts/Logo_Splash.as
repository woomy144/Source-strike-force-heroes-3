package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.KeyboardEvent;
   
   public class Logo_Splash extends MovieClip
   {
       
      
      public var bt_play:SimpleButton;
      
      private var main:Main;
      
      public function Logo_Splash(_main:Main, _extra:Object = null)
      {
         super();
         addFrameScript(12,this.frame13,69,this.frame70);
         this.main = _main;
         SH.playMusic(M_Menu);
      }
      
      public function done() : void
      {
         this.main.splashDone();
         stop();
      }
      
      public function MouseDown() : void
      {
         if(this.bt_play && this.bt_play.hitTestPoint(mouseX,mouseY,false))
         {
            play();
            SH.playSound(S_Shot);
         }
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
      
      function frame13() : *
      {
         stop();
      }
      
      function frame70() : *
      {
         this.done();
      }
   }
}
