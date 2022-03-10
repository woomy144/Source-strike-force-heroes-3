package
{
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   
   public class LoaderScreen extends MovieClip
   {
       
      
      public var bar1:MovieClip;
      
      public var logo1:Logo_LogoBox;
      
      public var logo2:Logo_LogoBox;
      
      public var txt_loading:TextField;
      
      public var txt_play:TextField;
      
      public var txt_play2:TextField;
      
      public var txt_size:TextField;
      
      public var txt_version:TextField;
      
      private var main:Main;
      
      private var otxtHeight:Number;
      
      private var helpNum:uint;
      
      private var helpAr:Array;
      
      private var showedChar:uint = 0;
      
      private var percent:Number;
      
      public function LoaderScreen(_main:Main = null, _extra:Object = null)
      {
         super();
         if(!_main)
         {
            return;
         }
         this.main = _main;
         this.otxtHeight = this.txt_play.y;
         this.txt_play.y = 2000;
         this.txt_play.htmlText = "<a href=\'event:null\'>PLAY</a>";
         this.txt_version.text = Main.VERSION;
      }
      
      public function MouseDown() : void
      {
         if(this.txt_play.hitTestPoint(mouseX,mouseY,false))
         {
            this.main.loadDone();
            this.txt_play.y = 2000;
            this.txt_loading.text = "";
            this.txt_size.text = "";
         }
         if(this.txt_play2.hitTestPoint(mouseX,mouseY,false))
         {
            this.main.skipBitHandler();
         }
      }
      
      public function showRender() : void
      {
         this.txt_loading.text = "Rendering " + Math.ceil(this.main.bitHandler.currentFrame / this.main.bitHandler.totalFrames * 100) + "%\nPlease wait";
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
         this.percent = this.main.loaderInfo.bytesLoaded / this.main.loaderInfo.bytesTotal;
         if(this.main.loaderInfo.bytesLoaded >= this.main.loaderInfo.bytesTotal)
         {
            this.txt_play.y = this.otxtHeight;
            this.txt_loading.text = "";
            this.txt_size.text = "";
         }
         else
         {
            this.txt_loading.text = "Loading\n" + Math.ceil(this.percent * 100) + "%";
            this.txt_size.text = Math.round(this.main.loaderInfo.bytesLoaded / 1024 / 1024 * 10) / 10 + "mb / " + Math.round(this.main.loaderInfo.bytesTotal / 1024 / 1024 * 10) / 10 + "mb";
         }
         this.bar1.bar2.width = this.percent * 300;
         if(this.txt_play.hitTestPoint(mouseX,mouseY,false))
         {
            this.txt_play.textColor = 16777215;
         }
         else
         {
            this.txt_play.textColor = 12303291;
         }
      }
   }
}
