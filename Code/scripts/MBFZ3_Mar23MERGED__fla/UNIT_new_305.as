package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class UNIT_new_305 extends MovieClip
   {
       
      
      public var backArm:MovieClip;
      
      public var backFoot:MovieClip;
      
      public var backForearm:MovieClip;
      
      public var backHand:MovieClip;
      
      public var backLeg:MovieClip;
      
      public var backShin:MovieClip;
      
      public var body:MovieClip;
      
      public var frontArm:MovieClip;
      
      public var frontFoot:MovieClip;
      
      public var frontForearm:MovieClip;
      
      public var frontHand:MovieClip;
      
      public var frontLeg:MovieClip;
      
      public var frontShin:MovieClip;
      
      public var gun:MovieClip;
      
      public var gun2:MovieClip;
      
      public var head:MovieClip;
      
      public var waist:MovieClip;
      
      public function UNIT_new_305()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,61,this.frame62,101,this.frame102,131,this.frame132,191,this.frame192,252,this.frame253,283,this.frame284,344,this.frame345,404,this.frame405,464,this.frame465,524,this.frame525);
      }
      
      function frame1() : *
      {
         gotoAndPlay("idle");
      }
      
      function frame2() : *
      {
         Menu(parent).FixWeapon();
         gotoAndPlay("idle");
      }
      
      function frame3() : *
      {
         this.gun.visible = false;
         gotoAndPlay("idle");
      }
      
      function frame62() : *
      {
         gotoAndPlay("idle");
      }
      
      function frame102() : *
      {
         gotoAndPlay("idleMenu");
      }
      
      function frame132() : *
      {
         gotoAndPlay("idlePost");
      }
      
      function frame192() : *
      {
         gotoAndPlay("injured");
      }
      
      function frame253() : *
      {
         gotoAndPlay("idle_akimbo");
      }
      
      function frame284() : *
      {
         gotoAndPlay("idle_akimbo");
      }
      
      function frame345() : *
      {
         gotoAndPlay("tired");
      }
      
      function frame405() : *
      {
         gotoAndPlay("idle_undermount");
      }
      
      function frame465() : *
      {
         gotoAndPlay("critical");
      }
      
      function frame525() : *
      {
         gotoAndPlay("idle_launcher");
      }
   }
}
