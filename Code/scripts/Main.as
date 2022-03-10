package
{
   import com.google.analytics.AnalyticsTracker;
   import com.google.analytics.GATracker;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class Main extends MovieClip
   {
      
      public static var STAGE;
      
      public static var ARMORFIRST:Boolean;
      
      public static var SPONSORSITE:Boolean;
      
      public static var DEBUGMODE:Boolean;
      
      public static var NOPLAY:Boolean;
      
      public static var WIDTH:uint;
      
      public static var HEIGHT:uint;
      
      public static var VERSION:String;
      
      public static var NEWS:String;
      
      public static var curClass;
       
      
      private var added:Boolean;
      
      public var bitHandler:BH;
      
      private var achievement:Stats_Achievements;
      
      public function Main()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,24,this.frame25);
         addEventListener(Event.ADDED_TO_STAGE,this.Init,false,0,true);
      }
      
      private function Init(e:Event) : void
      {
         var tracker:AnalyticsTracker = new GATracker(this,"UA-64256681-1","AS3",false);
         tracker.trackPageview("/Strike Force Heroes 3/Play");
         if(this.added)
         {
            return;
         }
         this.added = true;
         Main.STAGE = stage;
         Main.WIDTH = 800;
         Main.HEIGHT = 600;
         Main.VERSION = "v20.8s";
         if(DEBUGMODE)
         {
            Main.VERSION = "DEBUG - " + Main.VERSION;
         }
         stage.addEventListener(Event.ENTER_FRAME,this.EnterFrame);
         stage.addEventListener(Event.ACTIVATE,this.flashActivate);
         stage.addEventListener(Event.DEACTIVATE,this.flashDeactivate);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.KeyDown);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.KeyUp);
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.MouseDown);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.MouseUp);
         stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.MouseWheel);
         stage.addEventListener(MouseEvent.RIGHT_CLICK,this.DoNothing);
         stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN,this.RightMouseDown);
         SPONSORSITE = this.checkUrl(["armorgames.com","notdoppler.com","sky9games.com"]);
         if(SPONSORSITE)
         {
            ARMORFIRST = this.checkUrl(["armorgames.com"]);
            if(ARMORFIRST)
            {
               AGI.Init();
            }
         }
         else
         {
            ARMORFIRST = UT.coinFlip(true,false);
         }
         this.startClass(LoaderScreen);
      }
      
      public function loadDone() : void
      {
         gotoAndStop("start");
         trace("STARTING BH NOW");
         this.bitHandler = new BH(this);
      }
      
      public function skipBitHandler() : void
      {
         gotoAndStop("start");
         this.renderDone();
      }
      
      public function renderDone() : void
      {
         UT.Init();
         Stats_Achievements.Init();
         Stats_Misc.Init();
         Stats_Guns.Init();
         Stats_Maps.Init();
         Stats_Perks.Init();
         MatchSettings.Init();
         Stats_Info.Init();
         Stats_Classes.Init();
         SD.Init();
         Stats_Missions.Init();
         SH.Init();
         if(DEBUGMODE)
         {
            this.startClass(Menu);
         }
         else if(ARMORFIRST)
         {
            this.startClass(Logo_Armor);
         }
         else
         {
            this.startClass(Logo_NotDoppler);
         }
         this.achievement = new Stats_Achievements();
         addChild(this.achievement);
      }
      
      public function logoArmorDone() : void
      {
         if(ARMORFIRST)
         {
            this.startClass(Logo_NotDoppler);
         }
         else
         {
            this.startClass(Logo_Sky9Games);
         }
      }
      
      public function logoDopplerDone() : void
      {
         if(ARMORFIRST)
         {
            this.startClass(Logo_Sky9Games);
         }
         else
         {
            this.startClass(Logo_Armor);
         }
      }
      
      public function logoSky9Done() : void
      {
         this.startClass(Cutscene,{
            "start":1,
            "end":10
         });
      }
      
      public function introDone() : void
      {
         this.startClass(Logo_Splash);
      }
      
      public function splashDone() : void
      {
         trace("=== Start Game ===");
         this.startClass(Menu);
      }
      
      private function EnterFrame(e:Event) : void
      {
         if(this.bitHandler && !this.bitHandler.complete)
         {
            curClass.showRender();
            this.bitHandler.setup();
         }
         else
         {
            curClass.EnterFrame();
            SH.EnterFrame();
         }
      }
      
      private function MouseDown(e:MouseEvent) : void
      {
         if(curClass)
         {
            curClass.MouseDown();
         }
      }
      
      private function DoNothing(e:MouseEvent) : void
      {
      }
      
      private function RightMouseDown(e:MouseEvent) : void
      {
         if(curClass)
         {
            curClass.RightMouseDown();
         }
      }
      
      private function MouseUp(e:MouseEvent) : void
      {
         if(curClass)
         {
            curClass.MouseUp();
         }
      }
      
      private function KeyDown(e:KeyboardEvent) : void
      {
         if(curClass)
         {
            curClass.KeyDown(e.keyCode);
         }
      }
      
      private function KeyUp(e:KeyboardEvent) : void
      {
         if(curClass)
         {
            curClass.KeyUp(e.keyCode);
         }
      }
      
      private function flashActivate(e:Event) : void
      {
         trace("Flash Active");
         if(curClass)
         {
            curClass.flashActivate();
         }
      }
      
      private function flashDeactivate(e:Event) : void
      {
         trace("Flash Deactive");
         if(curClass)
         {
            curClass.flashDeactivate();
         }
      }
      
      private function MouseWheel(e:MouseEvent) : void
      {
         if(curClass)
         {
            curClass.MouseWheel(e.delta);
         }
      }
      
      public function startClass(cls:*, extra:Object = null) : void
      {
         if(curClass)
         {
            removeChild(curClass);
            curClass = null;
         }
         trace("new class:",cls);
         curClass = new cls(this,!!extra ? extra : {});
         addChild(curClass);
         if(this.achievement)
         {
            setChildIndex(this.achievement,numChildren - 1);
         }
         stage.focus = stage;
      }
      
      public function checkUrl(array:Array) : Boolean
      {
         var url:String = loaderInfo.url;
         var res:Boolean = false;
         for(var i:uint = 0; i < array.length; i++)
         {
            if(array[i] == url.substring(url.indexOf(".") + 1,url.indexOf("/",7)))
            {
               res = true;
            }
            if(array[i] == url.substring(url.indexOf("//") + 2,url.indexOf("/",7)))
            {
               res = true;
            }
            if(array[i] == url.substring(0,url.indexOf("/",7)))
            {
               res = true;
            }
         }
         return res;
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame2() : *
      {
         prevFrame();
      }
      
      function frame25() : *
      {
         stop();
      }
   }
}
