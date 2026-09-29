package net.battleMechsMulti.screens.arenaShop
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMLoadingTimer;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMScreenArenaShop extends BMBaseScreen
   {
      
      private static const NO_SKILL_SELECTED:int = -1;
      
      public var mcSkillPanelsHolder:Sprite;
      
      public var btnUpgrade:BMBasicButton;
      
      public var btnClose:BMBasicButton;
      
      public var levelsBar:BMBar;
      
      public var mcStatsBackground:MovieClip;
      
      public var mcIconSizer:Sprite;
      
      public var mcCostArenaCoins:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtSkillTitle:TextField;
      
      public var txtSkillLevel:TextField;
      
      public var txtMaxed:TextField;
      
      public var txtCurrentBonusTitle:TextField;
      
      public var txtCurrentBonusValue:TextField;
      
      public var txtCurrentBonusTitle_rewardInQueue:TextField;
      
      public var txtNextLevelBonusTitle:TextField;
      
      public var txtNextLevelBonusValue:TextField;
      
      public var txtNextLevelBonusTitle_rewardInQueue:TextField;
      
      public var txtCostTitle:TextField;
      
      public var txtCostValue:TextField;
      
      public var txtMyArenaCoins:TextField;
      
      public var btnPrevious:BMBasicButton;
      
      public var btnNext:BMBasicButton;
      
      private var _currentRewardInQueueTitle_originYPos:Number;
      
      private var _nextRewardInQueueTitle_originYPos:Number;
      
      private var _skillPanels:Array;
      
      private var _selectedSkillID:int = -1;
      
      private var _icon:Sprite;
      
      private var _costIconInitialXPos:Number;
      
      private var _costTextInitialXPos:Number;
      
      private var _skillPanelsHolderOriginXPos:Number;
      
      private var _totalPages:uint;
      
      private var _currentPage:uint;
      
      private const SKILLS_TOTAL:uint = 12;
      
      private const SKILL_PANEL_WIDTH:uint = 134;
      
      private const SKILL_PANEL_HEIGHT:uint = 100;
      
      private const PAGE_WIDTH_ADDON:uint = 6;
      
      public function BMScreenArenaShop()
      {
         super();
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("arenaShop");
      }
      
      public function initialize() : void
      {
         this._costIconInitialXPos = this.mcCostArenaCoins.x;
         this._costTextInitialXPos = this.txtCostValue.x;
         this._currentRewardInQueueTitle_originYPos = this.txtCurrentBonusTitle_rewardInQueue.y;
         this._nextRewardInQueueTitle_originYPos = this.txtNextLevelBonusTitle_rewardInQueue.y;
         this._skillPanelsHolderOriginXPos = this.mcSkillPanelsHolder.x;
         this._totalPages = Math.ceil(dataM.playerSkillsManager.totalSkillsEnabled / 9);
         this._currentPage = 1;
         this.initSkillPanels();
         this.skillClicked(0);
         this.initButtons();
         this.refreshNavigationButtons();
      }
      
      private function initButtons() : void
      {
         this.btnUpgrade.text = getSpecificText("upgrade_title");
         this.btnUpgrade.addEventListener(BMIntractable.HIT,this.upgradeClicked);
         this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
         this.btnNext.addEventListener(BMIntractable.HIT,this.nextClicked);
         this.btnPrevious.addEventListener(BMIntractable.HIT,this.previousClicked);
      }
      
      private function initSkillPanels() : void
      {
         var _loc2_:BMPlayerSkillData = null;
         this._skillPanels = new Array();
         var _loc1_:uint = 0;
         while(_loc1_ < dataM.playerSkillsManager.skillsData.length)
         {
            _loc2_ = dataM.playerSkillsManager.skillsData[_loc1_];
            if(this.initSpecifickillPanel(_loc1_))
            {
               this.refreshSkillPanel(_loc1_);
            }
            _loc1_++;
         }
      }
      
      private function initSpecifickillPanel(param1:uint) : Boolean
      {
         var _loc3_:BMArenaShopSkillPanel = null;
         var _loc2_:BMPlayerSkillData = dataM.playerSkillsManager.skillsData[param1];
         if(_loc2_.isEnabled == false)
         {
            this._skillPanels.push(null);
            return false;
         }
         _loc3_ = new BMArenaShopSkillPanel();
         var _loc4_:Boolean = BMPlayerSkillData.isLocalIcon(_loc2_.type);
         _loc3_.initialize(param1);
         if(_loc4_)
         {
            _loc3_.addLocalIcon(BMPlayerSkillData.getLocalIcon(_loc2_.type));
         }
         else
         {
            _loc3_.addExternalIcon(BMPlayerSkillData.getExternalIconName(_loc2_.type));
         }
         _loc3_.addClickFunction(this.skillClicked);
         _loc3_.x = Math.floor(param1 / 3) * this.SKILL_PANEL_WIDTH;
         _loc3_.y = param1 % 3 * this.SKILL_PANEL_HEIGHT;
         this._skillPanels.push(_loc3_);
         this.mcSkillPanelsHolder.addChild(_loc3_);
         return true;
      }
      
      private function refreshSkillPanel(param1:uint) : void
      {
         var _loc2_:BMPlayerSkillData = dataM.playerSkillsManager.skillsData[param1];
         var _loc3_:BMArenaShopSkillPanel = this._skillPanels[param1];
         var _loc4_:uint = dataM.playerSkillsManager.getSkillLevel(dataM.player1PlayerID,param1);
         _loc3_.setLevels(_loc4_,_loc2_.levelsTotal);
         var _loc5_:Boolean = dataM.playerSkillsManager.isSkillMaxed(param1);
         var _loc6_:Boolean = _loc2_.isFixedValue;
         var _loc7_:Number = dataM.playerSkillsManager.getSkillCurrentLevelBonus(dataM.player1PlayerID,param1);
         var _loc8_:Boolean = BMPlayerSkillData.isReductionSkill(_loc2_.type);
         var _loc9_:Boolean = BMPlayerSkillData.isRewardInQueueSkill(_loc2_.type);
         _loc3_.setBonusText(_loc7_,_loc6_,_loc5_,_loc8_,_loc9_);
      }
      
      private function get pageWidth() : Number
      {
         return this.SKILL_PANEL_WIDTH * 3;
      }
      
      private function nextClicked(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(this._totalPages - this._currentPage > 1)
         {
            this._currentPage += 1;
            _loc2_ = this._skillPanelsHolderOriginXPos - this.pageWidth * (this._currentPage - 1);
         }
         else
         {
            this._currentPage = this._totalPages;
            _loc2_ = this._skillPanelsHolderOriginXPos - (this.mcSkillPanelsHolder.width - this.pageWidth) - this.PAGE_WIDTH_ADDON;
         }
         TweenMax.to(this.mcSkillPanelsHolder,0.2,{
            "x":_loc2_,
            "onComplete":this.refreshNavigationButtons
         });
      }
      
      private function previousClicked(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(this._currentPage > 2)
         {
            --this._currentPage;
            _loc2_ = this._skillPanelsHolderOriginXPos - this.pageWidth * (this._currentPage - 1);
         }
         else
         {
            this._currentPage = 1;
            _loc2_ = this._skillPanelsHolderOriginXPos;
         }
         TweenMax.to(this.mcSkillPanelsHolder,0.2,{
            "x":_loc2_,
            "onComplete":this.refreshNavigationButtons
         });
      }
      
      private function refreshNavigationButtons() : void
      {
         this.btnNext.enableMe();
         this.btnPrevious.enableMe();
         if(this._currentPage == 1)
         {
            this.btnPrevious.disableMe();
         }
         else if(this._currentPage == this._totalPages)
         {
            this.btnNext.disableMe();
         }
      }
      
      private function skillClicked(param1:uint) : void
      {
         var _loc2_:BMArenaShopSkillPanel = null;
         if(this._selectedSkillID == param1)
         {
            return;
         }
         if(this._selectedSkillID != NO_SKILL_SELECTED)
         {
            _loc2_ = this._skillPanels[this._selectedSkillID];
            _loc2_.selected = false;
         }
         this._selectedSkillID = param1;
         _loc2_ = this._skillPanels[this._selectedSkillID];
         _loc2_.selected = true;
         this.refreshSelectedSkillInterface();
      }
      
      private function refreshSelectedSkillInterface() : void
      {
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc10_:Number = NaN;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc1_:BMPlayerSkillData = dataM.playerSkillsManager.skillsData[this._selectedSkillID];
         updateTextAndFormat(this.txtSkillTitle,_loc1_.skillName);
         var _loc2_:Boolean = BMPlayerSkillData.isLocalIcon(_loc1_.type);
         if(_loc2_)
         {
            this.addIcon(BMPlayerSkillData.getLocalIcon(_loc1_.type));
         }
         else
         {
            this.addExternalIcon(BMPlayerSkillData.getExternalIconName(_loc1_.type));
         }
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         updateTextAndFormat(this.txtCurrentBonusTitle,"");
         updateTextAndFormat(this.txtCurrentBonusValue,"");
         updateTextAndFormat(this.txtNextLevelBonusTitle,"");
         updateTextAndFormat(this.txtNextLevelBonusValue,"");
         updateTextAndFormat(this.txtCurrentBonusTitle_rewardInQueue,"");
         updateTextAndFormat(this.txtNextLevelBonusTitle_rewardInQueue,"");
         updateTextAndFormat(this.txtCostTitle,"");
         updateTextAndFormat(this.txtCostValue,"");
         updateTextAndFormat(this.txtMaxed,"");
         var _loc3_:Boolean = BMPlayerSkillData.isRewardInQueueSkill(_loc1_.type);
         if(_loc3_ == false)
         {
            updateTextAndFormat(this.txtCurrentBonusTitle,getScreenText("currentBonus"));
         }
         var _loc4_:uint = dataM.playerSkillsManager.getSkillLevel(dataM.player1PlayerID,this._selectedSkillID);
         var _loc5_:Number = _loc4_ / _loc1_.levelsTotal;
         this.levelsBar.setFill(_loc5_);
         updateTextAndFormat(this.txtSkillLevel,_loc4_ + " / " + _loc1_.levelsTotal);
         var _loc6_:Number = dataM.playerSkillsManager.getSkillCurrentLevelBonus(dataM.player1PlayerID,this._selectedSkillID);
         var _loc7_:String = "+";
         if(BMPlayerSkillData.isReductionSkill(_loc1_.type))
         {
            _loc7_ = "-";
         }
         _loc7_ += _loc6_;
         if(_loc1_.isFixedValue == false)
         {
            _loc7_ += "%";
         }
         if(_loc3_)
         {
            updateTextAndFormat(this.txtCurrentBonusValue,"");
         }
         else
         {
            updateTextAndFormat(this.txtCurrentBonusValue,_loc7_);
         }
         if(dataM.playerSkillsManager.isSkillMaxed(this._selectedSkillID))
         {
            updateTextAndFormat(this.txtMaxed,getScreenText("maxed"));
            this.mcCostArenaCoins.visible = false;
            if(_loc3_)
            {
               this.mcStatsBackground.gotoAndStop("maxed_rewardInQueue");
               this.updateRewardInQueueCurrentLevelText(_loc4_,_loc6_);
            }
            else
            {
               this.mcStatsBackground.gotoAndStop("maxed");
            }
         }
         else
         {
            _loc8_ = dataM.playerSkillsManager.getSkillNextLevelBonus(this._selectedSkillID);
            if(_loc3_)
            {
               this.updateRewardInQueueCurrentLevelText(_loc4_,_loc6_);
               _loc11_ = getScreenText("fortuneBox_levelDetails");
               _loc11_ = dataM.replaceStringInText(_loc11_,"%AMOUNT%","<FONT COLOR=\'#" + dataM.COLOR_GOOD + "\'>" + _loc8_ + "</FONT>");
               _loc11_ = getScreenText("nextLevelBonus") + ":<BR>" + _loc11_;
               updateTextAndFormat(this.txtNextLevelBonusTitle_rewardInQueue,_loc11_,TextUtils.SIZE_KEEP_CURRENT,true);
               this.txtNextLevelBonusTitle_rewardInQueue.y = this._nextRewardInQueueTitle_originYPos;
               if(this.txtNextLevelBonusTitle_rewardInQueue.numLines < 3)
               {
                  this.txtNextLevelBonusTitle_rewardInQueue.y += 11;
               }
            }
            else
            {
               _loc12_ = "+";
               if(BMPlayerSkillData.isReductionSkill(_loc1_.type))
               {
                  _loc12_ = "-";
               }
               _loc12_ += _loc8_;
               if(_loc1_.isFixedValue == false)
               {
                  _loc12_ += "%";
               }
               updateTextAndFormat(this.txtNextLevelBonusValue,_loc12_);
               updateTextAndFormat(this.txtNextLevelBonusTitle,getScreenText("nextLevelBonus"));
            }
            updateTextAndFormat(this.txtCostTitle,getScreenText("cost"));
            _loc9_ = dataM.playerSkillsManager.getNextLevelCost(this._selectedSkillID);
            updateTextAndFormat(this.txtCostValue,TextUtils.getNumberWithComma(_loc9_));
            this.mcCostArenaCoins.visible = true;
            _loc10_ = (this.txtCostValue.width - this.txtCostValue.textWidth) / 2;
            this.mcCostArenaCoins.x = this._costIconInitialXPos + _loc10_;
            this.txtCostValue.x = this._costTextInitialXPos + _loc10_;
            if(_loc3_)
            {
               this.mcStatsBackground.gotoAndStop("notMaxed_rewardInQueue");
            }
            else
            {
               this.mcStatsBackground.gotoAndStop("notMaxed");
            }
         }
         updateTextAndFormat(this.txtMyArenaCoins,TextUtils.getNumberWithComma(dataM.myProfile.arenaCoins));
         this.refreshUpgradeButton();
      }
      
      private function updateRewardInQueueCurrentLevelText(param1:uint, param2:uint) : void
      {
         var _loc3_:String = null;
         if(param1 == 0)
         {
            _loc3_ = getScreenText("currentBonus") + ":<BR>" + getScreenText("fortuneBox_noFortuneBoxes");
         }
         else
         {
            _loc3_ = getScreenText("fortuneBox_levelDetails");
            _loc3_ = dataM.replaceStringInText(_loc3_,"%AMOUNT%","<FONT COLOR=\'#" + dataM.COLOR_GOOD + "\'>" + param2 + "</FONT>");
            _loc3_ = getScreenText("currentBonus") + ":<BR>" + _loc3_;
         }
         updateTextAndFormat(this.txtCurrentBonusTitle_rewardInQueue,_loc3_,TextUtils.SIZE_KEEP_CURRENT,true);
         this.txtCurrentBonusTitle_rewardInQueue.y = this._currentRewardInQueueTitle_originYPos;
         if(this.txtCurrentBonusTitle_rewardInQueue.numLines < 3)
         {
            this.txtCurrentBonusTitle_rewardInQueue.y += 11;
         }
      }
      
      private function refreshUpgradeButton() : void
      {
         if(dataM.playerSkillsManager.isSkillMaxed(this._selectedSkillID))
         {
            this.btnUpgrade.visible = false;
            return;
         }
         var _loc1_:BMPlayerSkillData = dataM.playerSkillsManager.skillsData[this._selectedSkillID];
         var _loc2_:uint = uint(dataM.myProfile.skills[this._selectedSkillID]);
         var _loc3_:uint = uint(_loc1_.levelsCost[_loc2_]);
         this.btnUpgrade.visible = true;
         if(_loc3_ <= dataM.myProfile.arenaCoins)
         {
            this.btnUpgrade.enableMe();
         }
         else
         {
            this.btnUpgrade.disableMe();
         }
      }
      
      private function upgradeClicked(param1:Event) : void
      {
         BMLoadingTimer.gi().showLoading();
         dataM.playerSkillsManager.upgradeSkill(this._selectedSkillID,this.handleUpgradeFinished);
      }
      
      public function upgradeSuccess() : void
      {
         var _loc1_:BMPlayerSkillData = dataM.playerSkillsManager.skillsData[this._selectedSkillID];
         this.refreshSelectedSkillInterface();
         this.refreshSkillPanel(this._selectedSkillID);
         soundM.createSound("itemBought");
      }
      
      private function addExternalIcon(param1:String) : void
      {
         this.addIcon(externalAssetsM.getAsset("general",param1));
      }
      
      private function addIcon(param1:Sprite) : void
      {
         this.removeIcon();
         var _loc2_:int = this.mcIconSizer.width;
         this._icon = param1;
         this._icon.width = _loc2_;
         this._icon.height = _loc2_;
         this._icon.x = this.mcIconSizer.x;
         this._icon.y = this.mcIconSizer.y;
         addChild(this._icon);
      }
      
      private function removeIcon() : void
      {
         if(this._icon == null)
         {
            return;
         }
         this._icon.parent.removeChild(this._icon);
         this._icon = null;
      }
      
      private function closeClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.multiplayerLadderClicked();
      }
      
      private function handleUpgradeFinished(param1:uint, param2:Boolean, param3:String) : *
      {
         BMLoadingTimer.gi().hideLoading();
         if(param2)
         {
            this.upgradeSuccess();
         }
         else
         {
            screensM.screenConfirmation.displayCustomMessage(param3);
         }
      }
      
      public function removeMe() : void
      {
         TweenMax.killTweensOf(this.mcSkillPanelsHolder);
         screensM.removeScreen(BMScreensManager.SCR_ARENA_SHOP);
      }
   }
}

