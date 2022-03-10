package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.system.System;
   import flash.text.TextField;
   import flash.utils.getTimer;
   
   public dynamic class Debug_152 extends MovieClip
   {
       
      
      public var debug1:TextField;
      
      public var debug2:TextField;
      
      public var debug3:TextField;
      
      public var debug4:TextField;
      
      public var iBar:MovieClip;
      
      public var tf:TextField;
      
      public var time:Number;
      
      public var frameTime:Number;
      
      public var prevFrameTime:Number;
      
      public var secondTime:Number;
      
      public var prevSecondTime:Number;
      
      public var frames:Number;
      
      public var fps:String;
      
      public function Debug_152()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      public function onEnterFrame(event:Event) : void
      {
         this.time = getTimer();
         this.frameTime = this.time - this.prevFrameTime;
         this.secondTime = this.time - this.prevSecondTime;
         if(this.secondTime >= 1000)
         {
            this.fps = this.frames.toString();
            this.frames = 0;
            this.prevSecondTime = this.time;
         }
         else
         {
            ++this.frames;
         }
         this.prevFrameTime = this.time;
         this.tf.text = this.fps + " FPS / " + this.frameTime + " MS / " + Number(System.totalMemory / 1024 / 1024).toFixed(2) + "Mb";
         this.iBar.scaleX -= (this.iBar.scaleX - this.frameTime / 10) / 5;
      }
      
      function frame1() : *
      {
         this.prevFrameTime = getTimer();
         this.prevSecondTime = getTimer();
         this.frames = 0;
         this.fps = "...";
      }
      
      function frame2() : *
      {
         stop();
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
   }
}
