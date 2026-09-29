package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol812")]
   public class BMScreenPopUp extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcTutorialArrow_button:MovieClip;
      
      public var mcTutorialMarker_button:MovieClip;
      
      public var mcBackground:MovieClip;
      
      public var mcSizer_btnOK:Sprite;
      
      public var mcSizer_btnFacebookPublish:Sprite;
      
      public var mcGold:Sprite;
      
      public var mcItemBox:Sprite;
      
      public var mcTokens:Sprite;
      
      public var btnOK:BMButton;
      
      public var btnFacebookPublish:BMButton_pictureE;
      
      public var txtGoldBonus:TextField;
      
      public var txtTokensBonus:TextField;
      
      public var txtTitle:TextField;
      
      public var _facebookLevelPublished:Boolean = false;
      
      private var _popUpType:String;
      
      private var _unlockedEquipment:Array = new Array();
      
      public var mcItemsUnlockedCenter:Sprite;
      
      private var equipmentUnlocked_sideWeapon:MovieClip;
      
      private var equipmentUnlocked_topWeapon:MovieClip;
      
      private var equipmentUnlocked_drone:MovieClip;
      
      private var equipmentUnlocked_shield:MovieClip;
      
      private var equipmentUnlocked_teleport:MovieClip;
      
      private var equipmentUnlocked_charge:MovieClip;
      
      private var equipmentUnlocked_harpoon:MovieClip;
      
      private var equipmentUnlocked_module:MovieClip;
      
      private var equipmentUnlocked_kit:MovieClip;
      
      private var equipmentUnlocked_mech1:MovieClip;
      
      private var equipmentUnlocked_mech2:MovieClip;
      
      private var equipmentUnlocked_mech3:MovieClip;
      
      private var _equipmentUnlocksAnimationsDoneCounter:uint;
      
      private var _titleOriginYPos:Number;
      
      private var _equipmentIconNames:Object;
      
      private var _btnOKBlockCooldown:Number = 0;
      
      private var _goldIconOriginYPos:Number;
      
      private var _goldTextOriginYPos:Number;
      
      private var _tokensIconOriginXPos:Number;
      
      private var _tokensTextOriginXPos:Number;
      
      private var _firstRefresh:Boolean = true;
      
      private const EQUIPMENT_ICON_SIZE:uint = 65;
      
      private const EQUIPMENT_ICON_X_JUMP:uint = 10;
      
      public function BMScreenPopUp()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("popUp");
      }
      
      public function refreshScreen(param1:String, param2:Number, param3:Number, param4:Array) : void
      {
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenPopUp","btnOK","regular");
            screensM.createButtonFromSizer("screenPopUp","btnFacebookPublish","pictureE");
            _loc5_ = this.OKClicked;
            _loc6_ = this.facebookPublishClicked;
            if(dataM.runAsMobile)
            {
               _loc5_ = null;
               _loc6_ = null;
            }
            this.btnOK.initialize(getGeneralText("OK"),"blue",null,[],_loc5_,dataM.runAsMobile);
            this.btnFacebookPublish.initialize("","",new icon_facebook(),[],_loc6_,dataM.runAsMobile);
            this.btnOK.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnFacebookPublish.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this.mcTutorialArrow_button.mouseEnabled = false;
            this.mcTutorialArrow_button.mouseChildren = false;
            this.mcTutorialMarker_button.mouseEnabled = false;
            this.mcTutorialMarker_button.mouseChildren = false;
            this._equipmentIconNames = new Object();
            this._equipmentIconNames["sideWeapon"] = "subType_inventory_sideWeapon";
            this._equipmentIconNames["topWeapon"] = "subType_inventory_topWeapon";
            this._equipmentIconNames["drone"] = "subType_inventory_drone";
            this._equipmentIconNames["shield"] = "subType_inventory_shield";
            this._equipmentIconNames["teleport"] = "emptyItem_teleport2";
            this._equipmentIconNames["charge"] = "emptyItem_charge2";
            this._equipmentIconNames["harpoon"] = "emptyItem_harpoon2";
            this._equipmentIconNames["module"] = "subType_inventory_module";
            this._equipmentIconNames["kit"] = "subType_inventory_kit";
            this._equipmentIconNames["mech1"] = "subType_inventory_all";
            this._equipmentIconNames["mech2"] = "subType_inventory_all";
            this._equipmentIconNames["mech3"] = "subType_inventory_all";
            this._titleOriginYPos = this.txtTitle.y;
            this._goldIconOriginYPos = this.mcGold.y;
            this._goldTextOriginYPos = this.txtGoldBonus.y;
            this._tokensIconOriginXPos = this.mcTokens.x;
            this._tokensTextOriginXPos = this.txtTokensBonus.x;
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this._popUpType = param1;
         if(param4 == null)
         {
            this._unlockedEquipment = new Array();
         }
         else
         {
            this._unlockedEquipment = param4;
         }
         this.txtTitle.text = "";
         this.txtGoldBonus.visible = false;
         this.txtTokensBonus.visible = false;
         this.mcGold.visible = false;
         this.mcItemBox.visible = false;
         this.mcTokens.visible = false;
         this.btnOK.visible = false;
         this.btnFacebookPublish.visible = false;
         this.txtGoldBonus.text = dataM.getNumberWithComma(param2);
         this.txtTokensBonus.text = dataM.getNumberWithComma(param3);
         this.txtTitle.y = this._titleOriginYPos;
         switch(param1)
         {
            case "equipmentUnlocked":
            case "extendedItemBoxUnlocked":
               this.backgroundOpened();
               break;
            default:
               this.createTextsBitmapForMobile();
               this.mcBackground.gotoAndStop("open");
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtTitle,26);
            TextUtils.updateTextFormat(this.txtGoldBonus,26);
            TextUtils.updateTextFormat(this.txtTokensBonus,26);
            param1 = true;
         }
         if(param1)
         {
            this.btnOK.setButtonName(getGeneralText("OK"));
         }
      }
      
      private function createTextsBitmapForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("popup_texts",[this.txtTitle,this.txtGoldBonus,this.txtTokensBonus],"",this);
         }
      }
      
      public function backgroundOpened() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc4_:BMPlayerProfile = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:MovieClip = null;
         var _loc9_:uint = 0;
         switch(this._popUpType)
         {
            case "stompUnlocked":
               this.txtTitle.text = getScreenText("meleeAttackUnlocked");
               _loc1_ = dataM.STAGE_WIDTH / 2;
               _loc2_ = dataM.STAGE_HEIGHT / 2 + 30;
               effectsM.createMovingImage(screensM.screenBattleInterfaceBottom.btn5,_loc1_,_loc2_,this,this.stompAnimationDone,true,0,0,40,10,false);
               effectsM.allowMovingImageMotion(effectsM.movingImageIDCounter);
               break;
            case "levelUp":
               this.txtTitle.text = getScreenText("levelUpBonus");
               this.txtGoldBonus.visible = true;
               this.mcGold.visible = true;
               if(this.txtTokensBonus.text == "0")
               {
                  this.txtGoldBonus.y = this._goldTextOriginYPos + 15;
                  this.mcGold.y = this._goldIconOriginYPos + 15;
               }
               else
               {
                  this.txtTokensBonus.visible = true;
                  this.mcTokens.visible = true;
                  this.txtGoldBonus.y = this._goldTextOriginYPos;
                  this.mcGold.y = this._goldIconOriginYPos;
                  if(int(this.txtTokensBonus.text) < 100)
                  {
                     this.txtTokensBonus.x = this._tokensTextOriginXPos + 12;
                     this.mcTokens.x = this._tokensIconOriginXPos + 12;
                  }
                  else
                  {
                     this.txtTokensBonus.x = this._tokensTextOriginXPos;
                     this.mcTokens.x = this._tokensIconOriginXPos;
                  }
               }
               this.btnOK.visible = true;
               _loc4_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(_loc4_.level <= 3)
               {
                  this.mcTutorialArrow_button.gotoAndStop("animOn");
                  this.mcTutorialMarker_button.gotoAndStop("animOn");
               }
               break;
            case "equipmentUnlocked":
               this.txtTitle.text = getScreenText("equipmentUnlocked");
               if(this.txtTitle.numLines >= 2)
               {
                  this.txtTitle.y = this._titleOriginYPos - 12;
               }
               this._equipmentUnlocksAnimationsDoneCounter = 0;
               _loc6_ = 0;
               while(_loc6_ < this._unlockedEquipment.length)
               {
                  _loc7_ = this._unlockedEquipment[_loc6_];
                  if(this["equipmentUnlocked_" + _loc7_] == null)
                  {
                     this.createEquipmentIcon(_loc7_,this._equipmentIconNames[_loc7_]);
                  }
                  _loc8_ = this["equipmentUnlocked_" + _loc7_];
                  _loc9_ = this.EQUIPMENT_ICON_SIZE + this.EQUIPMENT_ICON_X_JUMP;
                  _loc8_.x = this.mcItemsUnlockedCenter.x + (_loc6_ * _loc9_ - (this._unlockedEquipment.length - 1) / 2 * _loc9_);
                  _loc8_.y = this.mcItemsUnlockedCenter.y;
                  _loc8_.scaleX = 0.1;
                  _loc8_.scaleY = 0.1;
                  _loc8_.delayFrames = _loc6_ * 10;
                  _loc8_.reachedExtraSize = false;
                  _loc8_.animationDone = false;
                  _loc8_.visible = false;
                  this.mcIconsHolder.addChild(_loc8_);
                  _loc6_++;
               }
               break;
            case "extendedItemBoxUnlocked":
               this._btnOKBlockCooldown = 20;
               this.btnOK.disableMe();
               _loc5_ = getScreenText("extendedItemBoxUnlocked");
               _loc5_ = dataM.replaceStringInText(_loc5_,"%LEVEL1%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>" + dataM.levelForExpandedItemBox + "</FONT>");
               _loc5_ = dataM.replaceStringInText(_loc5_,"%LEVEL2%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>" + dataM.LEVEL_MAX + "</FONT>");
               this.txtTitle.htmlText = _loc5_;
               this.txtTitle.y = this._titleOriginYPos - 10;
               this.mcItemBox.visible = true;
               this.btnOK.visible = true;
               break;
            case "challengeCompleted":
               this.txtTitle.text = getScreenText("challengeBonus");
               this.txtGoldBonus.visible = true;
               this.mcGold.visible = true;
               this.btnOK.visible = true;
         }
         var _loc3_:TextFormat = this.txtTitle.getTextFormat();
         switch(dataM.languageID)
         {
            case 5:
               _loc3_.size = 23;
               break;
            default:
               _loc3_.size = 26;
         }
         this.txtTitle.setTextFormat(_loc3_);
         this.createTextsBitmapForMobile();
      }
      
      private function stompAnimationDone() : void
      {
         switch(this._popUpType)
         {
            case "stompUnlocked":
               screensM.screenBattleInterfaceBottom.btn5.visible = true;
         }
         this.btnOK.visible = true;
         this.mcTutorialArrow_button.gotoAndStop("animOn");
         this.mcTutorialMarker_button.gotoAndStop("animOn");
      }
      
      public function backgroundClosed() : void
      {
         screensM.removeScreen("screenPopUp");
         switch(this._popUpType)
         {
            case "stompUnlocked":
               screensM.screenBattle.stompUnlockedPopUpClosed();
               screensM.stagePointer.focus = screensM.screenBattle;
               break;
            case "challengeCompleted":
               screensM.screenBattle.challengeIsOver();
               break;
            default:
               screensM.screenLevelUp.screenPopUpClosed();
         }
      }
      
      public function OKClicked() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         switch(this._popUpType)
         {
            case "stompUnlocked":
               break;
            case "levelUp":
               this.txtGoldBonus.visible = false;
               this.txtTokensBonus.visible = false;
               this.mcGold.visible = false;
               this.mcTokens.visible = false;
               this.mcTutorialArrow_button.gotoAndStop("animOff");
               this.mcTutorialMarker_button.gotoAndStop("animOff");
               if(this._unlockedEquipment != null)
               {
                  if(this._unlockedEquipment.length > 0)
                  {
                     _loc2_ = true;
                  }
               }
               if(_loc1_.level == dataM.levelForExpandedItemBox)
               {
                  _loc3_ = true;
               }
               break;
            case "equipmentUnlocked":
               if(_loc1_.level == dataM.levelForExpandedItemBox)
               {
                  _loc3_ = true;
               }
               break;
            case "extendedItemBoxUnlocked":
               this.mcItemBox.visible = false;
               break;
            case "challengeCompleted":
               this.txtGoldBonus.visible = false;
               this.mcGold.visible = false;
         }
         this.txtTitle.text = "";
         this.createTextsBitmapForMobile();
         this.btnOK.visible = false;
         this.mcTutorialArrow_button.gotoAndStop("animOff");
         this.mcTutorialMarker_button.gotoAndStop("animOff");
         this.removeAllEquipmentUnlocks();
         if(_loc2_)
         {
            this.refreshScreen("equipmentUnlocked",0,0,this._unlockedEquipment);
         }
         else if(_loc3_)
         {
            this.refreshScreen("extendedItemBoxUnlocked",0,0,null);
         }
         else
         {
            this.mcBackground.gotoAndStop("close");
         }
      }
      
      public function facebookPublishClicked() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("facebookPublish_levelUp",-1,-1);
      }
      
      public function facebookLevelPublished() : void
      {
         this._facebookLevelPublished = true;
         this.btnFacebookPublish.disableMe();
      }
      
      public function onEnterFrameTrigger() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         if(parent != null)
         {
            switch(this._popUpType)
            {
               case "equipmentUnlocked":
                  _loc1_ = 0;
                  while(_loc1_ < this._unlockedEquipment.length)
                  {
                     if(this["equipmentUnlocked_" + this._unlockedEquipment[_loc1_]] != null)
                     {
                        _loc2_ = this["equipmentUnlocked_" + this._unlockedEquipment[_loc1_]];
                        if(_loc2_.animationDone == false)
                        {
                           if(_loc2_.delayFrames > 0)
                           {
                              --_loc2_.delayFrames;
                           }
                           else
                           {
                              if(_loc2_.visible == false)
                              {
                                 _loc2_.visible = true;
                              }
                              if(_loc2_.reachedExtraSize == false)
                              {
                                 _loc2_.scaleX += 0.15;
                                 _loc2_.scaleY += 0.15;
                                 if(_loc2_.scaleX >= 1.15)
                                 {
                                    _loc2_.reachedExtraSize = true;
                                 }
                              }
                              else
                              {
                                 _loc2_.scaleX -= 0.1;
                                 _loc2_.scaleY -= 0.1;
                                 if(_loc2_.scaleX <= 1)
                                 {
                                    _loc2_.scaleX = 1;
                                    _loc2_.scaleY = 1;
                                    _loc2_.animationDone = true;
                                    ++this._equipmentUnlocksAnimationsDoneCounter;
                                    if(this._equipmentUnlocksAnimationsDoneCounter >= this._unlockedEquipment.length)
                                    {
                                       this.btnOK.visible = true;
                                    }
                                 }
                              }
                           }
                        }
                     }
                     _loc1_++;
                  }
            }
            if(this._btnOKBlockCooldown > 0)
            {
               --this._btnOKBlockCooldown;
               if(this._btnOKBlockCooldown == 0)
               {
                  this.btnOK.enableMe();
               }
            }
         }
      }
      
      private function removeAllEquipmentUnlocks() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._unlockedEquipment.length)
         {
            if(this["equipmentUnlocked_" + this._unlockedEquipment[_loc1_]] != null)
            {
               if(this["equipmentUnlocked_" + this._unlockedEquipment[_loc1_]].parent != null)
               {
                  this["equipmentUnlocked_" + this._unlockedEquipment[_loc1_]].parent.removeChild(this["equipmentUnlocked_" + this._unlockedEquipment[_loc1_]]);
               }
               this["equipmentUnlocked_" + this._unlockedEquipment[_loc1_]] = null;
            }
            _loc1_++;
         }
      }
      
      private function createEquipmentIcon(param1:String, param2:String) : void
      {
         var _loc3_:MovieClip = externalAssetsM.getAsset("general",param2,this.EQUIPMENT_ICON_SIZE,this.EQUIPMENT_ICON_SIZE,false,false);
         _loc3_.x = -this.EQUIPMENT_ICON_SIZE / 2;
         _loc3_.y = -this.EQUIPMENT_ICON_SIZE / 2;
         this["equipmentUnlocked_" + param1] = new MovieClip();
         this["equipmentUnlocked_" + param1].addChild(_loc3_);
      }
   }
}

