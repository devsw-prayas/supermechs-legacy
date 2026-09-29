package net.battleMechsMulti.screens.mechBuilds
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.clanWars.BMClanWarsManager;
   import net.battleMechsMulti.managers.mechBuilds.BMMechBuildData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.mechView.BMMechViewManualColors;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.clan.BMScreenClanMenu;
   import net.battleMechsMulti.screens.workshop.BMScreenWorkshop;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2802")]
   public class BMScreenMechBuilds extends BMBaseScreen
   {
      
      public var btnBuild0:BMBasicButton;
      
      public var btnBuild1:BMBasicButton;
      
      public var btnBuild2:BMBasicButton;
      
      public var btnBuild3:BMBasicButton;
      
      public var btnBuild4:BMBasicButton;
      
      public var btnBuild5:BMBasicButton;
      
      public var btnBuild6:BMBasicButton;
      
      public var btnBuild7:BMBasicButton;
      
      public var btnBuild8:BMBasicButton;
      
      public var mcMechThumb0:RaidEnemyThumb;
      
      public var mcMechThumb1:RaidEnemyThumb;
      
      public var mcMechThumb2:RaidEnemyThumb;
      
      public var txtWeight0:TextField;
      
      public var txtWeight1:TextField;
      
      public var txtWeight2:TextField;
      
      public var mcWeight0:MovieClip;
      
      public var mcWeight1:MovieClip;
      
      public var mcWeight2:MovieClip;
      
      public var btnClone:BMBasicButton;
      
      public var btnCancelClone:BMBasicButton;
      
      public var btnRename:BMBasicButton;
      
      public var btnClose:BMBasicButton;
      
      public var btnSelect:BMBasicButton;
      
      public var txtTitle:TextField;
      
      public var txtSelectedBuildName:TextField;
      
      public var mcSelectedBuildMarker:Sprite;
      
      public var mcCloneMarker0:Sprite;
      
      public var mcCloneMarker1:Sprite;
      
      public var mcCloneMarker2:Sprite;
      
      public var mcCloneMarker3:Sprite;
      
      public var mcCloneMarker4:Sprite;
      
      public var mcCloneMarker5:Sprite;
      
      public var mcCloneMarker6:Sprite;
      
      public var mcCloneMarker7:Sprite;
      
      public var mcCloneMarker8:Sprite;
      
      public var mcBuildIcon:Sprite;
      
      private var _inspectBuildID:uint = 0;
      
      private var _cloning:Boolean = false;
      
      private var _cloningToBuildID:uint;
      
      private var _buildCloned:Boolean = false;
      
      private var _selectedBuildAltered:Boolean = false;
      
      private var _mechs456Migrated:Boolean = false;
      
      public var mcWorkshopGuide:MovieClip;
      
      private const visibleItemIDs:Array = [BMMechStructure.TORSO,BMMechStructure.LEG,BMMechStructure.SIDE_WEAPON_1,BMMechStructure.SIDE_WEAPON_2,BMMechStructure.SIDE_WEAPON_3,BMMechStructure.SIDE_WEAPON_4,BMMechStructure.TOP_WEAPON_1,BMMechStructure.TOP_WEAPON_2];
      
      private var _nameChanged:Boolean = false;
      
      public function BMScreenMechBuilds()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("mechBuilds");
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         this._mechs456Migrated = dataM.mechBuildsM.migrateMechs456ToBuild2();
         this.initButtons();
         this._inspectBuildID = dataM.mechBuildsM.selectedBuildID;
         this.refreshMechThumbs();
         this.refreshMechsWeight();
         this.refreshSelectedBuildTitle();
         this.setCloneMarkersPositions();
         this.hideAllCloneMarkers();
         this.refreshMarkerPosition();
      }
      
      public function activateSelectOnlyMode(param1:uint = 1, param2:Boolean = false) : void
      {
         var _loc5_:BMBasicButton = null;
         var _loc6_:BMMechBuildData = null;
         var _loc7_:uint = 0;
         var _loc8_:BMMechStructure = null;
         updateTextAndFormat(this.txtTitle,getScreenText("selectTitle"));
         this.btnRename.visible = false;
         this.btnClone.visible = false;
         this.btnSelect.y -= 31;
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         while(_loc4_ < dataM.mechBuildsM.maxBuilds)
         {
            _loc5_ = this["btnBuild" + _loc4_];
            _loc6_ = dataM.mechBuildsM.getBuildData(_loc4_);
            if(_loc6_.isEmpty)
            {
               _loc5_.disableMe();
               if(dataM.mechBuildsM.selectedBuildID != _loc4_)
               {
                  _loc5_.alpha = 0.2;
               }
            }
            else if(_loc4_ >= 2)
            {
               _loc3_ = true;
            }
            _loc7_ = 1;
            while(_loc7_ <= Math.min(3,param1))
            {
               _loc8_ = _loc6_.mechStructures[_loc7_ - 1];
               if(dataM.isMechStructureReadyForBattle(_loc8_) == false)
               {
                  _loc5_.disableMe();
                  if(dataM.mechBuildsM.selectedBuildID != _loc4_)
                  {
                     _loc5_.alpha = 0.2;
                  }
                  break;
               }
               _loc7_++;
            }
            _loc4_++;
         }
         if(_loc3_ == false)
         {
            updateTextAndFormat(this.mcWorkshopGuide.txtWorkshopGuide,getScreenText("workshopGuide"));
            if(this.mcWorkshopGuide.txtWorkshopGuide.numLines == 2)
            {
               this.mcWorkshopGuide.txtWorkshopGuide.y += 10;
            }
            this.mcWorkshopGuide.y = 260;
         }
         if(param2)
         {
            if(dataM.mechBuildsM.getBuildsWith3ReadyMechs().indexOf(this._inspectBuildID) == -1)
            {
               this.btnSelect.disableMe();
            }
         }
      }
      
      private function initButtons() : void
      {
         var _loc2_:BMBasicButton = null;
         this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
         this.btnClone.addEventListener(BMIntractable.HIT,this.cloneClicked);
         this.btnClone.text = getScreenText("clone");
         this.btnCancelClone.addEventListener(BMIntractable.HIT,this.cancelCloneClicked);
         this.btnCancelClone.text = getGeneralText("cancel");
         this.btnCancelClone.visible = false;
         this.btnRename.addEventListener(BMIntractable.HIT,this.renameClicked);
         this.btnRename.text = getScreenText("rename");
         this.btnSelect.addEventListener(BMIntractable.HIT,this.selectClicked);
         this.btnSelect.text = getSpecificText("selectAccount_select");
         var _loc1_:uint = 0;
         while(_loc1_ < dataM.mechBuildsM.maxBuilds)
         {
            _loc2_ = this["btnBuild" + _loc1_];
            this.refreshButtonName(_loc1_);
            _loc2_.addEventListener(BMIntractable.HIT,this.buildClicked);
            _loc1_++;
         }
      }
      
      private function buildClicked(param1:Event) : void
      {
         var _loc2_:String = param1.target.name;
         var _loc3_:uint = uint(_loc2_.substr(_loc2_.length - 1,1));
         this.selectBuild(_loc3_);
      }
      
      private function selectBuild(param1:uint) : void
      {
         if(this._inspectBuildID == param1)
         {
            return;
         }
         if(this._cloning)
         {
            this._cloningToBuildID = param1;
            if(dataM.mechBuildsM.getBuildData(this._cloningToBuildID).isEmpty)
            {
               this.cloneConfirmed();
            }
            else
            {
               screensM.screenConfirmation.displayQuestionOrNotification("cloneMechBuild",this._inspectBuildID,param1);
            }
            return;
         }
         this._inspectBuildID = param1;
         this.refreshMarkerPosition();
         this.refreshMechThumbs();
         this.refreshMechsWeight();
         this.refreshSelectedBuildTitle();
         this.btnSelect.enableMe();
      }
      
      private function refreshMarkerPosition() : void
      {
         var _loc1_:BMBasicButton = this["btnBuild" + this._inspectBuildID];
         this.mcSelectedBuildMarker.y = _loc1_.y;
      }
      
      private function refreshMechThumbs() : void
      {
         var _loc3_:BMMechStructure = null;
         var _loc4_:BMMechViewManualColors = null;
         var _loc5_:uint = 0;
         var _loc6_:Vector.<BMMechStructure> = null;
         var _loc7_:RaidEnemyThumb = null;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:uint = 0;
         var _loc11_:BMPlayerItemData = null;
         var _loc1_:BMMechBuildData = dataM.mechBuildsM.getBuildData(this._inspectBuildID);
         var _loc2_:uint = 1;
         while(_loc2_ <= 3)
         {
            _loc3_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID);
            _loc3_.initialize(dataM.player1PlayerID,_loc2_);
            _loc3_.copyMechStructure(_loc1_.mechStructures[_loc2_ - 1]);
            _loc4_ = new BMMechViewManualColors();
            _loc5_ = 0;
            while(_loc5_ < this.visibleItemIDs.length)
            {
               _loc9_ = this.visibleItemIDs[_loc5_];
               _loc10_ = uint(_loc3_[_loc9_]);
               if(_loc10_ != 0)
               {
                  _loc11_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc10_);
                  if(_loc11_ != null)
                  {
                     if(_loc11_.colorID > 0)
                     {
                        _loc4_[_loc9_] = _loc11_.colorID;
                     }
                     else
                     {
                        _loc4_[_loc9_] = dataM.getItemPowerColorID(dataM.player1PlayerID,_loc10_);
                     }
                  }
               }
               _loc5_++;
            }
            _loc3_.convertPlayerItemIDsIntoItemIDs();
            _loc6_ = new Vector.<BMMechStructure>();
            _loc6_.push(_loc3_);
            _loc7_ = this["mcMechThumb" + (_loc2_ - 1)];
            _loc8_ = this._inspectBuildID + 1;
            _loc7_.initialize_mechView(_loc6_,_loc4_,1,_loc8_,false,true);
            _loc2_++;
         }
      }
      
      private function refreshMechsWeight() : void
      {
         var _loc2_:uint = 0;
         this.txtWeight0.text = "";
         this.txtWeight1.text = "";
         this.txtWeight2.text = "";
         this.mcWeight0.visible = false;
         this.mcWeight1.visible = false;
         this.mcWeight2.visible = false;
         var _loc1_:uint = 1;
         while(_loc1_ <= 3)
         {
            _loc2_ = dataM.mechBuildsM.getMechStructureWeight(this._inspectBuildID,_loc1_);
            if(_loc2_ != 0)
            {
               updateTextAndFormat(this["txtWeight" + (_loc1_ - 1)],TextUtils.getNumberWithComma(_loc2_));
               this["mcWeight" + (_loc1_ - 1)].visible = true;
               this["mcWeight" + (_loc1_ - 1)].gotoAndStop(1);
               if(_loc2_ >= BMScreenWorkshop.WEIGHT_EMPHASIZE_VAL)
               {
                  this["mcWeight" + (_loc1_ - 1)].gotoAndStop(2);
               }
            }
            _loc1_++;
         }
      }
      
      private function refreshSelectedBuildTitle() : void
      {
         updateTextAndFormat(this.txtSelectedBuildName,this.getBuildName(this._inspectBuildID));
         this.mcBuildIcon.x = this.txtSelectedBuildName.x + (this.txtSelectedBuildName.width - this.txtSelectedBuildName.textWidth) / 2 - (this.mcBuildIcon.width + 15);
      }
      
      private function renameClicked(param1:Event) : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("changeMechBuildName");
      }
      
      public function changeBuildName(param1:String) : void
      {
         this._nameChanged = true;
         dataM.mechBuildsM.renameBuild(this._inspectBuildID,param1);
         this.refreshSelectedBuildTitle();
         this.refreshButtonName(this._inspectBuildID);
         if(this._inspectBuildID == dataM.mechBuildsM.selectedBuildID)
         {
            this._selectedBuildAltered = true;
         }
      }
      
      private function refreshButtonName(param1:uint) : void
      {
         var _loc2_:BMBasicButton = this["btnBuild" + param1];
         _loc2_.text_withHTMLColoringForMobile = this.getBuildName(param1);
      }
      
      private function getBuildName(param1:uint) : String
      {
         var _loc2_:BMMechBuildData = dataM.mechBuildsM.getBuildData(param1);
         var _loc3_:String = _loc2_.buildName;
         if(_loc3_ == "")
         {
            _loc3_ = getScreenText("buildX");
            _loc3_ = dataM.replaceStringInText(_loc3_,"%NUMBER%",String(param1 + 1));
         }
         if(_loc2_.isEmpty)
         {
            _loc3_ = "<FONT COLOR=\'#999999\'>" + _loc3_ + "</FONT>";
         }
         return _loc3_;
      }
      
      public function cloneConfirmed() : void
      {
         dataM.mechBuildsM.cloneBuild(this._inspectBuildID,this._cloningToBuildID);
         this.cancelCloning();
         this.selectBuild(this._cloningToBuildID);
         this.refreshButtonName(this._cloningToBuildID);
         this.refreshMarkerPosition();
         this.mcSelectedBuildMarker.visible = true;
         this._buildCloned = true;
         if(this._cloningToBuildID == dataM.mechBuildsM.selectedBuildID)
         {
            this._selectedBuildAltered = true;
         }
      }
      
      public function cloneCancelled() : void
      {
         this.cancelCloning();
         this.mcSelectedBuildMarker.visible = true;
      }
      
      private function cloneClicked(param1:Event) : void
      {
         var _loc2_:BMBasicButton = this["btnBuild" + this._inspectBuildID];
         _loc2_.disableMe();
         this.showCloneMarkers();
         this.mcSelectedBuildMarker.visible = false;
         this.btnClone.visible = false;
         this.btnCancelClone.visible = true;
         this.btnRename.disableMe();
         this._cloning = true;
      }
      
      private function cancelCloneClicked(param1:Event) : void
      {
         this.cancelCloning();
      }
      
      private function cancelCloning() : void
      {
         var _loc1_:BMBasicButton = this["btnBuild" + this._inspectBuildID];
         _loc1_.enableMe();
         this.hideAllCloneMarkers();
         this.btnClone.visible = true;
         this.btnCancelClone.visible = false;
         this.btnRename.enableMe();
         this._cloning = false;
      }
      
      private function setCloneMarkersPositions() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < dataM.mechBuildsM.maxBuilds)
         {
            this["mcCloneMarker" + _loc1_].x = this["btnBuild" + _loc1_].x;
            this["mcCloneMarker" + _loc1_].y = this["btnBuild" + _loc1_].y;
            _loc1_++;
         }
      }
      
      private function hideAllCloneMarkers() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < dataM.mechBuildsM.maxBuilds)
         {
            this["mcCloneMarker" + _loc1_].visible = false;
            _loc1_++;
         }
      }
      
      private function showCloneMarkers() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < dataM.mechBuildsM.maxBuilds)
         {
            if(_loc1_ == this._inspectBuildID)
            {
               this["mcCloneMarker" + _loc1_].visible = false;
            }
            else
            {
               this["mcCloneMarker" + _loc1_].visible = true;
            }
            _loc1_++;
         }
      }
      
      private function selectClicked(param1:Event) : void
      {
         if(screensM.screenTransitionsManager.cameFromClanWarPreparation)
         {
            dataM.clanWarsM.defenceTeamChanged = true;
         }
         if(this._buildCloned == false && this._mechs456Migrated == false && this._nameChanged == false && dataM.mechBuildsM.selectedBuildID == this._inspectBuildID)
         {
            this.openPreviousScreen();
            return;
         }
         this.applyChanges();
      }
      
      private function closeClicked(param1:Event) : void
      {
         if(this._buildCloned || this._selectedBuildAltered || this._mechs456Migrated)
         {
            this.applyChanges();
            return;
         }
         this.openPreviousScreen();
      }
      
      private function applyChanges() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         TweenMax.delayedCall(0.1,this.closeScreenFunctions);
      }
      
      private function closeScreenFunctions() : void
      {
         dataM.mechBuildsM.selectedBuildID = this._inspectBuildID;
         remoteM.socketM.inventory_updateMechBuilds(dataM.mechBuildsM.exportData());
         dataM.mechBuildsM.loadSelectedBuild();
         var _loc1_:Array = dataM.createPlayerItemsArr();
         screensM.screenTransitionsManager.mechItemsDataToSave = _loc1_;
         this.openPreviousScreen();
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
      }
      
      private function openPreviousScreen() : void
      {
         if(screensM.screenTransitionsManager.cameFromMultiplayerLadder)
         {
            screensM.screenTransitionsManager.multiplayerLadderClicked();
         }
         else if(screensM.screenTransitionsManager.cameFromRaid)
         {
            screensM.screenTransitionsManager.raidMenuClicked();
         }
         else if(screensM.screenTransitionsManager.cameFromWorldMapClanBoss)
         {
            screensM.screenTransitionsManager.singlePlayerClicked();
         }
         else if(screensM.screenTransitionsManager.cameFromClanWarPreparation)
         {
            screensM.screenTransitionsManager.communityClanClicked(false,BMScreenClanMenu.TAB_WAR_PREPARATION);
         }
         else if(screensM.screenTransitionsManager.cameFromClanWarInspectEnemy)
         {
            screensM.screenTransitionsManager.clanWarBaseClicked(BMClanWarsManager.ALIGNMENT_ENEMY_CLAN,screensM.screenTransitionsManager.clanWarInspectEnemy_playerID);
         }
         else
         {
            screensM.screenTransitionsManager.hangerMechClicked();
         }
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_MECH_BUILDS);
      }
   }
}

