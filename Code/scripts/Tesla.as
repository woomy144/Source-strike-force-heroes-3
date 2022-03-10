package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class Tesla extends MovieClip
   {
       
      
      public var lightning:MovieClip;
      
      public var mc_hp:MovieClip;
      
      public var txt_level:TextField;
      
      public var txt_name:TextField;
      
      public function Tesla()
      {
         super();
         addFrameScript(0,this.frame1,33,this.frame34);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame34() : *
      {
         stop();
      }
   }
}
