package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class flat_clip_450 extends MovieClip
   {
       
      
      public function flat_clip_450()
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
