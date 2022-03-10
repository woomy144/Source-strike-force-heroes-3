package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class rife_clip_448 extends MovieClip
   {
       
      
      public function rife_clip_448()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
         MovieClip(parent.parent).setClip(this);
      }
   }
}
