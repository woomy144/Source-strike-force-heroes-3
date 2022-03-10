package
{
   public class Stats_Info
   {
      
      public static var itemOb:Object;
       
      
      public var frame:uint;
      
      public var x:Number;
      
      public var y:Number;
      
      public var id:String;
      
      public var title:String;
      
      public var desc:String;
      
      public function Stats_Info()
      {
         super();
      }
      
      public static function Init() : void
      {
         itemOb = {};
         addItem(1,0.7,0.5,"health","Health","When your health reaches 0, you die.");
         addItem(1,0.7,0.5,"critical","Critical","Chance to do a critical hit for extra damage.");
         addItem(1,0.7,0.5,"aim","AI Aim","How well the AI can aim at enemies.");
         addItem(1,0.7,0.5,"mobility","AI Mobility","How often the AI moves around the map.");
         addItem(1,0.7,0.5,"aggro","AI Aggresion","How often the AI fires their weapon.");
         addItem(1,0.7,0.5,"$class","","");
         addItem(3,0.5,1,"$status","","");
         addItem(3,0.5,1,"active","","This hero is ready for battle!");
         addItem(3,0.5,1,"tired","","This hero is tired and may become injured in battle.");
         addItem(3,0.5,1,"injured","","This hero is injured and cannot fight until fully recovered.");
         addItem(1,0.7,0.5,"weap0","Pistols","Can NOT be used by Juggernauts or Mercenaries");
         addItem(1,0.7,0.5,"weap1","SMGs","Can NOT be used by Snipers or Ninjas");
         addItem(1,0.7,0.5,"weap2","Blades","Can NOT be used by Medics or Gunslingers");
         addItem(1,0.7,0.5,"weap3","Rifles","Can be used by Engineers and Medics");
         addItem(1,0.7,0.5,"weap4","Duals","Can be used by Gunslingers and Ninjas");
         addItem(1,0.7,0.5,"weap5","Snipers","Can be used by Snipers and Gunslingers");
         addItem(1,0.7,0.5,"weap6","Shotguns","Can be used by Ninjas and Juggernauts");
         addItem(1,0.7,0.5,"weap7","Machine Guns","Can be used by Medics and Mercenaries");
         addItem(1,0.7,0.5,"weap8","Explosives","Can be used by Mercenaries and Engineers");
         addItem(1,0.7,0.5,"weap9","Elementals","Can be used by Juggernauts and Elites");
         addItem(1,0.7,0.5,"weap10","Experimentals","Can be used by Elites and Snipers");
         addItem(1,0.7,0.5,"weap11","Attachments","Add extra modifications to your weapon.");
         addItem(1,0.7,0.5,"weap12","Equipment","Add extra perks to your Hero.");
         addItem(3,0.6,1,"missions","","Select a mission to play.");
         addItem(3,0.5,1,"heroes","","Manage your heroes\' skills and equipment.");
         addItem(3,0.5,1,"inventory","","Manage all the inventory you own.");
         addItem(3,0.5,1,"store","","Purchase equipment or use the slot machine.");
         addItem(3,0.5,1,"workshop","","Build blueprints or upgrade equipment.");
         addItem(5,0.5,0,"fun","","Just for fun! Level differences are disabled.");
         addItem(5,0.5,0,"normal","","The default difficulty.\n ");
         addItem(5,0.5,0,"hard","","Harder, requires higher level heroes.");
         addItem(5,0.5,0,"insane","","The hardest. Max level heres are a must!");
      }
      
      public static function addItem(frame:uint, x:Number, y:Number, id:String, title:String, desc:String) : void
      {
         var item:Stats_Info = new Stats_Info();
         item.frame = frame;
         item.id = id;
         item.x = x;
         item.y = y;
         item.title = title;
         item.desc = desc;
         itemOb[id] = item;
      }
   }
}
