package
{
   public class UnitInfo
   {
       
      
      public var name:String;
      
      public var level:uint;
      
      public var team:int;
      
      public var trait:String;
      
      public var flaw:String;
      
      public var streak:Object;
      
      public var perks:Array;
      
      public var cls:String;
      
      public var primary:GunInfo;
      
      public var secondary:GunInfo;
      
      public var weaponMod:String;
      
      public var armorMod:String;
      
      public var hasUpgrade:int;
      
      public var hasLevel:Boolean;
      
      public var status:int;
      
      public var extra:Object;
      
      public var health:Number;
      
      public var crit:Number;
      
      public var armor:int;
      
      public var aim:int;
      
      public var mobile:int;
      
      public var aggro:int;
      
      public var runType:int;
      
      public var idleType:int;
      
      public var head:int;
      
      public var body:int;
      
      public var face:int;
      
      public var skin:int;
      
      public var hair:int;
      
      public var color:int;
      
      public var skills:Object;
      
      public var exp:Number;
      
      public var legendary:Boolean;
      
      public var earnedExp:Number;
      
      public var earnedFunds:Number;
      
      public var deaths:int;
      
      public var unique:Boolean;
      
      public function UnitInfo()
      {
         super();
         this.hasUpgrade = -1;
         this.hasLevel = false;
         this.skills = {};
         this.extra = {};
         this.earnedExp = 0;
         this.earnedFunds = 0;
         this.status = 400;
      }
      
      public static function loadObject(ob:Object) : UnitInfo
      {
         var saves:Array = [];
         saves.push("name","level","cls","trait","streak","flaw","perks","exp");
         saves.push("head","body","face","skin","hair","color");
         saves.push("status","weaponMod","armorMod");
         var info:UnitInfo = new UnitInfo();
         for(var i:uint = 0; i < saves.length; i++)
         {
            info[saves[i]] = ob[saves[i]];
         }
         if(ob.primary)
         {
            info.primary = GunInfo.loadObject(ob.primary);
         }
         if(ob.secondary)
         {
            info.secondary = GunInfo.loadObject(ob.secondary);
         }
         return info;
      }
      
      public function createObject() : Object
      {
         var saves:Array = [];
         saves.push("name","level","cls","trait","streak","flaw","perks","exp");
         saves.push("head","body","face","skin","hair","color");
         saves.push("status","weaponMod","armorMod");
         var ob:Object = {};
         for(var i:uint = 0; i < saves.length; i++)
         {
            ob[saves[i]] = this[saves[i]];
         }
         if(this.primary)
         {
            ob.primary = this.primary.createObject();
         }
         if(this.secondary)
         {
            ob.secondary = this.secondary.createObject();
         }
         return ob;
      }
      
      public function prepareForGame(captain:Boolean = false) : void
      {
         var statMod:Number = NaN;
         this.earnedExp = 0;
         this.earnedFunds = 0;
         if(this.status > 300)
         {
            statMod = !!captain ? Number(1.15) : Number(1);
         }
         else if(this.status > 200)
         {
            statMod = 0.8;
         }
         else if(this.status > 100)
         {
            statMod = 0.5;
         }
         else
         {
            statMod = 0.01;
         }
         this.InitStats(statMod);
      }
      
      public function addExp(amt:int) : void
      {
         this.earnedExp += amt;
         this.earnedFunds += amt;
      }
      
      public function addDeath() : void
      {
         ++this.deaths;
      }
      
      public function RandomPerks() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:Array = [Stats_Perks.itemOb[this.flaw].clash];
         this.perks = [];
         for(_loc2_ = 0; _loc2_ < 3; this.perks.push([]),_loc2_++)
         {
         }
         var _loc3_:Array = Stats_Classes.itemOb[this.cls].perks;
         for(_loc2_ = 0; _loc2_ < 3; _loc2_++)
         {
            this.createPerk(_loc1_,this.perks[_loc2_],Stats_Perks["perk" + _loc3_[_loc2_] + "Ar"]);
            this.createPerk(_loc1_,this.perks[_loc2_],Stats_Perks["perk" + _loc3_[_loc2_] + "Ar"]);
            this.perks[_loc2_].push(0);
         }
      }
      
      private function createPerk(perkList:Array, inputAr:Array, perksAr:Array) : void
      {
         var getPerk:String = null;
         do
         {
            getPerk = UT.randEl(perksAr).id;
         }
         while(perkList.indexOf(getPerk) != -1);
         
         inputAr.push(getPerk);
         perkList.push(getPerk);
      }
      
      public function InitStats(statMod:Number = 1) : void
      {
         var perSt:Stats_Perks = null;
         var i:* = undefined;
         if(this.extra.statMod)
         {
            statMod += this.extra.statMod;
         }
         this.health = Math.ceil(Stats_Classes.getStat(this.level,this.cls,"health") * statMod);
         this.crit = Math.ceil(Stats_Classes.getStat(this.level,this.cls,"crit") * statMod);
         this.armor = Math.ceil(Stats_Classes.getArmor(this.level) * statMod);
         this.aim = Math.ceil(Stats_Classes.getStat(this.level,this.cls,"aim") * statMod);
         this.mobile = Math.ceil(Stats_Classes.getStat(this.level,this.cls,"mobile") * statMod);
         this.aggro = Math.ceil(Stats_Classes.getStat(this.level,this.cls,"aggro") * statMod);
         this.runType = 1;
         this.idleType = 1;
         this.skills = {};
         if(this.trait)
         {
            this.skills[this.trait] = Stats_Perks.itemOb[this.trait].val;
         }
         if(this.flaw)
         {
            this.skills[this.flaw] = Stats_Perks.itemOb[this.flaw].val;
         }
         if(this.weaponMod)
         {
            this.skills[this.weaponMod] = Stats_Perks.itemOb[this.weaponMod].val;
         }
         if(this.armorMod)
         {
            this.skills[this.armorMod] = Stats_Perks.itemOb[this.armorMod].val;
         }
         perSt = this.getEquippedPerk(0);
         this.skills[perSt.id] = perSt.val;
         perSt = this.getEquippedPerk(1);
         this.skills[perSt.id] = perSt.val;
         perSt = this.getEquippedPerk(2);
         this.skills[perSt.id] = perSt.val;
         if(this.extra.skills)
         {
            for(i in this.extra.skills)
            {
               this.skills[i] = Stats_Perks.itemOb[i].val;
            }
         }
      }
      
      public function getEquippedPerk(num:int) : Stats_Perks
      {
         var selPerkName:String = null;
         var selPerkNum:int = this.perks[num][2];
         if(selPerkNum > 0)
         {
            selPerkName = this.perks[num][selPerkNum - 1];
            return Stats_Perks.itemOb[selPerkName];
         }
         return Stats_Perks.itemOb["none"];
      }
      
      public function setupLevelStats(num:int) : void
      {
         this.level = num;
         if(this.extra.levelUp)
         {
            this.level += this.extra.levelUp;
         }
         if(this.primary)
         {
            this.primary.level = this.primary.olevel = num;
            this.primary.setStats();
         }
         if(this.secondary)
         {
            this.secondary.level = this.secondary.olevel = num;
            this.secondary.setStats();
         }
      }
      
      public function levelUp() : void
      {
         ++this.level;
         if(this.level == 5)
         {
            this.hasUpgrade = 0;
         }
         if(this.level == 10)
         {
            this.hasUpgrade = 1;
         }
         if(this.level == 15)
         {
            this.hasUpgrade = 2;
         }
         this.hasLevel = true;
      }
   }
}
