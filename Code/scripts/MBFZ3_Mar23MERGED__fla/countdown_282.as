package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class countdown_282 extends MovieClip
   {
       
      
      public var circle:MovieClip;
      
      public var num:MovieClip;
      
      public function countdown_282()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         this.circle.mask = this.num;
      }
   }
}
