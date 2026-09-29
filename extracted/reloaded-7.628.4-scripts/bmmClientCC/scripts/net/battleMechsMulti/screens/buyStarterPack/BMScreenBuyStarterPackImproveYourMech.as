package net.battleMechsMulti.screens.buyStarterPack
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechDrone;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.mechView.BMMechViewManualColors;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1408")]
   public class BMScreenBuyStarterPackImproveYourMech extends BMScreenBuyStarterPack
   {
      
      public var mcMechHolder:Sprite;
      
      public var mcItemsPosition:Sprite;
      
      public var mcOldMechPosition:Sprite;
      
      public var mcNewMechPosition:Sprite;
      
      public var mcStat1:MovieClip;
      
      public var mcStat2:MovieClip;
      
      public var mcStat3:MovieClip;
      
      public var mcStat4:MovieClip;
      
      public var mcRays1:Sprite;
      
      public var mcRays2:Sprite;
      
      public var mcArrow1:Sprite;
      
      public var mcArrow2:Sprite;
      
      public var mcArrow3:Sprite;
      
      private var oldMechView:BMMechView;
      
      private var newMechView:BMMechView;
      
      private var manualNewMechStructure:BMMechStructure = null;
      
      private var _removeScreenInstantly:Boolean = false;
      
      private const OLD_MECH_SIZE_RATIO:Number = 0.75;
      
      private const NEW_MECH_SIZE_RATIO:Number = 0.85;
      
      private var oldDrone:MovieClip;
      
      private var newDrone:MovieClip;
      
      private var _droneOriginXPos:Number;
      
      private var _droneOriginYPos:Number;
      
      public function BMScreenBuyStarterPackImproveYourMech()
      {
         super();
      }
      
      public static function getHPText(param1:Number) : String
      {
         var _loc2_:String = BMLanguageManager.getInstance().getText("buyStarterPack_improveYourMech_hp");
         return BMDataManager.getInstance().replaceStringInText(_loc2_,"%VALUE%",String(param1));
      }
      
      public static function getDamageText(param1:Number) : String
      {
         var _loc2_:String = BMLanguageManager.getInstance().getText("buyStarterPack_improveYourMech_damage");
         return BMDataManager.getInstance().replaceStringInText(_loc2_,"%VALUE%",String(param1));
      }
      
      public static function getEnergyText(param1:Number) : String
      {
         var _loc2_:String = BMLanguageManager.getInstance().getText("buyStarterPack_improveYourMech_energy");
         return BMDataManager.getInstance().replaceStringInText(_loc2_,"%VALUE%",String(param1));
      }
      
      public static function getHeatText(param1:Number) : String
      {
         var _loc2_:String = BMLanguageManager.getInstance().getText("buyStarterPack_improveYourMech_heat");
         return BMDataManager.getInstance().replaceStringInText(_loc2_,"%VALUE%",String(param1));
      }
      
      public function initialize() : void
      {
         var _loc2_:Object = null;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:String = null;
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("buyStarterPack");
         if(dataM.myProfile.improveYourMechStarterPackOffer != null)
         {
            this.manualNewMechStructure = new BMMechStructure(BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID);
            this.manualNewMechStructure.initialize(dataM.player1PlayerID,1);
            this.manualNewMechStructure.copyMechStructure(dataM.myPlayerData.mechStructures[1]);
            this.manualNewMechStructure.convertPlayerItemIDsIntoItemIDs();
            for each(_loc2_ in dataM.myProfile.improveYourMechStarterPackOffer)
            {
               _loc3_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc2_.playerItemID);
               _loc4_ = BMMechStructure.getEquipmentSlotByTypeAndID(_loc3_.equipmentType,_loc3_.equipmentID);
               this.manualNewMechStructure[_loc4_] = _loc2_.newItemID;
            }
         }
         else
         {
            if(dataM.myProfile.starterPackData == null)
            {
               this._removeScreenInstantly = true;
            }
            else if(dataM.myProfile.starterPackData.torso == 0)
            {
               this._removeScreenInstantly = true;
            }
            if(this._removeScreenInstantly)
            {
               visible = false;
            }
         }
         dataM.trackScreenView("buyStarterPack");
         dataM.updateStarterPackActive();
         var _loc1_:String = BMLanguageManager.getInstance().getText("buyStarterPack_improveYourMechTitle");
         updateTextAndFormat(txtTitle,_loc1_);
         this.initArrowsAnim();
      }
      
      public function refreshScreen(param1:String, param2:Array, param3:Array) : void
      {
         if(this._removeScreenInstantly)
         {
            return;
         }
         refreshScreenSub(param1);
         if(this.manualNewMechStructure != null)
         {
            this.displayStats(param2,BMBuyStarterPackScreenChooser.getStatsForItems(this.manualNewMechStructure.mechItemIDs));
         }
         else
         {
            this.displayStats(param2,param3);
         }
         this.displayOldMech();
         this.displayNewMech();
      }
      
      private function displayStats(param1:Array, param2:Array) : void
      {
         var _loc8_:String = null;
         var _loc10_:MovieClip = null;
         var _loc11_:Object = null;
         var _loc3_:Number = Math.ceil((param2[0] / param1[0] - 1) * 100);
         var _loc4_:Number = Math.ceil((param2[3] / param1[3] - 1) * 100);
         var _loc5_:Number = Math.ceil((param2[2] / param1[2] - 1) * 100);
         var _loc6_:Number = Math.ceil((param2[1] / param1[1] - 1) * 100);
         var _loc7_:Array = new Array();
         if(_loc3_ > 0)
         {
            _loc7_.push({
               "type":"hp",
               "text":getHPText(_loc3_)
            });
         }
         if(_loc4_ > 0)
         {
            _loc7_.push({
               "type":"damage",
               "text":getDamageText(_loc4_)
            });
         }
         if(_loc5_ > 0)
         {
            _loc7_.push({
               "type":"heat",
               "text":getHeatText(_loc5_)
            });
         }
         if(_loc6_ > 0)
         {
            _loc7_.push({
               "type":"energy",
               "text":getEnergyText(_loc6_)
            });
         }
         var _loc9_:uint = 0;
         while(_loc9_ < 4)
         {
            _loc10_ = this["mcStat" + (_loc9_ + 1)];
            if(_loc7_[_loc9_] == null)
            {
               _loc10_.visible = false;
            }
            else
            {
               _loc11_ = _loc7_[_loc9_];
               _loc10_.mcHP.visible = _loc11_.type == "hp";
               _loc10_.mcDamage.visible = _loc11_.type == "damage";
               _loc10_.mcHeat.visible = _loc11_.type == "heat";
               _loc10_.mcEnergy.visible = _loc11_.type == "energy";
               updateTextAndFormat(_loc10_.txtBonus,_loc11_.text);
            }
            _loc9_++;
         }
         switch(_loc7_.length)
         {
            case 3:
               this.mcStat1.y = 136.05;
               this.mcStat2.y = 179.55;
               this.mcStat3.y = 223.05;
               break;
            case 2:
               this.mcStat1.y = 151.05;
               this.mcStat2.y = 212.55;
               break;
            case 1:
               this.mcStat1.y = 180.05;
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent == null)
         {
            return;
         }
         if(this._removeScreenInstantly)
         {
            if(screensM.screenBlack.isActive() == false)
            {
               this._removeScreenInstantly = false;
               closeScreen();
            }
            return;
         }
         if(this.newMechView != null)
         {
            this.oldMechView.onEnterFrameTrigger();
            this.newMechView.onEnterFrameTrigger();
            this.mcRays1.rotation += 0.4;
            this.mcRays2.rotation -= 0.2;
         }
      }
      
      private function displayOldMech() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:uint = 1;
         this.oldMechView = new BMMechView();
         this.oldMechView.useLegsShadow = true;
         this.oldMechView.initialize(dataM.player1PlayerID,"battle",BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID,this.OLD_MECH_SIZE_RATIO,false);
         this.oldMechView.buildMech(dataM.myPlayerData.mechStructures[_loc2_],this.oldMechBuilt);
      }
      
      private function oldMechBuilt() : void
      {
         this.oldMechView.x = this.mcOldMechPosition.x;
         this.oldMechView.y = this.mcOldMechPosition.y - (this.oldMechView.mechSizer.height + this.oldMechView.mechSizer.y);
         this.mcMechHolder.addChild(this.oldMechView);
         if(this.displayDrones == false)
         {
            return;
         }
         var _loc1_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,dataM.myPlayerData.mechStructures[1].drone);
         var _loc2_:BMItemData = dataM.itemsDB[_loc1_.itemID];
         this.addDroneGrp(false,_loc2_,this.OLD_MECH_SIZE_RATIO,this.oldMechView,_loc1_.colorID);
      }
      
      private function displayNewMech() : void
      {
         var _loc3_:BMMechStructure = null;
         var _loc4_:BMMechViewManualColors = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this.newMechView = new BMMechView();
         this.newMechView.useLegsShadow = true;
         var _loc2_:uint = 0;
         if(this.manualNewMechStructure != null)
         {
            _loc2_ = 1;
         }
         this.newMechView.initialize(_loc2_,"battle",BMMechStructure.ITEM_TYPE_ITEM_ID,this.NEW_MECH_SIZE_RATIO,false);
         if(this.manualNewMechStructure != null)
         {
            this.newMechView.buildMech(this.manualNewMechStructure,this.newMechBuilt);
         }
         else
         {
            _loc3_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
            _loc3_.torso = dataM.myProfile.starterPackData.torso;
            _loc3_.leg = dataM.myProfile.starterPackData.leg;
            _loc3_.sideWeapon1 = dataM.myProfile.starterPackData.sideWeapon1;
            _loc3_.sideWeapon2 = dataM.myProfile.starterPackData.sideWeapon2;
            _loc3_.topWeapon1 = dataM.myProfile.starterPackData.topWeapon1;
            _loc3_.topWeapon2 = dataM.myProfile.starterPackData.topWeapon2;
            _loc4_ = new BMMechViewManualColors();
            _loc4_.torso = dataM.myProfile.starterPackData.mechColorID;
            _loc4_.leg = dataM.myProfile.starterPackData.mechColorID;
            _loc4_.sideWeapon = dataM.myProfile.starterPackData.mechColorID;
            _loc4_.topWeapon = dataM.myProfile.starterPackData.mechColorID;
            this.newMechView.setManualColors(_loc4_);
            this.newMechView.buildMech(_loc3_,this.newMechBuilt);
         }
      }
      
      private function newMechBuilt() : void
      {
         this.newMechView.activateBreathing();
         this.newMechView.x = this.mcNewMechPosition.x;
         this.newMechView.y = this.mcNewMechPosition.y - (this.newMechView.mechSizer.height + this.newMechView.mechSizer.y);
         this.mcMechHolder.addChild(this.newMechView);
         if(this.displayDrones == false)
         {
            return;
         }
         var _loc1_:BMItemData = dataM.itemsDB[this.manualNewMechStructure.drone];
         this.addDroneGrp(true,_loc1_,this.NEW_MECH_SIZE_RATIO,this.newMechView,this.manualNewMechStructure.drone_colorID);
      }
      
      private function get displayDrones() : Boolean
      {
         if(this.manualNewMechStructure == null)
         {
            return false;
         }
         if(this.manualNewMechStructure.drone == 0)
         {
            return false;
         }
         return true;
      }
      
      private function addDroneGrp(param1:Boolean, param2:BMItemData, param3:Number, param4:BMMechView, param5:uint) : void
      {
         var _loc6_:MovieClip = null;
         if(param1)
         {
            this.newDrone = externalAssetsM.getAsset("items1",param2.grp,0,0,false,true);
            _loc6_ = this.newDrone;
         }
         else
         {
            this.oldDrone = externalAssetsM.getAsset("items1",param2.grp,0,0,false,true);
            _loc6_ = this.oldDrone;
         }
         var _loc7_:uint = 0;
         if(param4 == this.newMechView)
         {
            _loc7_ = 50;
         }
         var _loc8_:Point = new Point(param4.torso.x + BMMechDrone.DRONE_X_DISTANCE_FROM_TORSO - _loc7_,param4.torso.y + BMMechDrone.DRONE_Y_DISTANCE_FROM_TORSO);
         var _loc9_:Point = param4.localToGlobal(_loc8_);
         var _loc10_:Array = [_loc9_.x,_loc9_.y,param3,param5,param4];
         if(_loc6_.loading)
         {
            externalAssetsM.modifyExternalAssetDuplicationContainer(_loc6_,true,0,this.droneGrpLoaded,_loc10_);
         }
         else
         {
            this.droneGrpLoaded(_loc6_,_loc10_);
         }
      }
      
      private function droneGrpLoaded(param1:MovieClip, param2:Array) : void
      {
         var _loc3_:Number = Number(param2[0]);
         var _loc4_:Number = Number(param2[1]);
         var _loc5_:Number = Number(param2[2]);
         var _loc6_:uint = uint(param2[3]);
         var _loc7_:BMMechView = param2[4];
         if(_loc6_ > 0)
         {
            dataM.colorItemGrp(param1,_loc6_);
         }
         param1.scaleX = _loc5_;
         param1.scaleY = _loc5_;
         param1.x = _loc3_ - param1.mcCenter.x * _loc5_;
         param1.y = _loc4_ - param1.mcCenter.y * _loc5_;
         this.mcMechHolder.addChild(param1);
         _loc7_.parent.removeChild(_loc7_);
         this.mcMechHolder.addChild(_loc7_);
         if(param1 == this.newDrone)
         {
            this._droneOriginXPos = this.newDrone.x;
            this._droneOriginYPos = this.newDrone.y;
            this.activateDroneMotion();
         }
      }
      
      private function activateDroneMotion() : void
      {
         var _loc1_:Number = Math.random() * 2 + 2;
         var _loc2_:Number = this._droneOriginXPos + Math.random() * 20 - 10;
         var _loc3_:Number = this._droneOriginYPos + Math.random() * 20 - 10;
         TweenMax.to(this.newDrone,0.45,{
            "delay":_loc1_,
            "x":_loc2_,
            "y":_loc3_,
            "onComplete":this.activateDroneMotion
         });
      }
      
      public function itemMouseOver(param1:Number, param2:Number) : void
      {
         tooltip.showToolTip("newsItem","",param2);
      }
      
      private function itemMouseOut(param1:Number, param2:Number) : void
      {
         tooltip.hideToolTip();
      }
      
      private function initArrowsAnim() : void
      {
         this.mcArrow1.alpha = 0;
         this.mcArrow2.alpha = 0;
         this.mcArrow3.alpha = 0;
         TweenMax.to(this.mcArrow1,0.3,{
            "delay":0,
            "alpha":1,
            "onComplete":this.arrowAlphaInCompleted,
            "onCompleteParams":[this.mcArrow1]
         });
         TweenMax.to(this.mcArrow2,0.3,{
            "delay":0.3,
            "alpha":1,
            "onComplete":this.arrowAlphaInCompleted,
            "onCompleteParams":[this.mcArrow2]
         });
         TweenMax.to(this.mcArrow3,0.3,{
            "delay":0.6,
            "alpha":1,
            "onComplete":this.arrowAlphaInCompleted,
            "onCompleteParams":[this.mcArrow3]
         });
      }
      
      private function arrowAlphaInCompleted(param1:Sprite) : void
      {
         TweenMax.to(param1,0.3,{
            "delay":1.2,
            "alpha":0,
            "onComplete":this.arrowAlphaOutCompleted,
            "onCompleteParams":[param1]
         });
      }
      
      private function arrowAlphaOutCompleted(param1:Sprite) : void
      {
         TweenMax.to(param1,0.3,{
            "delay":0.1,
            "alpha":1,
            "onComplete":this.arrowAlphaInCompleted,
            "onCompleteParams":[param1]
         });
      }
      
      override public function removeMe() : void
      {
         if(this.oldMechView != null)
         {
            this.oldMechView.removeMe();
            this.oldMechView = null;
         }
         if(this.newMechView != null)
         {
            this.newMechView.removeMe();
            this.newMechView = null;
         }
         TweenMax.killTweensOf(this.mcArrow1);
         TweenMax.killTweensOf(this.mcArrow2);
         TweenMax.killTweensOf(this.mcArrow3);
         if(this.newDrone != null)
         {
            TweenMax.killTweensOf(this.newDrone);
         }
         screensM.removeScreen(BMScreensManager.SCR_BUY_STARTER_PACK_IMPROVE_YOUR_MECH);
      }
   }
}

