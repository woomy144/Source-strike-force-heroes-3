package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class rocket_446 extends MovieClip
   {
       
      
      public function rocket_446()
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
