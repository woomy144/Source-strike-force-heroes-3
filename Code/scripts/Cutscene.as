package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class Cutscene extends MovieClip
   {
       
      
      private var bg:CutsceneBg;
      
      private var top:CutsceneTop;
      
      private var sp:Sprite;
      
      var main:Main;
      
      private var curFrame:int;
      
      var timer:int = 0;
      
      var frameTimer:int;
      
      var fadeTimer:int;
      
      var fadeSpeed:Number;
      
      var introSpeed:Number;
      
      var start:int;
      
      var end:int;
      
      var showCredits:Boolean;
      
      var stopPlaying:Boolean;
      
      var fc:uint = 0;
      
      public function Cutscene(main:Main, extra:Object)
      {
         super();
         this.main = main;
         this.bg = new CutsceneBg();
         this.sp = new Sprite();
         this.sp.addChild(this.bg);
         this.bg.x = -400;
         this.bg.y = -250;
         addChild(this.sp);
         this.top = new CutsceneTop();
         this.top.stop();
         this.top.skip.visible = false;
         addChild(this.top);
         this.start = extra.start;
         this.end = extra.end;
         this.showCredits = extra.showCredits;
         this.curFrame = this.start;
         this.setFrame();
         this.top.black.alpha = 1;
         SH.playMusic(M_Epic);
      }
      
      public function EnterFrame() : void
      {
         if(this.stopPlaying)
         {
            return;
         }
         ++this.fc;
         if(this.fc >= 45)
         {
            this.top.skip.visible = true;
         }
         this.sp.x += (800 - this.bg.cut2.x - this.sp.x) * 0.01;
         this.sp.y += (500 - this.bg.cut2.y - this.sp.y) * 0.01;
         this.sp.scaleX += (this.bg.cut2.scaleX - this.sp.scaleX) * 0.01;
         this.sp.scaleY += (this.bg.cut2.scaleY - this.sp.scaleY) * 0.01;
         ++this.timer;
         if(this.timer > this.fadeTimer)
         {
            this.top.black.alpha += (1 - this.top.black.alpha) * this.fadeSpeed;
         }
         else
         {
            this.top.black.alpha += (0 - this.top.black.alpha) * this.introSpeed;
         }
         if(this.timer > this.frameTimer)
         {
            ++this.curFrame;
            if(this.curFrame == this.end + 1)
            {
               if(this.showCredits)
               {
                  this.setFrame();
                  this.top.nextFrame();
                  this.stopPlaying = true;
                  return;
               }
               this.main.introDone();
               this.stopPlaying = true;
               return;
            }
            this.setFrame();
         }
      }
      
      public function setFrame() : void
      {
         this.bg.gotoAndStop(this.curFrame);
         this.sp.x = 800 - this.bg.cut1.x;
         this.sp.y = 500 - this.bg.cut1.y;
         this.sp.scaleX = this.bg.cut1.scaleX;
         this.sp.scaleY = this.bg.cut1.scaleY;
         this.timer = 0;
         this.bg.cut1.visible = false;
         this.bg.cut2.visible = false;
         this.top.txt_word.text = this.bg.txt_word.text;
         this.frameTimer = 30 * 5;
         this.fadeSpeed = 0.4;
         this.introSpeed = 0.4;
         if(this.bg.short1)
         {
            this.introSpeed = 0.05;
         }
         if(this.bg.long1)
         {
            this.introSpeed = 0.04;
            this.frameTimer += 40;
         }
         if(this.bg.short0)
         {
            this.frameTimer -= 80;
         }
         if(this.bg.long0)
         {
            this.frameTimer += 80;
         }
         this.fadeTimer = this.frameTimer - 6;
         if(this.bg.long2)
         {
            this.frameTimer += 60;
            this.fadeTimer = this.frameTimer - 60;
            this.fadeSpeed = 0.05;
         }
         trace(this.curFrame,this.frameTimer);
      }
      
      public function MouseDown() : void
      {
         if(this.top.skip.visible && this.top.skip.hitTestPoint(mouseX,mouseY,false))
         {
            if(!this.showCredits)
            {
               this.main.introDone();
               this.stopPlaying = true;
               return;
            }
            this.main.startClass(PostGame);
            this.stopPlaying = true;
         }
      }
      
      public function MouseUp() : void
      {
      }
      
      public function KeyDown(e:int) : void
      {
      }
      
      public function KeyUp(e:int) : void
      {
      }
      
      public function flashActivate() : void
      {
      }
      
      public function flashDeactivate() : void
      {
      }
      
      private function MouseWheel(e:int) : void
      {
      }
   }
}
