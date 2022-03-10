package
{
   public class Stats_MapParticles
   {
       
      
      private var game:Game;
      
      private var map:String;
      
      private var fc:uint;
      
      private var graphPart1:uint;
      
      private var graphPart2:uint;
      
      public function Stats_MapParticles(_game:Game, _map:String)
      {
         super();
         this.game = _game;
         this.map = _map;
         this.fc = 0;
      }
      
      public function mapInit() : void
      {
         var _loc1_:uint = 0;
         switch(this.map)
         {
            case "temple":
               for(_loc1_ = 0; _loc1_ < 2; this.game.createParticle(1579,855,"fairy",0,null,"fairy","idle",1,true),_loc1_++)
               {
               }
               for(_loc1_ = 0; _loc1_ < 2; this.game.createParticle(1916,855,"fairy",0,null,"fairy","idle",1,true),_loc1_++)
               {
               }
               for(_loc1_ = 0; _loc1_ < 2; this.game.createParticle(2023,1087,"fairy",0,null,"fairy","idle",1,true),_loc1_++)
               {
               }
               for(_loc1_ = 0; _loc1_ < 2; this.game.createParticle(2506,754,"fairy",0,null,"fairy","idle",1,true),_loc1_++)
               {
               }
               for(_loc1_ = 0; _loc1_ < 2; this.game.createParticle(1100 + UT.irand(-20,20),986 + UT.irand(-20,20),"fairy",0,null,"fairy","idle",UT.irand(2,6),true),_loc1_++)
               {
               }
               for(_loc1_ = 0; _loc1_ < 3; this.game.createParticle(1559 + UT.irand(-20,20),1020 + UT.irand(-20,20),"fairy",0,null,"fairy","idle",UT.irand(2,6),true),_loc1_++)
               {
               }
               for(_loc1_ = 0; _loc1_ < 4; this.game.createParticle(576 + UT.irand(-30,30),930 + UT.irand(-20,20),"fairy",0,null,"fairy","idle",UT.irand(2,6),true),_loc1_++)
               {
               }
               for(_loc1_ = 0; _loc1_ < 3; this.game.createParticle(1187 + UT.rand(-40,40),1189 + UT.rand(-10,10),"fish",0,null,"fairy","fish",1,true),_loc1_++)
               {
               }
               break;
            case "forest":
               for(_loc1_ = 0; _loc1_ < 3; this.game.createParticle(1180,760,"fairy",0,null,"fairy","idle",2,true),_loc1_++)
               {
               }
               for(_loc1_ = 0; _loc1_ < 2; this.game.createParticle(1950,925,"fairy",0,null,"fairy","idle",2,true),_loc1_++)
               {
               }
               for(_loc1_ = 0; _loc1_ < 2; this.game.createParticle(2500,1040,"fairy",0,null,"fairy","idle",2,true),_loc1_++)
               {
               }
               for(_loc1_ = 0; _loc1_ < 2; this.game.createParticle(3245,1020,"fairy",0,null,"fairy","idle",2,true),_loc1_++)
               {
               }
         }
      }
      
      public function EnterFrame() : void
      {
         var _loc1_:uint = 0;
         ++this.fc;
         switch(this.map)
         {
            case "canyon":
               if(Math.random() < 0.3)
               {
                  this.game.createParticle(UT.rand(250,3500),UT.rand(500,1500),"move",0,{
                     "xSpd":-50,
                     "ySpd":0
                  },"wind");
               }
               if(Math.random() < 0.3)
               {
                  this.game.createParticle(UT.rand(250,3500),UT.rand(500,1500),"move",0,{
                     "xSpd":-30,
                     "ySpd":0
                  },"dust");
               }
               break;
            case "gorge":
               if(Math.random() < 0.2)
               {
                  this.game.createParticle(UT.rand(250,2900),UT.rand(80,760),"move",0,{
                     "xSpd":-50,
                     "ySpd":0
                  },"wind");
               }
               if(Math.random() < 0.2)
               {
                  this.game.createParticle(UT.rand(250,2900),UT.rand(80,760),"move",0,{
                     "xSpd":-30,
                     "ySpd":0
                  },"dust");
               }
               break;
            case "factory":
               if(Math.random() < 0.3)
               {
                  this.game.createParticle(UT.rand(345,2750),UT.rand(30,50),"snow",0,null,"snowFall","idle",UT.rand(1,3));
               }
               break;
            case "cavesb":
               if(Math.random() < 0.15)
               {
                  this.game.createParticle(UT.rand(60,3600),UT.rand(150,200),"snow",0,null,"snowFall","idle",UT.rand(1,3));
               }
               if(Math.random() < 0.05)
               {
                  this.game.createEffect(UT.rand(155,650),UT.rand(630,800),"shine");
                  this.game.createEffect(UT.rand(825,1640),UT.rand(684,844),"shine");
                  this.game.createEffect(UT.rand(2100,2800),UT.rand(684,844),"shine");
                  this.game.createEffect(UT.rand(3000,3550),UT.rand(630,800),"shine");
               }
               break;
            case "street":
               this.game.createParticle(UT.irand(130,1580),UT.irand(190,340),"rain",5,null,"waterdrop");
               this.game.createParticle(UT.irand(130,1580),UT.irand(190,340),"rain",5,null,"waterdrop");
               break;
            case "forest":
               this.game.createParticle(UT.irand(100,3500),UT.irand(250,340),"rain",5,null,"waterdrop");
               this.game.createParticle(UT.irand(100,3500),UT.irand(250,340),"rain",5,null,"waterdrop");
               this.game.createParticle(UT.irand(100,3500),UT.irand(250,340),"rain",5,null,"waterdrop");
               break;
            case "caves":
               this.game.createParticle(1380,1100,"geiser",0,{
                  "xSpd":UT.rand(-1,1),
                  "ySpd":UT.rand(-15,-10)
               },"Ice");
               this.game.createParticle(1380,1100,"geiser",0,{
                  "xSpd":UT.rand(-1,1),
                  "ySpd":UT.rand(-15,-10)
               },"Ice");
               if(this.fc % 15 == 0)
               {
                  this.game.createParticle(1160,582,"waterdrop",10,null,"waterdrop");
               }
               if(this.fc % 16 == 0)
               {
                  this.game.createParticle(926,300,"waterdrop",10,null,"waterdrop");
               }
               if(this.fc % 18 == 0)
               {
                  this.game.createParticle(2600,900,"waterdrop",10,null,"waterdrop");
               }
               if(this.fc % 13 == 0)
               {
                  this.game.createParticle(1190,800,"waterdrop",10,null,"waterdrop");
               }
               if(this.fc % 10 == 0)
               {
                  this.game.createParticle(1450,245,"waterdrop",10,null,"waterdrop");
               }
               break;
            case "junkyard":
               if(Math.random() < 0.1)
               {
                  for(_loc1_ = 0; _loc1_ < UT.irand(3,10); this.game.createParticle(1510,340,"spark",10,{"xSpd":UT.rand(0,3)},"ember"),_loc1_++)
                  {
                  }
               }
               if(Math.random() < 0.1)
               {
                  for(_loc1_ = 0; _loc1_ < UT.irand(3,10); this.game.createParticle(1790,630,"spark",10,{"xSpd":UT.rand(-3,0)},"ember"),_loc1_++)
                  {
                  }
               }
               if(Math.random() < 0.1)
               {
                  for(_loc1_ = 0; _loc1_ < UT.irand(3,10); this.game.createParticle(670,650,"spark",10,{"xSpd":UT.rand(0,3)},"ember"),_loc1_++)
                  {
                  }
               }
               break;
            case "construction":
               this.game.createParticle(3003 + UT.rand(-30,30),1276,"move",0,{
                  "xSpd":0,
                  "ySpd":-10
               },"gas_big","idle");
               this.game.createParticle(1337 + UT.rand(-30,30),1090,"move",0,{
                  "xSpd":0,
                  "ySpd":-10
               },"gas_big","idle");
               this.game.createParticle(1407 + UT.rand(-30,30),1090,"move",0,{
                  "xSpd":0,
                  "ySpd":-10
               },"gas_big","idle");
               if(Math.random() < 0.1)
               {
                  for(_loc1_ = 0; _loc1_ < UT.irand(3,10); this.game.createParticle(1318,961,"spark",10,null,"ember"),_loc1_++)
                  {
                  }
               }
               if(Math.random() < 0.1)
               {
                  for(_loc1_ = 0; _loc1_ < UT.irand(3,10); this.game.createParticle(945,1071,"spark",10,{"xSpd":UT.rand(-6,-3)},"ember"),_loc1_++)
                  {
                  }
               }
               break;
            case "cqc":
               if(Math.random() < 0.2)
               {
                  for(_loc1_ = 0; _loc1_ < UT.irand(5,20); this.game.createParticle(230,182,"spark",10,{"xSpd":UT.rand(0,3)},"ember"),_loc1_++)
                  {
                  }
               }
               if(Math.random() < 0.2)
               {
                  for(_loc1_ = 0; _loc1_ < UT.irand(5,20); this.game.createParticle(1175,350,"spark",10,{"xSpd":UT.rand(-5,0)},"ember"),_loc1_++)
                  {
                  }
               }
               break;
            case "frigate":
               if(this.fc % 15 == 0)
               {
                  this.game.createParticle(890,788,"waterdrop",10,null,"waterdrop");
               }
               if(this.fc % 16 == 0)
               {
                  this.game.createParticle(1048,788,"waterdrop",10,null,"waterdrop");
               }
               if(this.fc % 18 == 0)
               {
                  this.game.createParticle(1657,754,"waterdrop",10,null,"waterdrop");
               }
               if(this.fc % 13 == 0)
               {
                  this.game.createParticle(2111,788,"waterdrop",10,null,"waterdrop");
               }
               if(this.fc % 10 == 0)
               {
                  this.game.createParticle(2437,788,"waterdrop",10,null,"waterdrop");
               }
               if(Math.random() < 0.3)
               {
                  this.game.createParticle(UT.rand(400,3300),UT.rand(200,940),"move",0,{
                     "xSpd":-50,
                     "ySpd":0
                  },"wind");
               }
               break;
            case "volcano":
               if(Math.random() < 0.2)
               {
                  this.game.createParticle(UT.rand(870,1090),UT.rand(1290,1300),"move",0,{
                     "xSpd":UT.rand(-1,1),
                     "ySpd":UT.rand(-1,-2)
                  },"flame");
               }
               if(Math.random() < 0.2)
               {
                  this.game.createParticle(UT.rand(1320,1490),UT.rand(1300,1330),"move",0,{
                     "xSpd":UT.rand(-1,1),
                     "ySpd":UT.rand(-1,-2)
                  },"flame");
               }
               if(Math.random() < 0.2)
               {
                  this.game.createParticle(UT.rand(1700,1940),UT.rand(1280,1300),"move",0,{
                     "xSpd":UT.rand(-1,1),
                     "ySpd":UT.rand(-1,-2)
                  },"flame");
               }
         }
      }
   }
}
