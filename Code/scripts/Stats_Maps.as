package
{
   public class Stats_Maps
   {
      
      public static var mapOrder:Array;
       
      
      public function Stats_Maps()
      {
         super();
      }
      
      public static function Init() : void
      {
         mapOrder = ["factory","street","canyon","caves","forest","cavesb","cqc","frigate","construction","junkyard","temple","volcano","gorge"];
      }
      
      public static function getMap(id:String) : Object
      {
         var ob:Object = {};
         ob.id = id;
         switch(id)
         {
            case "street":
               ob.map = "street";
               ob.bg1 = "street1";
               ob.bg2 = "street2";
               ob.sky = "street";
               ob.particles = "street";
               ob.name = "Street";
               ob.phys = "";
               ob.extra = "";
               ob.water = 0;
               break;
            case "factory":
               ob.map = "factory";
               ob.bg1 = "factory1";
               ob.bg2 = "factory2";
               ob.sky = "factory";
               ob.particles = "factory";
               ob.name = "Factory";
               ob.phys = "";
               ob.extra = "";
               ob.water = 0;
               break;
            case "caves":
               ob.map = "caves";
               ob.bg1 = "caves1";
               ob.bg2 = "caves2";
               ob.sky = "caves";
               ob.particles = "caves";
               ob.name = "Caves";
               ob.phys = "";
               ob.extra = "";
               ob.water = 0;
               break;
            case "canyon":
               ob.map = "canyon";
               ob.bg1 = "canyon1";
               ob.bg2 = "canyon2";
               ob.sky = "canyon";
               ob.particles = "canyon";
               ob.name = "Canyon";
               ob.phys = "canyon";
               ob.extra = "";
               ob.water = 0;
               break;
            case "forest":
               ob.map = "forest";
               ob.bg1 = "forest1";
               ob.bg2 = "forest2";
               ob.sky = "forest";
               ob.particles = "forest";
               ob.name = "Forest";
               ob.phys = "";
               ob.extra = "";
               ob.water = 0;
               break;
            case "cavesb":
               ob.map = "cavesb";
               ob.bg1 = "cavern1";
               ob.bg2 = "cavern2";
               ob.sky = "cavern";
               ob.particles = "cavesb";
               ob.name = "Ice Caverns";
               ob.phys = "";
               ob.extra = "";
               ob.water = 0;
               break;
            case "cqc":
               ob.map = "cqc";
               ob.bg1 = "cqc1";
               ob.bg2 = "";
               ob.sky = "";
               ob.particles = "cqc";
               ob.name = "Furnace";
               ob.desc = "";
               ob.phys = "cqc";
               ob.extra = "";
               ob.water = 0;
               break;
            case "frigate":
               ob.map = "frigate";
               ob.bg1 = "";
               ob.bg2 = "";
               ob.sky = "frigate";
               ob.particles = "frigate";
               ob.name = "Frigate";
               ob.desc = "";
               ob.phys = "frigate";
               ob.extra = "";
               ob.water = 0;
               break;
            case "construction":
               ob.map = "construction";
               ob.bg1 = "construction1";
               ob.bg2 = "construction2";
               ob.sky = "construction";
               ob.particles = "construction";
               ob.name = "Construction";
               ob.desc = "";
               ob.phys = "";
               ob.extra = "";
               ob.water = 0;
               break;
            case "junkyard":
               ob.map = "junkyard";
               ob.bg1 = "junkyard1";
               ob.bg2 = "junkyard2";
               ob.sky = "junkyard";
               ob.particles = "junkyard";
               ob.name = "junkyard";
               ob.desc = "";
               ob.phys = "";
               ob.extra = "";
               ob.water = 0;
               break;
            case "temple":
               ob.map = "temple";
               ob.bg1 = "temple1";
               ob.bg2 = "temple2";
               ob.sky = "temple";
               ob.particles = "temple";
               ob.name = "Temple";
               ob.desc = "";
               ob.phys = "";
               ob.extra = "";
               ob.water = 0;
               break;
            case "volcano":
               ob.map = "volcano";
               ob.bg1 = "volcano1";
               ob.bg2 = "volcano2";
               ob.sky = "volcano";
               ob.particles = "volcano";
               ob.name = "Volcano";
               ob.desc = "";
               ob.phys = "";
               ob.extra = "";
               ob.water = 0;
               break;
            case "gorge":
               ob.map = "gorge";
               ob.bg1 = "canyon1";
               ob.bg2 = "canyon2";
               ob.sky = "canyon";
               ob.particles = "gorge";
               ob.name = "Gorge";
               ob.desc = "";
               ob.phys = "canyon";
               ob.extra = "";
               ob.water = 0;
         }
         return ob;
      }
   }
}
