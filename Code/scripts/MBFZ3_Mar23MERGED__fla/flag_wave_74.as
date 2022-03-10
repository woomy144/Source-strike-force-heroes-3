package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class flag_wave_74 extends MovieClip
   {
       
      
      public var txt_letter:TextField;
      
      public function flag_wave_74()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         this.txt_letter.text = NodeHoldpoint(parent.parent).letter;
      }
   }
}
