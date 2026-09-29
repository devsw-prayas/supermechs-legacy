package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureC;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureD;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureF;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureK;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol903")]
   public class BMScreenConfirmation extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnCancel:Sprite;
      
      public var mcSizer_btnCancelOnly:Sprite;
      
      public var mcSizer_btnConfirm:Sprite;
      
      public var mcSizer_btnOKOnly:Sprite;
      
      public var mcSizer_btnRegister:Sprite;
      
      public var mcSizer_btnLater:Sprite;
      
      public var mcSizer_btnHanger:Sprite;
      
      public var mcSizer_btnCancelSmall:Sprite;
      
      public var mcSizer_btnGetCredits:Sprite;
      
      public var mcSizer_btnGetTokens:Sprite;
      
      public var mcSizer_btnSuperMechs:Sprite;
      
      public var mcSizer_btnAppStore:Sprite;
      
      public var mcSizer_weight:Sprite;
      
      public var mcTermsOfUseLinkHitArea1:Sprite;
      
      public var mcTermsOfUseLinkHitArea2:Sprite;
      
      public var mcTutorialArrow_button:MovieClip;
      
      public var serverNotification_text:String;
      
      public var serverNotification_restart:Boolean;
      
      public var mcFacebookIcon:Sprite;
      
      private var _questionOrNotificationType:String;
      
      private var _ID1:Number;
      
      private var _ID2:Number;
      
      private var _logoutCounter:Number = 0;
      
      private var _btnOKOnlyOriginYPos:Number;
      
      private var _sellingItemIDs:Array;
      
      private var _sellingItemSlot:uint;
      
      private var _backgroundOriginalWidth:Number;
      
      private var _input1OriginalYPos:Number;
      
      private var _input1BackgroundOriginalYPos:Number;
      
      private var _tutorialArrowOriginalYPos:Number;
      
      private var _adminToolsPasswordCounter:Number = 0;
      
      private var mcItem:BMItem;
      
      private var mcPicture:MovieClip;
      
      private var originYPos_txtTermsOfUse:Number;
      
      private var originYPos_mcErrorMarkTermsOfUse:Number;
      
      private var originYPos_mcV:Number;
      
      private var originYPos_mcVFrame:Number;
      
      private var originYPos_mcVMouseHitArea:Number;
      
      private var originYPos_mcTermsOfUseBackground:Number;
      
      public var mcBackground:MovieClip;
      
      public var btnCancel:BMButton_pictureC;
      
      public var btnCancelOnly:BMButton_pictureE;
      
      public var btnConfirm:BMButton_pictureD;
      
      public var btnOKOnly:BMButton;
      
      public var btnRegister:BMButton;
      
      public var btnLater:BMButton;
      
      public var btnCancelSmall:BMButton_pictureE;
      
      public var btnHanger:BMButton;
      
      public var btnGetCredits:BMButton_pictureF;
      
      public var btnGetTokens:BMButton_pictureK;
      
      public var btnSuperMechs:BMButton;
      
      public var btnAppStore:BMButton;
      
      public var mcPicture1Sizer:Sprite;
      
      public var mcIconGoldBuy:Sprite;
      
      public var mcIconGoldSell:Sprite;
      
      public var mcIconGoldReward:Sprite;
      
      public var mcIconGoldRewardClan:Sprite;
      
      public var mcIconTokens:Sprite;
      
      public var mcIconBattleCredits:Sprite;
      
      public var mcIconBullets:Sprite;
      
      public var mcIconRockets:Sprite;
      
      public var mcIconDurability:Sprite;
      
      public var mcBuySellItemBackground:Sprite;
      
      public var mcGoldRewardBackground:Sprite;
      
      public var mcSandClock:MovieClip;
      
      private var mcIconWeight:Sprite;
      
      public var txtNotification:TextField;
      
      public var txtBuySell:TextField;
      
      public var txtGold:TextField;
      
      public var txtTokens:TextField;
      
      public var txtGoldReward:TextField;
      
      public var txtInput1:TextField;
      
      public var txtInput2:TextField;
      
      public var mcInputText1Background:Sprite;
      
      public var mcInputText2Background:Sprite;
      
      public var txtTermsOfUse:TextField;
      
      public var mcErrorMarkTermsOfUse:Sprite;
      
      public var mcVMouseHitArea:Sprite;
      
      public var mcSMMouseHitArea:Sprite;
      
      public var mcV:Sprite;
      
      public var mcVFrame:Sprite;
      
      public var mcTermsOfUseBackground:Sprite;
      
      public var mcTutorialArrow_inputName:MovieClip;
      
      private var mcTopRanksChatBlock_rank1:Sprite;
      
      private var mcTopRanksChatBlock_rank2:Sprite;
      
      private var mcTopRanksChatBlock_rank3:Sprite;
      
      private var _topRanksChatBlockSize:Number;
      
      private var _topRanksChatBlockOriginXPos1:Number;
      
      private var _topRanksChatBlockOriginXPos2:Number;
      
      private var _topRanksChatBlockOriginXPos3:Number;
      
      private var _topRanksChatBlockOriginYPos:Number;
      
      private var _focusInputTextOnNextFrame:Boolean = false;
      
      private var _displayUrgentMessage:Boolean = false;
      
      private var _displayUrgentMessageType:String;
      
      private var _displayUrgentMessageFrameCounter:Number;
      
      public var urgentMessageClanMemberName:String;
      
      private var _firstRefresh:Boolean = true;
      
      private var customConfirmationHandler:Function;
      
      private var customConfirmationText:String;
      
      public function BMScreenConfirmation()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("confirmation");
      }
      
      public function onEnterFrameTrigger() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         if(parent != null)
         {
            if(this._focusInputTextOnNextFrame)
            {
               stage.focus = this.txtInput1;
               this._focusInputTextOnNextFrame = false;
            }
         }
         if(this._displayUrgentMessage)
         {
            _loc1_ = true;
            if(screensM.isScreenOpened("screenWelcomeBackground") || screensM.isScreenOpened("screenDailyLoginStreakBonus"))
            {
               _loc1_ = false;
            }
            if(_loc1_)
            {
               _loc2_ = false;
               if(this._displayUrgentMessageType == "newItemsCreated")
               {
                  if(screensM.isScreenOpened("screenBattle") == false)
                  {
                     if(screensM.isScreenOpened("screenHangerMenu") == false)
                     {
                        _loc2_ = true;
                     }
                  }
               }
               else if(screensM.isScreenOpened("screenBattle") == false && screensM.isScreenOpened("screenMissionBaseMap") == false)
               {
                  _loc2_ = true;
               }
               if(_loc2_)
               {
                  ++this._displayUrgentMessageFrameCounter;
                  if(this._displayUrgentMessageFrameCounter >= 10)
                  {
                     this._displayUrgentMessage = false;
                     this.displayQuestionOrNotification(this._displayUrgentMessageType,-1,-1);
                  }
               }
            }
         }
      }
      
      private function setText(param1:String) : void
      {
         this.txtNotification.htmlText = TextUtils.getTextFont() + param1;
      }
      
      public function displayCustomYesNoQuestion(param1:String, param2:Function) : *
      {
         this.customConfirmationHandler = param2;
         this.customConfirmationText = param1;
         this.displayQuestionOrNotification("customYesNoQuestion");
      }
      
      public function displayCustomMessage(param1:String, param2:Function = null) : *
      {
         this.customConfirmationText = param1;
         this.customConfirmationHandler = param2;
         this.displayQuestionOrNotification("customMessage");
      }
      
      public function displayCustomLoading(param1:String) : *
      {
         if(screensM.isScreenOpened("screenConfirmation") && this._questionOrNotificationType == "customLoading")
         {
            this.setText("<br><br><br><br>" + param1);
            return;
         }
         this.customConfirmationText = param1;
         this.displayQuestionOrNotification("customLoading");
      }
      
      public function displayCustomLockedMessage(param1:String) : *
      {
         this.customConfirmationText = param1;
         this.displayQuestionOrNotification("customLockedMessage");
      }
      
      public function displayQuestionOrNotification(param1:String, param2:Number = -1, param3:Number = -1) : void
      {
         var _loc4_:BMItemData = null;
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:String = null;
         var _loc7_:BMBoostData = null;
         var _loc8_:Object = null;
         var _loc9_:BMPlayerProfile = null;
         var _loc10_:Function = null;
         var _loc11_:Function = null;
         var _loc12_:Function = null;
         var _loc13_:Function = null;
         var _loc14_:Function = null;
         var _loc15_:Function = null;
         var _loc16_:Function = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:String = null;
         var _loc21_:String = null;
         var _loc22_:String = null;
         var _loc23_:String = null;
         var _loc24_:String = null;
         var _loc25_:String = null;
         var _loc26_:String = null;
         var _loc27_:String = null;
         var _loc28_:Number = NaN;
         var _loc29_:String = null;
         var _loc30_:String = null;
         var _loc31_:String = null;
         var _loc32_:String = null;
         var _loc33_:String = null;
         var _loc34_:String = null;
         var _loc35_:String = null;
         var _loc36_:String = null;
         var _loc37_:String = null;
         var _loc38_:String = null;
         var _loc39_:String = null;
         var _loc40_:String = null;
         var _loc41_:String = null;
         var _loc42_:String = null;
         var _loc43_:String = null;
         var _loc44_:String = null;
         var _loc45_:String = null;
         var _loc46_:String = null;
         var _loc47_:String = null;
         var _loc48_:String = null;
         var _loc49_:String = null;
         var _loc50_:Object = null;
         var _loc51_:String = null;
         var _loc52_:String = null;
         var _loc53_:String = null;
         var _loc54_:String = null;
         var _loc55_:uint = 0;
         var _loc56_:String = null;
         var _loc57_:String = null;
         var _loc58_:String = null;
         var _loc59_:String = null;
         var _loc60_:String = null;
         var _loc61_:String = null;
         var _loc62_:String = null;
         var _loc63_:String = null;
         var _loc64_:uint = 0;
         var _loc65_:Object = null;
         var _loc66_:String = null;
         var _loc67_:String = null;
         var _loc68_:BMItemData = null;
         var _loc69_:String = null;
         var _loc70_:String = null;
         var _loc71_:String = null;
         var _loc72_:Number = NaN;
         var _loc73_:Number = NaN;
         var _loc74_:Number = NaN;
         var _loc75_:String = null;
         var _loc76_:Number = NaN;
         var _loc77_:String = null;
         var _loc78_:String = null;
         var _loc79_:Array = null;
         if(parent != null)
         {
            screensM.removeScreen("screenConfirmation");
         }
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenConfirmation","btnCancel","pictureC");
            screensM.createButtonFromSizer("screenConfirmation","btnCancelOnly","pictureE");
            screensM.createButtonFromSizer("screenConfirmation","btnConfirm","pictureD");
            screensM.createButtonFromSizer("screenConfirmation","btnOKOnly","regular");
            screensM.createButtonFromSizer("screenConfirmation","btnRegister","regular");
            screensM.createButtonFromSizer("screenConfirmation","btnLater","regular");
            screensM.createButtonFromSizer("screenConfirmation","btnHanger","regular");
            screensM.createButtonFromSizer("screenConfirmation","btnCancelSmall","pictureE");
            screensM.createButtonFromSizer("screenConfirmation","btnGetCredits","pictureF");
            screensM.createButtonFromSizer("screenConfirmation","btnGetTokens","pictureK");
            screensM.createButtonFromSizer("screenConfirmation","btnSuperMechs","regular");
            this.btnHanger.setRunAsMobile(dataM.runAsMobile);
            this.btnHanger.changeFontSize(20);
            this.btnSuperMechs.setRunAsMobile(dataM.runAsMobile);
            this.btnSuperMechs.changeFontSize(13);
            _loc10_ = this.cancelClicked;
            _loc11_ = this.confirmClicked;
            _loc12_ = this.registerClicked;
            _loc13_ = this.hangerClicked;
            _loc14_ = this.getCreditsClicked;
            _loc15_ = this.getTokensClicked;
            _loc16_ = this.superMechsClicked;
            if(dataM.runAsMobile)
            {
               _loc10_ = null;
               _loc11_ = null;
               _loc12_ = null;
               _loc13_ = null;
               _loc14_ = null;
               _loc15_ = null;
               _loc16_ = null;
               screensM.createButtonFromSizer("screenConfirmation","btnAppStore","regular");
               this.btnAppStore.setRunAsMobile(dataM.runAsMobile);
               this.btnAppStore.changeFontSize(26);
               this.btnAppStore.initialize(getScreenText("update"),"blue",null,[],this.appStoreClicked,dataM.runAsMobile);
               this.btnAppStore.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
               this.btnOKOnly.setRunAsMobile(dataM.runAsMobile);
               this.btnOKOnly.changeFontSize(34);
            }
            this.btnCancel.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc10_,dataM.runAsMobile);
            this.btnCancelOnly.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc10_,dataM.runAsMobile);
            this.btnConfirm.initialize("","",externalAssetsM.getAsset("general","interface_V"),null,_loc11_,dataM.runAsMobile);
            this.btnOKOnly.initialize(getGeneralText("OK"),"blue",null,[],_loc11_,dataM.runAsMobile);
            this.btnRegister.initialize(getGeneralText("register"),"orange",null,[],_loc12_,dataM.runAsMobile);
            this.btnLater.initialize(getGeneralText("later"),"blue",null,[],_loc10_,dataM.runAsMobile);
            this.btnHanger.initialize(getScreenText("openWorkshop"),"blue",null,[],_loc13_,dataM.runAsMobile);
            this.btnCancelSmall.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc10_,dataM.runAsMobile);
            this.btnGetCredits.initialize("","",externalAssetsM.getAsset("general","interface_getCredits"),null,_loc14_,dataM.runAsMobile);
            this.btnGetTokens.initialize("","",externalAssetsM.getAsset("general","interface_getTokens"),null,_loc15_,dataM.runAsMobile);
            this.btnSuperMechs.initialize("WWW.SUPERMECHS.COM","blue",null,[],_loc16_,dataM.runAsMobile);
            if(dataM.runAsMobile == false)
            {
               this.btnGetCredits.buttonCore.addMouseOverListerner(this.getCreditsMouseOver);
               this.btnGetCredits.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnGetTokens.buttonCore.addMouseOverListerner(this.getTokensMouseOver);
               this.btnGetTokens.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
            }
            this.btnCancel.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnCancelOnly.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnConfirm.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnOKOnly.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnRegister.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnLater.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnHanger.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnCancelSmall.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnGetCredits.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnGetTokens.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSuperMechs.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            if(dataM.runAsMobile == false)
            {
               this.mcVMouseHitArea.addEventListener(MouseEvent.CLICK,this.acceptTermsOfUseClicked);
               this.mcVMouseHitArea.buttonMode = true;
               this.mcVMouseHitArea.useHandCursor = true;
            }
            this.txtInput1.maxChars = 30;
            this.txtInput1.restrict = "^<>&";
            this._btnOKOnlyOriginYPos = this.btnOKOnly.y;
            this._backgroundOriginalWidth = this.mcBackground.width;
            this._input1OriginalYPos = this.txtInput1.y;
            this._input1BackgroundOriginalYPos = this.mcInputText1Background.y;
            this._tutorialArrowOriginalYPos = this.mcTutorialArrow_inputName.y;
            this.mcTutorialArrow_inputName.mouseEnabled = false;
            this.mcTutorialArrow_inputName.mouseChildren = false;
            this.mcTutorialArrow_button.mouseEnabled = false;
            this.mcTutorialArrow_button.mouseChildren = false;
            this.mcIconWeight = externalAssetsM.getAsset("general","icon_weight",this.mcSizer_weight.width,this.mcSizer_weight.height,false,false);
            this.mcIconWeight.x = this.mcSizer_weight.x;
            this.mcIconWeight.y = this.mcSizer_weight.y;
            this.mcButtonsHolder.addChild(this.mcIconWeight);
            this.mcSizer_weight.parent.removeChild(this.mcSizer_weight);
            this.originYPos_txtTermsOfUse = this.txtTermsOfUse.y;
            this.originYPos_mcErrorMarkTermsOfUse = this.mcErrorMarkTermsOfUse.y;
            this.originYPos_mcV = this.mcV.y;
            this.originYPos_mcVFrame = this.mcVFrame.y;
            this.originYPos_mcVMouseHitArea = this.mcVMouseHitArea.y;
            this.originYPos_mcTermsOfUseBackground = this.mcTermsOfUseBackground.y;
            this.mcSMMouseHitArea.parent.removeChild(this.mcSMMouseHitArea);
            this.mcSMMouseHitArea = null;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this._questionOrNotificationType = param1;
         this._ID1 = param2;
         this._ID2 = param3;
         this.btnConfirm.visible = false;
         this.btnCancel.visible = false;
         this.btnCancelOnly.visible = false;
         this.btnOKOnly.visible = false;
         this.btnCancelSmall.visible = false;
         this.btnRegister.visible = false;
         this.btnLater.visible = false;
         this.btnHanger.visible = false;
         this.btnGetCredits.visible = false;
         this.btnGetTokens.visible = false;
         this.btnSuperMechs.visible = false;
         if(dataM.runAsMobile)
         {
            this.btnAppStore.visible = false;
         }
         this.btnOKOnly.y = this._btnOKOnlyOriginYPos;
         this.mcIconGoldBuy.visible = false;
         this.mcIconGoldSell.visible = false;
         this.mcIconGoldReward.visible = false;
         this.mcIconGoldRewardClan.visible = false;
         this.mcIconTokens.visible = false;
         this.mcIconBattleCredits.visible = false;
         this.mcIconBullets.visible = false;
         this.mcIconRockets.visible = false;
         this.mcIconWeight.visible = false;
         this.mcIconDurability.visible = false;
         this.mcBuySellItemBackground.visible = false;
         this.mcGoldRewardBackground.visible = false;
         this.mcFacebookIcon.visible = false;
         if(this.mcItem != null)
         {
            this.mcItem.removeMe();
            this.mcItem = null;
         }
         if(this.mcPicture != null)
         {
            this.mcPicture.parent.removeChild(this.mcPicture);
            this.mcPicture = null;
         }
         if(this.mcTopRanksChatBlock_rank1 != null)
         {
            if(this.mcTopRanksChatBlock_rank1.parent != null)
            {
               this.mcTopRanksChatBlock_rank1.parent.removeChild(this.mcTopRanksChatBlock_rank1);
               this.mcTopRanksChatBlock_rank2.parent.removeChild(this.mcTopRanksChatBlock_rank2);
               this.mcTopRanksChatBlock_rank3.parent.removeChild(this.mcTopRanksChatBlock_rank3);
            }
         }
         this.txtNotification.text = "";
         this.txtBuySell.text = "";
         this.txtGold.text = "";
         this.txtTokens.text = "";
         this.txtGold.textColor = 16750848;
         this.txtTokens.textColor = 14540253;
         this.txtGoldReward.text = "";
         this.txtInput1.text = "";
         this.txtInput1.visible = false;
         this.txtInput2.text = "";
         this.txtInput2.visible = false;
         this.mcInputText1Background.visible = false;
         this.mcInputText2Background.visible = false;
         this.mcSandClock.gotoAndStop("animOff");
         this.mcBackground.width = this._backgroundOriginalWidth;
         this.txtInput1.y = this._input1OriginalYPos;
         this.mcInputText1Background.y = this._input1BackgroundOriginalYPos;
         this.mcTutorialArrow_inputName.y = this._tutorialArrowOriginalYPos;
         this.mcTermsOfUseLinkHitArea1.visible = false;
         this.mcTermsOfUseLinkHitArea2.visible = false;
         this.txtTermsOfUse.visible = false;
         this.mcV.visible = false;
         this.mcVMouseHitArea.visible = false;
         this.mcErrorMarkTermsOfUse.visible = false;
         this.mcTermsOfUseBackground.visible = false;
         this.mcVFrame.visible = false;
         this.mcTutorialArrow_inputName.gotoAndStop("animOff");
         switch(this._questionOrNotificationType)
         {
            case "purchaseSuccessful":
               this.setText("<FONT COLOR=\'#" + dataM.COLOR_GOOD + "\'>" + getScreenText("purchaseSuccessful") + "</FONT>");
               this.btnOKOnly.visible = true;
               break;
            case "notEnoughMoneyForItem":
               _loc4_ = dataM.itemsDB[this._ID1];
               _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(_loc4_.costTokens == 0)
               {
                  this.mcIconGoldBuy.visible = true;
                  this.txtGold.text = dataM.getNumberWithComma(_loc4_.costGold);
                  if(_loc4_.costGold > _loc9_.gold)
                  {
                     this.txtGold.textColor = 13369344;
                  }
               }
               else if(_loc4_.costTokens > 0)
               {
                  this.txtTokens.text = String(_loc4_.costTokens);
                  this.mcIconTokens.visible = true;
                  if(_loc4_.costTokens > _loc9_.tokens)
                  {
                     this.txtTokens.textColor = 13369344;
                  }
               }
               this.btnCancel.visible = true;
               if(_loc4_.costTokens > 0)
               {
                  this.btnGetTokens.visible = true;
               }
               else
               {
                  this.btnGetCredits.visible = true;
               }
               this.mcBuySellItemBackground.visible = true;
               this.addItem(_loc4_,0);
               break;
            case "itemEquippedNoBullets":
               _loc17_ = getScreenText("needBulletsForWeapon");
               _loc17_ = dataM.replaceStringInText(_loc17_,"%NAME%",dataM.itemsDB[this._ID1].fullName);
               this.setText(_loc17_);
               this.mcIconBullets.visible = true;
               this.btnOKOnly.visible = true;
               break;
            case "itemEquippedNoRockets":
               _loc18_ = getScreenText("needRocketsForWeapon");
               _loc18_ = dataM.replaceStringInText(_loc18_,"%NAME%",dataM.itemsDB[this._ID1].fullName);
               this.setText(_loc18_);
               this.mcIconRockets.visible = true;
               this.btnOKOnly.visible = true;
               break;
            case "resistanceModuleBlock":
               this.setText(getScreenText("resistanceModuleLimitation"));
               this.btnOKOnly.visible = true;
               break;
            case "resistanceKitBlock":
               this.setText(getScreenText("resistanceKitLimitation"));
               this.btnOKOnly.visible = true;
               break;
            case "buyItemFailed":
               this.setText(getScreenText("buyItemFailed"));
               this.btnOKOnly.visible = true;
               break;
            case "repairKitBlock":
               this.setText(getScreenText("repairKitLimitation"));
               this.btnOKOnly.visible = true;
               break;
            case "energyKitBlock":
               this.setText(getScreenText("energyKitLimitation"));
               this.btnOKOnly.visible = true;
               break;
            case "coolingKitBlock":
               this.setText(getScreenText("coolingKitLimitation"));
               this.btnOKOnly.visible = true;
               break;
            case "bulletsKitBlock":
               this.setText(getScreenText("bulletsKitLimitation"));
               this.btnOKOnly.visible = true;
               break;
            case "rocketsKitBlock":
               this.setText(getScreenText("rocketsKitLimitation"));
               this.btnOKOnly.visible = true;
               break;
            case "powerKitBlock":
               this.setText(getScreenText("powerKitLimitation"));
               this.btnOKOnly.visible = true;
               break;
            case "colorKitBlock":
               this.setText(getScreenText("colorKitLimitation"));
               this.btnOKOnly.visible = true;
               break;
            case "weightBlock":
               this.setText(getScreenText("tooMuchWeight"));
               this.mcIconWeight.visible = true;
               this.btnOKOnly.visible = true;
               break;
            case "changeMechsOrderFailed":
               this.setText(getScreenText("changeMechsOrderFailed"));
               this.btnOKOnly.visible = true;
               break;
            case "rewardVideosGotTokens":
               _loc19_ = getScreenText("rewardedVideoGotTokens");
               _loc19_ = dataM.replaceStringInText(_loc19_,"%AMOUNT%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>" + this._ID1 + "</FONT>");
               this.setText(_loc19_);
               this.btnOKOnly.visible = true;
               break;
            case "rewardVideosGotGold":
               _loc20_ = getScreenText("rewardedVideoGotGold");
               _loc20_ = dataM.replaceStringInText(_loc20_,"%AMOUNT%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>" + dataM.getNumberWithComma(this._ID1) + "</FONT>");
               this.setText(_loc20_);
               this.btnOKOnly.visible = true;
               break;
            case "rewardVideosComeBackLater":
               this.setText(getScreenText("rewardedVideoComeBackLater"));
               this.btnOKOnly.visible = true;
               break;
            case "missionFailed":
               _loc21_ = getScreenText("missionFailed");
               _loc21_ = dataM.replaceStringInText(_loc21_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_BAD + "\'>");
               this.setText(_loc21_);
               this.btnOKOnly.visible = true;
               break;
            case "abortMission":
               this.setText(getScreenText("abortMission"));
               this.btnCancel.visible = true;
               this.btnConfirm.visible = true;
               break;
            case "missionSavingProgress":
               this.setText(getScreenText("missionSavingProgress"));
               this.btnOKOnly.visible = true;
               break;
            case "missionRevive":
               this.setText(getScreenText("missionRevive"));
               this.mcIconBattleCredits.visible = true;
               this.btnCancel.visible = true;
               this.btnConfirm.visible = true;
               break;
            case "missionBought":
               _loc22_ = getScreenText("missionBought");
               _loc22_ = dataM.replaceStringInText(_loc22_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOOD + "\'>");
               this.setText(_loc22_);
               this.btnOKOnly.visible = true;
               break;
            case "missionsBought":
               _loc23_ = getScreenText("missionsBought");
               _loc23_ = dataM.replaceStringInText(_loc23_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOOD + "\'>");
               this.setText(_loc23_);
               this.btnOKOnly.visible = true;
               break;
            case "itemBoxAlreadyClaimed":
               this.setText(getScreenText("itemBoxAlreadyClaimed"));
               this.btnOKOnly.visible = true;
               break;
            case "starterPackBought":
               this.setText(getScreenText("starterPackBought"));
               this.btnOKOnly.visible = true;
               break;
            case "mustRedeemStarterPackMech":
               this.setText(getScreenText("mustRedeemStarterPackMech"));
               this.btnOKOnly.visible = true;
               break;
            case "onlineWinsRequiredForItemBox":
               _loc24_ = getScreenText("onlineWinsRequiredForItemBox");
               _loc24_ = dataM.replaceStringInText(_loc24_,"%REQUIRED%",String(this._ID1));
               _loc24_ = dataM.replaceStringInText(_loc24_,"%REMAINING%",String(this._ID2));
               _loc24_ = dataM.replaceStringInText(_loc24_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
               _loc24_ = dataM.replaceStringInText(_loc24_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
               this.setText(_loc24_);
               this.btnOKOnly.visible = true;
               break;
            case "hardInsaneMissionsRequiredForItemBox":
               _loc25_ = getScreenText("hardInsaneMissionsRequiredForItemBox");
               _loc25_ = dataM.replaceStringInText(_loc25_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_HARD + "\'>");
               _loc25_ = dataM.replaceStringInText(_loc25_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_INSANE + "\'>");
               this.setText(_loc25_);
               this.btnOKOnly.visible = true;
               break;
            case "previousMissionsRequiredForItemBox":
               this.setText(getScreenText("previousMissionsRequiredForItemBox"));
               this.btnOKOnly.visible = true;
               break;
            case "rateBox_usedRated":
               this.setText(getSpecificText("rateBox_userRated"));
               this.btnOKOnly.visible = true;
               break;
            case "giftUsed":
               _loc26_ = getScreenText("giftUsed");
               _loc26_ = dataM.replaceStringInText(_loc26_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               _loc26_ = dataM.replaceStringInText(_loc26_,"%GOLD%",dataM.getNumberWithComma(dataM.giftKeyGold));
               this.setText(_loc26_);
               this.btnOKOnly.visible = true;
               break;
            case "giftAlreadyUsed":
               this.setText(getScreenText("giftAlreadyUsed"));
               this.btnOKOnly.visible = true;
               break;
            case "giftIsMyOwn":
               this.setText(getScreenText("giftIsMyOwn"));
               this.btnOKOnly.visible = true;
               break;
            case "giftDoesNotExist":
               this.setText(getScreenText("giftDoesNotExist"));
               this.btnOKOnly.visible = true;
               break;
            case "giftWasNotUsed":
               this.setText(getScreenText("giftWasNotUsed"));
               this.btnOKOnly.visible = true;
               break;
            case "giftUserDoesNotExist":
               this.setText(getScreenText("giftUserDoesNotExist"));
               this.btnOKOnly.visible = true;
               break;
            case "giftUserDidNotReachLevel":
               this.setText(getScreenText("giftUserDidNotReachLevel"));
               this.btnOKOnly.visible = true;
               break;
            case "giftBonusesAlreadyClaimed":
               this.setText(getScreenText("giftBonusesAlreadyClaimed"));
               this.btnOKOnly.visible = true;
               break;
            case "giftBonusClaimed":
               _loc27_ = getScreenText("giftBonusClaimed");
               _loc27_ = dataM.replaceStringInText(_loc27_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               if(this._ID1 == 1)
               {
                  _loc28_ = dataM.giftKeysBonus1Gold;
               }
               else
               {
                  _loc28_ = dataM.giftKeysBonus2Gold;
               }
               _loc27_ = dataM.replaceStringInText(_loc27_,"%GOLD%",dataM.getNumberWithComma(_loc28_));
               this.setText(_loc27_);
               this.btnOKOnly.visible = true;
               break;
            case "cannotWriteGiftKeyInChat":
               _loc29_ = getScreenText("cannotWriteGiftKeyInChat");
               _loc29_ = dataM.replaceStringInText(_loc29_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GIFT_KEY + "\'>");
               this.setText(_loc29_);
               this.btnOKOnly.visible = true;
               break;
            case "chatForHighRanksOnly":
               if(this.mcTopRanksChatBlock_rank1 == null)
               {
                  this._topRanksChatBlockSize = 70;
                  this.mcTopRanksChatBlock_rank1 = externalAssetsM.getAsset("general","Grp_rank" + dataM.getLadderRankIconNumber(1),this._topRanksChatBlockSize,this._topRanksChatBlockSize,false,false);
                  this.mcTopRanksChatBlock_rank2 = externalAssetsM.getAsset("general","Grp_rank" + dataM.getLadderRankIconNumber(2),this._topRanksChatBlockSize,this._topRanksChatBlockSize,false,false);
                  this.mcTopRanksChatBlock_rank3 = externalAssetsM.getAsset("general","Grp_rank" + dataM.getLadderRankIconNumber(3),this._topRanksChatBlockSize,this._topRanksChatBlockSize,false,false);
                  this._topRanksChatBlockOriginXPos1 = 435;
                  this._topRanksChatBlockOriginXPos2 = 365;
                  this._topRanksChatBlockOriginXPos3 = 295;
                  this._topRanksChatBlockOriginYPos = 210;
                  this.mcTopRanksChatBlock_rank1.x = this._topRanksChatBlockOriginXPos1;
                  this.mcTopRanksChatBlock_rank2.x = this._topRanksChatBlockOriginXPos2;
                  this.mcTopRanksChatBlock_rank3.x = this._topRanksChatBlockOriginXPos3;
                  this.mcTopRanksChatBlock_rank1.y = this._topRanksChatBlockOriginYPos;
                  this.mcTopRanksChatBlock_rank2.y = this._topRanksChatBlockOriginYPos;
                  this.mcTopRanksChatBlock_rank3.y = this._topRanksChatBlockOriginYPos;
               }
               addChild(this.mcTopRanksChatBlock_rank1);
               addChild(this.mcTopRanksChatBlock_rank2);
               addChild(this.mcTopRanksChatBlock_rank3);
               this.setText(getScreenText("topRanksChannelBlock"));
               this.btnOKOnly.visible = true;
               break;
            case "craftingFailed":
               this.setText(getScreenText("craftingFailed"));
               this.btnOKOnly.visible = true;
               break;
            case "activateFusionPower":
               _loc5_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._ID1);
               _loc4_ = dataM.itemsDB[_loc5_.itemID];
               _loc30_ = _loc4_.fullName;
               if(dataM.languageID == 2)
               {
                  _loc30_ = getSpecificText("item_" + _loc4_.itemID);
               }
               if(this._ID2 == 1)
               {
                  _loc31_ = getScreenText("desctroyItemToUpgradeItem");
                  _loc31_ = dataM.replaceStringInText(_loc31_,"%NAME%",_loc30_);
               }
               else
               {
                  _loc31_ = getScreenText("desctroyItemsToUpgradeItem");
                  _loc31_ = dataM.replaceStringInText(_loc31_,"%NAME%",_loc30_);
                  _loc31_ = dataM.replaceStringInText(_loc31_,"%AMOUNT%",String(this._ID2));
               }
               this.setText(_loc31_);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               if(dataM.isTutorialActive())
               {
                  this.mcTutorialArrow_button.gotoAndStop("animOn");
               }
               break;
            case "activateFusionColor":
               _loc5_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._ID1);
               _loc4_ = dataM.itemsDB[_loc5_.itemID];
               _loc32_ = _loc4_.fullName;
               if(dataM.languageID == 2)
               {
                  _loc32_ = getSpecificText("item_" + _loc4_.itemID);
               }
               _loc33_ = getScreenText("fusionColorItem");
               _loc33_ = dataM.replaceStringInText(_loc33_,"%NAME%",_loc32_);
               this.setText(_loc33_);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "destroyingMythicalItem_fusion":
            case "destroyingMythicalItem_craft":
               _loc34_ = getScreenText("destroyingMythicalItem");
               _loc34_ = dataM.replaceStringInText(_loc34_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_BAD + "\'>");
               _loc34_ = dataM.replaceStringInText(_loc34_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>");
               this.setText(_loc34_);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "cannotUpgradeItemWithNoDamage":
               this.setText("<BR>" + getSpecificText("hanger_fusionItemDealsNoDamage"));
               this.btnOKOnly.visible = true;
               break;
            case "tryToBuy1BattleCredit":
               _loc35_ = getScreenText("buy1BattleCredit");
               _loc35_ = dataM.replaceStringInText(_loc35_,"%GOLD%",dataM.getNumberWithComma(dataM.getBattleCreditX1Cost()));
               _loc35_ = dataM.replaceStringInText(_loc35_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               this.setText(_loc35_);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "tryToBuy6BattleCredits":
               _loc36_ = getScreenText("buy6BattleCredits");
               _loc36_ = dataM.replaceStringInText(_loc36_,"%GOLD%",dataM.getNumberWithComma(dataM.getBattleCreditX6Cost()));
               _loc36_ = dataM.replaceStringInText(_loc36_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               _loc36_ = dataM.replaceStringInText(_loc36_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               this.setText(_loc36_);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "battleCreditsBought":
               this.setText(getScreenText("battleCreditsBought"));
               this.btnOKOnly.visible = true;
               break;
            case "notEnoughGoldForBattleCredit":
               this.setText(getScreenText("notEnoughGoldForBattleCredit"));
               this.btnOKOnly.visible = true;
               break;
            case "noBattleCreditsLeft":
               this.setText(getScreenText("noBattleCreditsLeft"));
               this.btnOKOnly.visible = true;
               break;
            case "playerHasJoinedAClan":
               _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc37_ = getScreenText("playerHasJoinedAClan");
               _loc37_ = dataM.replaceStringInText(_loc37_,"%NAME%",_loc9_.clan_name);
               this.setText(_loc37_);
               this.btnOKOnly.visible = true;
               break;
            case "playerHasBeenKicked":
               this.setText(getScreenText("playerHasBeenKicked"));
               this.btnOKOnly.visible = true;
               break;
            case "tryToLeaveClan":
               this.setText(getScreenText("tryToLeaveClan"));
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "playerHasLeftClan":
               this.setText(getScreenText("playerHasLeftClan"));
               this.btnOKOnly.visible = true;
               break;
            case "tryToKickMember":
               _loc38_ = getScreenText("tryToKickMember");
               _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc39_ = _loc9_.clan_members[this._ID1].name;
               _loc38_ = dataM.replaceStringInText(_loc38_,"%NAME%",_loc39_);
               this.setText(_loc38_);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "clanCreated":
               this.setText(getScreenText("clanCreated"));
               this.btnOKOnly.visible = true;
               break;
            case "clanNameUnavailable":
               _loc40_ = getScreenText("clanNameUnavailable");
               _loc40_ = dataM.replaceStringInText(_loc40_,"%NAME%",screensM.screenClanCreate.txtInputName.text);
               this.setText(_loc40_);
               this.btnOKOnly.visible = true;
               break;
            case "clanNameTooShort":
               this.setText(getScreenText("clanNameTooShort"));
               this.btnOKOnly.visible = true;
               break;
            case "requestSentToClan":
               _loc41_ = getScreenText("requestSentToClan");
               _loc41_ = dataM.replaceStringInText(_loc41_,"%NAME%",dataM.clansRankingList[this._ID1].clanName);
               this.setText(_loc41_);
               this.btnOKOnly.visible = true;
               break;
            case "joinClanRequestNotValid":
               this.setText(getScreenText("joinClanRequestNotValid"));
               this.btnOKOnly.visible = true;
               break;
            case "newClanMember":
               _loc42_ = getScreenText("newClanMember");
               _loc42_ = dataM.replaceStringInText(_loc42_,"%NAME%",this.urgentMessageClanMemberName);
               this.setText(_loc42_);
               this.btnOKOnly.visible = true;
               break;
            case "clanMemberLeft":
               _loc43_ = getScreenText("clanMemberLeft");
               _loc43_ = dataM.replaceStringInText(_loc43_,"%NAME%",this.urgentMessageClanMemberName);
               this.setText(_loc43_);
               this.btnOKOnly.visible = true;
               break;
            case "notClanLeader":
               this.setText(getScreenText("notClanLeader"));
               this.btnOKOnly.visible = true;
               break;
            case "notInClan":
               this.setText(getScreenText("notInClan"));
               this.btnOKOnly.visible = true;
               break;
            case "invitingPlayerToClan":
               this.setText(getScreenText("invitingPlayerToClan"));
               this.mcSandClock.gotoAndStop("animOn");
               this.btnCancelOnly.visible = true;
               break;
            case "playerHasDeclinedInvitation":
               this.setText(getScreenText("playerHasDeclinedInvitation"));
               this.btnOKOnly.visible = true;
               break;
            case "playerAlreadyInClan":
               this.setText(getScreenText("playerAlreadyInClan"));
               this.btnOKOnly.visible = true;
               break;
            case "clanIsFull":
               this.setText(getScreenText("clanIsFull"));
               this.btnOKOnly.visible = true;
               break;
            case "clanSearch":
               this.setText(getScreenText("clanSearch"));
               this.txtInput1.visible = true;
               this.mcInputText1Background.visible = true;
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "clanSearchNoResults":
               this.setText(getScreenText("clanSearchNoResults"));
               this.btnOKOnly.visible = true;
               break;
            case "clanSearchTextTooShort":
               this.setText(getScreenText("clanSearchTextTooShort"));
               this.btnOKOnly.visible = true;
               break;
            case "createOrJoinAClan":
               _loc44_ = "<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>";
               _loc45_ = getScreenText("createOrJoinAClan");
               _loc45_ = dataM.replaceStringInText(_loc45_,"%COLOR%",_loc44_);
               this.setText(_loc45_);
               this.btnOKOnly.visible = true;
               break;
            case "clanNotEnoughGold":
               _loc46_ = getScreenText("clanNotEnoughGold");
               _loc46_ = dataM.replaceStringInText(_loc46_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               _loc46_ = dataM.replaceStringInText(_loc46_,"%GOLD%",dataM.getNumberWithComma(dataM.createClanCost));
               this.setText(_loc46_);
               this.btnOKOnly.visible = true;
               break;
            case "clanWinsRewardGold":
               _loc47_ = getScreenText("clanWinsRewardGold");
               _loc47_ = dataM.replaceStringInText(_loc47_,"%BATTLES%",dataM.getNumberWithComma(dataM.clanWinsWinsRequired));
               _loc47_ = dataM.replaceStringInText(_loc47_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               _loc47_ = dataM.replaceStringInText(_loc47_,"%REWARD%",dataM.getNumberWithComma(dataM.clanWinsRewardValue));
               this.setText(_loc47_);
               this.mcIconGoldRewardClan.visible = true;
               this.btnOKOnly.visible = true;
               _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc9_.gold += _loc9_.clan_winsRewardGold;
               _loc9_.clan_winsRewardGold = 0;
               break;
            case "clanWinsRewardBattleCredits":
               _loc48_ = getScreenText("clanWinsRewardBattleCredits");
               _loc48_ = dataM.replaceStringInText(_loc48_,"%BATTLES%",dataM.getNumberWithComma(dataM.clanWinsWinsRequired));
               _loc48_ = dataM.replaceStringInText(_loc48_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               _loc48_ = dataM.replaceStringInText(_loc48_,"%REWARD%",dataM.getNumberWithComma(dataM.clanWinsRewardValue));
               this.setText(_loc48_);
               this.mcIconBattleCredits.visible = true;
               this.btnOKOnly.visible = true;
               _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc9_.battleCredits += _loc9_.clan_winsRewardBattleCredits;
               _loc9_.clan_winsRewardBattleCredits = 0;
               if(screensM.isScreenOpened("screenTopBar"))
               {
                  screensM.screenTopBar.refreshBattleCredits();
               }
               break;
            case "newItemsCreated":
               this.setText(getScreenText("newItemsCreated"));
               this.btnOKOnly.visible = true;
               _loc64_ = 0;
               while(_loc64_ < dataM.newItemsCreated.length)
               {
                  _loc65_ = dataM.newItemsCreated[_loc64_];
                  dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,_loc65_.itemID,_loc65_.playerItemID,0,0,_loc65_.power);
                  _loc64_++;
               }
               dataM.newItemsCreated = new Array();
               break;
            case "mythicalItemDestroyed":
               this.setText(getScreenText("mythicalItemDestroyed"));
               this.mcIconDurability.visible = true;
               this.btnOKOnly.visible = true;
               break;
            case "mythicalItemsDestroyed":
               this.setText(getScreenText("mythicalItemsDestroyed"));
               this.mcIconDurability.visible = true;
               this.btnOKOnly.visible = true;
               break;
            case "searchForPlayerFailed":
               this.setText(getScreenText("searchForPlayerFailed"));
               this.btnOKOnly.visible = true;
               break;
            case "quitBattleVSComputer":
               this.setText(getScreenText("quitSPBattle"));
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "quitBattleVSMission":
               this.setText(getScreenText("quitMissionBattle"));
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "quitBattleVSPlayer":
               this.setText("<FONT COLOR=\'#" + dataM.COLOR_BAD + "\'>" + getScreenText("quitMPBattle"));
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "exitingBattle":
               this.setText(getScreenText("exitingBattle"));
               break;
            case "mechIsNotReady":
               this.setText(getScreenText("mechNotReadyForBattle"));
               this.btnHanger.visible = true;
               break;
            case "mechIsNotReadyTextOnly":
               this.setText(getScreenText("mechNotReadyForBattle"));
               this.btnOKOnly.visible = true;
               break;
            case "opponentQuitOnFirstRoundNoReward":
               this.setText(getScreenText("noRewardDueToQuit"));
               this.btnOKOnly.y = this._btnOKOnlyOriginYPos - 30;
               this.btnOKOnly.visible = true;
               break;
            case "battleInvitationPlayerNotFound":
               this.setText(getScreenText("playerOffline"));
               this.btnCancelOnly.visible = true;
               break;
            case "battleInvitationSent":
               this.setText(getScreenText("invitationSent"));
               this.mcSandClock.gotoAndStop("animOn");
               this.btnCancelOnly.visible = true;
               break;
            case "battleInvitationCancelling":
               this.setText(getScreenText("cancelingInvitation"));
               break;
            case "battleInvitationDeclined":
               this.setText(getScreenText("invitationDeclined"));
               this.btnOKOnly.visible = true;
               break;
            case "playerHasLeftChat":
               this.setText(getScreenText("playerHasLeftChat"));
               this.btnOKOnly.visible = true;
               break;
            case "invitationPlayerOffline":
               this.setText(getScreenText("invitationFailed"));
               this.btnCancel.visible = true;
               break;
            case "boostsHaveBeenModified":
               this.setText(getScreenText("boostsHaveBeenModified"));
               this.btnOKOnly.visible = true;
               break;
            case "sendTokens":
               _loc49_ = getScreenText("sendTokens");
               _loc49_ = dataM.replaceStringInText(_loc49_,"%TOKENS%","<FONT COLOR=\'#" + dataM.COLOR_BAD + "\'>" + dataM.getNumberWithComma(this._ID1) + "</FONT>");
               _loc49_ = dataM.replaceStringInText(_loc49_,"%NAME%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>" + screensM.screenSendTokensToPlayer.txtName.text + "</FONT>");
               this.setText(_loc49_);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "tokensSent":
               this.setText(getScreenText("tokensSent"));
               this.btnOKOnly.visible = true;
               break;
            case "newNotification":
               _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc50_ = _loc9_.notifications[0];
               _loc51_ = getScreenText("gotTokensNotification");
               _loc51_ = dataM.replaceStringInText(_loc51_,"%NAME%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>" + _loc50_.fromPlayerName + "</FONT>");
               _loc51_ = dataM.replaceStringInText(_loc51_,"%TOKENS%","<FONT COLOR=\'#" + dataM.COLOR_BAD + "\'>" + _loc50_.amount + "</FONT>");
               this.setText(_loc51_);
               this.btnOKOnly.visible = true;
               break;
            case "noFreeBoxes":
               this.setText(getScreenText("noFreeBoxes"));
               this.btnOKOnly.visible = true;
               break;
            case "activateWeeklyReset":
               this.setText("Activate weekly reset?");
               this.txtInput1.visible = true;
               this.mcInputText1Background.visible = true;
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "openAdminTools":
               this.setText("Enter password:");
               this.txtInput1.visible = true;
               this.mcInputText1Background.visible = true;
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "setResetBoostsTimeSuccess":
               this.setText("Boosts reset time updated");
               this.txtInput1.visible = true;
               this.txtInput1.text = String(this._ID1);
               this.btnOKOnly.visible = true;
               break;
            case "updateBoostSuccess":
               this.setText("Boost updated");
               this.btnOKOnly.visible = true;
               break;
            case "admin_sendFreeBoostsFailed":
               this.setText("<FONT COLOR = \'#" + dataM.COLOR_BAD + "\'>Sending free boosts failed!</FONT>");
               this.btnOKOnly.visible = true;
               break;
            case "admin_sendFreeBoostsSuccess":
               this.setText("Sending free boosts success!");
               this.btnOKOnly.visible = true;
               break;
            case "admin_sendItemFailed":
               this.setText("<FONT COLOR = \'#" + dataM.COLOR_BAD + "\'>Sending item failed!</FONT>");
               this.btnOKOnly.visible = true;
               break;
            case "admin_sendItemSuccess":
               this.setText("Sending item success!");
               this.btnOKOnly.visible = true;
               break;
            case "admin_alertServerRestartSent":
               this.setText("Alert server restart request sent");
               this.btnOKOnly.visible = true;
               break;
            case "admin_forceItemsUpdateSent":
               this.setText("Force items update request sent");
               this.btnOKOnly.visible = true;
               break;
            case "alreadyLoggedIn":
               this.setText(getScreenText("alreadyLoggedIn"));
               break;
            case "notLoggedIn":
               this.setText(getScreenText("notLoggedIn"));
               this.btnOKOnly.visible = true;
               break;
            case "connectionLost":
               if(screensM.isScreenOpened("screenBattle"))
               {
                  screensM.screenBattle.clientDisconnected();
               }
               this.setText(getScreenText("connectionLost"));
               this.btnOKOnly.visible = true;
               break;
            case "errorOccured":
               this.setText(getScreenText("errorOccured"));
               break;
            case "playerDoesNotExist":
               this.setText(getScreenText("playerDoesNotExist"));
               this.btnOKOnly.visible = true;
               break;
            case "clanDoesNotExist":
               this.setText(getScreenText("clanDoesNotExist"));
               this.btnOKOnly.visible = true;
               break;
            case "buyTokens_thankYou":
               this.setText(getScreenText("buyTokens_thankYou"));
               this.btnOKOnly.visible = true;
               break;
            case "buyTokens_failed":
               this.setText(getScreenText("buyTokens_failed"));
               this.btnOKOnly.visible = true;
               break;
            case "buyTokens_canceled":
               this.setText(getScreenText("buyTokens_canceled"));
               this.btnOKOnly.visible = true;
               break;
            case "buyTokens_cannotBeCompleted":
               this.setText(getScreenText("buyTokens_cannotBeCompleted"));
               this.btnOKOnly.visible = true;
               break;
            case "buyStarterPack":
               _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc52_ = getScreenText("buyStarterPack");
               _loc52_ = dataM.replaceStringInText(_loc52_,"%PRICE%","<FONT COLOR=\'#" + dataM.COLOR_TOKENS + "\'>" + _loc9_.starterPackData.price + "</FONT>");
               this.setText(_loc52_);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "buyPackage":
               _loc7_ = dataM.boostsDB[this._ID1];
               switch(_loc7_.type)
               {
                  case "resources":
                     _loc66_ = getScreenText("buyCredits");
                     _loc66_ = dataM.replaceStringInText(_loc66_,"%GOLD%",dataM.getNumberWithComma(_loc7_.bonusGold));
                     _loc66_ = dataM.replaceStringInText(_loc66_,"%TOKENS%",dataM.getNumberWithComma(_loc7_.costTokens));
                     _loc66_ = dataM.replaceStringInText(_loc66_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
                     _loc66_ = dataM.replaceStringInText(_loc66_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_TOKENS + "\'>");
                     this.setText(_loc66_);
                     break;
                  case "premiumAccount":
                     switch(this._ID1)
                     {
                        case 1:
                           _loc67_ = getScreenText("buyPremiumAccountXDays");
                           _loc67_ = dataM.replaceStringInText(_loc67_,"%DAYS%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>30</FONT>");
                           break;
                        case 8:
                           _loc67_ = getScreenText("buyPremiumAccount1Day");
                           break;
                        case 10:
                           _loc67_ = getScreenText("buyPremiumAccountXDays");
                           _loc67_ = dataM.replaceStringInText(_loc67_,"%DAYS%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>7</FONT>");
                     }
                     _loc67_ = dataM.replaceStringInText(_loc67_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
                     _loc67_ = dataM.replaceStringInText(_loc67_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_TOKENS + "\'>");
                     _loc67_ = dataM.replaceStringInText(_loc67_,"%TOKENS%",dataM.getNumberWithComma(_loc7_.costTokens));
                     this.setText(_loc67_);
                     break;
                  case "specificItem":
                     _loc68_ = dataM.itemsDB[_loc7_.itemID];
                     _loc69_ = getScreenText("buySpecificItem");
                     _loc70_ = dataM.COLOR_LEGENDARY_ITEM;
                     if(_loc68_.specialStatus == 4)
                     {
                        _loc70_ = dataM.COLOR_MYTHICAL_ITEM;
                     }
                     _loc69_ = dataM.replaceStringInText(_loc69_,"%NAME%","<FONT COLOR=\'#" + _loc70_ + "\'>" + _loc68_.fullName + "</FONT>");
                     _loc69_ = dataM.replaceStringInText(_loc69_,"%TOKENS%","<FONT COLOR=\'#" + dataM.COLOR_TOKENS + "\'>" + _loc7_.costTokens + "</FONT>");
                     this.setText(_loc69_);
                     break;
                  case "randomItems":
                     _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                     _loc72_ = _loc7_.amount;
                     _loc73_ = _loc9_.level - _loc7_.levelDifference;
                     _loc74_ = _loc9_.level + _loc7_.levelDifference;
                     if(_loc73_ < 2)
                     {
                        _loc73_ = 2;
                     }
                     if(_loc9_.level >= dataM.levelForExpandedItemBox)
                     {
                        _loc73_ = dataM.levelForExpandedItemBox;
                        _loc74_ = dataM.LEVEL_MAX;
                     }
                     if(_loc7_.ratioMythical == 100)
                     {
                        if(_loc7_.amount == 1)
                        {
                           _loc71_ = getScreenText("buyItemsBoxMythical");
                        }
                        else
                        {
                           _loc71_ = getScreenText("buyItemsBoxMythicals");
                        }
                        _loc76_ = _loc7_.costTokens;
                        _loc75_ = dataM.COLOR_TOKENS;
                     }
                     else if(_loc7_.costGold > 0)
                     {
                        _loc71_ = getScreenText("buyItemsBoxGold");
                        _loc76_ = _loc7_.costGold;
                        _loc75_ = dataM.COLOR_GOLD;
                     }
                     else
                     {
                        _loc71_ = getScreenText("buyItemsBoxTokens");
                        _loc76_ = _loc7_.costTokens;
                        _loc75_ = dataM.COLOR_TOKENS;
                     }
                     _loc71_ = dataM.replaceStringInText(_loc71_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
                     _loc71_ = dataM.replaceStringInText(_loc71_,"%COLOR2%","<FONT COLOR=\'#" + _loc75_ + "\'>");
                     if(_loc7_.ratioMythical == 100)
                     {
                        _loc71_ = dataM.replaceStringInText(_loc71_,"%COLOR3%","<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>");
                     }
                     _loc71_ = dataM.replaceStringInText(_loc71_,"%TOKENS%",dataM.getNumberWithComma(_loc76_));
                     _loc71_ = dataM.replaceStringInText(_loc71_,"%ITEMS%",String(_loc72_));
                     _loc71_ = dataM.replaceStringInText(_loc71_,"%LEVELS%",_loc73_ + " - " + _loc74_);
                     this.setText(_loc71_);
               }
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "buyPackageFailed_packageChanged":
               this.setText(getScreenText("buyPackageFailed_packageChanged"));
               this.btnOKOnly.visible = true;
               break;
            case "buyingPackage":
               this.setText(getScreenText("pleaseWait"));
               this.mcSandClock.gotoAndStop("animOn");
               break;
            case "packageBought":
               _loc7_ = dataM.boostsDB[this._ID1];
               _loc53_ = getScreenText("creditsPackageBought");
               _loc53_ = dataM.replaceStringInText(_loc53_,"%GOLD%",dataM.getNumberWithComma(_loc7_.bonusGold));
               _loc53_ = dataM.replaceStringInText(_loc53_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               this.setText(_loc53_);
               this.btnOKOnly.visible = true;
               break;
            case "premiumAccountXDaysBought":
               _loc54_ = getScreenText("premiumAccountXDaysBought");
               switch(this._ID1)
               {
                  case 1:
                     _loc54_ = dataM.replaceStringInText(_loc54_,"%DAYS%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>30</FONT>");
                     break;
                  case 10:
                     _loc54_ = dataM.replaceStringInText(_loc54_,"%DAYS%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>7</FONT>");
               }
               this.setText("<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>" + _loc54_);
               this.btnOKOnly.visible = true;
               break;
            case "premiumAccount1DayBought":
               this.setText("<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>" + getScreenText("premiumAccount1DayBought"));
               this.btnOKOnly.visible = true;
               break;
            case "notEnoughTokens_noValue":
               this.setText(getScreenText("notEnoughTokens_noValue"));
               this.btnOKOnly.visible = true;
               break;
            case "notEnoughTokens":
               if(screensM.isScreenOpened("screenBuyMissions"))
               {
                  _loc55_ = this._ID1;
               }
               else
               {
                  _loc7_ = dataM.boostsDB[this._ID1];
                  _loc55_ = _loc7_.costTokens;
               }
               _loc56_ = getScreenText("notEnoughTokens");
               _loc56_ = dataM.replaceStringInText(_loc56_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_TOKENS + "\'>");
               _loc56_ = dataM.replaceStringInText(_loc56_,"%TOKENS%",String(_loc55_));
               this.setText(_loc56_);
               if(dataM.isTutorialActive() == false)
               {
                  this.btnCancel.visible = true;
                  this.btnGetTokens.visible = true;
               }
               else
               {
                  this.btnOKOnly.visible = true;
               }
               break;
            case "notEnoughGold":
               _loc7_ = dataM.boostsDB[this._ID1];
               _loc57_ = getScreenText("notEnoughGold");
               _loc57_ = dataM.replaceStringInText(_loc57_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               _loc57_ = dataM.replaceStringInText(_loc57_,"%GOLD%",dataM.getNumberWithComma(dataM.getBoostGoldCost(this._ID1)));
               this.setText(_loc57_);
               this.btnOKOnly.visible = true;
               break;
            case "refreshBrowserAfterBuyingTokens":
               this.setText(getScreenText("refreshBrowserForTokens"));
               this.btnCancelOnly.visible = true;
               this.mcSandClock.gotoAndStop("animOn");
               break;
            case "replayEnded_battleOver":
               _loc9_ = dataM["player" + dataM["player" + this._ID1 + "PlayerID"] + "Profile"];
               this.setText("<BR><BR>" + _loc9_.playerName + getScreenText("replayPlayerWon"));
               this.btnOKOnly.visible = true;
               this.btnOKOnly.y = this._btnOKOnlyOriginYPos - 30;
               if(screensM.isScreenOpened("screenBattleOptions"))
               {
                  screensM.removeScreen("screenBattleOptions");
               }
               break;
            case "replayEnded_playerQuit":
               _loc9_ = dataM["player" + dataM["player" + this._ID1 + "PlayerID"] + "Profile"];
               this.setText("<BR><BR>" + _loc9_.playerName + getScreenText("replayPlayerQuit"));
               this.btnOKOnly.visible = true;
               this.btnOKOnly.y = this._btnOKOnlyOriginYPos - 30;
               if(screensM.isScreenOpened("screenBattleOptions"))
               {
                  screensM.removeScreen("screenBattleOptions");
               }
               break;
            case "changeName":
               if(this._ID1 == 0)
               {
                  _loc58_ = getScreenText("changeNameForFree");
                  _loc58_ = dataM.replaceStringInText(_loc58_,"%NAME%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>" + screensM.screenChangeName.txtInputName.text + "</FONT>");
               }
               else
               {
                  _loc58_ = getScreenText("changeNameForTokens");
                  _loc58_ = dataM.replaceStringInText(_loc58_,"%NAME%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>" + screensM.screenChangeName.txtInputName.text + "</FONT>");
                  _loc58_ = dataM.replaceStringInText(_loc58_,"%TOKENS%","<FONT COLOR=\'#" + dataM.COLOR_TOKENS + "\'>" + dataM.getNumberWithComma(this._ID1) + "</FONT>");
               }
               this.setText(_loc58_);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "nameChanged":
               this.setText(getScreenText("nameChanged"));
               this.btnOKOnly.visible = true;
               break;
            case "ageVerification":
               this.setText(getScreenText("ageVerificationTitle"));
               this.txtInput1.y -= 20;
               this.mcInputText1Background.y -= 20;
               this.mcTutorialArrow_inputName.y -= 20;
               this.mcBackground.width += 140;
               this.txtTermsOfUse.y = this.originYPos_txtTermsOfUse - 26;
               switch(dataM.languageID)
               {
                  case 5:
                     this.txtTermsOfUse.y -= 4;
               }
               this.mcErrorMarkTermsOfUse.y = this.originYPos_mcErrorMarkTermsOfUse - 40;
               this.mcV.y = this.originYPos_mcV - 40;
               this.mcVFrame.y = this.originYPos_mcVFrame - 40;
               this.mcVMouseHitArea.y = this.originYPos_mcVMouseHitArea - 40;
               this.mcTermsOfUseBackground.y = this.originYPos_mcTermsOfUseBackground - 40;
               this.showAgeVerificationText();
               this.txtTermsOfUse.visible = true;
               this.mcVMouseHitArea.visible = true;
               this.mcTermsOfUseBackground.visible = true;
               this.mcVFrame.visible = true;
               this.mcTermsOfUseLinkHitArea1.visible = true;
               this.mcTermsOfUseLinkHitArea2.visible = true;
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "skipTutorial":
               this.setText(getScreenText("skipTutorial"));
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "skipChallenge":
               this.setText(getScreenText("skipChallenge"));
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "serverNotification":
               this.setText(this.serverNotification_text);
               this.btnOKOnly.visible = true;
               break;
            case "changePlayerName_online":
            case "changePlayerNameAndTermsOfUse_online":
               this.setText(getScreenText("enterNickname"));
               this.txtInput1.visible = true;
               if(false == false)
               {
                  _loc9_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
                  _loc77_ = _loc9_.playerName;
                  if(_loc77_ != "" && _loc77_ != "username")
                  {
                     this.txtInput1.text = _loc77_;
                  }
               }
               this._focusInputTextOnNextFrame = true;
               this.mcInputText1Background.visible = true;
               this.btnOKOnly.visible = true;
               keyboardM.setKeyboardOutputFunction(this.keyboardOutput,"screenConfirmation changePlayerName");
               keyboardM.activateMe("screenConfirmation");
               switch(this._questionOrNotificationType)
               {
                  case "changePlayerNameAndTermsOfUse_online":
                     this.txtInput1.y -= 20;
                     this.mcInputText1Background.y -= 20;
                     this.mcTutorialArrow_inputName.y -= 20;
                     this.mcBackground.width += 140;
                     this.showTermsOfUseText();
                     this.txtTermsOfUse.y = this.originYPos_txtTermsOfUse;
                     switch(dataM.languageID)
                     {
                        case 5:
                           this.txtTermsOfUse.y -= 4;
                     }
                     this.mcErrorMarkTermsOfUse.y = this.originYPos_mcErrorMarkTermsOfUse;
                     this.mcV.y = this.originYPos_mcV;
                     this.mcVFrame.y = this.originYPos_mcVFrame;
                     this.mcVMouseHitArea.y = this.originYPos_mcVMouseHitArea;
                     this.mcTermsOfUseBackground.y = this.originYPos_mcTermsOfUseBackground;
                     this.txtTermsOfUse.visible = true;
                     this.mcVMouseHitArea.visible = true;
                     this.mcTermsOfUseBackground.visible = true;
                     this.mcVFrame.visible = true;
                     this.mcTermsOfUseLinkHitArea1.visible = true;
                     this.mcTermsOfUseLinkHitArea2.visible = true;
               }
               break;
            case "goldBought":
               _loc59_ = getScreenText("goldBought");
               _loc59_ = dataM.replaceStringInText(_loc59_,"%GOLD%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>" + dataM.getNumberWithComma(this._ID1) + "</FONT>");
               _loc59_ = dataM.replaceStringInText(_loc59_,"%TOKENS%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>" + dataM.getNumberWithComma(this._ID2) + "</FONT>");
               this.setText(_loc59_);
               this.btnOKOnly.visible = true;
               break;
            case "logout":
               this.setText(getScreenText("logout"));
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "loggingOut":
               this.setText(getScreenText("loggingOut"));
               addEventListener(Event.ENTER_FRAME,this.logoutOnEnterFrame);
               break;
            case "pleaseWait":
               this.setText(getScreenText("pleaseWait"));
               this.mcSandClock.gotoAndStop("animOn");
               break;
            case "pleaseWaitFacebookWeb":
               this.setText(getScreenText("pleaseWaitFacebookWeb"));
               this.mcSandClock.gotoAndStop("animOn");
               break;
            case "youWereChatBlocked":
               this.setText(getScreenText("youWereChatBlocked"));
               this.btnOKOnly.visible = true;
               break;
            case "savingMech":
               this.setText(getScreenText("savingMech"));
               break;
            case "mustExitSearchForBattle":
               this.setText(getScreenText("mustExitSearchForBattle"));
               this.btnOKOnly.visible = true;
               break;
            case "mustRegister":
               if(param2 == 1)
               {
                  this.setText(getScreenText("mustRegisterForStarterPacks"));
               }
               else
               {
                  this.setText(dataM.replaceStringInText(getScreenText("pleaseRegister"),"%COLOR%",dataM.COLOR_GOLD));
               }
               this.btnRegister.visible = true;
               this.btnLater.visible = true;
               break;
            case "mustRegisterInventoryBlocked":
               this.setText(getScreenText("guestMaxItems"));
               this.btnRegister.visible = true;
               this.btnLater.visible = true;
               break;
            case "mustRegisterMaxLevel":
               this.setText(getScreenText("guestMaxLevel"));
               this.btnRegister.visible = true;
               this.btnLater.visible = true;
               break;
            case "mustRegisterMaxGold":
               this.setText(getScreenText("guestMaxCredits"));
               this.btnRegister.visible = true;
               this.btnLater.visible = true;
               break;
            case "cantRegisterTooMuchGold":
               _loc60_ = getScreenText("guestCantRegisterTooMuchGold");
               _loc61_ = "<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>" + dataM.getNumberWithComma(dataM.GUEST_MAX_GOLD) + "</FONT>";
               this.setText(dataM.replaceStringInText(_loc60_,"%GOLD%",_loc61_));
               this.btnCancelOnly.visible = true;
               break;
            case "cantRegisterTooManyItems":
               _loc62_ = getScreenText("guestCantRegisterTooManyItems");
               _loc63_ = "<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>" + String(dataM.GUEST_MAX_ITEMS) + "</FONT>";
               this.setText(dataM.replaceStringInText(_loc62_,"%ITEMS%",_loc63_));
               this.btnCancelOnly.visible = true;
               break;
            case "cantRegisterNoInternetConnection":
               this.setText(getScreenText("cantRegisterNoInternetConnection"));
               this.btnCancelOnly.visible = true;
               break;
            case "playingOnDev":
               this.setText("<FONT SIZE = \'14\'>" + getScreenText("developmentClient") + "WWW.SUPERMECHS.COM.");
               this.btnOKOnly.visible = true;
               break;
            case "clientIsNotUpToDate":
               if(dataM.runAsMobile)
               {
                  _loc78_ = "ios";
                  switch(_loc78_)
                  {
                     case "ios":
                        this.setText(getScreenText("clientNotUpToDate_mobileIOS"));
                        break;
                     case "android":
                        this.setText(getScreenText("clientNotUpToDate_mobileAndroid"));
                  }
                  this.btnAppStore.visible = true;
               }
               else
               {
                  this.setText("<FONT SIZE = \'14\'>" + getScreenText("clientNotUpToDate") + "</FONT><FONT  SIZE=\'14\' COLOR=\'#" + dataM.COLOR_GOLD + "\'><A href=\'http://www.supermechs.com\'>WWW.SUPERMECHS.COM</A>");
                  this.btnSuperMechs.visible = true;
               }
               break;
            case "customYesNoQuestion":
               this.setText(this.customConfirmationText);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "customMessage":
               this.setText(this.customConfirmationText);
               this.btnOKOnly.visible = true;
               break;
            case "customLoading":
               this.setText("<br><br><br><br>" + this.customConfirmationText);
               this.mcSandClock.gotoAndStop("animOn");
               break;
            case "customLockedMessage":
               this.setText(this.customConfirmationText);
         }
         this.mcBackground.x = dataM.STAGE_WIDTH / 2 - this.mcBackground.width / 2;
         if(dataM.runAsMobile)
         {
            _loc79_ = [this.txtNotification,this.txtBuySell,this.txtGold,this.txtTokens,this.txtGoldReward,this.txtTermsOfUse];
            screensM.createMultipleTextsBitmap("confirmation_texts",_loc79_,"",this);
         }
         screensM.addScreen("screenConfirmation");
      }
      
      private function languageUpdate() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc1_ = 33;
            _loc2_ = 18;
            _loc3_ = 20;
            _loc4_ = 33;
            switch(dataM.languageID)
            {
               case 4:
                  _loc4_ = 28;
                  break;
               case 5:
                  _loc1_ = 25;
                  _loc2_ = 14;
                  _loc3_ = 17;
                  break;
               case 7:
                  _loc3_ = 22;
                  break;
               case 9:
                  _loc2_ = 17;
                  _loc3_ = 18;
            }
            TextUtils.updateTextFormat(this.txtBuySell,20);
            TextUtils.updateTextFormat(this.txtGold,20);
            TextUtils.updateTextFormat(this.txtGoldReward,20);
            TextUtils.updateTextFormat(this.txtInput1,20);
            TextUtils.updateTextFormat(this.txtInput2,20);
            TextUtils.updateTextFormat(this.txtNotification,18);
            TextUtils.updateTextFormat(this.txtTermsOfUse,_loc2_);
            TextUtils.updateTextFormat(this.txtTokens,20);
            TextUtils.updateTextFormat(this.btnRegister.txtButtonName);
            TextUtils.updateTextFormat(this.btnHanger.txtButtonName);
            TextUtils.updateTextFormat(this.btnLater.txtButtonName);
            TextUtils.updateTextFormat(this.btnOKOnly.txtButtonName);
            this.btnRegister.changeFontSize(_loc1_);
            this.btnHanger.changeFontSize(_loc3_);
            this.btnLater.changeFontSize(33);
            this.btnOKOnly.changeFontSize(_loc4_);
            this.btnRegister.setButtonName(getGeneralText("register"));
            this.btnHanger.setButtonName(getScreenText("openWorkshop"));
            this.btnLater.setButtonName(getGeneralText("later"));
            if(dataM.runAsMobile)
            {
               TextUtils.updateTextFormat(this.btnAppStore.txtButtonName);
               this.btnAppStore.changeFontSize(33);
               this.btnAppStore.setButtonName(getScreenText("update"));
            }
         }
      }
      
      private function addItem(param1:BMItemData, param2:Number) : void
      {
         this.mcItem = new BMItem();
         this.mcItem.initialize(-1,this.mcPicture1Sizer.width,this.mcPicture1Sizer.height,externalAssetsM.getAsset(dataM.itemTypeSourceDB[param1.type],param1.grp),-1,-1,false,null,dataM.runAsMobile);
         this.mcItem.x = this.mcPicture1Sizer.x;
         this.mcItem.y = this.mcPicture1Sizer.y;
         if(param2 > 0)
         {
            dataM.colorItem(this.mcItem,param2);
         }
         addChild(this.mcItem);
      }
      
      public function cancelClicked() : void
      {
         var _loc3_:BMPlayerProfile = null;
         var _loc1_:String = "";
         var _loc2_:Boolean = false;
         this._ID1 = -1;
         this._ID2 = -1;
         switch(this._questionOrNotificationType)
         {
            case "battleInvitationSent":
               _loc1_ = "battleInvitationCancelling";
               remoteM.lobby_battleInvitation_canceled();
               break;
            case "missionRevive":
               _loc1_ = "abortMission";
               break;
            case "abortMission":
               _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(_loc3_.mission_hp == 0)
               {
                  _loc1_ = "missionRevive";
               }
               break;
            case "quitBattleVSPlayer":
            case "quitBattleVSComputer":
            case "quitBattleVSMission":
               screensM.screenBattle.quitCancelled();
               _loc2_ = true;
               break;
            case "activateFusionPower":
            case "activateFusionColor":
            case "destroyingMythicalItem_fusion":
            case "cannotUpgradeItemWithNoDamage":
               screensM.screenHangerFusion.fusionCancelled();
               break;
            case "destroyingMythicalItem_craft":
               screensM.screenHangerFusion.craftingCancelled();
               break;
            case "invitingPlayerToClan":
               remoteM.socketM.clan_cancelInvitation();
               _loc1_ = "pleaseWait";
               break;
            case "customYesNoQuestion":
               this.finishCustomYesNoConfirmationScreen(false);
               break;
            case "refreshBrowserAfterBuyingTokens":
               dataM.refreshBrowserAfterBuyingTokensCancelClicked();
         }
         if(_loc1_ == "")
         {
            screensM.removeScreen("screenConfirmation");
            if(_loc2_)
            {
               screensM.stagePointer.focus = screensM.screenBattle;
            }
         }
         else
         {
            this.displayQuestionOrNotification(_loc1_,-1,-1);
         }
      }
      
      private function finishCustomYesNoConfirmationScreen(param1:Boolean) : void
      {
         screensM.removeScreen("screenConfirmation");
         var _loc2_:* = this.customConfirmationHandler;
         this.customConfirmationHandler = null;
         this.customConfirmationText = null;
         _loc2_(param1);
      }
      
      private function finishCustomMessageConfirmationScreen() : void
      {
         screensM.removeScreen("screenConfirmation");
         var _loc1_:* = this.customConfirmationHandler;
         this.customConfirmationHandler = null;
         this.customConfirmationText = null;
         if(_loc1_ != null)
         {
            _loc1_();
         }
      }
      
      public function hangerClicked() : void
      {
         screensM.removeScreen("screenConfirmation");
         screensM.screenNewMenu.hangerMechClicked();
      }
      
      public function confirmClicked() : void
      {
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:BMPlayerData = null;
         var _loc5_:uint = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Boolean = false;
         var _loc11_:Object = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:BMBoostData = null;
         var _loc15_:String = null;
         var _loc16_:uint = 0;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Boolean = false;
         var _loc1_:String = "";
         var _loc2_:Boolean = true;
         var _loc6_:Number = -1;
         var _loc7_:Number = -1;
         var _loc8_:String = "";
         switch(this._questionOrNotificationType)
         {
            case "newNotification":
               _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc9_ = Number(_loc3_.notifications[0].notificationID);
               remoteM.socketM.lobby_deleteNotification(_loc9_);
               _loc3_.notifications.splice(0,1);
               if(_loc3_.notifications.length > 0)
               {
                  this.displayUrgentMessage("newNotification");
               }
               break;
            case "sendTokens":
               screensM.screenSendTokensToPlayer.sendTokensAccepted();
               _loc1_ = "pleaseWait";
               break;
            case "changeName":
               remoteM.socketM.lobby_buyChangeName(screensM.screenChangeName.txtInputName.text);
               _loc1_ = "pleaseWait";
               break;
            case "missionFailed":
               screensM.screenMissionBaseMap.missionFailedClicked();
               break;
            case "abortMission":
               _loc10_ = false;
               if(dataM.isRewardedVideoAvailable(BMScreenWatchRewardedVideo.PLACEMENT_ABORT_MISSION))
               {
                  if(screensM.screenMissionBaseMap.getEnemiesDestroyed() > 0)
                  {
                     _loc10_ = true;
                  }
               }
               if(_loc10_)
               {
                  screensM.addScreen("screenWatchRewardedVideo");
                  screensM.screenWatchRewardedVideo.refreshScreen(screensM.screenWatchRewardedVideo.TYPE_ABORT_MISSION);
               }
               else
               {
                  screensM.screenMissionBaseMap.abortingMission();
                  _loc1_ = "pleaseWait";
               }
               break;
            case "missionRevive":
               _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(_loc3_.battleCredits > 0)
               {
                  if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
                  {
                     remoteM.socketM.mission_revive();
                     _loc1_ = "pleaseWait";
                  }
                  else
                  {
                     screensM.screenMissionBaseMap.reviveSuccessful();
                  }
               }
               else
               {
                  screensM.screenMissionBaseMap.notEnoughBattleCredits();
               }
               break;
            case "starterPackBought":
               screensM.screenBuyStarterPack.packBoughtSub();
               break;
            case "mustRedeemStarterPackMech":
               screensM.screenBuyStarterPack.forceToRedeemMech();
               break;
            case "onlineWinsRequiredForItemBox":
               screensM.screenMissionWorldMap.pointTemporarilyToMultiplayer();
               break;
            case "clanSearch":
               if(this.txtInput1.text.length < 3)
               {
                  _loc1_ = "clanSearchTextTooShort";
               }
               else
               {
                  remoteM.socketM.clan_searchClans(this.txtInput1.text);
                  _loc1_ = "pleaseWait";
               }
               break;
            case "clanSearchTextTooShort":
               _loc1_ = "clanSearch";
               break;
            case "clanSearchNoResults":
               _loc1_ = "clanSearch";
               break;
            case "requestSentToClan":
               screensM.screenSearchForClan.backClicked();
               break;
            case "tryToLeaveClan":
               remoteM.socketM.clan_leave();
               _loc1_ = "pleaseWait";
               break;
            case "tryToKickMember":
               _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc11_ = _loc3_.clan_members[this._ID1];
               remoteM.socketM.clan_kick(_loc11_.playerID);
               if(screensM.isScreenOpened("screenClan"))
               {
                  screensM.screenClan.resetSelectedMemberSlot();
               }
               if(screensM.isScreenOpened("screenMultiPlayerChat"))
               {
                  screensM.screenMultiPlayerChat.memberKickedFromClan(this._ID1);
               }
               _loc1_ = "pleaseWait";
               break;
            case "playerHasLeftClan":
               screensM.screenNewMenu.multiplayerChatClicked(false,true);
               break;
            case "tryToBuy1BattleCredit":
               _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc12_ = dataM.getBattleCreditX1Cost();
               if(_loc3_.gold >= _loc12_)
               {
                  if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
                  {
                     remoteM.socketM.ladderBattles_buyX1();
                     _loc1_ = "pleaseWait";
                  }
                  else
                  {
                     _loc3_.battleCredits += 1;
                     _loc3_.battleCreditsBought += 1;
                     _loc3_.gold -= dataM.battleCreditX1CostGold;
                     screensM.screenTopBar.refreshBattleCredits();
                     screensM.screenBuyBattleCredits.battleCreditsBought();
                  }
               }
               else
               {
                  screensM.screenBuyBattleCredits.backClicked();
                  screensM.screenTopBar.getGoldClicked();
                  screensM.screenBuyGold.reopenScreenBuyBattleCredits = true;
               }
               break;
            case "tryToBuy6BattleCredits":
               _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc13_ = dataM.getBattleCreditX6Cost();
               if(_loc3_.gold >= _loc13_)
               {
                  if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
                  {
                     remoteM.socketM.ladderBattles_buyX6();
                     _loc1_ = "pleaseWait";
                  }
                  else
                  {
                     _loc3_.battleCredits += 6;
                     _loc3_.battleCreditsBought += 6;
                     _loc3_.gold -= dataM.battleCreditX1CostGold;
                     screensM.screenTopBar.refreshBattleCredits();
                     screensM.screenBuyBattleCredits.battleCreditsBought();
                  }
               }
               else
               {
                  screensM.screenBuyBattleCredits.backClicked();
                  screensM.screenTopBar.getGoldClicked();
                  screensM.screenBuyGold.reopenScreenBuyBattleCredits = true;
               }
               break;
            case "clanNotEnoughGold":
               screensM.screenSearchForClan.createClanNotEnoughGoldOKClicked();
               break;
            case "rewardVideosGotTokens":
            case "rewardVideosGotGold":
            case "rewardVideosComeBackLater":
               if(screensM.isScreenOpened("screenWatchRewardedVideo"))
               {
                  screensM.screenWatchRewardedVideo.backClicked();
               }
               break;
            case "replayEnded_battleOver":
            case "replayEnded_playerQuit":
               screensM.screenBattle.endReplay();
               break;
            case "quitBattleVSPlayer":
               screensM.screenBattle.activateNextBattlePhase("endBattle_quitBattleVSPlayerConfirmed");
               _loc1_ = "pleaseWait";
               break;
            case "quitBattleVSComputer":
            case "quitBattleVSMission":
               screensM.screenBattle.activateNextBattlePhase("endBattle_quitBattleVSComputerConfirmed");
               break;
            case "activateFusionPower":
            case "activateFusionColor":
               _loc8_ = "fusionAccepted";
               _loc2_ = false;
               break;
            case "destroyingMythicalItem_fusion":
               _loc8_ = "fusionMythicalWarningAccepted";
               _loc2_ = false;
               break;
            case "destroyingMythicalItem_craft":
               screensM.screenHangerFusion.craftingAccepted();
               break;
            case "buyStarterPack":
               screensM.screenBuyStarterPack.buyConfirmed();
               _loc1_ = "buyingPackage";
               break;
            case "buyPackage":
               _loc14_ = dataM.boostsDB[this._ID1];
               if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
               {
                  _loc20_ = 0;
                  _loc21_ = 0;
                  if(_loc14_.type == "specificItem")
                  {
                     _loc20_ = _loc14_.itemID;
                     _loc21_ = _loc14_.costTokens;
                  }
                  remoteM.tokens_buyPackageNew(this._ID1,_loc20_,_loc21_);
                  _loc1_ = "buyingPackage";
               }
               else
               {
                  switch(_loc14_.type)
                  {
                     case "resources":
                        _loc1_ = "packageBought";
                        _loc6_ = this._ID1;
                        break;
                     case "premiumAccount":
                        switch(this._ID1)
                        {
                           case 8:
                              _loc1_ = "premiumAccount1DayBought";
                              _loc6_ = this._ID1;
                              break;
                           case 1:
                           case 10:
                              _loc1_ = "premiumAccountXDaysBought";
                              _loc6_ = this._ID1;
                        }
                        break;
                     case "randomItems":
                  }
               }
               break;
            case "activateWeeklyReset":
               remoteM.socketM.admin_activateWeeklyReset(this.txtInput1.text);
               break;
            case "openAdminTools":
               if(this._adminToolsPasswordCounter <= 3)
               {
                  if(this.txtInput1.text == "adminTools10")
                  {
                     this._adminToolsPasswordCounter = 0;
                     screensM.addScreen("screenAdminTools");
                     screensM.screenAdminTools.refreshScreen();
                  }
                  else
                  {
                     ++this._adminToolsPasswordCounter;
                  }
               }
               break;
            case "notLoggedIn":
               dataM.refreshClient();
               break;
            case "opponentQuitOnFirstRoundNoReward":
               screensM.screenBattle.returnToLobbyClicked(false);
               break;
            case "skipChallenge":
               screensM.screenWorldMapSelectBattle.challengeSkipped();
               break;
            case "changePlayerName_online":
            case "changePlayerNameAndTermsOfUse_online":
               _loc15_ = this.txtInput1.text;
               _loc16_ = 0;
               _loc17_ = 0;
               _loc19_ = 0;
               _loc18_ = 0;
               while(_loc18_ < _loc15_.length)
               {
                  if(_loc15_.substr(_loc18_,1) == " ")
                  {
                     _loc19_++;
                  }
                  else
                  {
                     _loc18_ = _loc15_.length;
                  }
                  _loc18_++;
               }
               if(_loc19_ > 0)
               {
                  _loc15_ = _loc15_.substr(_loc19_,_loc15_.length - _loc19_);
               }
               _loc18_ = 0;
               while(_loc18_ < _loc15_.length)
               {
                  if(_loc15_.substr(_loc18_,1) != " ")
                  {
                     _loc16_ = _loc18_;
                     _loc17_++;
                  }
                  _loc18_++;
               }
               if(_loc16_ < _loc15_.length - 1)
               {
                  _loc15_ = _loc15_.substr(0,_loc16_ + 1);
               }
               if(_loc15_.toLowerCase() == "server")
               {
                  _loc15_ = "SuperMechs Player";
               }
               if(_loc15_ != "" && _loc17_ > 0)
               {
                  _loc22_ = false;
                  switch(this._questionOrNotificationType)
                  {
                     case "changePlayerNameAndTermsOfUse_online":
                        if(this.mcV.visible == false)
                        {
                           _loc22_ = true;
                        }
                  }
                  if(_loc22_)
                  {
                     _loc2_ = false;
                     this.mcErrorMarkTermsOfUse.visible = true;
                  }
                  else
                  {
                     dataM.userName = _loc15_;
                     switch(this._questionOrNotificationType)
                     {
                        case "changePlayerName_online":
                        case "changePlayerNameAndTermsOfUse_online":
                           _loc3_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
                           _loc3_.playerName = _loc15_;
                           remoteM.lobby_changeName(_loc15_);
                           _loc1_ = "pleaseWait";
                     }
                     keyboardM.deactivateMe();
                  }
                  this.mcTutorialArrow_inputName.gotoAndStop("animOff");
               }
               else
               {
                  this.mcTutorialArrow_inputName.gotoAndStop("animOn");
                  _loc2_ = false;
                  this.txtInput1.text = "";
               }
               break;
            case "ageVerification":
               if(this.mcV.visible == false)
               {
                  _loc2_ = false;
                  this.mcErrorMarkTermsOfUse.visible = true;
               }
               else
               {
                  _loc3_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
                  _loc3_.ageVerification = true;
                  remoteM.socketM.lobby_setAgeVerification();
                  if(screensM.isScreenOpened("screenMainMenu") || screensM.isScreenOpened("screenNewMenu"))
                  {
                     screensM.screenNewMenu.multiplayerLadderClicked();
                  }
               }
               break;
            case "logout":
               dataM.logOutClicked = true;
               BMLoginManager.gi().generateLogout();
               _loc1_ = "loggingOut";
               break;
            case "clientIsNotUpToDate":
               dataM.openURL("http://www.supermechs.com","_self");
               _loc2_ = false;
               break;
            case "skipTutorial":
               screensM.screenSkipTutorial.skipTutorialAccepted();
               break;
            case "connectionLost":
               screensM.forceBackToLoginScreen();
               break;
            case "customYesNoQuestion":
               this.finishCustomYesNoConfirmationScreen(true);
               break;
            case "customMessage":
               this.finishCustomMessageConfirmationScreen();
         }
         this.mcTutorialArrow_button.gotoAndStop("animOff");
         this._ID1 = _loc6_;
         this._ID2 = _loc7_;
         if(_loc1_ == "")
         {
            if(_loc2_)
            {
               screensM.removeScreen("screenConfirmation");
            }
         }
         else
         {
            this.displayQuestionOrNotification(_loc1_,this._ID1,this._ID2);
         }
         switch(_loc8_)
         {
            case "fusionAccepted":
               screensM.screenHangerFusion.fusionAccepted();
               break;
            case "fusionMythicalWarningAccepted":
               screensM.screenHangerFusion.mythicalWarningAccepted();
         }
      }
      
      private function logoutOnEnterFrame(param1:Event) : void
      {
         ++this._logoutCounter;
         if(this._logoutCounter > 50)
         {
            removeEventListener(Event.ENTER_FRAME,this.logoutOnEnterFrame);
            this._logoutCounter = 0;
            screensM.forceBackToLoginScreen();
         }
      }
      
      public function superMechsClicked() : void
      {
         if(dataM.languageID == 2)
         {
            dataM.openURL("http://www.supermechs.com/?mcamp_id=652&ref=7k7k&iframeck=1&hideall=1","_self");
         }
         else
         {
            dataM.openURL("http://www.supermechs.com","_self");
         }
      }
      
      public function appStoreClicked() : void
      {
         var _loc1_:String = "ios";
         switch(_loc1_)
         {
            case "ios":
               dataM.openURL("https://itunes.apple.com/il/app/supermechs/id864103912?mt=8","_blank");
               break;
            case "android":
               dataM.openURL("https://play.google.com/store/apps/details?id=air.com.supermechs.superapp","_blank");
         }
      }
      
      private function keyboardOutput(param1:Object) : void
      {
         if(param1.enter)
         {
            this.confirmClicked();
         }
      }
      
      public function resetUrgentMessage() : void
      {
         this._displayUrgentMessage = false;
      }
      
      public function displayUrgentMessage(param1:String) : void
      {
         this._displayUrgentMessage = true;
         this._displayUrgentMessageType = param1;
         switch(this._displayUrgentMessageType)
         {
            case "newClanMember":
            case "clanMemberLeft":
            case "newNotification":
               this._displayUrgentMessageFrameCounter = 8;
               break;
            default:
               this._displayUrgentMessageFrameCounter = 0;
         }
      }
      
      public function getCreditsClicked() : void
      {
         screensM.removeScreen("screenConfirmation");
         screensM.screenTopBar.getGoldClicked();
         tooltip.hideToolTip();
      }
      
      public function getTokensClicked() : void
      {
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
         }
         else
         {
            screensM.removeScreen("screenConfirmation");
            dataM.openBuyTokensPage("ScreenConfirmation");
            tooltip.hideToolTip();
         }
      }
      
      private function getCreditsMouseOver() : void
      {
         tooltip.showToolTip("regularText",getGeneralText("getMoreCredits"),-1,-1);
      }
      
      private function getTokensMouseOver() : void
      {
         tooltip.showToolTip("regularText",getGeneralText("getMoreTokens"),-1,-1);
      }
      
      private function generalButtonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      private function acceptTermsOfUseClicked(param1:MouseEvent) : void
      {
         this.acceptTermsOfUseClickedSub();
      }
      
      public function acceptTermsOfUseClickedSub() : void
      {
         if(this.mcV.visible)
         {
            this.mcV.visible = false;
         }
         else
         {
            this.mcV.visible = true;
         }
      }
      
      private function SMLinkClicked(param1:MouseEvent) : void
      {
         this.superMechsClicked();
      }
      
      public function registerClicked() : void
      {
         var _loc2_:BMPlayerData = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.gold > dataM.GUEST_MAX_GOLD)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("cantRegisterTooMuchGold",-1,-1);
         }
         else
         {
            _loc2_ = dataM.playersData[dataM.player1PlayerID];
            if(_loc2_.items.length > dataM.GUEST_MAX_ITEMS)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("cantRegisterTooManyItems",-1,-1);
            }
            else if(dataM.useNoConnectionMode && dataM.firstSocketConnectionEstablished == false)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("cantRegisterNoInternetConnection",-1,-1);
            }
            else
            {
               screensM.addIfNotOpened("screenWelcomeLoginAs");
               screensM.screenWelcomeLoginAs.refreshScreen(true);
               screensM.removeScreen("screenConfirmation");
            }
         }
      }
      
      private function showTermsOfUseText() : void
      {
         var _loc1_:String = getSpecificText("register_termsOfUse");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%COLOR%","<FONT COLOR=\'#00CCFF\'>");
         var _loc2_:uint = 18;
         switch(dataM.languageID)
         {
            case 5:
               _loc2_ = 14;
               break;
            case 9:
               _loc2_ = 17;
         }
         this.txtTermsOfUse.htmlText = TextUtils.getTextFont(_loc2_) + _loc1_;
      }
      
      private function showAgeVerificationText() : void
      {
         this.txtTermsOfUse.htmlText = TextUtils.getTextFont() + getScreenText("ageVerificationContent");
      }
      
      public function getQuestionOrNotificationType() : String
      {
         return this._questionOrNotificationType;
      }
      
      public function backClicked() : *
      {
         if(this.btnCancel.visible)
         {
            this.cancelClicked();
         }
      }
      
      public function removeMe() : void
      {
         this.mcSandClock.gotoAndStop("animOff");
      }
   }
}

