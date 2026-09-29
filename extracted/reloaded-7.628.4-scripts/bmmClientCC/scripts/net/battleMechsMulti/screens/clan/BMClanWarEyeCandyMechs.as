package net.battleMechsMulti.screens.clan
{
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.mechView.BMMechViewManualColors;
   
   public class BMClanWarEyeCandyMechs
   {
      
      private var mechs:Array;
      
      public function BMClanWarEyeCandyMechs()
      {
         super();
      }
      
      public function createMechs(param1:Sprite, param2:Sprite, param3:Sprite) : void
      {
         this.mechs = new Array();
         var _loc4_:BMMechStructure = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
         _loc4_.torso = 29905;
         _loc4_.leg = 7761;
         _loc4_.sideWeapon1 = 29177;
         _loc4_.sideWeapon2 = 17940;
         _loc4_.sideWeapon3 = 17380;
         _loc4_.sideWeapon4 = 26525;
         _loc4_.topWeapon1 = 19540;
         _loc4_.topWeapon2 = 20260;
         this.createSpecificMech(-180,0.4,_loc4_,520,param3);
         _loc4_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
         _loc4_.torso = 21590;
         _loc4_.leg = 10640;
         _loc4_.sideWeapon1 = 18060;
         _loc4_.sideWeapon2 = 15580;
         _loc4_.sideWeapon3 = 25253;
         _loc4_.sideWeapon4 = 30431;
         _loc4_.topWeapon1 = 19420;
         _loc4_.topWeapon2 = 20710;
         this.createSpecificMech(180,0.4,_loc4_,520,param3);
         _loc4_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
         _loc4_.torso = 21590;
         _loc4_.leg = 25915;
         _loc4_.sideWeapon1 = 25483;
         _loc4_.sideWeapon2 = 17640;
         _loc4_.sideWeapon3 = 18470;
         _loc4_.sideWeapon4 = 18800;
         _loc4_.topWeapon1 = 19680;
         _loc4_.topWeapon2 = 27165;
         this.createSpecificMech(-250,0.5,_loc4_,521,param2);
         _loc4_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
         _loc4_.torso = 22790;
         _loc4_.leg = 11590;
         _loc4_.sideWeapon1 = 18330;
         _loc4_.sideWeapon2 = 17940;
         _loc4_.sideWeapon3 = 16480;
         _loc4_.sideWeapon4 = 15880;
         _loc4_.topWeapon1 = 19540;
         _loc4_.topWeapon2 = 26735;
         this.createSpecificMech(250,0.5,_loc4_,521,param2);
         _loc4_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
         _loc4_.torso = 28043;
         _loc4_.leg = 10980;
         _loc4_.sideWeapon1 = 17850;
         _loc4_.sideWeapon2 = 26405;
         _loc4_.sideWeapon3 = 17230;
         _loc4_.sideWeapon4 = 18940;
         _loc4_.topWeapon1 = 28166;
         _loc4_.topWeapon2 = 25343;
         this.createSpecificMech(-340,0.6,_loc4_,522,param1);
         _loc4_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
         _loc4_.torso = 22340;
         _loc4_.leg = 10980;
         _loc4_.sideWeapon1 = 18240;
         _loc4_.sideWeapon2 = 17230;
         _loc4_.sideWeapon3 = 17850;
         _loc4_.sideWeapon4 = 26145;
         _loc4_.topWeapon1 = 20500;
         _loc4_.topWeapon2 = 20120;
         this.createSpecificMech(340,0.6,_loc4_,522,param1);
      }
      
      private function createSpecificMech(param1:int, param2:Number, param3:BMMechStructure, param4:uint, param5:Sprite) : void
      {
         var _loc6_:uint = 150;
         var _loc7_:uint = Math.ceil(Math.random() * 3);
         var _loc8_:BMMechView = new BMMechView();
         _loc8_.initialize(0,"hanger","itemID",param2);
         var _loc9_:Array = new Array();
         _loc9_.push(_loc8_,param1,param5);
         if(param1 > 0)
         {
            _loc8_.scaleX *= -1;
         }
         var _loc10_:BMMechViewManualColors = new BMMechViewManualColors();
         _loc10_.setSpecificColorForAll(param4);
         _loc8_.setManualColors(_loc10_);
         _loc8_.buildMech(param3,this.onBuildMechComplete,_loc9_);
         this.mechs.push(_loc8_);
      }
      
      private function onBuildMechComplete(param1:Array) : void
      {
         var _loc2_:BMMechView = param1[0];
         _loc2_.x = param1[1];
         _loc2_.resetYPos();
         param1[2].addChild(_loc2_);
      }
      
      public function removeMechs() : void
      {
         var _loc2_:BMMechView = null;
         if(this.mechs == null)
         {
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < this.mechs.length)
         {
            _loc2_ = this.mechs[_loc1_];
            _loc2_.removeMe();
            this.mechs[_loc1_] = null;
            _loc1_++;
         }
      }
   }
}

