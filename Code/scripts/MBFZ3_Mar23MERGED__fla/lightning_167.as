package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class lightning_167 extends MovieClip
   {
       
      
      public var l1:MovieClip;
      
      public var l2:MovieClip;
      
      public var l3:MovieClip;
      
      public var l4:MovieClip;
      
      public function lightning_167()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         this.l1.gotoAndStop(UT.irand(1,6));
         this.l2.gotoAndStop(UT.irand(1,6));
         this.l3.gotoAndStop(UT.irand(1,6));
         this.l4.gotoAndStop(UT.irand(1,6));
         rotation = UT.rand(0,360);
      }
   }
}
