package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class Sentry extends MovieClip
   {
       
      
      public var head:MovieClip;
      
      public var mc_hp:MovieClip;
      
      public var txt_level:TextField;
      
      public var txt_name:TextField;
      
      public function Sentry()
      {
         super();
         addFrameScript(69,this.frame70);
      }
      
      function frame70() : *
      {
         gotoAndPlay("idle");
      }
   }
}
