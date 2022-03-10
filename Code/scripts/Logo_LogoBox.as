package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class Logo_LogoBox extends MovieClip
   {
       
      
      public var btn:SimpleButton;
      
      private var armorButton:Boolean;
      
      private var alwaysEnable:Boolean;
      
      public function Logo_LogoBox()
      {
         super();
         if(name == "logo1")
         {
            this.armorButton = Main.ARMORFIRST;
         }
         else if(name == "logo2")
         {
            this.armorButton = !Main.ARMORFIRST;
         }
         if(name == "logo1b")
         {
            this.alwaysEnable = true;
            this.armorButton = Main.ARMORFIRST;
         }
         else if(name == "logo2b")
         {
            this.alwaysEnable = true;
            this.armorButton = !Main.ARMORFIRST;
         }
         if(this.armorButton)
         {
            gotoAndStop(1);
         }
         else
         {
            gotoAndStop(2);
         }
         if(this.alwaysEnable)
         {
            this.btn.addEventListener(MouseEvent.CLICK,this.MouseClick,false,0,true);
         }
         else if(!this.armorButton && Main.SPONSORSITE && Main.ARMORFIRST)
         {
            this.btn.enabled = false;
         }
         else if(this.armorButton && Main.SPONSORSITE && !Main.ARMORFIRST)
         {
            this.btn.enabled = false;
         }
         else
         {
            this.btn.addEventListener(MouseEvent.CLICK,this.MouseClick,false,0,true);
         }
      }
      
      private function MouseClick(e:Event) : void
      {
         if(this.armorButton)
         {
            SD.urlArmor();
         }
         else
         {
            SD.urlNotDoppler();
         }
      }
   }
}
