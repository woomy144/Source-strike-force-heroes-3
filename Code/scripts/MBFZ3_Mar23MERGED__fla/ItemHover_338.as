package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class ItemHover_338 extends MovieClip
   {
       
      
      public var item:ItemContainer;
      
      public function ItemHover_338()
      {
         super();
         addFrameScript(0,this.frame1,110,this.frame111);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame111() : *
      {
         gotoAndPlay("hover");
      }
   }
}
