package
{
   public class GunInfo
   {
       
      
      public var id:String;
      
      public var stats:Stats_Guns;
      
      public var rarity:int;
      
      public var olevel:int;
      
      public var level:int;
      
      public var upgrades:uint;
      
      public var upgradeAmt:uint;
      
      public var name:String;
      
      public function GunInfo(_id:String = "", _level:uint = 1, _rarity:int = -1, statSet:Boolean = true)
      {
         super();
         if(_id)
         {
            this.id = _id;
         }
         else
         {
            this.id = UT.randEl(Stats_Guns.itemAr).id;
         }
         if(_level > Stats_Misc.maxLvl)
         {
            _level = Stats_Misc.maxLvl + 1;
         }
         this.olevel = _level;
         this.rarity = _rarity;
         if(this.rarity < 0)
         {
            this.rarity = UT.irand(0,5);
         }
         this.upgrades = 0;
         this.upgradeAmt = 0;
         for(var i:uint = 0; i < 5; i++)
         {
            if(Math.random() < 0.1)
            {
               this.upgrades += UT.intToBit(i + 1);
            }
         }
         if(statSet)
         {
            this.setStats();
         }
      }
      
      public static function loadObject(ob:Object) : GunInfo
      {
         var info:GunInfo = new GunInfo(ob.id,ob.level,ob.rarity,false);
         info.upgrades = ob.upgrades;
         info.setStats();
         return info;
      }
      
      public function setStats() : void
      {
         Stats_Guns.setGunInfoStats(this);
         this.name = this.stats.name;
         if(this.rarity == 3)
         {
            this.name = this.stats.namePerf;
         }
      }
      
      public function createObject() : Object
      {
         var ob:Object = {};
         ob.id = this.id;
         ob.rarity = this.rarity;
         ob.level = this.olevel;
         ob.upgrades = this.upgrades;
         return ob;
      }
   }
}
