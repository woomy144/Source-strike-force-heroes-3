package MBFZ3_Mar23MERGED__fla
{
   import flash.display.MovieClip;
   
   public dynamic class arm1_453 extends MovieClip
   {
       
      
      public var armlow1:MovieClip;
      
      public var armup1:MovieClip;
      
      public var clip:MovieClip;
      
      public var gun:MovieClip;
      
      public var hand1:MovieClip;
      
      public var part:MovieClip;
      
      public function arm1_453()
      {
         super();
         addFrameScript(0,this.frame1,6,this.frame7,7,this.frame8,12,this.frame13,25,this.frame26,35,this.frame36,36,this.frame37,40,this.frame41,44,this.frame45,45,this.frame46,58,this.frame59,65,this.frame66,93,this.frame94,98,this.frame99,99,this.frame100,112,this.frame113,119,this.frame120,147,this.frame148,148,this.frame149,159,this.frame160,160,this.frame161,214,this.frame215,223,this.frame224,232,this.frame233,233,this.frame234,241,this.frame242,287,this.frame288,309,this.frame310,313,this.frame314,314,this.frame315,315,this.frame316,322,this.frame323,330,this.frame331,336,this.frame337,355,this.frame356,359,this.frame360,360,this.frame361,362,this.frame363,368,this.frame369,376,this.frame377,382,this.frame383,401,this.frame402,405,this.frame406,406,this.frame407,408,this.frame409,416,this.frame417,437,this.frame438,441,this.frame442,442,this.frame443,450,this.frame451,458,this.frame459,464,this.frame465,473,this.frame474,474,this.frame475,498,this.frame499,499,this.frame500,512,this.frame513,562,this.frame563,584,this.frame585,588,this.frame589,589,this.frame590,596,this.frame597,604,this.frame605,617,this.frame618,625,this.frame626,651,this.frame652,677,this.frame678,681,this.frame682,684,this.frame685,711,this.frame712,712,this.frame713,733,this.frame734,742,this.frame743,748,this.frame749,770,this.frame771,784,this.frame785,785,this.frame786,832,this.frame833,846,this.frame847,860,this.frame861,878,this.frame879,896,this.frame897,910,this.frame911,924,this.frame925,943,this.frame944,944,this.frame945,990,this.frame991,996,this.frame997,997,this.frame998,1057,this.frame1058,1079,this.frame1080,1080,this.frame1081,1093,this.frame1094,1143,this.frame1144,1155,this.frame1156,1156,this.frame1157,1176,this.frame1177,1205,this.frame1206,1217,this.frame1218,1221,this.frame1222,1222,this.frame1223,1226,this.frame1227,1262,this.frame1263,1266,this.frame1267,1267,this.frame1268,1342,this.frame1343);
      }
      
      function frame1() : *
      {
         stop();
         MovieClip(parent).setClipFrame(this.part);
         MovieClip(parent).showGunPart(false);
      }
      
      function frame7() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame8() : *
      {
         MovieClip(parent).reloadSound();
         MovieClip(parent).setClipFrame(this.part);
         MovieClip(parent).showGunPart(false);
      }
      
      function frame13() : *
      {
         MovieClip(parent).setClipFrame(this.clip);
         MovieClip(parent).showGunClip(false);
      }
      
      function frame26() : *
      {
         MovieClip(parent).showGunClip(true);
      }
      
      function frame36() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame37() : *
      {
         MovieClip(parent).setClipFrame(this.part);
         MovieClip(parent).showGunPart(false);
      }
      
      function frame41() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame45() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame46() : *
      {
         MovieClip(parent).reloadSound();
         MovieClip(parent).setClipFrame(this.part);
         MovieClip(parent).showGunPart(false);
      }
      
      function frame59() : *
      {
         MovieClip(parent).setClipFrame(this.clip);
         MovieClip(parent).showGunClip(false);
      }
      
      function frame66() : *
      {
         MovieClip(parent).showGunClip(true);
      }
      
      function frame94() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame99() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame100() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame113() : *
      {
         MovieClip(parent).setClipFrame(this.clip);
         MovieClip(parent).showGunClip(false);
      }
      
      function frame120() : *
      {
         MovieClip(parent).showGunClip(true);
      }
      
      function frame148() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame149() : *
      {
         MovieClip(parent).setClipFrame(this.part);
         MovieClip(parent).showGunPart(false);
      }
      
      function frame160() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame161() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame215() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame224() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame233() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame234() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame242() : *
      {
         MovieClip(parent).checkFastReload();
      }
      
      function frame288() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame310() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame314() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame315() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame316() : *
      {
         MovieClip(parent).checkFastReload();
      }
      
      function frame323() : *
      {
         MovieClip(parent).setClipFrame(this.clip);
         MovieClip(parent).showGunClip(false);
      }
      
      function frame331() : *
      {
         MovieClip(parent).setClipFrame(this.clip);
      }
      
      function frame337() : *
      {
         MovieClip(parent).showGunClip(true);
      }
      
      function frame356() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame360() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame361() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame363() : *
      {
         MovieClip(parent).checkFastReload();
      }
      
      function frame369() : *
      {
         MovieClip(parent).setClipFrame(this.clip);
         MovieClip(parent).showGunClip(false);
      }
      
      function frame377() : *
      {
         MovieClip(parent).setClipFrame(this.clip);
      }
      
      function frame383() : *
      {
         MovieClip(parent).showGunClip(true);
      }
      
      function frame402() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame406() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame407() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame409() : *
      {
         MovieClip(parent).setClipFrame(this.clip);
         MovieClip(parent).showGunClip(false);
      }
      
      function frame417() : *
      {
         MovieClip(parent).showGunClip(true);
      }
      
      function frame438() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame442() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame443() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame451() : *
      {
         MovieClip(parent).setClipFrame(this.clip);
         MovieClip(parent).showGunClip(false);
      }
      
      function frame459() : *
      {
         MovieClip(parent).setClipFrame(this.clip);
      }
      
      function frame465() : *
      {
         MovieClip(parent).showGunClip(true);
      }
      
      function frame474() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame475() : *
      {
         MovieClip(parent).setClipFrame(this.part);
         MovieClip(parent).showGunPart(false);
      }
      
      function frame499() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame500() : *
      {
         MovieClip(parent).reloadSound();
         MovieClip(parent).showGunPart(true);
      }
      
      function frame513() : *
      {
         MovieClip(parent).checkFastReload();
      }
      
      function frame563() : *
      {
         MovieClip(parent).setClipFrame(this.part);
         MovieClip(parent).showGunPart(false);
      }
      
      function frame585() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame589() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame590() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame597() : *
      {
         MovieClip(parent).setClipFrame(this.part);
         MovieClip(parent).showGunPart(false);
      }
      
      function frame605() : *
      {
         MovieClip(parent).setClipFrame(this.clip);
         MovieClip(parent).showGunClip(false);
      }
      
      function frame618() : *
      {
         MovieClip(parent).setClipFrame(this.clip);
      }
      
      function frame626() : *
      {
         MovieClip(parent).showGunClip(true);
      }
      
      function frame652() : *
      {
         MovieClip(parent).showGunPart(true);
      }
      
      function frame678() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame682() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame685() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame712() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame713() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame734() : *
      {
         MovieClip(parent).setClipFrame(this.clip);
         MovieClip(parent).showGunClip(false);
      }
      
      function frame743() : *
      {
         MovieClip(parent).setClipFrame(this.clip);
      }
      
      function frame749() : *
      {
         MovieClip(parent).showGunClip(true);
      }
      
      function frame771() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame785() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame786() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame833() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame847() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame861() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame879() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame897() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame911() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame925() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame944() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame945() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame991() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame997() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame998() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame1058() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame1080() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame1081() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame1094() : *
      {
         MovieClip(parent).checkFastReload();
      }
      
      function frame1144() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame1156() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame1157() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame1177() : *
      {
         MovieClip(parent).checkFastReload();
      }
      
      function frame1206() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame1218() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame1222() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame1223() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame1227() : *
      {
         MovieClip(parent).checkFastReload();
      }
      
      function frame1263() : *
      {
         MovieClip(parent).doneReload();
      }
      
      function frame1267() : *
      {
         MovieClip(parent).doneShoot();
      }
      
      function frame1268() : *
      {
         MovieClip(parent).reloadSound();
      }
      
      function frame1343() : *
      {
         MovieClip(parent).reloadSound();
         MovieClip(parent).doneReload();
      }
   }
}
