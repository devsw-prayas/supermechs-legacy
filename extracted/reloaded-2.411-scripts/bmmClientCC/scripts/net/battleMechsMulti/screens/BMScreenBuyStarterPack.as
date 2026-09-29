package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMShopManager;
   import net.battleMechsMulti.managers.BMSpecialOffersManager;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.BMTokenPackage;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureC;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureK;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol517")]
   public class BMScreenBuyStarterPack extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcBoxesPosition:Sprite;
      
      public var mcMechHolder:Sprite;
      
      public var mcItemsPosition:Sprite;
      
      public var mcMechPosition:Sprite;
      
      public var mcSizer_btnBackOrange:Sprite;
      
      public var mcSizer_btnBackRed:Sprite;
      
      public var mcSizer_btnBuyOrange:Sprite;
      
      public var mcSizer_btnBuyRed:Sprite;
      
      public var mcTokens_bonus:Sprite;
      
      public var mcGold_bonus:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtDescription:TextField;
      
      public var txtDescription2:TextField;
      
      public var txtTimeLeft:TextField;
      
      public var txtPrice:TextField;
      
      public var txtBonusGold:TextField;
      
      public var txtBonusTokens:TextField;
      
      public var btnBackOrange:BMButton_pictureK;
      
      public var btnBackRed:BMButton_pictureC;
      
      public var btnBuyOrange:BMButton;
      
      public var mcBoxes:MovieClip;
      
      public var mcBackground:MovieClip;
      
      private var mechView:BMMechView;
      
      private var _titleOriginXPos:Number;
      
      private var _bonusGoldIconOriginXPos:Number;
      
      private var _bonusGoldTextOriginXPos:Number;
      
      private var _bonusTokensIconOriginXPos:Number;
      
      private var _bonusTokensTextOriginXPos:Number;
      
      private var _minuteLength:Number;
      
      private var _hourLength:Number;
      
      private var _dayLength:Number;
      
      private var _itemCardMCs:Array = new Array();
      
      private var _itemCardsRarity:Array = new Array();
      
      private var _sparks:Array = new Array();
      
      public var tileListItems:Array = new Array();
      
      private var _resetTimer:Timer;
      
      private var _boxesRotation:Boolean = false;
      
      private var _boxesRotationFrameCounter:uint;
      
      private var _boxesRotationXSpeed:uint;
      
      private var _boxMcsToShake:Array;
      
      private var _boxRaysToRotate:Sprite;
      
      private var _lastChanceAlert:Boolean = false;
      
      private var _firstRefresh:Boolean = true;
      
      private var _screenSource:String;
      
      public function BMScreenBuyStarterPack()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("buyStarterPack");
         dataM.trackScreenView("buyStarterPack");
         dataM.updateStarterPackActive();
      }
      
      public function refreshScreen(param1:String) : void
      {
         var _loc7_:Function = null;
         var _loc8_:Function = null;
         var _loc9_:BMTokenPackage = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenBuyStarterPack","btnBackOrange","pictureK");
            screensM.createButtonFromSizer("screenBuyStarterPack","btnBackRed","pictureC");
            screensM.createButtonFromSizer("screenBuyStarterPack","btnBuyOrange","regular");
            _loc7_ = this.backClicked;
            _loc8_ = this.buyClicked;
            if(dataM.runAsMobile)
            {
               _loc7_ = null;
               _loc8_ = null;
            }
            this.btnBuyOrange.changeFontSize(33);
            this.btnBackOrange.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc7_,dataM.runAsMobile);
            this.btnBackRed.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc7_,dataM.runAsMobile);
            this.btnBuyOrange.initialize(getScreenText("buy"),"green",null,null,_loc8_,dataM.runAsMobile);
            this.btnBackOrange.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBackRed.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBuyOrange.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this._titleOriginXPos = this.txtTitle.x;
            this._bonusGoldIconOriginXPos = this.mcGold_bonus.x;
            this._bonusGoldTextOriginXPos = this.txtBonusGold.x;
            this._bonusTokensIconOriginXPos = this.mcTokens_bonus.x;
            this._bonusTokensTextOriginXPos = this.txtBonusTokens.x;
            this._minuteLength = 60;
            this._hourLength = this._minuteLength * 60;
            this._dayLength = this._hourLength * 24;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this._screenSource = param1;
         dataM.starterPack_displayAfterOnlineBattleCounter = 0;
         dataM.starterPack_displayAfterSinglePlayerMissionCounter = 0;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:* = false;
         var _loc4_:uint = 0;
         while(_loc4_ < dataM.allTokenPackages.length)
         {
            _loc9_ = dataM.allTokenPackages[_loc4_];
            if(_loc9_.starterPackID == _loc2_.starterPackData.packID)
            {
               _loc2_.starterPackData.tokenPackageID = _loc9_.packageID;
               _loc2_.starterPackData.bonusTokens = _loc9_.tokens;
               _loc2_.starterPackData.price = _loc9_.price;
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         if(!_loc3_)
         {
            TsLogger.log("BMScreenBuyStarterPack :: refreshScreen ERROR could not find starterPackID " + _loc9_.starterPackID + " in allTokenPackages");
         }
         this._boxesRotation = false;
         if(_loc2_.starterPackData.boostID > 0)
         {
            this.displayItemBoxes();
         }
         else
         {
            this.displayMech();
         }
         this.txtPrice.text = _loc2_.starterPackData.price;
         this.txtBonusGold.text = dataM.getNumberWithComma(_loc2_.starterPackData.bonusGold);
         this.txtBonusTokens.text = dataM.getNumberWithComma(_loc2_.starterPackData.bonusTokens);
         this.mcGold_bonus.visible = true;
         this.mcTokens_bonus.visible = true;
         var _loc5_:Number = this.txtBonusGold.width - this.txtBonusGold.textWidth;
         this.txtBonusGold.x += _loc5_ / 2;
         this.mcGold_bonus.x += _loc5_ / 2;
         _loc5_ = this.txtBonusTokens.width - this.txtBonusTokens.textWidth;
         this.txtBonusTokens.x += _loc5_ / 2;
         this.mcTokens_bonus.x += _loc5_ / 2;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyStarterPack_costTokens",[this.txtBonusGold,this.txtBonusTokens,this.txtPrice],"",this);
         }
         this.stopTimer();
         this.refreshTimer();
         this._resetTimer = new Timer(1000,0);
         this._resetTimer.addEventListener(TimerEvent.TIMER,this.resetTimerEvent);
         this._resetTimer.start();
         this.btnBackOrange.visible = false;
         this.btnBackRed.visible = false;
         this.btnBuyOrange.enableMe();
         var _loc6_:String = "regular";
         switch(_loc2_.starterPackData.skin)
         {
            case 0:
               this.btnBackOrange.visible = true;
               break;
            case 1:
               this.btnBackOrange.visible = true;
               _loc6_ = "summerSale";
               break;
            case 2:
               this.btnBackRed.visible = true;
               _loc6_ = "blackFriday";
               break;
            case 3:
               this.btnBackRed.visible = true;
               _loc6_ = "christmas";
         }
         this.mcBackground.gotoAndStop(_loc6_);
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 20;
         var _loc3_:uint = 20;
         var _loc4_:uint = 28;
         switch(dataM.languageID)
         {
            case 3:
               _loc2_ = 18;
               _loc3_ = 18;
               break;
            case 5:
               _loc2_ = 16;
               _loc3_ = 16;
               _loc4_ = 24;
               break;
            case 7:
               _loc2_ = 18;
               _loc3_ = 18;
               break;
            case 9:
               _loc2_ = 15;
               _loc3_ = 15;
               _loc4_ = 16;
         }
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtPrice,35);
            TextUtils.updateTextFormat(this.txtDescription,_loc2_);
            TextUtils.updateTextFormat(this.txtDescription2,_loc3_);
            TextUtils.updateTextFormat(this.txtTimeLeft,20);
            TextUtils.updateTextFormat(this.txtTitle,24);
            TextUtils.updateTextFormat(this.btnBuyOrange.txtButtonName);
            param1 = true;
         }
         if(param1)
         {
            this.btnBuyOrange.changeFontSize(33);
            this.btnBuyOrange.setButtonName(getScreenText("buy"));
         }
         this.txtTitle.htmlText = TextUtils.getTextFont() + getScreenText("title");
         this.txtTitle.x = this._titleOriginXPos;
         var _loc5_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc5_.starterPackData.packID >= 2000)
         {
            this.txtTitle.htmlText = TextUtils.getTextFont() + "<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>" + getScreenText("title");
            this.txtTitle.x = this._titleOriginXPos - 70;
         }
         else if(_loc5_.starterPackData.packID >= 2000)
         {
            this.txtTitle.htmlText = TextUtils.getTextFont() + getScreenText("blackFriday");
         }
         else if(_loc5_.starterPackData.packID >= 1000)
         {
            this.txtTitle.htmlText = TextUtils.getTextFont() + getScreenText("summerSale");
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyStarterPack_mainTexts",[this.txtTitle],"",this);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            if(this.mechView != null)
            {
               this.mechView.onEnterFrameTrigger();
            }
            this.boxesRotationHandler();
            this.sparksHandler();
         }
      }
      
      private function displayMech() : void
      {
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc12_:Number = NaN;
         var _loc13_:BMTileListItem = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this.mechView = new BMMechView();
         this.mechView.initialize(0,"battle","itemID",0.8,false);
         var _loc2_:BMMechStructure = new BMMechStructure();
         _loc2_.torso = _loc1_.starterPackData.torso;
         _loc2_.leg = _loc1_.starterPackData.leg;
         _loc2_.sideWeapon1 = _loc1_.starterPackData.sideWeapon1;
         _loc2_.sideWeapon2 = _loc1_.starterPackData.sideWeapon2;
         _loc2_.topWeapon1 = _loc1_.starterPackData.topWeapon1;
         _loc2_.topWeapon2 = _loc1_.starterPackData.topWeapon2;
         var _loc3_:Object = new Object();
         _loc3_.torso = _loc1_.starterPackData.mechColorID;
         _loc3_.leg = _loc1_.starterPackData.mechColorID;
         _loc3_.sideWeapon = _loc1_.starterPackData.mechColorID;
         _loc3_.topWeapon = _loc1_.starterPackData.mechColorID;
         this.mechView.setManualColors(_loc3_);
         this.mechView.buildMech(_loc2_,"buyStarterPack");
         this.mechView.activateBreathing();
         this.mechView.x = this.mcMechPosition.x;
         this.mechView.y = this.mcMechPosition.y - (this.mechView.mechSizer.height + this.mechView.mechSizer.y);
         this.mcMechHolder.addChild(this.mechView);
         var _loc4_:Array = new Array();
         var _loc5_:Array = ["torso","leg","sideWeapon1","sideWeapon2","topWeapon1","topWeapon2","drone","module1","module2","module3","module4","module5"];
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(_loc1_.starterPackData[_loc5_[_loc6_]] > 0)
            {
               _loc4_.push(_loc1_.starterPackData[_loc5_[_loc6_]]);
            }
            _loc6_++;
         }
         var _loc7_:* = 0;
         _loc8_ = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc12_ = Number(_loc4_[_loc6_]);
            if(_loc12_ > 0)
            {
               _loc13_ = dataM.createShopTileListItem_basedOnItemID(_loc12_,"starterPack",null,null,null,this.itemMouseOver,this.itemMouseOut,true);
               _loc13_.x = this.mcItemsPosition.x + _loc7_ * dataM.STARTER_PACK_SIZE;
               _loc13_.y = this.mcItemsPosition.y + _loc8_ * dataM.STARTER_PACK_SIZE;
               this.tileListItems.push(_loc13_);
               addChild(_loc13_);
               if(++_loc7_ >= 3)
               {
                  _loc7_ = 0;
                  _loc8_++;
               }
            }
            _loc6_++;
         }
         var _loc9_:uint = 20;
         switch(dataM.languageID)
         {
            case 3:
               _loc9_ = 18;
               break;
            case 5:
               _loc9_ = 16;
               break;
            case 7:
               _loc9_ = 18;
               break;
            case 9:
               _loc9_ = 15;
         }
         var _loc10_:String = dataM.COLOR_LEGENDARY_ITEM;
         if(_loc1_.starterPackData.packID >= 2000)
         {
            _loc10_ = "FF0000";
         }
         var _loc11_:String = getScreenText("description_items");
         _loc11_ = dataM.replaceStringInText(_loc11_,"%COLOR%","<FONT COLOR=\'#" + _loc10_ + "\'>");
         _loc11_ = dataM.replaceStringInText(_loc11_,"%AMOUNT%",String(_loc4_.length));
         this.txtDescription.htmlText = TextUtils.getTextFont(_loc9_) + _loc11_;
         this.txtDescription2.text = getScreenText("description_goldTokens");
         this.mcBoxes.visible = false;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyStarterPack_description",[this.txtDescription,this.txtDescription2],"",this);
         }
      }
      
      public function itemMouseOver(param1:Number, param2:Number) : void
      {
         tooltip.showToolTip("newsItem","",param2);
      }
      
      private function itemMouseOut(param1:Number, param2:Number) : void
      {
         tooltip.hideToolTip();
      }
      
      private function boxesRotationHandler() : void
      {
         var _loc1_:uint = 0;
         if(this._boxesRotation)
         {
            ++this._boxesRotationFrameCounter;
            this._boxRaysToRotate.rotation += 0.5;
            if(this._boxesRotationFrameCounter == 100)
            {
               this._boxesRotationXSpeed = 20;
            }
            if(this._boxesRotationFrameCounter >= 100)
            {
               _loc1_ = 0;
               while(_loc1_ < this._boxMcsToShake.length)
               {
                  if(this._boxesRotationXSpeed % 2 == 0)
                  {
                     this._boxMcsToShake[_loc1_].x = this._boxesRotationXSpeed;
                  }
                  else
                  {
                     this._boxMcsToShake[_loc1_].x = -this._boxesRotationXSpeed;
                  }
                  _loc1_++;
               }
               --this._boxesRotationXSpeed;
               if(this._boxesRotationXSpeed <= 0)
               {
                  this._boxesRotationFrameCounter = 0;
               }
            }
         }
      }
      
      private function displayItemBoxes() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this.mcBoxes.visible = true;
         this.mcBoxes.mcMyth1_rays.visible = false;
         this.mcBoxes.mcMyth1_A.visible = false;
         this.mcBoxes.mcMyth1_B.visible = false;
         this.mcBoxes.mcMyth1_floor.visible = false;
         this.mcBoxes.mcMyth2_rays.visible = false;
         this.mcBoxes.mcMyth2_1A.visible = false;
         this.mcBoxes.mcMyth2_1B.visible = false;
         this.mcBoxes.mcMyth2_2.visible = false;
         this.mcBoxes.mcMyth2_floor.visible = false;
         this.mcBoxes.mcMythUltra_rays.visible = false;
         this.mcBoxes.mcMythUltra_A.visible = false;
         this.mcBoxes.mcMythUltra_B.visible = false;
         this.mcBoxes.mcMythUltra_floor.visible = false;
         this._boxMcsToShake = new Array();
         var _loc2_:String = "";
         if(_loc1_.starterPackData.boostID == 20)
         {
            if(_loc1_.starterPackData.boostAmount == 1)
            {
               _loc2_ = "Get one <FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>Mythical</FONT> Item Box";
               this.mcBoxes.mcMyth1_A.visible = true;
               this.mcBoxes.mcMyth1_B.visible = true;
               this.mcBoxes.mcMyth1_floor.visible = true;
               this.mcBoxes.mcMyth1_rays.visible = true;
               this._boxRaysToRotate = this.mcBoxes.mcMyth1_rays;
               this._boxMcsToShake.push(this.mcBoxes.mcMyth1_A,this.mcBoxes.mcMyth1_B);
               this.mcBoxes.mcCardOptions.gotoAndStop(1);
            }
            else
            {
               _loc2_ = "Get <FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>Two Mythical</FONT> Item Boxes";
               this.mcBoxes.mcMyth2_1A.visible = true;
               this.mcBoxes.mcMyth2_1B.visible = true;
               this.mcBoxes.mcMyth2_2.visible = true;
               this.mcBoxes.mcMyth2_floor.visible = true;
               this.mcBoxes.mcMyth2_rays.visible = true;
               this._boxRaysToRotate = this.mcBoxes.mcMyth2_rays;
               this._boxMcsToShake.push(this.mcBoxes.mcMyth2_1A,this.mcBoxes.mcMyth2_1B);
               this.mcBoxes.mcCardOptions.gotoAndStop(2);
            }
         }
         else
         {
            _loc2_ = "Get one <FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>Ultra Mythical</FONT> Item Box";
            this.mcBoxes.mcMythUltra_A.visible = true;
            this.mcBoxes.mcMythUltra_B.visible = true;
            this.mcBoxes.mcMythUltra_floor.visible = true;
            this.mcBoxes.mcMythUltra_rays.visible = true;
            this._boxRaysToRotate = this.mcBoxes.mcMythUltra_rays;
            this._boxMcsToShake.push(this.mcBoxes.mcMythUltra_A,this.mcBoxes.mcMythUltra_B);
            this.mcBoxes.mcCardOptions.gotoAndStop(3);
         }
         var _loc3_:uint = 20;
         switch(dataM.languageID)
         {
            case 3:
               _loc3_ = 18;
               break;
            case 5:
               _loc3_ = 16;
               break;
            case 7:
               _loc3_ = 18;
               break;
            case 9:
               _loc3_ = 15;
         }
         this.txtDescription.htmlText = TextUtils.getTextFont(_loc3_) + _loc2_;
         this.txtDescription2.text = getScreenText("description_goldTokens");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyStarterPack_description",[this.txtDescription,this.txtDescription2],"",this);
         }
         this._boxesRotation = true;
         this._boxesRotationFrameCounter = 0;
      }
      
      private function hideAllBoxes() : void
      {
      }
      
      private function sparksHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Sprite = null;
         var _loc4_:Sprite = null;
         var _loc5_:Sprite = null;
         _loc1_ = 0;
         while(_loc1_ < this._itemCardMCs.length)
         {
            _loc2_ = Math.ceil(Math.random() * 15);
            if(_loc2_ == 1)
            {
               _loc3_ = this._itemCardMCs[_loc1_];
               _loc4_ = externalAssetsM.getAsset("general","Grp_itemCardSpark" + this._itemCardsRarity[_loc1_],0,0,false,false);
               _loc4_.x = _loc3_.x + 20 + Math.random() * (_loc3_.width - 40) - _loc3_.width / 2;
               _loc4_.y = _loc3_.y + 15 + Math.random() * (_loc3_.height - 30);
               addChild(_loc4_);
               this._sparks.push(_loc4_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._sparks.length)
         {
            _loc5_ = this._sparks[_loc1_];
            if(_loc5_.scaleX > 0.075)
            {
               _loc5_.scaleX -= 0.075;
               _loc5_.scaleY -= 0.075;
            }
            else
            {
               this._sparks[_loc1_].parent.removeChild(this._sparks[_loc1_]);
               this._sparks[_loc1_] = null;
               this._sparks.splice(_loc1_,1);
            }
            _loc1_++;
         }
      }
      
      private function setStarterPackPurchaseInProgress() : *
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         _loc1_.starterPackData.starterPackStatus = 1;
      }
      
      public function buyClicked() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:BMTokenPackage = null;
         if(dataM.needToRegisterToBuyRealMoney)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",1);
            return;
         }
         if(screensM.screenBlack.isActive() == false)
         {
            _loc1_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
            if(_loc1_.pendingStarterPackMech == 0)
            {
               BMSpecialOffersManager.trackSpecialOffersEvent("BeginBuy",this._screenSource,_loc1_.starterPackData.tokenPackageID);
               _loc2_ = dataM.getTokenPackageByID(_loc1_.starterPackData.tokenPackageID);
               this.setStarterPackPurchaseInProgress();
               BMShopManager.getInstance().triggerMobilePurchase(String(_loc2_.tokenSystemPackageID));
               this.backClicked();
            }
            else
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mustRedeemStarterPackMech");
            }
         }
      }
      
      public function forceToRedeemMech() : void
      {
         dataM.starterPack_goBackToScreen = "hanger";
         this.backClicked();
      }
      
      public function buyConfirmed() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this.setStarterPackPurchaseInProgress();
         remoteM.socketM.lobby_buyStarterPack();
         this.btnBuyOrange.disableMe();
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
      }
      
      public function packBought() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("starterPackBought");
      }
      
      public function packBoughtSub() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.starterPackData.torso > 0)
         {
            dataM.starterPack_goBackToScreen = "hanger";
            this.backClicked();
         }
         else
         {
            screensM.addScreen("screenItemCards");
         }
      }
      
      public function backClicked() : void
      {
         switch(dataM.starterPack_goBackToScreen)
         {
            case "hanger":
               screensM.screenNewMenu.hangerMechClicked();
               break;
            case "singlePlayer":
               screensM.screenNewMenu.singlePlayerClicked();
               break;
            case "multiplayerLadder":
               screensM.screenNewMenu.multiplayerLadderClicked();
               break;
            case "multiplayerChat":
               screensM.screenNewMenu.multiplayerChatClicked();
            case "mainMenu":
               screensM.screenNewMenu.mainMenu();
         }
      }
      
      private function resetTimerEvent(param1:TimerEvent) : void
      {
         this.refreshTimer();
      }
      
      private function refreshTimer() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         if(this._lastChanceAlert == false)
         {
            _loc1_ = dataM.myProfile;
            _loc2_ = _loc1_.starterPackData.starterPackStartDate + _loc1_.starterPackData.offerDuration - dataM.currentTime;
            if(_loc2_ <= 0)
            {
               this._lastChanceAlert = true;
               this.txtTimeLeft.htmlText = TextUtils.getTextFont() + getScreenText("timeUp");
               if(dataM.runAsMobile)
               {
                  screensM.createMultipleTextsBitmap("starterPack_timer",[this.txtTimeLeft],"",this);
               }
            }
            else
            {
               _loc3_ = Math.floor(_loc2_ / this._hourLength);
               _loc4_ = Math.floor((_loc2_ - _loc3_ * this._hourLength) / this._minuteLength);
               _loc5_ = Math.floor(_loc2_ - _loc3_ * this._hourLength - _loc4_ * this._minuteLength);
               if(_loc4_ < 10)
               {
                  _loc6_ = "0" + _loc4_;
               }
               else
               {
                  _loc6_ = String(_loc4_);
               }
               if(_loc5_ < 10)
               {
                  _loc7_ = "0" + _loc5_;
               }
               else
               {
                  _loc7_ = String(_loc5_);
               }
               _loc8_ = _loc3_;
               if(_loc8_ > 0)
               {
                  this.txtTimeLeft.htmlText = TextUtils.getTextFont() + getScreenText("timeLeft") + "<BR>" + _loc3_ + ":" + _loc6_ + ":" + _loc7_;
               }
               else
               {
                  this.txtTimeLeft.htmlText = TextUtils.getTextFont() + getScreenText("timeLeft") + "<BR>" + _loc6_ + ":" + _loc7_;
               }
               if(_loc2_ <= 60)
               {
                  soundM.createSound("clockTick",1);
               }
               if(dataM.runAsMobile)
               {
                  screensM.createMultipleTextsBitmap("starterPack_timer",[this.txtTimeLeft],"",this);
               }
            }
         }
      }
      
      private function stopTimer() : void
      {
         if(this._resetTimer != null)
         {
            this._resetTimer.stop();
            this._resetTimer.removeEventListener(TimerEvent.TIMER,this.resetTimerEvent);
            this._resetTimer = null;
         }
      }
      
      public function removeMe() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMTileListItem = null;
         if(this.mechView != null)
         {
            this.mechView.removeMe();
            this.mechView = null;
         }
         if(this._itemCardMCs.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this._itemCardMCs.length)
            {
               if(dataM.runAsMobile)
               {
                  this._itemCardMCs[_loc1_].cardBMD.dispose();
                  this._itemCardMCs[_loc1_].cardBMD = null;
                  this._itemCardMCs[_loc1_].cardBM.parent.removeChild(this._itemCardMCs[_loc1_].cardBM);
                  this._itemCardMCs[_loc1_].cardBM = null;
               }
               this._itemCardMCs[_loc1_].parent.removeChild(this._itemCardMCs[_loc1_]);
               this._itemCardMCs[_loc1_] = null;
               _loc1_++;
            }
            this._itemCardMCs = new Array();
         }
         if(this.tileListItems.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this.tileListItems.length)
            {
               _loc2_ = this.tileListItems[_loc1_];
               _loc2_.removeMe();
               _loc2_ = null;
               this.tileListItems[_loc1_] = null;
               _loc1_++;
            }
            this.tileListItems = new Array();
         }
         this.stopTimer();
         this._lastChanceAlert = false;
         screensM.removeScreen("screenBuyStarterPack");
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen(this._screenSource);
      }
   }
}

