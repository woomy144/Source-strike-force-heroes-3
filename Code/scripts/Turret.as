package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class Turret extends MovieClip
   {
       
      
      public var head:MovieClip;
      
      public var mc_hp:MovieClip;
      
      public var txt_level:TextField;
      
      public var txt_name:TextField;
      
      public function Turret()
      {
         super();
         addFrameScript(0,this.frame1,69,this.frame70);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame70() : *
      {
         gotoAndPlay("idle");
      }
   }
}
