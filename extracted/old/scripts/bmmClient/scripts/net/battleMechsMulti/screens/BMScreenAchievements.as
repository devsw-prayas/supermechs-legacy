package net.battleMechsMulti.screens
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.FileReference;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton3;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1631")]
   public class BMScreenAchievements extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcFingerWheeling:Sprite;
      
      public var mcSizer_tileList:Sprite;
      
      public var mcSizer_btnSinglePlayer:Sprite;
      
      public var mcSizer_btnMultiplayer:Sprite;
      
      public var mcSizer_btnGoogleAchievements:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var btnSinglePlayer:BMButton3;
      
      public var btnMultiplayer:BMButton3;
      
      public var btnGoogleAchievements:BMButton_pictureE;
      
      public var btnBack:BMButton_pictureE;
      
      public var txtTitle:TextField;
      
      public var txtEarned:TextField;
      
      public var mcButtonMarker:Sprite;
      
      private var achievementsTileList:BMTileList;
      
      private var _fingerWheeling:BMFingerWheeling;
      
      private var _targetGroupsArray:Array;
      
      private var _targetGroupsID:uint;
      
      private var _firstRefresh:Boolean = true;
      
      private const ROWS_TOTAL:uint = 5;
      
      private const ROWS_TOTAL_MOBILE:uint = 4;
      
      private const ROW_WIDTH:Number = 470;
      
      private const ROW_HEIGHT:Number = 61;
      
      private const ROW_WIDTH_MOBILE:Number = 440;
      
      private const ROW_HEIGHT_MOBILE:Number = 67;
      
      private var _debugItemsToSave:Array;
      
      public function BMScreenAchievements()
      {
         super();
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMScreenAchievements initialized");
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("achievements");
      }
      
      public function refreshScreen(param1:Boolean) : void
      {
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenAchievements","btnSinglePlayer","regular3");
            screensM.createButtonFromSizer("screenAchievements","btnMultiplayer","regular3");
            screensM.createButtonFromSizer("screenAchievements","btnGoogleAchievements","pictureE");
            screensM.createButtonFromSizer("screenAchievements","btnBack","pictureE");
            _loc2_ = this.singlePlayerClicked;
            _loc3_ = this.multiplayerClicked;
            switch(dataM.languageID)
            {
               case 6:
                  this.btnSinglePlayer.changeFontSize(33);
                  this.btnMultiplayer.changeFontSize(33);
                  break;
               default:
                  this.btnSinglePlayer.changeFontSize(40);
                  this.btnMultiplayer.changeFontSize(40);
            }
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
               _loc3_ = null;
               this.btnSinglePlayer.changeFontSize(40);
               this.btnMultiplayer.changeFontSize(40);
            }
            this.btnSinglePlayer.initialize(getScreenText("singlePlayer"),"blue",null,null,_loc2_,dataM.runAsMobile);
            this.btnMultiplayer.initialize(getScreenText("multiplayer"),"blue",null,null,_loc3_,dataM.runAsMobile);
            this.btnGoogleAchievements.initialize("","",externalAssetsM.getAsset("general","interface_googleAchievements"),null,null,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
            this.btnSinglePlayer.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnMultiplayer.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnGoogleAchievements.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            if(dataM.runAsMobile)
            {
               this._fingerWheeling = new BMFingerWheeling();
               this._fingerWheeling.initialize("achievements",this.achievementsTileList,this.mcFingerWheeling,null,null,false);
               addChild(this._fingerWheeling);
            }
            else
            {
               this.mcFingerWheeling.parent.removeChild(this.mcFingerWheeling);
               this.mcFingerWheeling = null;
            }
            this.btnGoogleAchievements.visible = false;
            this._firstRefresh = false;
         }
         else
         {
            this.languageUpdate(true);
         }
         this._targetGroupsArray = [2];
         this._targetGroupsID = 2;
         this.mcButtonMarker.x = this.btnMultiplayer.x;
         this.mcButtonMarker.y = this.btnMultiplayer.y;
         if(param1)
         {
            remoteM.socketM.lobby_getAchievementStatistic(dataM.userID);
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         }
         else
         {
            this.statisticsLoaded();
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtEarned,14);
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.btnSinglePlayer.txtButtonName);
            TextUtils.updateTextFormat(this.btnMultiplayer.txtButtonName);
            param1 = true;
         }
         if(param1)
         {
            switch(dataM.languageID)
            {
               case 6:
                  this.btnSinglePlayer.changeFontSize(33);
                  this.btnMultiplayer.changeFontSize(33);
                  break;
               default:
                  this.btnSinglePlayer.changeFontSize(40);
                  this.btnMultiplayer.changeFontSize(40);
            }
            this.btnSinglePlayer.setButtonName(getScreenText("singlePlayer"));
            this.btnMultiplayer.setButtonName(getScreenText("multiplayer"));
         }
         this.txtTitle.text = getScreenText("title");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("achievements_title",[this.txtTitle],"",this);
         }
      }
      
      public function statisticsLoaded() : void
      {
         screensM.removeScreen("screenConfirmation");
         this.addAndRefreshTileList();
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.addMouseListeners();
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(screensM.isScreenOpened("screenAchievements"))
         {
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.onEnterFrameTrigger();
            }
         }
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.cancelFingerWheeling();
         }
      }
      
      public function singlePlayerClicked() : void
      {
         if(this._targetGroupsID != 1)
         {
            this._targetGroupsID = 1;
            this._targetGroupsArray = [0,1];
            this.addAndRefreshTileList();
            this.mcButtonMarker.x = this.btnSinglePlayer.x;
            this.mcButtonMarker.y = this.btnSinglePlayer.y;
         }
      }
      
      public function multiplayerClicked() : void
      {
         if(this._targetGroupsID != 2)
         {
            this._targetGroupsID = 2;
            this._targetGroupsArray = [2];
            this.addAndRefreshTileList();
            this.mcButtonMarker.x = this.btnMultiplayer.x;
            this.mcButtonMarker.y = this.btnMultiplayer.y;
         }
      }
      
      private function addAndRefreshTileList() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc11_:Object = null;
         var _loc12_:Object = null;
         var _loc13_:Array = null;
         var _loc17_:uint = 0;
         var _loc18_:Number = NaN;
         var _loc19_:Object = null;
         var _loc20_:Boolean = false;
         var _loc21_:String = null;
         var _loc22_:MovieClip = null;
         var _loc23_:Boolean = false;
         var _loc24_:MovieClip = null;
         var _loc25_:MovieClip = null;
         var _loc26_:BMItem = null;
         var _loc27_:BMTileListItem = null;
         var _loc28_:BMBar = null;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Array = null;
         var _loc32_:Array = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this.achievementsTileList != null)
         {
            this.achievementsTileList.removeMe();
         }
         _loc2_ = 0;
         _loc3_ = 0;
         var _loc4_:Number = this.ROW_WIDTH;
         var _loc5_:Number = this.ROW_HEIGHT;
         var _loc6_:Number = this.ROWS_TOTAL;
         if(dataM.runAsMobile)
         {
            _loc4_ = this.ROW_WIDTH_MOBILE;
            _loc5_ = this.ROW_HEIGHT_MOBILE;
            _loc6_ = this.ROWS_TOTAL_MOBILE;
         }
         this.achievementsTileList = new BMTileList();
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.resetTileList(this.achievementsTileList);
         }
         var _loc8_:Array = new Array();
         var _loc9_:Array = new Array();
         var _loc10_:Array = new Array();
         for each(_loc12_ in dataM.achievementsSortedDB)
         {
            _loc17_ = 1;
            while(_loc17_ <= _loc12_.length - 1)
            {
               _loc18_ = Number(_loc12_[_loc17_]);
               _loc11_ = dataM.achievementsDB[_loc18_];
               _loc11_.completed = false;
               _loc11_.locked = false;
               if(_loc11_.requirement > _loc1_.achievementsStatistics[_loc11_.type])
               {
                  if(_loc17_ > 1)
                  {
                     _loc19_ = dataM.achievementsDB[_loc12_[_loc17_ - 1]];
                     if(_loc19_.requirement > _loc1_.achievementsStatistics[_loc11_.type])
                     {
                        _loc11_.locked = true;
                     }
                  }
               }
               else
               {
                  _loc11_.completed = true;
               }
               _loc17_++;
            }
         }
         for each(_loc11_ in dataM.achievementsDB)
         {
            _loc20_ = false;
            _loc7_ = 0;
            while(_loc7_ < this._targetGroupsArray.length)
            {
               if(_loc11_.group == this._targetGroupsArray[_loc7_])
               {
                  _loc20_ = true;
               }
               _loc7_++;
            }
            if(_loc20_)
            {
               _loc21_ = dataM.getAchievmentDescriptionText(_loc11_);
               if(dataM.runAsMobile)
               {
                  _loc22_ = new mcAchievementsListRow_mobile();
               }
               else
               {
                  _loc22_ = new mcAchievementsListRow();
               }
               TextUtils.updateTextFormat(_loc22_.txtProgress,15);
               _loc22_.txtProgress.text = "";
               _loc23_ = false;
               if(_loc11_.requirement > 1)
               {
                  switch(_loc11_.type)
                  {
                     case "chargeKills":
                     case "droneKills":
                     case "teleportKills":
                     case "harpoonKills":
                     case "ladderWins":
                     case "fuseItems":
                     case "buyItemBoxes":
                     case "totalOverheats":
                     case "energyExtraDamage":
                     case "swordCombos":
                     case "shotgunCombos":
                     case "stompCombos":
                     case "machineGunCombos":
                     case "flameThrowerCombos":
                        _loc23_ = true;
                  }
               }
               if(Boolean(_loc11_.completed) || Boolean(_loc11_.locked))
               {
                  _loc23_ = false;
               }
               if(_loc23_)
               {
                  _loc28_ = new BMBar();
                  _loc28_.initialize("blue","right");
                  _loc29_ = Number(_loc1_.achievementsStatistics[_loc11_.type]);
                  _loc30_ = _loc29_ / _loc11_.requirement;
                  _loc28_.setFill(_loc30_,false);
                  _loc22_.txtProgress.text = _loc29_ + " / " + _loc11_.requirement;
                  _loc28_.x = _loc22_.mcSizer_bar.x;
                  _loc28_.y = _loc22_.mcSizer_bar.y;
                  _loc28_.width = _loc22_.mcSizer_bar.width;
                  _loc28_.height = _loc22_.mcSizer_bar.height;
                  _loc22_.mcHolder.addChild(_loc28_);
               }
               else
               {
                  _loc22_.mcBarBackground.parent.removeChild(_loc22_.mcBarBackground);
                  _loc22_.mcBarBackground = null;
               }
               _loc24_ = null;
               if(_loc11_.locked)
               {
                  _loc24_ = new mcAchievementLocked();
               }
               else
               {
                  _loc24_ = externalAssetsM.getAsset("general","achievement_" + _loc11_.type);
               }
               if(_loc24_ != null)
               {
                  _loc24_.width = _loc22_.mcSizer_icon.width;
                  _loc24_.height = _loc22_.mcSizer_icon.height;
                  _loc24_.x = _loc22_.mcSizer_icon.x;
                  _loc24_.y = _loc22_.mcSizer_icon.y;
                  _loc22_.mcHolder.addChild(_loc24_);
               }
               if(Boolean(_loc11_.completed) || Boolean(_loc11_.locked))
               {
                  _loc22_.removeChild(_loc22_.mcGold);
                  _loc22_.removeChild(_loc22_.mcTokens);
                  _loc22_.removeChild(_loc22_.mcBattleCredits);
                  _loc22_.removeChild(_loc22_.txtReward);
                  _loc22_.mcGold = null;
                  _loc22_.mcTokens = null;
                  _loc22_.mcBattleCredits = null;
                  _loc22_.txtReward = null;
               }
               else
               {
                  TextUtils.updateTextFormat(_loc22_.txtReward,15);
                  if(_loc11_.goldBonus > 0)
                  {
                     _loc22_.txtReward.htmlText = TextUtils.getTextFont() + "<FONT COLOR =\'#" + dataM.COLOR_GOLD + "\'>" + dataM.getNumberWithComma(_loc11_.goldBonus) + "</FONT>";
                     _loc22_.removeChild(_loc22_.mcTokens);
                     _loc22_.removeChild(_loc22_.mcBattleCredits);
                     _loc22_.mcTokens = null;
                     _loc22_.mcBattleCredits = null;
                  }
                  else if(_loc11_.tokensBonus > 0)
                  {
                     _loc22_.txtReward.htmlText = TextUtils.getTextFont() + String(_loc11_.tokensBonus);
                     _loc22_.removeChild(_loc22_.mcGold);
                     _loc22_.removeChild(_loc22_.mcBattleCredits);
                     _loc22_.mcGold = null;
                     _loc22_.mcBattleCredits = null;
                  }
                  else if(_loc11_.battleCreditsBonus > 0)
                  {
                     _loc22_.txtReward.htmlText = TextUtils.getTextFont() + String(_loc11_.battleCreditsBonus);
                     _loc22_.removeChild(_loc22_.mcGold);
                     _loc22_.removeChild(_loc22_.mcTokens);
                     _loc22_.mcGold = null;
                     _loc22_.mcTokens = null;
                  }
               }
               _loc25_ = externalAssetsM.getAsset("general","achievementRank");
               _loc25_.width = _loc22_.mcSizer_icon.width;
               _loc25_.height = _loc22_.mcSizer_icon.height;
               _loc25_.x = _loc22_.mcSizer_icon.x;
               _loc25_.y = _loc22_.mcSizer_icon.y;
               _loc25_.gotoAndStop("rank" + _loc11_.level);
               _loc22_.mcHolder.addChild(_loc25_);
               TextUtils.updateTextFormat(_loc22_.txtDescription,15);
               _loc22_.txtDescription.htmlText = TextUtils.getTextFont() + _loc21_;
               if(_loc11_.completed)
               {
                  _loc22_.mcBackground.gotoAndStop("completed");
                  _loc22_.txtDescription.htmlText = TextUtils.getTextFont() + _loc21_ + "<BR>" + getScreenText("completed");
                  _loc2_++;
               }
               else if(_loc11_.locked)
               {
                  _loc22_.mcBackground.gotoAndStop("locked");
               }
               _loc26_ = new BMItem();
               _loc26_.initialize(0,_loc4_,_loc5_,_loc22_,0,0,false,null,dataM.runAsMobile);
               if(dataM.runAsMobile)
               {
                  _loc31_ = new Array();
                  if(_loc24_ != null)
                  {
                     _loc31_.push(_loc24_);
                  }
                  if(_loc25_ != null)
                  {
                     _loc31_.push(_loc25_);
                  }
                  if(_loc22_.mcGold != null)
                  {
                     _loc31_.push(_loc22_.mcGold);
                  }
                  if(_loc22_.mcTokens != null)
                  {
                     _loc31_.push(_loc22_.mcTokens);
                  }
                  if(_loc22_.mcBattleCredits != null)
                  {
                     _loc31_.push(_loc22_.mcBattleCredits);
                  }
                  _loc32_ = [_loc22_.txtDescription,_loc22_.txtProgress];
                  if(_loc22_.txtReward != null)
                  {
                     _loc32_.push(_loc22_.txtReward);
                  }
                  if(dataM.runAsMobile)
                  {
                     _loc26_.createAssetsBitmap(_loc32_,_loc31_,_loc22_);
                  }
               }
               _loc27_ = new BMTileListItem();
               _loc27_.initialize(_loc4_,_loc5_,_loc26_,"","","",0,null,null,null,null,null,dataM.runAsMobile);
               _loc27_.disableMouseOverEffect();
               if(_loc11_.completed)
               {
                  _loc10_.push(_loc27_);
               }
               else if(_loc11_.locked)
               {
                  _loc9_.push(_loc27_);
               }
               else
               {
                  _loc8_.push(_loc27_);
               }
            }
            else if(_loc11_.completed)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         _loc13_ = new Array();
         _loc7_ = 0;
         while(_loc7_ < _loc8_.length)
         {
            _loc13_.push(_loc8_[_loc7_]);
            _loc7_++;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc10_.length)
         {
            _loc13_.push(_loc10_[_loc7_]);
            _loc7_++;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc9_.length)
         {
            _loc13_.push(_loc9_[_loc7_]);
            _loc7_++;
         }
         var _loc14_:MovieClip = new Grp_scrollerContent();
         var _loc15_:Boolean = false;
         if(dataM.runAsMobile)
         {
            _loc15_ = true;
            this.achievementsTileList.activateExtendedMode(0.57,true);
         }
         this.achievementsTileList.initialize(screensM.stagePointer,_loc13_,_loc6_,1,_loc4_,_loc5_,null,true,_loc14_,null,null,false,0,1,true,_loc15_,dataM.runAsMobile);
         this.achievementsTileList.x = this.mcSizer_tileList.x;
         this.achievementsTileList.y = this.mcSizer_tileList.y;
         this.mcButtonsHolder.addChild(this.achievementsTileList);
         var _loc16_:Number = Math.floor(_loc2_ / _loc3_ * 100);
         this.txtEarned.htmlText = TextUtils.getTextFont() + getScreenText("totalEarned") + _loc2_ + " / " + _loc3_ + "  <FONT COLOR =\'#B2B2B2\'>(" + _loc16_ + "%)</FONT>";
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("achievements_earned",[this.txtEarned],"",this);
         }
      }
      
      private function saveIconsToDisc() : *
      {
         var _loc1_:Object = null;
         this._debugItemsToSave = new Array();
         for each(_loc1_ in dataM.achievementsDB)
         {
            this._debugItemsToSave.unshift(_loc1_);
         }
         this.saveNextIconToDisc();
      }
      
      private function saveNextIconToDisc(param1:Event = null) : *
      {
         var _loc2_:Object = this._debugItemsToSave.pop();
         var _loc3_:String = dataM.getAchievmentDescriptionText(_loc2_);
         var _loc4_:MovieClip = this.createIconToSave(_loc2_);
         var _loc5_:String = "achievement" + _loc2_.achievementID + ".png";
         trace("group:" + _loc2_.group + " , id:" + _loc2_.achievementID + " , desc:" + _loc3_ + " , file:" + _loc5_);
         var _loc6_:FileReference = new FileReference();
         _loc6_.save(ImageUtils.getMovieClipAsByteArrayPNG(_loc4_,new BitmapData(512,512,false,0)),_loc5_);
         if(this._debugItemsToSave.length > 0)
         {
            _loc6_.addEventListener(Event.COMPLETE,this.saveNextIconToDisc);
         }
      }
      
      private function createIconToSave(param1:Object) : MovieClip
      {
         var _loc2_:MovieClip = new MovieClip();
         var _loc3_:MovieClip = externalAssetsM.getAsset("general","achievement_" + param1.type);
         if(_loc3_ != null)
         {
            _loc2_.addChild(_loc3_);
         }
         var _loc4_:MovieClip = externalAssetsM.getAsset("general","achievementRank");
         _loc4_.gotoAndStop("rank" + param1.level);
         _loc2_.addChild(_loc4_);
         return _loc2_;
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen(true);
      }
      
      public function googleAchievementsClicked() : void
      {
      }
      
      public function backClicked() : void
      {
         screensM.screenNewMenu.mainMenu();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen("screenAchievements");
         this.achievementsTileList.removeMe();
         this.achievementsTileList = null;
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.removeMouseListeners();
         }
      }
   }
}

