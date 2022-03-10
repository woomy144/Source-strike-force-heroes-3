package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class CutsceneBg extends MovieClip
   {
       
      
      public var cut1:MovieClip;
      
      public var cut2:MovieClip;
      
      public var long0:MovieClip;
      
      public var long1:MovieClip;
      
      public var long2:MovieClip;
      
      public var short0:MovieClip;
      
      public var short1:MovieClip;
      
      public var txt_word:TextField;
      
      public function CutsceneBg()
      {
         super();
         addFrameScript(6,this.frame7,12,this.frame13,16,this.frame17,17,this.frame18,18,this.frame19);
      }
      
      function frame7() : *
      {
         SH.playMusic(M_Menu);
      }
      
      function frame13() : *
      {
         SH.playMusic(M_Speed,false,19 * 1000);
      }
      
      function frame17() : *
      {
         SH.playMusic(M_Mute);
      }
      
      function frame18() : *
      {
         SH.playSound(S_Radar);
      }
      
      function frame19() : *
      {
         SH.playSound(S_Twist);
      }
   }
}
