package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.data.BMClanMemberData;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
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
   import net.battleMechsMulti.screens.screensDirector.BMScreensDirectorTask;
   import net.battleMechsMulti.session.LoginAsFlowTypes;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2186")]
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
            if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_BACKGROUND) || screensM.isScreenOpened(BMScreensManager.SCR_DAILY_LOGIN_STREAK_BONUS))
            {
               _loc1_ = false;
            }
            if(_loc1_)
            {
               _loc2_ = false;
               if(this._displayUrgentMessageType == "newItemsCreated")
               {
                  if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE) == false)
                  {
                     if(screensM.isScreenOpened(BMScreensManager.SCR_WORKSHOP) == false)
                     {
                        _loc2_ = true;
                     }
                  }
               }
               else
               {
                  if(screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP))
                  {
                     _loc2_ = true;
                  }
                  if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE) == false && screensM.isScreenOpened(BMScreensManager.SCR_MISSION_BASE_MAP) == false)
                  {
                     _loc2_ = true;
                  }
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
         updateTextAndFormat(this.txtNotification,param1);
      }
      
      public function displayCustomYesNoQuestion(param1:String, param2:Function) : *
      {
         this.customConfirmationText = param1;
         this.displayQuestionOrNotification("customYesNoQuestion",-1,-1,param2);
      }
      
      public function displayCustomMessage(param1:String, param2:Function = null) : *
      {
         this.customConfirmationText = param1;
         this.displayQuestionOrNotification("customMessage",-1,-1,param2);
      }
      
      public function displayCustomUrgentMessage(param1:String) : *
      {
         this.customConfirmationText = param1;
         this.displayUrgentMessage("customMessage");
      }
      
      public function displayCustomLoading(param1:String) : *
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CONFIRMATION) && this._questionOrNotificationType == "customLoading")
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
      
      public function displayQuestionOrNotification(param1:String, param2:Number = -1, param3:Number = -1, param4:Function = null) : void
      {
         var _loc5_:BMItemData = null;
         var _loc6_:BMPlayerItemData = null;
         var _loc7_:String = null;
         var _loc8_:BMBoostData = null;
         var _loc9_:Object = null;
         var _loc10_:BMPlayerProfile = null;
         var _loc11_:Function = null;
         var _loc12_:Function = null;
         var _loc13_:Function = null;
         var _loc14_:Function = null;
         var _loc15_:Function = null;
         var _loc16_:Function = null;
         var _loc17_:Function = null;
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
         var _loc28_:String = null;
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
         var _loc46_:uint = 0;
         var _loc47_:String = null;
         var _loc48_:String = null;
         var _loc49_:String = null;
         var _loc50_:String = null;
         var _loc51_:String = null;
         var _loc52_:String = null;
         var _loc53_:String = null;
         var _loc54_:uint = 0;
         var _loc55_:Object = null;
         var _loc56_:BMItemData = null;
         var _loc57_:String = null;
         var _loc58_:String = null;
         var _loc59_:String = null;
         var _loc60_:Number = NaN;
         var _loc61_:Number = NaN;
         var _loc62_:Number = NaN;
         var _loc63_:String = null;
         var _loc64_:Number = NaN;
         var _loc65_:String = null;
         var _loc66_:String = null;
         var _loc67_:Array = null;
         if(parent != null)
         {
            screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         }
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer(BMScreensManager.SCR_CONFIRMATION,"btnCancel","pictureC");
            screensM.createButtonFromSizer(BMScreensManager.SCR_CONFIRMATION,"btnCancelOnly","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_CONFIRMATION,"btnConfirm","pictureD");
            screensM.createButtonFromSizer(BMScreensManager.SCR_CONFIRMATION,"btnOKOnly","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_CONFIRMATION,"btnRegister","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_CONFIRMATION,"btnLater","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_CONFIRMATION,"btnHanger","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_CONFIRMATION,"btnCancelSmall","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_CONFIRMATION,"btnGetCredits","pictureF");
            screensM.createButtonFromSizer(BMScreensManager.SCR_CONFIRMATION,"btnGetTokens","pictureK");
            screensM.createButtonFromSizer(BMScreensManager.SCR_CONFIRMATION,"btnSuperMechs","regular");
            this.btnHanger.setRunAsMobile(dataM.runAsMobile);
            this.btnHanger.changeFontSize(20);
            this.btnSuperMechs.setRunAsMobile(dataM.runAsMobile);
            this.btnSuperMechs.changeFontSize(13);
            _loc11_ = this.cancelClicked;
            _loc12_ = this.confirmClicked;
            _loc13_ = this.registerClicked;
            _loc14_ = this.hangerClicked;
            _loc15_ = this.getCreditsClicked;
            _loc16_ = this.getTokensClicked;
            _loc17_ = this.superMechsClicked;
            if(dataM.runAsMobile)
            {
               _loc11_ = null;
               _loc12_ = null;
               _loc13_ = null;
               _loc14_ = null;
               _loc15_ = null;
               _loc16_ = null;
               _loc17_ = null;
               screensM.createButtonFromSizer(BMScreensManager.SCR_CONFIRMATION,"btnAppStore","regular");
               this.btnAppStore.setRunAsMobile(dataM.runAsMobile);
               this.btnAppStore.initialize(getScreenText("update"),"blue",null,[],this.appStoreClicked,dataM.runAsMobile);
               this.btnAppStore.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            }
            this.btnCancel.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc11_,dataM.runAsMobile);
            this.btnCancelOnly.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc11_,dataM.runAsMobile);
            this.btnConfirm.initialize("","",externalAssetsM.getAsset("general","interface_V"),null,_loc12_,dataM.runAsMobile);
            this.btnOKOnly.initialize("","blue",null,[],_loc12_,dataM.runAsMobile);
            this.btnRegister.initialize("","orange",null,[],_loc13_,dataM.runAsMobile);
            this.btnLater.initialize("","blue",null,[],_loc11_,dataM.runAsMobile);
            this.btnHanger.initialize("","blue",null,[],_loc14_,dataM.runAsMobile);
            this.btnCancelSmall.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc11_,dataM.runAsMobile);
            this.btnGetCredits.initialize("","",externalAssetsM.getAsset("general","interface_getCredits"),null,_loc15_,dataM.runAsMobile);
            this.btnGetTokens.initialize("","",externalAssetsM.getAsset("general","interface_getTokens"),null,_loc16_,dataM.runAsMobile);
            this.btnSuperMechs.initialize("WWW.SUPERMECHS.COM","blue",null,[],_loc17_,dataM.runAsMobile);
            this.btnCancel.buttonCore.ignoreScreensDirectorTasks();
            this.btnCancelOnly.buttonCore.ignoreScreensDirectorTasks();
            this.btnConfirm.buttonCore.ignoreScreensDirectorTasks();
            this.btnOKOnly.buttonCore.ignoreScreensDirectorTasks();
            this.btnRegister.buttonCore.ignoreScreensDirectorTasks();
            this.btnLater.buttonCore.ignoreScreensDirectorTasks();
            this.btnHanger.buttonCore.ignoreScreensDirectorTasks();
            this.btnCancelSmall.buttonCore.ignoreScreensDirectorTasks();
            this.btnGetCredits.buttonCore.ignoreScreensDirectorTasks();
            this.btnGetTokens.buttonCore.ignoreScreensDirectorTasks();
            this.btnSuperMechs.buttonCore.ignoreScreensDirectorTasks();
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
         this.mcSandClock.visible = false;
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
         this.customConfirmationHandler = param4;
         switch(this._questionOrNotificationType)
         {
            case "purchaseSuccessful":
               this.setText("<FONT COLOR=\'#" + dataM.COLOR_GOOD + "\'>" + getScreenText("purchaseSuccessful") + "</FONT>");
               this.btnOKOnly.visible = true;
               break;
            case "notEnoughMoneyForItem":
               _loc5_ = dataM.itemsDB[this._ID1];
               _loc10_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(_loc5_.costTokens == 0)
               {
                  this.mcIconGoldBuy.visible = true;
                  this.txtGold.text = TextUtils.getNumberWithComma(_loc5_.costGold);
                  if(_loc5_.costGold > _loc10_.gold)
                  {
                     this.txtGold.textColor = 13369344;
                  }
               }
               else if(_loc5_.costTokens > 0)
               {
                  this.txtTokens.text = String(_loc5_.costTokens);
                  this.mcIconTokens.visible = true;
                  if(_loc5_.costTokens > _loc10_.tokens)
                  {
                     this.txtTokens.textColor = 13369344;
                  }
               }
               this.btnCancel.visible = true;
               if(_loc5_.costTokens > 0)
               {
                  this.btnGetTokens.visible = true;
               }
               else
               {
                  this.btnGetCredits.visible = true;
               }
               this.mcBuySellItemBackground.visible = true;
               this.addItem(_loc5_,0);
               break;
            case "itemEquippedNoBullets":
               _loc18_ = getScreenText("needBulletsForWeapon");
               _loc5_ = dataM.itemsDB[this._ID1];
               _loc18_ = dataM.replaceStringInText(_loc18_,"%NAME%",languageM.getItemNameByItemData(_loc5_));
               this.setText(_loc18_);
               this.mcIconBullets.visible = true;
               this.btnOKOnly.visible = true;
               break;
            case "itemEquippedNoRockets":
               _loc19_ = getScreenText("needRocketsForWeapon");
               _loc5_ = dataM.itemsDB[this._ID1];
               _loc19_ = dataM.replaceStringInText(_loc19_,"%NAME%",languageM.getItemNameByItemData(_loc5_));
               this.setText(_loc19_);
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
            case "powerKitBlock":
               this.setText(getScreenText("powerKitLimitation"));
               this.btnOKOnly.visible = true;
               break;
            case "weightBlock":
               this.setText(getScreenText("tooMuchWeight"));
               this.mcIconWeight.visible = true;
               if(screensM.isScreenOpened(BMScreensManager.SCR_WORKSHOP))
               {
                  this.btnOKOnly.visible = true;
               }
               else
               {
                  this.btnHanger.visible = true;
               }
               break;
            case "cannotPlayWithLegacyShields":
               this.setText(getGeneralText("cannotPlayWithLegacyShields"));
               this.btnHanger.visible = true;
               break;
            case "cannotPlayWithRepairDrones":
               this.setText(getGeneralText("cannotPlayWithRepairDrones"));
               this.btnHanger.visible = true;
               break;
            case "changeMechsOrderFailed":
               this.setText(getScreenText("changeMechsOrderFailed"));
               this.btnOKOnly.visible = true;
               break;
            case "rewardVideosGotTokens":
               _loc20_ = getScreenText("rewardedVideoGotTokens");
               _loc20_ = dataM.replaceStringInText(_loc20_,"%AMOUNT%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + this._ID1 + "</FONT>");
               this.setText(_loc20_);
               this.btnOKOnly.visible = true;
               break;
            case "rewardVideosGotGold":
               _loc21_ = getScreenText("rewardedVideoGotGold");
               _loc21_ = dataM.replaceStringInText(_loc21_,"%AMOUNT%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + TextUtils.getNumberWithComma(this._ID1) + "</FONT>");
               this.setText(_loc21_);
               this.btnOKOnly.visible = true;
               break;
            case "rewardVideosComeBackLater":
               this.setText(getScreenText("rewardedVideoComeBackLater"));
               this.btnOKOnly.visible = true;
               break;
            case "missionFailed":
               _loc22_ = getScreenText("missionFailed");
               _loc22_ = dataM.replaceStringInText(_loc22_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_BAD + "\'>");
               this.setText(_loc22_);
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
            case "notEnoughBattleCredits":
               this.setText("<BR>Not enough Fuel");
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
            case "mechAlreadyBought":
               this.setText("<BR>Mech already bought");
               this.btnOKOnly.visible = true;
               break;
            case "onlineWinsRequiredForItemBox":
               _loc23_ = getScreenText("onlineWinsRequiredForItemBox");
               _loc23_ = dataM.replaceStringInText(_loc23_,"%REQUIRED%",String(this._ID1));
               _loc23_ = dataM.replaceStringInText(_loc23_,"%REMAINING%",String(this._ID2));
               _loc23_ = dataM.replaceStringInText(_loc23_,"%COLOR1%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>");
               _loc23_ = dataM.replaceStringInText(_loc23_,"%COLOR2%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>");
               this.setText(_loc23_);
               this.btnOKOnly.visible = true;
               break;
            case "hardInsaneMissionsRequiredForItemBox":
               _loc24_ = getScreenText("hardInsaneMissionsRequiredForItemBox");
               _loc24_ = dataM.replaceStringInText(_loc24_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_HARD + "\'>");
               _loc24_ = dataM.replaceStringInText(_loc24_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_INSANE + "\'>");
               this.setText(_loc24_);
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
            case "battleCreditsBought":
               this.setText(getScreenText("battleCreditsBought"));
               this.btnOKOnly.visible = true;
               break;
            case "doYouWantToJoinThisClan":
               _loc25_ = getScreenText("doYouWantToJoinThisClan");
               _loc25_ = dataM.replaceStringInText(_loc25_,"%NAME%",screensM.screenSearchForClan.getClanName(this._ID1));
               this.setText(_loc25_);
               this.btnCancel.visible = true;
               this.btnConfirm.visible = true;
               break;
            case "clanRequiredRankToJoinTooHigh":
               _loc26_ = "<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>" + this._ID1 + "</FONT>";
               _loc27_ = getScreenText("youMustReachRankXToJoinClan");
               _loc27_ = dataM.replaceStringInText(_loc27_,"%RANK%",_loc26_);
               this.setText(_loc27_);
               this.btnOKOnly.visible = true;
               break;
            case "playerHasJoinedAClan":
               _loc10_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc28_ = getScreenText("playerHasJoinedAClan");
               _loc28_ = dataM.replaceStringInText(_loc28_,"%NAME%",_loc10_.clanName);
               this.setText(_loc28_);
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
               _loc29_ = getScreenText("tryToKickMember");
               _loc10_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc30_ = _loc10_.clanData.members[this._ID1].name;
               _loc29_ = dataM.replaceStringInText(_loc29_,"%NAME%",_loc30_);
               this.setText(_loc29_);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "clanCreated":
               this.setText(getScreenText("clanCreated"));
               this.btnOKOnly.visible = true;
               break;
            case "clanNameUnavailable":
               _loc31_ = getScreenText("clanNameUnavailable");
               _loc31_ = dataM.replaceStringInText(_loc31_,"%NAME%",screensM.screenClanCreate.txtInputName.text);
               this.setText(_loc31_);
               this.btnOKOnly.visible = true;
               break;
            case "clanNameTooShort":
               this.setText(getScreenText("clanNameTooShort"));
               this.btnOKOnly.visible = true;
               break;
            case "requestSentToClan":
               _loc32_ = getScreenText("requestSentToClan");
               _loc32_ = dataM.replaceStringInText(_loc32_,"%NAME%",dataM.clansRankingList[this._ID1].clanName);
               this.setText(_loc32_);
               this.btnOKOnly.visible = true;
               break;
            case "joinClanRequestNotValid":
               this.setText(getScreenText("joinClanRequestNotValid"));
               this.btnOKOnly.visible = true;
               break;
            case "newClanMember":
               _loc33_ = getScreenText("newClanMember");
               _loc33_ = dataM.replaceStringInText(_loc33_,"%NAME%",this.urgentMessageClanMemberName);
               this.setText(_loc33_);
               this.btnOKOnly.visible = true;
               break;
            case "clanMemberLeft":
               _loc34_ = getScreenText("clanMemberLeft");
               _loc34_ = dataM.replaceStringInText(_loc34_,"%NAME%",this.urgentMessageClanMemberName);
               this.setText(_loc34_);
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
               this.mcSandClock.visible = true;
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
               _loc35_ = "<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>";
               _loc36_ = getScreenText("createOrJoinAClan");
               _loc36_ = dataM.replaceStringInText(_loc36_,"%COLOR%",_loc35_);
               _loc36_ = dataM.replaceStringInText(_loc36_,"%COLOR%",_loc35_);
               _loc36_ = dataM.replaceStringInText(_loc36_,"%COLOR%",_loc35_);
               this.setText(_loc36_);
               this.btnOKOnly.visible = true;
               break;
            case "clanNotEnoughGold":
               _loc37_ = getScreenText("clanNotEnoughGold");
               _loc37_ = dataM.replaceStringInText(_loc37_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               _loc37_ = dataM.replaceStringInText(_loc37_,"%GOLD%",TextUtils.getNumberWithComma(dataM.createClanCost));
               this.setText(_loc37_);
               this.btnOKOnly.visible = true;
               break;
            case "clanWinsRewardGold":
               _loc38_ = getScreenText("clanWinsRewardGold");
               _loc38_ = dataM.replaceStringInText(_loc38_,"%BATTLES%",TextUtils.getNumberWithComma(dataM.clanWinsWinsRequired));
               _loc38_ = dataM.replaceStringInText(_loc38_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               _loc38_ = dataM.replaceStringInText(_loc38_,"%REWARD%",TextUtils.getNumberWithComma(dataM.clanWinsRewardValue));
               this.setText(_loc38_);
               this.mcIconGoldRewardClan.visible = true;
               this.btnOKOnly.visible = true;
               _loc10_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc10_.gold += _loc10_.clan_winsRewardGold;
               _loc10_.clan_winsRewardGold = 0;
               break;
            case "newItemsCreated":
               this.setText(getScreenText("newItemsCreated"));
               this.btnOKOnly.visible = true;
               _loc54_ = 0;
               while(_loc54_ < dataM.newItemsCreated.length)
               {
                  _loc55_ = dataM.newItemsCreated[_loc54_];
                  dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,_loc55_.itemID,_loc55_.playerItemID,0,0,_loc55_.power);
                  _loc54_++;
               }
               dataM.newItemsCreated = new Array();
               break;
            case "changeMechBuildName":
               this.setText(getSpecificText("mechBuilds_enterNewBuildName"));
               this.txtInput1.visible = true;
               this.mcInputText1Background.visible = true;
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "cloneMechBuild":
               _loc39_ = getSpecificText("mechBuilds_cloneOverrideConfirmation");
               _loc40_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + dataM.mechBuildsM.getBuildName(this._ID2,true) + "</FONT>";
               _loc39_ = dataM.replaceStringInText(_loc39_,"%NAME%",_loc40_);
               this.setText(_loc39_);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
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
               if(dataM.useHiddenBaseMap)
               {
                  this.setText(getScreenText("abortMission"));
               }
               else
               {
                  this.setText(getScreenText("quitMissionBattle"));
               }
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
               this.mcSandClock.visible = true;
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
            case "admin_giveSpecialItems":
               this.setText("Special items sent");
               this.btnOKOnly.visible = true;
               break;
            case "baseBuilding_anotherUpgradeInProgress":
               this.setText(getSpecificText("baseBuilding_anotherUpgradeInProgress"));
               this.btnOKOnly.visible = true;
               break;
            case "baseBuilding_hqLevelTooLow":
               this.setText(getSpecificText("baseBuilding_hqLevelTooLow"));
               this.btnOKOnly.visible = true;
               break;
            case "baseBuilding_cannotBuildAnotherStructure":
               _loc41_ = getSpecificText("baseBuilding_cannotBuildAnotherStructure");
               _loc41_ = dataM.replaceStringInText(_loc41_,"%LEVEL%",this._ID1.toString());
               this.setText(_loc41_);
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
               if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE))
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
            case "buySpecialOfferForTokens":
               _loc42_ = getScreenText("buySpecificItem");
               _loc42_ = dataM.replaceStringInText(_loc42_,"%NAME%",getSpecificText("specialOffers_oneTimeOffer"));
               _loc42_ = dataM.replaceStringInText(_loc42_,"%TOKENS%",String(this._ID1));
               this.setText(_loc42_);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "buyStarterPack":
               _loc10_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc43_ = getScreenText("buyStarterPack");
               _loc43_ = dataM.replaceStringInText(_loc43_,"%PRICE%","<FONT COLOR=\'#" + dataM.COLOR_TOKENS + "\'>" + _loc10_.starterPackData.price + "</FONT>");
               this.setText(_loc43_);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "buyPackage":
               _loc8_ = dataM.boostsDB[this._ID1];
               switch(_loc8_.type)
               {
                  case "specificItem":
                     _loc56_ = dataM.itemsDB[_loc8_.itemID];
                     _loc57_ = getScreenText("buySpecificItem");
                     _loc58_ = ItemRarityResolver.COLOR_LEGENDARY_ITEM;
                     if(_loc56_.specialStatus == 4)
                     {
                        _loc58_ = ItemRarityResolver.COLOR_MYTHICAL_ITEM;
                     }
                     _loc57_ = dataM.replaceStringInText(_loc57_,"%NAME%","<FONT COLOR=\'#" + _loc58_ + "\'>" + languageM.getItemNameByItemData(_loc56_) + "</FONT>");
                     _loc57_ = dataM.replaceStringInText(_loc57_,"%TOKENS%","<FONT COLOR=\'#" + dataM.COLOR_TOKENS + "\'>" + _loc8_.costTokens + "</FONT>");
                     this.setText(_loc57_);
                     break;
                  case "randomItems":
                     _loc10_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                     _loc60_ = _loc8_.amount;
                     _loc61_ = _loc10_.level - _loc8_.levelDifference;
                     _loc62_ = _loc10_.level + _loc8_.levelDifference;
                     if(_loc61_ < 2)
                     {
                        _loc61_ = 2;
                     }
                     if(_loc10_.level >= dataM.levelForExpandedItemBox)
                     {
                        _loc61_ = dataM.levelForExpandedItemBox;
                        _loc62_ = dataM.LEVEL_MAX;
                     }
                     if(_loc8_.ratioMythical == 100)
                     {
                        if(_loc8_.amount == 1)
                        {
                           _loc59_ = getScreenText("buyItemsBoxMythical");
                        }
                        else
                        {
                           _loc59_ = getScreenText("buyItemsBoxMythicals");
                        }
                        _loc64_ = _loc8_.costTokens;
                        _loc63_ = dataM.COLOR_TOKENS;
                     }
                     else if(_loc8_.costGold > 0)
                     {
                        _loc59_ = getScreenText("buyItemsBoxGold");
                        _loc64_ = _loc8_.costGold;
                        _loc63_ = dataM.COLOR_GOLD;
                     }
                     else
                     {
                        _loc59_ = getScreenText("buyItemsBoxTokens");
                        _loc64_ = _loc8_.costTokens;
                        _loc63_ = dataM.COLOR_TOKENS;
                     }
                     _loc59_ = dataM.replaceStringInText(_loc59_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
                     _loc59_ = dataM.replaceStringInText(_loc59_,"%COLOR2%","<FONT COLOR=\'#" + _loc63_ + "\'>");
                     if(_loc8_.ratioMythical == 100)
                     {
                        _loc59_ = dataM.replaceStringInText(_loc59_,"%COLOR3%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_MYTHICAL_ITEM + "\'>");
                     }
                     _loc59_ = dataM.replaceStringInText(_loc59_,"%TOKENS%",TextUtils.getNumberWithComma(_loc64_));
                     _loc59_ = dataM.replaceStringInText(_loc59_,"%ITEMS%",String(_loc60_));
                     _loc59_ = dataM.replaceStringInText(_loc59_,"%LEVELS%",_loc61_ + " - " + _loc62_);
                     this.setText(_loc59_);
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
               this.mcSandClock.visible = true;
               break;
            case "featureNotAvailable":
               this.setText("<BR><BR>Feature is not available");
               this.btnOKOnly.visible = true;
               break;
            case "packageBought":
               _loc8_ = dataM.boostsDB[this._ID1];
               _loc44_ = getScreenText("creditsPackageBought");
               _loc44_ = dataM.replaceStringInText(_loc44_,"%GOLD%",TextUtils.getNumberWithComma(_loc8_.bonusGold));
               _loc44_ = dataM.replaceStringInText(_loc44_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               this.setText(_loc44_);
               this.btnOKOnly.visible = true;
               break;
            case "premiumAccountXDaysBought":
               _loc45_ = getScreenText("premiumAccountXDaysBought");
               switch(this._ID1)
               {
                  case 1:
                     _loc45_ = dataM.replaceStringInText(_loc45_,"%DAYS%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>30</FONT>");
                     break;
                  case 10:
                     _loc45_ = dataM.replaceStringInText(_loc45_,"%DAYS%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>7</FONT>");
               }
               this.setText("<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>" + _loc45_);
               this.btnOKOnly.visible = true;
               break;
            case "notEnoughTokens_noValue":
               this.setText(getScreenText("notEnoughTokens_noValue"));
               this.btnOKOnly.visible = true;
               break;
            case "notEnoughTokens":
               _loc8_ = dataM.boostsDB[this._ID1];
               _loc46_ = _loc8_.costTokens;
               _loc47_ = getScreenText("notEnoughTokens");
               _loc47_ = dataM.replaceStringInText(_loc47_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_TOKENS + "\'>");
               _loc47_ = dataM.replaceStringInText(_loc47_,"%TOKENS%",String(_loc46_));
               this.setText(_loc47_);
               if(tutorialM.isTutorialActive() == false)
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
               _loc8_ = dataM.boostsDB[this._ID1];
               _loc48_ = getScreenText("notEnoughGold");
               _loc48_ = dataM.replaceStringInText(_loc48_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               _loc48_ = dataM.replaceStringInText(_loc48_,"%GOLD%",TextUtils.getNumberWithComma(dataM.getBoostGoldCost(this._ID1)));
               this.setText(_loc48_);
               this.btnOKOnly.visible = true;
               break;
            case "notEnoughGoldForShopItem":
               _loc49_ = getScreenText("notEnoughGold");
               _loc49_ = dataM.replaceStringInText(_loc49_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               _loc49_ = dataM.replaceStringInText(_loc49_,"%GOLD%",TextUtils.getNumberWithComma(this._ID1));
               this.setText(_loc49_);
               this.btnOKOnly.visible = true;
               break;
            case "notEnoughTokensForShopItem":
               _loc50_ = getScreenText("notEnoughTokens");
               _loc50_ = dataM.replaceStringInText(_loc50_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
               _loc50_ = dataM.replaceStringInText(_loc50_,"%TOKENS%",TextUtils.getNumberWithComma(this._ID1));
               this.setText(_loc50_);
               this.btnOKOnly.visible = true;
               break;
            case "refreshBrowserAfterBuyingTokens":
               this.setText(getScreenText("refreshBrowserForTokens"));
               this.btnCancelOnly.visible = true;
               this.mcSandClock.visible = true;
               break;
            case "chainDiscountEnded":
               this.setText(getSpecificText("chainDiscount_chainDiscountEnded"));
               this.btnOKOnly.visible = true;
               break;
            case "buyGachaMachineFailed":
               this.setText(getScreenText("buyItemFailed"));
               this.btnOKOnly.visible = true;
               break;
            case "loadReplayByCode":
               this.setText(getSpecificText("insertReplayCode"));
               this.txtInput1.visible = true;
               this.mcInputText1Background.visible = true;
               this.btnCancel.visible = true;
               this.btnConfirm.visible = true;
               break;
            case "invalidReplayCode":
               this.setText(getSpecificText("invalidReplayCode"));
               this.btnOKOnly.visible = true;
               break;
            case "replayEnded_battleOver":
               _loc10_ = dataM["player" + dataM["player" + this._ID1 + "PlayerID"] + "Profile"];
               this.setText("<BR><BR>" + _loc10_.playerName + getScreenText("replayPlayerWon"));
               this.btnOKOnly.visible = true;
               this.btnOKOnly.y = this._btnOKOnlyOriginYPos - 30;
               if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_OPTIONS))
               {
                  screensM.removeScreen(BMScreensManager.SCR_BATTLE_OPTIONS);
               }
               break;
            case "replayEnded_playerQuit":
               _loc10_ = dataM["player" + dataM["player" + this._ID1 + "PlayerID"] + "Profile"];
               this.setText("<BR><BR>" + _loc10_.playerName + getScreenText("replayPlayerQuit"));
               this.btnOKOnly.visible = true;
               this.btnOKOnly.y = this._btnOKOnlyOriginYPos - 30;
               if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_OPTIONS))
               {
                  screensM.removeScreen(BMScreensManager.SCR_BATTLE_OPTIONS);
               }
               break;
            case "loadingExternalAssets":
               _loc51_ = getScreenText("loadingAdditionalData");
               _loc51_ = dataM.replaceStringInText(_loc51_,"%VALUE%",String(this._ID1));
               this.setText(_loc51_);
               break;
            case "contentPackUnlocked":
               this.setText(getScreenText("armoryExtended"));
               this.btnOKOnly.visible = true;
               break;
            case "changeName":
               if(this._ID1 == 0)
               {
                  _loc52_ = getScreenText("changeNameForFree");
                  _loc52_ = dataM.replaceStringInText(_loc52_,"%NAME%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + screensM.screenChangeName.txtInputName.text + "</FONT>");
               }
               else
               {
                  _loc52_ = getScreenText("changeNameForTokens");
                  _loc52_ = dataM.replaceStringInText(_loc52_,"%NAME%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + screensM.screenChangeName.txtInputName.text + "</FONT>");
                  _loc52_ = dataM.replaceStringInText(_loc52_,"%TOKENS%","<FONT COLOR=\'#" + dataM.COLOR_TOKENS + "\'>" + TextUtils.getNumberWithComma(this._ID1) + "</FONT>");
               }
               this.setText(_loc52_);
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               break;
            case "enterKinWalletPassword_create":
               this.setText(getSpecificText("kin_walletPassword_create"));
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               this.txtInput1.visible = true;
               this.txtInput1.y += 24;
               this.mcInputText1Background.y += 24;
               this.mcInputText1Background.visible = true;
               break;
            case "enterKinWalletPassword_restore":
               this.setText(getSpecificText("kin_walletPassword_restore"));
               this.btnConfirm.visible = true;
               this.btnCancel.visible = true;
               this.txtInput1.visible = true;
               this.txtInput1.y += 24;
               this.mcInputText1Background.y += 24;
               this.mcInputText1Background.visible = true;
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
            case "serverNotification":
               this.setText(this.serverNotification_text);
               this.btnOKOnly.visible = true;
               break;
            case "changePlayerName_tutorial":
            case "changePlayerName_online":
            case "changePlayerNameAndTermsOfUse_online":
               this.setText(getScreenText("enterNickname"));
               this.txtInput1.visible = true;
               if(false == false)
               {
                  _loc10_ = dataM.myProfile;
                  _loc65_ = _loc10_.playerName;
                  if(_loc65_ != "" && _loc65_ != "username")
                  {
                     this.txtInput1.text = _loc65_;
                  }
               }
               this._focusInputTextOnNextFrame = true;
               this.mcInputText1Background.visible = true;
               this.btnOKOnly.visible = true;
               keyboardM.setKeyboardOutputFunction(this.keyboardOutput,"screenConfirmation changePlayerName");
               keyboardM.activateMe(BMScreensManager.SCR_CONFIRMATION);
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
               _loc53_ = getScreenText("goldBought");
               _loc53_ = dataM.replaceStringInText(_loc53_,"%GOLD%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + TextUtils.getNumberWithComma(this._ID1) + "</FONT>");
               _loc53_ = dataM.replaceStringInText(_loc53_,"%TOKENS%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + TextUtils.getNumberWithComma(this._ID2) + "</FONT>");
               this.setText(_loc53_);
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
            case "loadingGeneralLibraryExtension":
               this.setText("<BR><BR><BR><BR>Loading extension data...<BR>" + this._ID1 + "%");
               this.mcSandClock.visible = true;
               break;
            case "pleaseWait":
               this.setText(getScreenText("pleaseWait"));
               this.mcSandClock.visible = true;
               break;
            case "pleaseWaitFacebookWeb":
               this.setText(getScreenText("pleaseWaitFacebookWeb"));
               this.mcSandClock.visible = true;
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
                  this.btnRegister.visible = true;
                  this.btnLater.visible = true;
               }
               else
               {
                  this.setText(dataM.replaceStringInText(getScreenText("pleaseRegister"),"%COLOR%",dataM.COLOR_GOLD));
                  this.btnRegister.visible = true;
               }
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
                  _loc66_ = "ios";
                  _loc66_ = "android";
                  switch(_loc66_)
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
               this.mcSandClock.visible = true;
               break;
            case "customLockedMessage":
               this.setText(this.customConfirmationText);
         }
         this.mcBackground.x = dataM.STAGE_WIDTH / 2 - this.mcBackground.width / 2;
         if(dataM.runAsMobile)
         {
            _loc67_ = [this.txtNotification,this.txtBuySell,this.txtGold,this.txtTokens,this.txtGoldReward,this.txtTermsOfUse];
            screensM.createMultipleTextsBitmap("confirmation_texts",_loc67_,"",this);
         }
         screensM.addScreen(BMScreensManager.SCR_CONFIRMATION);
      }
      
      private function languageUpdate() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            this.btnOKOnly.setButtonName(getGeneralText("OK"));
            this.btnRegister.setButtonName(getGeneralText("register"));
            this.btnHanger.setButtonName(getScreenText("openWorkshop"));
            this.btnLater.setButtonName(getGeneralText("later"));
            if(dataM.runAsMobile)
            {
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
         var _loc1_:String = "";
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = true;
         this._ID1 = -1;
         this._ID2 = -1;
         switch(this._questionOrNotificationType)
         {
            case "enterKinWalletPassword_create":
               dataM.kinM.createAccountPasswordCancelled();
               _loc3_ = false;
               break;
            case "enterKinWalletPassword_restore":
               dataM.kinM.restoreAccountCancelled();
               _loc3_ = false;
               break;
            case "battleInvitationSent":
               _loc1_ = "battleInvitationCancelling";
               remoteM.lobby_battleInvitation_canceled();
               break;
            case "abortMission":
               screensM.screenMissionBaseMap.abortMissionClicked();
               break;
            case "quitBattleVSPlayer":
            case "quitBattleVSComputer":
            case "quitBattleVSMission":
               screensM.screenBattle.quitCancelled();
               _loc2_ = true;
               break;
            case "invitingPlayerToClan":
               remoteM.socketM.clan_cancelInvitation();
               _loc1_ = "pleaseWait";
               break;
            case "customYesNoQuestion":
               _loc3_ = false;
               this.finishConfirmationScreenWithResultCallback(false);
               break;
            case "refreshBrowserAfterBuyingTokens":
               dataM.refreshBrowserAfterBuyingTokensCancelClicked();
               break;
            case "cloneMechBuild":
               screensM.screenMechBuilds.cloneCancelled();
         }
         if(_loc1_ == "")
         {
            if(_loc3_)
            {
               screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
            }
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
      
      private function finishConfirmationScreenWithResultCallback(param1:*) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         var _loc2_:* = this.customConfirmationHandler;
         this.customConfirmationHandler = null;
         this.customConfirmationText = null;
         if(_loc2_ != null)
         {
            _loc2_(param1);
         }
      }
      
      private function finishCustomMessageConfirmationScreen() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
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
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         var _loc1_:Number = this._ID1;
         if(_loc1_ <= 0)
         {
            screensM.screenTransitionsManager.hangerMechClicked();
            return;
         }
         if(!screensM.isScreenOpened(BMScreensManager.SCR_MAIN_MENU))
         {
            screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
         }
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_WORKSHOP);
         if(_loc1_ == 1)
         {
            return;
         }
         screensM.screensDirector.addUserActionTask(BMScreensDirectorTask.USER_ACTION_WORKSHOP_SWITCH_TO_MECH_X,{"mechID":_loc1_});
      }
      
      public function confirmClicked() : void
      {
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:BMPlayerData = null;
         var _loc5_:uint = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Boolean = false;
         var _loc10_:BMClanMemberData = null;
         var _loc11_:BMBoostData = null;
         var _loc12_:String = null;
         var _loc13_:uint = 0;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Boolean = false;
         var _loc1_:String = "";
         var _loc2_:Boolean = true;
         var _loc6_:Number = -1;
         var _loc7_:Number = -1;
         switch(this._questionOrNotificationType)
         {
            case "chainDiscountEnded":
               _loc1_ = "pleaseWait";
               BMShopManager.getInstance().chainDiscountEndedConfirmationClosed();
               break;
            case "buyGachaMachineFailed":
               _loc1_ = "pleaseWait";
               remoteM.socketM.lobby_getGachaMachines();
               break;
            case "newNotification":
               _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc8_ = Number(_loc3_.notifications[0].notificationID);
               remoteM.socketM.lobby_deleteNotification(_loc8_);
               _loc3_.notifications.splice(0,1);
               if(_loc3_.notifications.length > 0)
               {
                  this.displayUrgentMessage("newNotification");
               }
               break;
            case "changeName":
               remoteM.socketM.lobby_buyChangeName(screensM.screenChangeName.txtInputName.text);
               _loc1_ = "pleaseWait";
               break;
            case "enterKinWalletPassword_create":
               dataM.kinM.setAccountPassword(this.txtInput1.text);
               _loc2_ = false;
               break;
            case "enterKinWalletPassword_restore":
               dataM.kinM.validateRestoreAccountPassword(this.txtInput1.text);
               _loc2_ = false;
               break;
            case "missionFailed":
               screensM.screenMissionBaseMap.missionFailedClicked();
               break;
            case "abortMission":
               _loc9_ = false;
               if(dataM.isRewardedVideoAvailable(BMScreenWatchRewardedVideo.PLACEMENT_ABORT_MISSION))
               {
                  if(screensM.screenMissionBaseMap.getEnemiesDestroyed() > 0)
                  {
                     _loc9_ = true;
                  }
               }
               if(_loc9_)
               {
                  screensM.addScreen(BMScreensManager.SCR_WATCH_REWARDED_VIDEO);
                  screensM.screenWatchRewardedVideo.refreshScreen(screensM.screenWatchRewardedVideo.TYPE_ABORT_MISSION,dataM.myProfile.currentMissionSlot);
               }
               else
               {
                  screensM.screenMissionBaseMap.abortingMission();
                  _loc1_ = "pleaseWait";
               }
               break;
            case "loadReplayByCode":
               if(this.txtInput1.text.length < 4)
               {
                  _loc1_ = "invalidReplayCode";
               }
               else
               {
                  remoteM.socketM.lobby_getReplayByCode(this.txtInput1.text);
               }
               break;
            case "starterPackBought":
               if(screensM.isScreenOpened(BMScreensManager.SCR_BUY_STARTER_PACK))
               {
                  screensM.getBuyStarterPackScreen().packBoughtSub();
               }
               break;
            case "mustRedeemStarterPackMech":
               if(screensM.isBuyStarterPackOpened())
               {
                  screensM.getBuyStarterPackScreen().forceToRedeemMech();
               }
               break;
            case "onlineWinsRequiredForItemBox":
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
            case "changeMechBuildName":
               screensM.screenMechBuilds.changeBuildName(this.txtInput1.text);
               break;
            case "cloneMechBuild":
               screensM.screenMechBuilds.cloneConfirmed();
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
            case "doYouWantToJoinThisClan":
               screensM.screenSearchForClan.clanSelected(this._ID1);
               _loc1_ = "pleaseWait";
               break;
            case "tryToLeaveClan":
               remoteM.socketM.clan_leave();
               _loc1_ = "pleaseWait";
               break;
            case "tryToKickMember":
               _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc10_ = _loc3_.clanData.members[this._ID1];
               remoteM.socketM.clan_kick(_loc10_.playerID);
               if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_MEMBERS))
               {
                  screensM.screenClanMembers.resetSelectedMemberSlot();
               }
               if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_CHAT))
               {
                  screensM.screenMultiPlayerChat.memberKickedFromClan(this._ID1);
               }
               _loc1_ = "pleaseWait";
               break;
            case "playerHasLeftClan":
               screensM.screenTransitionsManager.mainMenu();
               break;
            case "clanNotEnoughGold":
               screensM.screenSearchForClan.createClanNotEnoughGoldOKClicked();
               break;
            case "rewardVideosGotTokens":
            case "rewardVideosGotGold":
            case "rewardVideosComeBackLater":
               if(screensM.isScreenOpened(BMScreensManager.SCR_WATCH_REWARDED_VIDEO))
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
            case "buyStarterPack":
               screensM.getBuyStarterPackScreen().buyConfirmed();
               _loc1_ = "buyingPackage";
               break;
            case "buySpecialOfferForTokens":
               trace("screensM.getBuyStarterPackScreen():" + screensM.getBuyStarterPackScreen());
               screensM.getBuyStarterPackScreen().buyStarterPackWithTokensConfirmed();
               break;
            case "buyPackage":
               _loc11_ = dataM.boostsDB[this._ID1];
               if(loginM.isConnected)
               {
                  _loc17_ = 0;
                  _loc18_ = 0;
                  if(_loc11_.type == "specificItem")
                  {
                     _loc17_ = _loc11_.itemID;
                     _loc18_ = _loc11_.costTokens;
                  }
                  remoteM.tokens_buyPackageNew(this._ID1,_loc17_,_loc18_);
                  _loc1_ = "buyingPackage";
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
                     screensM.addScreen(BMScreensManager.SCR_ADMIN_TOOLS);
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
               screensM.screenBattle.closeScreen();
               break;
            case "changePlayerName_tutorial":
            case "changePlayerName_online":
            case "changePlayerNameAndTermsOfUse_online":
               _loc12_ = this.txtInput1.text;
               _loc13_ = 0;
               _loc14_ = 0;
               _loc16_ = 0;
               _loc15_ = 0;
               while(_loc15_ < _loc12_.length)
               {
                  if(_loc12_.substr(_loc15_,1) == " ")
                  {
                     _loc16_++;
                  }
                  else
                  {
                     _loc15_ = _loc12_.length;
                  }
                  _loc15_++;
               }
               if(_loc16_ > 0)
               {
                  _loc12_ = _loc12_.substr(_loc16_,_loc12_.length - _loc16_);
               }
               _loc15_ = 0;
               while(_loc15_ < _loc12_.length)
               {
                  if(_loc12_.substr(_loc15_,1) != " ")
                  {
                     _loc13_ = _loc15_;
                     _loc14_++;
                  }
                  _loc15_++;
               }
               if(_loc13_ < _loc12_.length - 1)
               {
                  _loc12_ = _loc12_.substr(0,_loc13_ + 1);
               }
               if(_loc12_.toLowerCase() == "server")
               {
                  _loc12_ = "SuperMechs Player";
               }
               if(_loc12_ != "" && _loc14_ > 0)
               {
                  _loc19_ = false;
                  switch(this._questionOrNotificationType)
                  {
                     case "changePlayerNameAndTermsOfUse_online":
                        if(this.mcV.visible == false)
                        {
                           _loc19_ = true;
                        }
                  }
                  if(_loc19_)
                  {
                     _loc2_ = false;
                     this.mcErrorMarkTermsOfUse.visible = true;
                  }
                  else
                  {
                     dataM.userName = _loc12_;
                     switch(this._questionOrNotificationType)
                     {
                        case "changePlayerName_online":
                        case "changePlayerNameAndTermsOfUse_online":
                           _loc3_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
                           _loc3_.playerName = _loc12_;
                           remoteM.lobby_changeName(_loc12_);
                           _loc1_ = "pleaseWait";
                           break;
                        case "changePlayerName_tutorial":
                           _loc2_ = false;
                           this.finishConfirmationScreenWithResultCallback(_loc12_);
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
                  if(screensM.isScreenOpened(BMScreensManager.SCR_MAIN_MENU) || screensM.isScreenOpened("screenNewMenu"))
                  {
                     screensM.screenTransitionsManager.multiplayerLadderClicked();
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
               _loc2_ = false;
               this.finishConfirmationScreenWithResultCallback(true);
               break;
            case "customMessage":
               _loc2_ = false;
               this.finishCustomMessageConfirmationScreen();
         }
         this.mcTutorialArrow_button.gotoAndStop("animOff");
         this._ID1 = _loc6_;
         this._ID2 = _loc7_;
         if(_loc1_ == "")
         {
            if(_loc2_)
            {
               screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
            }
         }
         else
         {
            this.displayQuestionOrNotification(_loc1_,this._ID1,this._ID2);
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
         _loc1_ = "android";
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
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         screensM.screenTopBar.getGoldClicked();
         tooltip.hideToolTip();
      }
      
      public function getTokensClicked() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         dataM.openBuyTokensPage(BMScreensManager.SCR_CONFIRMATION);
         tooltip.hideToolTip();
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
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         if(dataM.useNoConnectionMode && dataM.firstSocketConnectionEstablished == false)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("cantRegisterNoInternetConnection",-1,-1);
         }
         else
         {
            loginM.startLoginAsFlow(LoginAsFlowTypes.GUEST);
            screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         }
      }
      
      private function showTermsOfUseText() : void
      {
         var _loc1_:String = getSpecificText("register_termsOfUse");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%COLOR%","<FONT COLOR=\'#00CCFF\'>");
         updateTextAndFormat(this.txtTermsOfUse,_loc1_);
      }
      
      private function showAgeVerificationText() : void
      {
         updateTextAndFormat(this.txtTermsOfUse,getScreenText("ageVerificationContent"));
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
         this.mcSandClock.visible = false;
      }
   }
}

