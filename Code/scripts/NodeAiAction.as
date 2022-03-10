package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class NodeAiAction extends MovieClip
   {
       
      
      public var txt_action:TextField;
      
      public var txt_con:TextField;
      
      public var con:String;
      
      public var action:String;
      
      public function NodeAiAction()
      {
         super();
         var tname:Array = name.split("_");
         this.action = tname[0];
         this.con = tname[1];
         this.txt_con.text = this.con.toUpperCase();
         switch(this.action)
         {
            case "c":
               this.txt_action.text = "Crouch";
               break;
            case "j":
               this.txt_action.text = "Jump";
               break;
            case "fp":
               this.txt_action.text = "Fix P";
               break;
            case "fc":
               this.txt_action.text = "Fix C";
               break;
            case "fd":
               this.txt_action.text = "Fix D";
         }
         visible = false;
      }
   }
}
