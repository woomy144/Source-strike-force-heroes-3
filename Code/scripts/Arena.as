package
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class Arena extends MovieClip
   {
       
      
      public var $armor_15:MovieClip;
      
      public var $health_15:MovieClip;
      
      public var L_:NodeHoldpoint;
      
      public var S_:NodeHoldpoint;
      
      public var a_0:MovieClip;
      
      public var a_1:MovieClip;
      
      public var a__1:NodeCtfFlag;
      
      public var a_b:MovieClip;
      
      public var a_be:MovieClip;
      
      public var a_bi:MovieClip;
      
      public var a_bk:MovieClip;
      
      public var a_bl:MovieClip;
      
      public var a_bm:MovieClip;
      
      public var a_dg:MovieClip;
      
      public var a_fedh:MovieClip;
      
      public var a_ok:MovieClip;
      
      public var a_q:MovieClip;
      
      public var ammo_10:MovieClip;
      
      public var ammo_15:MovieClip;
      
      public var ammobig_30:MovieClip;
      
      public var armor_10:MovieClip;
      
      public var armor_15:MovieClip;
      
      public var armorbig_10:MovieClip;
      
      public var armorbig_30:MovieClip;
      
      public var b_0:MovieClip;
      
      public var b_1:MovieClip;
      
      public var b__1:NodeCtfFlag;
      
      public var b_acd:MovieClip;
      
      public var b_acde:MovieClip;
      
      public var b_ach:MovieClip;
      
      public var b_acld:MovieClip;
      
      public var b_agdcz:MovieClip;
      
      public var b_ahn:MovieClip;
      
      public var b_ajc:MovieClip;
      
      public var b_apc:MovieClip;
      
      public var b_defca:MovieClip;
      
      public var b_ock:MovieClip;
      
      public var b_qp:MovieClip;
      
      public var botCont:MovieClip;
      
      public var c_:NodeHoldpoint;
      
      public var c_0:MovieClip;
      
      public var c_1:MovieClip;
      
      public var c_2:MovieClip;
      
      public var c_a:MovieClip;
      
      public var c_badez:MovieClip;
      
      public var c_bd:MovieClip;
      
      public var c_bde:MovieClip;
      
      public var c_bjid:MovieClip;
      
      public var c_bp:MovieClip;
      
      public var c_bpf:MovieClip;
      
      public var c_f:MovieClip;
      
      public var c_g:MovieClip;
      
      public var c_kl:MovieClip;
      
      public var c_lk:MovieClip;
      
      public var c_nog:MovieClip;
      
      public var c_pd:MovieClip;
      
      public var d_:NodeHoldpoint;
      
      public var d_0:MovieClip;
      
      public var d_2:MovieClip;
      
      public var d_aecbgf:MovieClip;
      
      public var d_cbel:MovieClip;
      
      public var d_cbf:MovieClip;
      
      public var d_cblek:MovieClip;
      
      public var d_ce:MovieClip;
      
      public var d_ceg:MovieClip;
      
      public var d_chel:MovieClip;
      
      public var d_eahi:MovieClip;
      
      public var d_efn:MovieClip;
      
      public var d_fjoabc:MovieClip;
      
      public var d_pfe:MovieClip;
      
      public var e_:NodeHoldpoint;
      
      public var e_0:MovieClip;
      
      public var e_1:MovieClip;
      
      public var e_2:MovieClip;
      
      public var e__2:NodeCtfFlag;
      
      public var e_abi:MovieClip;
      
      public var e_adhg:MovieClip;
      
      public var e_dcfg:MovieClip;
      
      public var e_df:MovieClip;
      
      public var e_dfk:MovieClip;
      
      public var e_dk:MovieClip;
      
      public var e_fd:MovieClip;
      
      public var e_fhbpa:MovieClip;
      
      public var e_hdlf:MovieClip;
      
      public var f_0:MovieClip;
      
      public var f_2:MovieClip;
      
      public var f__2:NodeCtfFlag;
      
      public var f_aeg:MovieClip;
      
      public var f_decgn:MovieClip;
      
      public var f_deijk:MovieClip;
      
      public var f_dg:MovieClip;
      
      public var f_dhj:MovieClip;
      
      public var f_edg:MovieClip;
      
      public var f_eg:MovieClip;
      
      public var f_egik:MovieClip;
      
      public var f_egm:MovieClip;
      
      public var f_gem:MovieClip;
      
      public var f_jhegk:MovieClip;
      
      public var g_0:MovieClip;
      
      public var g_1:MovieClip;
      
      public var g_2:MovieClip;
      
      public var g__2:NodeCtfFlag;
      
      public var g_af:MovieClip;
      
      public var g_efh:MovieClip;
      
      public var g_f:MovieClip;
      
      public var g_fh:MovieClip;
      
      public var g_fhdl:MovieClip;
      
      public var g_fhie:MovieClip;
      
      public var g_fnmh:MovieClip;
      
      public var g_hfelj:MovieClip;
      
      public var g_hfj:MovieClip;
      
      public var g_hpjo:MovieClip;
      
      public var g_ihf:MovieClip;
      
      public var h_0:MovieClip;
      
      public var h_1:MovieClip;
      
      public var h_2:MovieClip;
      
      public var h__1:NodeCtfFlag;
      
      public var h__2:NodeCtfFlag;
      
      public var h_bfj:MovieClip;
      
      public var h_edgm:MovieClip;
      
      public var h_gbil:MovieClip;
      
      public var h_gfji:MovieClip;
      
      public var h_gi:MovieClip;
      
      public var h_gij:MovieClip;
      
      public var h_gojepq:MovieClip;
      
      public var h_i:MovieClip;
      
      public var h_idge:MovieClip;
      
      public var h_ig:MovieClip;
      
      public var h_igk:MovieClip;
      
      public var health_10:MovieClip;
      
      public var health_15:MovieClip;
      
      public var healthbig_30:MovieClip;
      
      public var i_:NodeHoldpoint;
      
      public var i_0:MovieClip;
      
      public var i_1:MovieClip;
      
      public var i_2:MovieClip;
      
      public var i_amkp:MovieClip;
      
      public var i_dhmgkl:MovieClip;
      
      public var i_eh:MovieClip;
      
      public var i_fkjmeh:MovieClip;
      
      public var i_hak:MovieClip;
      
      public var i_hfkj:MovieClip;
      
      public var i_hgk:MovieClip;
      
      public var i_hj:MovieClip;
      
      public var i_jchg:MovieClip;
      
      public var i_jh:MovieClip;
      
      public var imageMC:MovieClip;
      
      public var imgCont:MovieClip;
      
      public var j_0:MovieClip;
      
      public var j_1:MovieClip;
      
      public var j_2:MovieClip;
      
      public var j__2:NodeCtfFlag;
      
      public var j_a:MovieClip;
      
      public var j_b:MovieClip;
      
      public var j_ba:MovieClip;
      
      public var j_bac:MovieClip;
      
      public var j_bci:MovieClip;
      
      public var j_c:MovieClip;
      
      public var j_d:MovieClip;
      
      public var j_e:MovieClip;
      
      public var j_ef:MovieClip;
      
      public var j_f:MovieClip;
      
      public var j_fd:MovieClip;
      
      public var j_fe:MovieClip;
      
      public var j_fkonhiq:MovieClip;
      
      public var j_g:MovieClip;
      
      public var j_ge:MovieClip;
      
      public var j_ghk:MovieClip;
      
      public var j_h:MovieClip;
      
      public var j_hed:MovieClip;
      
      public var j_hge:MovieClip;
      
      public var j_hoj:MovieClip;
      
      public var j_i:MovieClip;
      
      public var j_if:MovieClip;
      
      public var j_ihkn:MovieClip;
      
      public var j_ikp:MovieClip;
      
      public var j_il:MovieClip;
      
      public var j_ilm:MovieClip;
      
      public var j_j:MovieClip;
      
      public var j_ji:MovieClip;
      
      public var j_jl:MovieClip;
      
      public var j_k:MovieClip;
      
      public var j_kf:MovieClip;
      
      public var j_ki:MovieClip;
      
      public var j_kil:MovieClip;
      
      public var j_l:MovieClip;
      
      public var j_lmik:MovieClip;
      
      public var j_m:MovieClip;
      
      public var j_mi:MovieClip;
      
      public var j_mkl:MovieClip;
      
      public var j_n:MovieClip;
      
      public var j_o:MovieClip;
      
      public var j_p:MovieClip;
      
      public var k_:NodeHoldpoint;
      
      public var k_0:MovieClip;
      
      public var k_1:MovieClip;
      
      public var k_2:MovieClip;
      
      public var k__2:NodeCtfFlag;
      
      public var k_ajbl:MovieClip;
      
      public var k_al:MovieClip;
      
      public var k_elmp:MovieClip;
      
      public var k_ifl:MovieClip;
      
      public var k_inljfh:MovieClip;
      
      public var k_jil:MovieClip;
      
      public var k_l:MovieClip;
      
      public var k_ldfj:MovieClip;
      
      public var k_lefgh:MovieClip;
      
      public var k_lmgi:MovieClip;
      
      public var l_0:MovieClip;
      
      public var l_2:MovieClip;
      
      public var l__2:NodeCtfFlag;
      
      public var l_ak:MovieClip;
      
      public var l_bkjm:MovieClip;
      
      public var l_jkmg:MovieClip;
      
      public var l_kdm:MovieClip;
      
      public var l_kjcm:MovieClip;
      
      public var l_kpjm:MovieClip;
      
      public var l_mk:MovieClip;
      
      public var l_mkde:MovieClip;
      
      public var l_mkij:MovieClip;
      
      public var l_n:MovieClip;
      
      public var m_:NodeHoldpoint;
      
      public var m_0:MovieClip;
      
      public var m_1:MovieClip;
      
      public var m_2:MovieClip;
      
      public var m_fl:MovieClip;
      
      public var m_ifjl:MovieClip;
      
      public var m_jln:MovieClip;
      
      public var m_klihg:MovieClip;
      
      public var m_lan:MovieClip;
      
      public var m_ldno:MovieClip;
      
      public var m_lf:MovieClip;
      
      public var m_li:MovieClip;
      
      public var m_ngjl:MovieClip;
      
      public var midCont:MovieClip;
      
      public var n_0:MovieClip;
      
      public var n_1:MovieClip;
      
      public var n_2:MovieClip;
      
      public var n_cbg:MovieClip;
      
      public var n_cfgm:MovieClip;
      
      public var n_gh:MovieClip;
      
      public var n_kojifh:MovieClip;
      
      public var n_mj:MovieClip;
      
      public var n_mpo:MovieClip;
      
      public var n_qpm:MovieClip;
      
      public var o_0:MovieClip;
      
      public var o_1:MovieClip;
      
      public var o__1:NodeCtfFlag;
      
      public var o_ab:MovieClip;
      
      public var o_cdg:MovieClip;
      
      public var o_jnheq:MovieClip;
      
      public var o_ma:MovieClip;
      
      public var o_pn:MovieClip;
      
      public var p_0:MovieClip;
      
      public var p_1:MovieClip;
      
      public var p_2:MovieClip;
      
      public var p_bcn:MovieClip;
      
      public var p_cd:MovieClip;
      
      public var p_ceghf:MovieClip;
      
      public var p_lm:MovieClip;
      
      public var p_lob:MovieClip;
      
      public var q_:NodeHoldpoint;
      
      public var q_0:MovieClip;
      
      public var q_abn:MovieClip;
      
      public var q_ho:MovieClip;
      
      public var wallMC:MovieClip;
      
      public var z_bc:MovieClip;
      
      public var z_h:MovieClip;
      
      public var game:Game;
      
      public var wall:BitmapData;
      
      public var image:BitmapData;
      
      private var camFocus:Unit;
      
      private var camIntenseX:Number;
      
      private var camIntenseY:Number;
      
      private var useAim:Boolean;
      
      private var shakeX:Number;
      
      private var shakeY:Number;
      
      private var shkOffX:Number;
      
      private var shkOffY:Number;
      
      public var spawns:Array;
      
      public var spawnsT1:Array;
      
      public var spawnsT2:Array;
      
      public var waypoints:Array;
      
      public var wpOb:Object;
      
      public var aiactions:Array;
      
      public var physboxes:Array;
      
      public var pickups:Array;
      
      public var holdpoints:Array;
      
      public var ctfflags:Array;
      
      public var lights:Array;
      
      public var downarrows:Array;
      
      public var flag1:NodeCtfFlag;
      
      public var flag2:NodeCtfFlag;
      
      private var removed:Boolean;
      
      public function Arena(_game:Game)
      {
         super();
         addFrameScript(1,this.frame2,2,this.frame3,3,this.frame4,4,this.frame5,5,this.frame6,6,this.frame7,7,this.frame8,8,this.frame9,9,this.frame10,10,this.frame11,11,this.frame12,12,this.frame13,13,this.frame14);
         this.game = _game;
         trace(MatchSettings.useMap);
         trace(MatchSettings.useMap.map);
         gotoAndStop(MatchSettings.useMap.map);
         if(MatchSettings.useMap.bg1)
         {
            this.game.bg1.gotoAndStop(MatchSettings.useMap.bg1);
         }
         if(MatchSettings.useMap.bg2)
         {
            this.game.bg2.gotoAndStop(MatchSettings.useMap.bg2);
         }
         if(MatchSettings.useMap.sky)
         {
            this.game.bgSky.gotoAndStop(MatchSettings.useMap.sky);
         }
      }
      
      public function changeWallFrame(_frame:uint = 1, _next:Boolean = false) : void
      {
         if(_next)
         {
            _frame = this.wallMC.currentFrame + 1;
         }
         this.wallMC.gotoAndStop(_frame);
         this.wall.fillRect(new Rectangle(0,0,this.wall.width,this.wall.height),0);
         this.wall.draw(this.wallMC);
      }
      
      protected function Init() : void
      {
         var _loc5_:uint = 0;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:uint = 0;
         if(this.wallMC.box)
         {
            this.wall = new BitmapData(this.wallMC.box.width,this.wallMC.box.height,true,0);
         }
         else
         {
            this.wall = new BitmapData(this.wallMC.width,this.wallMC.height,true,0);
         }
         this.wall.draw(this.wallMC);
         this.wallMC.visible = false;
         this.image = new BitmapData(this.imageMC.width,this.imageMC.height,true,0);
         var _loc1_:Matrix = new Matrix();
         _loc1_.translate(this.imageMC.x,this.imageMC.y);
         this.image.draw(this.imageMC,_loc1_);
         removeChild(this.imageMC);
         var _loc2_:Bitmap = new Bitmap(this.image);
         this.imgCont.addChild(_loc2_);
         this.shakeX = 0;
         this.shakeY = 0;
         this.shkOffX = 0;
         this.shkOffY = 0;
         this.spawns = [];
         this.spawnsT1 = [];
         this.spawnsT2 = [];
         this.waypoints = [];
         this.aiactions = [];
         this.physboxes = [];
         this.pickups = [];
         this.holdpoints = [];
         this.ctfflags = [];
         this.lights = [];
         this.downarrows = [];
         var _loc3_:uint = 1;
         var _loc4_:uint = 2;
         if(MatchSettings.useMode == "ctf" && Math.random() < 0.5)
         {
            _loc3_ = 2;
            _loc4_ = 1;
         }
         for(_loc5_ = 0; _loc5_ < numChildren; _loc5_++)
         {
            if(getChildAt(_loc5_).name == "light")
            {
               this.lights.push(getChildAt(_loc5_));
            }
            if(getChildAt(_loc5_) is DownArrow)
            {
               this.downarrows.push(getChildAt(_loc5_));
               getChildAt(_loc5_).visible = false;
            }
            if(getChildAt(_loc5_) is NodeSpawn)
            {
               _loc6_ = getChildAt(_loc5_);
               if(_loc6_.team == 0)
               {
                  this.spawns.push(getChildAt(_loc5_));
               }
               if(_loc6_.team == _loc3_)
               {
                  this.spawnsT1.push(getChildAt(_loc5_));
               }
               if(_loc6_.team == _loc4_)
               {
                  this.spawnsT2.push(getChildAt(_loc5_));
               }
            }
            if(getChildAt(_loc5_) is NodeWaypoint)
            {
               this.waypoints.push(getChildAt(_loc5_));
            }
            if(getChildAt(_loc5_) is NodeAiAction)
            {
               this.aiactions.push(getChildAt(_loc5_));
            }
            if(getChildAt(_loc5_) is NodePhysBox || getChildAt(_loc5_) is NodePhysBox_)
            {
               this.physboxes.push(getChildAt(_loc5_));
            }
            if(getChildAt(_loc5_) is NodePickup)
            {
               this.pickups.push(getChildAt(_loc5_));
            }
            if(getChildAt(_loc5_) is NodeHoldpoint)
            {
               if(MatchSettings.useMode == "dom")
               {
                  this.holdpoints.push(getChildAt(_loc5_));
               }
               else
               {
                  getChildAt(_loc5_).visible = false;
               }
            }
            if(getChildAt(_loc5_) is NodeCtfFlag)
            {
               if(MatchSettings.useMode == "ctf")
               {
                  _loc7_ = getChildAt(_loc5_);
                  this.ctfflags.push(_loc7_);
                  if(_loc7_.team == 1)
                  {
                     this["flag" + _loc3_] = _loc7_;
                     _loc7_.setTeam(_loc3_);
                  }
                  else
                  {
                     this["flag" + _loc4_] = _loc7_;
                     _loc7_.setTeam(_loc4_);
                  }
               }
               else
               {
                  getChildAt(_loc5_).visible = false;
               }
            }
         }
         this.holdpoints.sortOn("x",Array.NUMERIC);
         for(_loc5_ = 0; _loc5_ < this.holdpoints.length; _loc5_++)
         {
            this.holdpoints[_loc5_].letter = UT.getEl(_loc5_,["A","B","C","D","E"]);
         }
         this.wpOb = {};
         for(_loc5_ = 0; _loc5_ < this.waypoints.length; _loc5_++)
         {
            this.wpOb[this.waypoints[_loc5_].id] = this.waypoints[_loc5_];
            this.waypoints[_loc5_].arena = this;
         }
         for(_loc5_ = 0; _loc5_ < this.waypoints.length; _loc5_++)
         {
            this.waypoints[_loc5_].setConnectors(this.wpOb);
         }
         for(_loc5_ = 0; _loc5_ < this.aiactions.length; _loc5_++)
         {
            for(_loc8_ = 0; _loc8_ < this.aiactions[_loc5_].con.length; _loc8_++)
            {
               trace(this.aiactions[_loc5_].name);
               this.wpOb[this.aiactions[_loc5_].con.charAt(_loc8_)].setActionBox(this.aiactions[_loc5_]);
            }
         }
         for(_loc5_ = 0; _loc5_ < this.spawns.length; _loc5_++)
         {
            this.spawns[_loc5_].setWaypoint(this.wpOb[this.spawns[_loc5_].id]);
         }
         for(_loc5_ = 0; _loc5_ < this.spawnsT1.length; _loc5_++)
         {
            this.spawnsT1[_loc5_].setWaypoint(this.wpOb[this.spawnsT1[_loc5_].id]);
         }
         for(_loc5_ = 0; _loc5_ < this.spawnsT2.length; _loc5_++)
         {
            this.spawnsT2[_loc5_].setWaypoint(this.wpOb[this.spawnsT2[_loc5_].id]);
         }
         for(_loc5_ = 0; _loc5_ < this.pickups.length; _loc5_++)
         {
            this.pickups[_loc5_].game = this.game;
         }
         this.game.physWorld.generateWorld(this.physboxes);
         this.toggleLights();
         this.game.InitGame(this);
      }
      
      public function toggleLights() : void
      {
         for(var i:uint = 0; i < this.lights.length; i++)
         {
            this.lights[i].visible = SD.graphLights;
         }
      }
      
      public function setShake(_shakeX:Number, _shakeY:Number) : void
      {
         if(!SD.screenShake)
         {
            return;
         }
         if(_shakeX > this.shakeX)
         {
            this.shakeX = _shakeX;
         }
         if(_shakeY > this.shakeY)
         {
            this.shakeY = _shakeY;
         }
      }
      
      public function setFocus(_unit:Unit, _intense:Number = 0.5) : void
      {
         this.camFocus = _unit;
         this.camIntenseX = _intense;
         this.camIntenseY = _intense;
      }
      
      public function EnterFrame() : void
      {
         var toX:Number = NaN;
         var toY:Number = NaN;
         var focusX:Number = NaN;
         var focusY:Number = NaN;
         if(this.game.destroyed)
         {
            return;
         }
         if(this.shakeX)
         {
            this.shkOffX = UT.rand(-this.shakeX,this.shakeX);
            this.shakeX -= 0.2;
            if(this.shakeX < 0)
            {
               this.shakeX = 0;
            }
         }
         else
         {
            this.shkOffX = 0;
         }
         if(this.shakeY)
         {
            this.shkOffY = UT.rand(-this.shakeY,this.shakeY);
            this.shakeY -= 0.2;
            if(this.shakeY < 0)
            {
               this.shakeY = 0;
            }
         }
         else
         {
            this.shkOffY = 0;
         }
         if(this.camFocus)
         {
            focusX = !this.camFocus.dead ? Number(this.camFocus.x) : Number(this.camFocus.dead.rdBody.GetDefinition().userData.x);
            focusY = !this.camFocus.dead ? Number(this.camFocus.y) : Number(this.camFocus.dead.rdBody.GetDefinition().userData.y + 50);
            if(this.camFocus.human)
            {
               toX = Main.WIDTH * 0.5 - focusX - (this.game.mouseX - Main.WIDTH * 0.5) * this.camIntenseX;
               toY = Main.HEIGHT * 0.5 - focusY - (this.game.mouseY - Main.HEIGHT * 0.5) * this.camIntenseY + 20;
            }
            else
            {
               toX = Main.WIDTH * 0.5 - focusX;
               toY = Main.HEIGHT * 0.5 - focusY + 20;
            }
            if(MatchSettings.useMap.extra == "frigate")
            {
               UT.setDate();
               toY += UT.getOscillation(0.5,25);
            }
            if(MatchSettings.useMap.extra == "cqc")
            {
               UT.setDate();
               toY += UT.getOscillation(0.5,5);
            }
            x += (toX - x) * 0.7;
            y += (toY - y) * 0.7;
            if(x > 0)
            {
               x = 0;
            }
            if(y > 5)
            {
               y = 0;
            }
            if(x < -this.wall.width + Main.WIDTH)
            {
               x = -this.wall.width + Main.WIDTH;
            }
            if(y < -this.wall.height + Main.HEIGHT)
            {
               y = -this.wall.height + Main.HEIGHT;
            }
         }
         this.game.bg1.x = (Main.WIDTH - this.game.bg1.usebox.width) * (x / (Main.WIDTH - this.wall.width));
         this.game.bg1.y = (Main.HEIGHT - this.game.bg1.usebox.height) * (y / (Main.HEIGHT - this.wall.height));
         this.game.bg2.x = (Main.WIDTH - this.game.bg2.usebox.width) * (x / (Main.WIDTH - this.wall.width));
         this.game.bg2.y = (Main.HEIGHT - this.game.bg2.usebox.height) * (y / (Main.HEIGHT - this.wall.height));
         x += this.shkOffX;
         y += this.shkOffY;
      }
      
      public function destroy() : void
      {
         this.wall.dispose();
      }
      
      function frame2() : *
      {
         this.Init();
      }
      
      function frame3() : *
      {
         this.Init();
      }
      
      function frame4() : *
      {
         this.Init();
      }
      
      function frame5() : *
      {
         this.Init();
      }
      
      function frame6() : *
      {
         this.Init();
      }
      
      function frame7() : *
      {
         this.Init();
      }
      
      function frame8() : *
      {
         this.Init();
      }
      
      function frame9() : *
      {
         this.Init();
      }
      
      function frame10() : *
      {
         this.Init();
      }
      
      function frame11() : *
      {
         this.Init();
      }
      
      function frame12() : *
      {
         this.Init();
      }
      
      function frame13() : *
      {
         this.Init();
      }
      
      function frame14() : *
      {
         this.Init();
      }
   }
}
