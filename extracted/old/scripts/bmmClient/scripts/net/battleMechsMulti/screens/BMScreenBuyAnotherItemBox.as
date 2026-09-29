package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol531")]
   public class BMScreenBuyAnotherItemBox extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_tileList:Sprite;
      
      public var mcSizer_tileList_mobile:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var txtTitle:TextField;
      
      public var btnBack:BMButton_pictureE;
      
      public var packagesTileList:BMTileList;
      
      private var _titleOriginYPos:Number;
      
      private var _firstRefresh:Boolean = true;
      
      private const ITEM_WIDTH:uint = 180;
      
      private const ITEM_HEIGHT:uint = 145;
      
      private const PACKAGES_ROWS:uint = 1;
      
      private const PACKAGES_COLUMS:uint = 2;
      
      private const ITEM_WIDTH_MOBILE:uint = 307;
      
      private const ITEM_HEIGHT_MOBILE:uint = 167;
      
      private const PACKAGES_ROWS_MOBILE:uint = 1;
      
      private const PACKAGES_COLUMS_MOBILE:uint = 2;
      
      public function BMScreenBuyAnotherItemBox()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("buyAnotherItemBox");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         if(this._firstRefresh)
         {
            if(dataM.runAsMobile)
            {
               this.mcSizer_btnBack.x += (this.mcSizer_tileList_mobile.width - this.mcSizer_tileList.width) / 2;
               this.mcBackground.gotoAndStop("mobile");
            }
            screensM.createButtonFromSizer("screenBuyAnotherItemBox","btnBack","pictureE");
            _loc1_ = this.backClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc1_,dataM.runAsMobile);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this._titleOriginYPos = this.txtTitle.y;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this.addAndRefreshPackagesTileList();
      }
      
      private function languageUpdate() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc1_ = 20;
            _loc2_ = 0;
            if(dataM.runAsMobile)
            {
               switch(dataM.languageID)
               {
                  case 1:
                  case 5:
                     break;
                  default:
                     _loc2_ = 2;
               }
            }
            else
            {
               switch(dataM.languageID)
               {
                  case 3:
                     _loc1_ = 14;
                     _loc2_ = 6;
                     break;
                  case 7:
                     _loc1_ = 15;
                     _loc2_ = 6;
                     break;
                  case 5:
                  case 10:
                     _loc1_ = 17;
                     _loc2_ = 5;
                     break;
                  case 9:
                     _loc1_ = 12;
                     _loc2_ = 6;
               }
            }
            TextUtils.updateTextFormat(this.txtTitle,_loc1_);
            this.txtTitle.y = this._titleOriginYPos + _loc2_;
         }
         this.txtTitle.text = getScreenText("title");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyAnotherItemBox_title",[this.txtTitle],"",this);
         }
      }
      
      private function addAndRefreshPackagesTileList() : void
      {
         var _loc10_:MovieClip = null;
         var _loc14_:uint = 0;
         var _loc15_:BMBoostData = null;
         var _loc16_:MovieClip = null;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:uint = 0;
         var _loc23_:Number = NaN;
         var _loc24_:Boolean = false;
         var _loc25_:Number = NaN;
         var _loc26_:BMItem = null;
         var _loc27_:BMTileListItem = null;
         var _loc28_:Function = null;
         var _loc29_:Function = null;
         var _loc30_:Function = null;
         var _loc31_:Function = null;
         var _loc32_:String = null;
         var _loc33_:Boolean = false;
         var _loc34_:String = null;
         var _loc35_:uint = 0;
         var _loc36_:Number = NaN;
         var _loc37_:Array = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this.packagesTileList != null)
         {
            this.packagesTileList.removeMe();
            this.packagesTileList = null;
         }
         var _loc2_:Array = [5,6];
         var _loc3_:Array = new Array();
         var _loc4_:Number = 0;
         var _loc5_:uint = this.ITEM_WIDTH;
         var _loc6_:uint = this.ITEM_HEIGHT;
         var _loc7_:uint = this.PACKAGES_ROWS;
         var _loc8_:uint = this.PACKAGES_COLUMS;
         if(dataM.runAsMobile)
         {
            _loc5_ = this.ITEM_WIDTH_MOBILE;
            _loc6_ = this.ITEM_HEIGHT_MOBILE;
            _loc7_ = this.PACKAGES_ROWS_MOBILE;
            _loc8_ = this.PACKAGES_COLUMS_MOBILE;
         }
         var _loc9_:uint = 0;
         while(_loc9_ < _loc2_.length)
         {
            _loc14_ = uint(_loc2_[_loc9_]);
            _loc15_ = dataM.boostsDB[_loc14_];
            if(dataM.runAsMobile)
            {
               _loc16_ = new PackageButton_mobile1();
            }
            else
            {
               _loc16_ = new PackageButton();
            }
            _loc17_ = 18;
            _loc18_ = 16;
            _loc19_ = 27;
            _loc20_ = 22;
            _loc21_ = 22;
            _loc22_ = 27;
            if(dataM.runAsMobile)
            {
               _loc17_ = 27;
               _loc18_ = 24;
               switch(dataM.languageID)
               {
                  case 3:
                     _loc22_ = 28;
                     _loc19_ = 27;
                     _loc20_ = 18;
                     _loc21_ = 20;
                     _loc17_ = 20;
                     break;
                  case 7:
                     _loc17_ = 22;
                     break;
                  case 9:
                     _loc17_ = 24;
                     _loc18_ = 22;
               }
               switch(dataM.languageID)
               {
                  case 1:
                  case 5:
                     break;
                  default:
                     _loc22_ = 35;
                     _loc16_.txtCostTokensGold.y -= 3;
               }
            }
            else
            {
               _loc22_ = 20;
               _loc19_ = 20;
               switch(dataM.languageID)
               {
                  case 3:
                     _loc16_.txtCostTokensGold.y -= 3;
                     _loc22_ = 28;
                     _loc18_ = 14;
                     _loc19_ = 20;
                     break;
                  case 9:
                     _loc17_ = 14;
                     _loc18_ = 14;
               }
            }
            TextUtils.updateTextFormat(_loc16_.txtPackageName,_loc17_);
            TextUtils.updateTextFormat(_loc16_.txtPackageNameSmall,_loc18_);
            TextUtils.updateTextFormat(_loc16_.txtAvailable,_loc19_);
            TextUtils.updateTextFormat(_loc16_.txtCostTokensGold,_loc22_);
            _loc16_.gotoAndStop("package" + _loc14_);
            _loc16_.txtPackageName.text = "";
            _loc16_.txtPackageNameSmall.text = "";
            _loc16_.txtPremiumAccountDays.text = "";
            _loc16_.txtAvailable.text = "";
            _loc16_.txtBonusGold.text = "";
            if(dataM.runAsMobile)
            {
               TextUtils.updateTextFormat(_loc16_.txtItemBoxRarity,_loc20_);
               TextUtils.updateTextFormat(_loc16_.txtItemBoxItems,_loc21_);
               _loc16_.txtItemBoxRarity.text = "";
               _loc16_.txtItemBoxItems.text = "";
            }
            _loc23_ = _loc15_.costTokens;
            _loc16_.txtCostTokensGold.x -= 7.5;
            _loc16_.txtCostTokensGold.text = dataM.getNumberWithComma(_loc23_);
            if(_loc15_.bonusGold > 0)
            {
               _loc16_.txtBonusGold.text = dataM.getNumberWithComma(_loc15_.bonusGold);
            }
            if(dataM.runAsMobile)
            {
               _loc32_ = getSpecificText("packages_itemBoxItems");
               _loc32_ = dataM.replaceStringInText(_loc32_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
               _loc32_ = dataM.replaceStringInText(_loc32_,"%AMOUNT%",String(_loc15_.amount));
               _loc16_.txtItemBoxItems.htmlText = TextUtils.getTextFont() + _loc32_;
               _loc33_ = false;
               if(_loc15_.ratioMythical > 0)
               {
                  _loc33_ = true;
               }
               if(_loc33_)
               {
                  _loc34_ = getSpecificText("packages_itemBoxRarityMythical");
                  _loc34_ = dataM.replaceStringInText(_loc34_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_EPIC_ITEM + "\'>");
                  _loc34_ = dataM.replaceStringInText(_loc34_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
                  _loc34_ = dataM.replaceStringInText(_loc34_,"%COLOR3%","<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>");
                  _loc34_ = dataM.replaceStringInText(_loc34_,"%EPIC%",String(_loc15_.ratioEpic));
                  _loc34_ = dataM.replaceStringInText(_loc34_,"%LEGENDARY%",String(_loc15_.ratioLegendary));
                  _loc34_ = dataM.replaceStringInText(_loc34_,"%MYTHICAL%",String(_loc15_.ratioMythical));
               }
               else
               {
                  _loc34_ = getSpecificText("packages_itemBoxRarityLegendary");
                  _loc34_ = dataM.replaceStringInText(_loc34_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_EPIC_ITEM + "\'>");
                  _loc34_ = dataM.replaceStringInText(_loc34_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
                  _loc34_ = dataM.replaceStringInText(_loc34_,"%RARE%",String(_loc15_.ratioRare));
                  _loc34_ = dataM.replaceStringInText(_loc34_,"%EPIC%",String(_loc15_.ratioEpic));
                  _loc34_ = dataM.replaceStringInText(_loc34_,"%LEGENDARY%",String(_loc15_.ratioLegendary));
               }
               _loc35_ = 0;
               if(dataM.runAsMobile)
               {
                  switch(dataM.languageID)
                  {
                     case 3:
                        _loc35_ = 9;
                        break;
                     case 1:
                     case 5:
                        _loc35_ = 1;
                        break;
                     default:
                        _loc35_ = 3;
                  }
               }
               _loc16_.txtItemBoxRarity.htmlText = TextUtils.getTextFont(_loc20_,_loc35_) + _loc34_;
            }
            _loc16_.txtPackageName.text = _loc15_.boostName;
            if(_loc15_.costTokens < _loc15_.costTokensDefault)
            {
               _loc36_ = Math.floor(100 - _loc15_.costTokens / _loc15_.costTokensDefault * 100);
               _loc16_.txtDiscount.text = "-" + _loc36_ + "%";
            }
            else
            {
               _loc16_.mcDiscountBadge.parent.removeChild(_loc16_.mcDiscountBadge);
               _loc16_.txtDiscount.text = "";
            }
            _loc24_ = false;
            _loc25_ = _loc1_.getFreePackageAmount(_loc14_);
            if(_loc25_ > 0)
            {
               _loc24_ = true;
            }
            _loc16_.mcTokens.visible = false;
            _loc16_.mcGold.visible = false;
            _loc16_.txtCostTokensGold.visible = false;
            if(_loc24_)
            {
               _loc16_.txtAvailable.text = getSpecificText("packages_available");
               if(_loc25_ > 1)
               {
                  _loc16_.txtAvailable.text = _loc16_.txtAvailable.text + " (" + _loc25_ + ")";
               }
            }
            else
            {
               _loc16_.txtAvailable.text = "";
               if(_loc15_.costGold > 0)
               {
                  _loc16_.mcGold.visible = true;
               }
               else
               {
                  _loc16_.mcTokens.visible = true;
               }
               _loc16_.txtCostTokensGold.visible = true;
            }
            _loc16_.mcDisabledEffect.visible = false;
            _loc26_ = new BMItem();
            if(dataM.runAsMobile)
            {
               _loc37_ = [_loc16_.txtPackageName,_loc16_.txtPackageNameSmall,_loc16_.txtPremiumAccountDays,_loc16_.txtAvailable,_loc16_.txtCostTokensGold,_loc16_.txtBonusGold];
               if(dataM.runAsMobile)
               {
                  _loc37_.push(_loc16_.txtItemBoxRarity,_loc16_.txtItemBoxItems);
               }
               _loc26_.createAssetsBitmap(_loc37_,null,_loc16_.mcTextsHolder);
            }
            _loc26_.initialize(_loc14_,_loc5_,_loc6_,_loc16_,0,_loc4_,false,null,dataM.runAsMobile);
            _loc27_ = new BMTileListItem();
            _loc28_ = this.packageClicked;
            _loc29_ = this.packageMouseOver;
            _loc30_ = this.packageMouseOut;
            _loc31_ = this.packageMouseDown;
            if(dataM.runAsMobile)
            {
               _loc28_ = null;
               _loc29_ = null;
               _loc30_ = null;
               _loc31_ = null;
            }
            _loc27_.initialize(_loc5_,_loc6_,_loc26_,"","","",0,_loc28_,_loc31_,_loc30_,_loc29_,_loc30_,dataM.runAsMobile);
            _loc3_.push(_loc27_);
            _loc9_++;
         }
         this.packagesTileList = new BMTileList();
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:uint = 0;
         this.packagesTileList.initialize(screensM.stagePointer,_loc3_,_loc7_,_loc8_,_loc5_,_loc6_,null,_loc11_,_loc10_,null,null,false,_loc13_,1,false,_loc12_,dataM.runAsMobile);
         if(dataM.runAsMobile)
         {
            this.packagesTileList.x = this.mcSizer_tileList_mobile.x;
            this.packagesTileList.y = this.mcSizer_tileList_mobile.y;
         }
         else
         {
            this.packagesTileList.x = this.mcSizer_tileList.x;
            this.packagesTileList.y = this.mcSizer_tileList.y;
         }
         this.mcButtonsHolder.addChild(this.packagesTileList);
      }
      
      private function packageClicked(param1:Number, param2:uint) : void
      {
         if(param2 > -1)
         {
            this.packageClickedSub(param2);
         }
      }
      
      public function packageClickedSub(param1:Number) : void
      {
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:BMBoostData = null;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         if(param1 > -1)
         {
            _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc3_ = dataM.boostsDB[param1];
            _loc4_ = false;
            if(_loc2_.getFreePackageAmount(param1) > 0)
            {
               _loc4_ = true;
            }
            _loc5_ = false;
            _loc6_ = false;
            if(_loc3_.costTokens > _loc2_.tokens)
            {
               _loc5_ = true;
            }
            if(_loc3_.costGold > _loc2_.gold)
            {
               _loc6_ = true;
            }
            if(_loc4_ == false && (_loc5_ || _loc6_))
            {
               if(_loc5_)
               {
                  if(dataM.runAsMobile == false && dataM.usePersonaly)
                  {
                     screensM.screenGetTokens.refreshScreen(param1);
                     screensM.addScreen("screenGetTokens");
                  }
                  else
                  {
                     screensM.screenConfirmation.displayQuestionOrNotification("notEnoughTokens",param1,-1);
                  }
               }
               else
               {
                  screensM.screenConfirmation.displayQuestionOrNotification("notEnoughGold",param1,-1);
               }
            }
            else if(_loc4_)
            {
               remoteM.tokens_buyPackageNew(param1);
               if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
               {
                  screensM.screenConfirmation.displayQuestionOrNotification("buyingPackage",-1,-1);
               }
            }
            else
            {
               screensM.screenConfirmation.displayQuestionOrNotification("buyPackage",param1,-1);
            }
            soundM.createSound("buttonClick",1);
         }
      }
      
      private function packageMouseDown(param1:Number, param2:uint) : void
      {
      }
      
      public function packageMouseDownSub(param1:MovieClip) : void
      {
         if(param1.mcBackground.currentLabel != "mouseDown")
         {
            param1.mcBackground.gotoAndStop("mouseDown");
         }
      }
      
      private function packageMouseOver(param1:Number, param2:uint) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc9_:String = null;
         soundM.createSound("buttonRollover",1);
         var _loc3_:BMBoostData = dataM.boostsDB[param2];
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc5_:BMBoostData = dataM.boostsDB[param2];
         if(_loc4_.level >= dataM.levelForExpandedItemBox)
         {
            _loc6_ = dataM.levelForExpandedItemBox;
            _loc7_ = dataM.LEVEL_MAX;
         }
         else
         {
            _loc6_ = _loc4_.level - _loc5_.levelDifference;
            _loc7_ = _loc4_.level + _loc5_.levelDifference;
            if(_loc6_ < 2)
            {
               _loc6_ = 2;
            }
         }
         var _loc8_:Boolean = false;
         if(_loc5_.ratioMythical > 0)
         {
            _loc8_ = true;
         }
         if(_loc8_)
         {
            _loc9_ = getSpecificText("packages_randomItemsTooltipWithMythical");
         }
         else
         {
            _loc9_ = getSpecificText("packages_randomItemsTooltip");
         }
         _loc9_ = dataM.replaceStringInText(_loc9_,"%ITEMS%",String(_loc5_.amount));
         _loc9_ = dataM.replaceStringInText(_loc9_,"%LEVEL1%",String(_loc6_));
         _loc9_ = dataM.replaceStringInText(_loc9_,"%LEVEL2%",String(_loc7_));
         _loc9_ = dataM.replaceStringInText(_loc9_,"%RARE%",String(_loc5_.ratioRare));
         _loc9_ = dataM.replaceStringInText(_loc9_,"%EPIC%",String(_loc5_.ratioEpic));
         _loc9_ = dataM.replaceStringInText(_loc9_,"%LEGENDARY%",String(_loc5_.ratioLegendary));
         _loc9_ = dataM.replaceStringInText(_loc9_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
         _loc9_ = dataM.replaceStringInText(_loc9_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_RARE_ITEM + "\'>");
         _loc9_ = dataM.replaceStringInText(_loc9_,"%COLOR3%","<FONT COLOR=\'#" + dataM.COLOR_EPIC_ITEM + "\'>");
         _loc9_ = dataM.replaceStringInText(_loc9_,"%COLOR4%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
         if(_loc8_)
         {
            _loc9_ = dataM.replaceStringInText(_loc9_,"%MYTHICAL%",String(_loc5_.ratioMythical));
            _loc9_ = dataM.replaceStringInText(_loc9_,"%COLOR5%","<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>");
            _loc9_ = dataM.replaceStringInText(_loc9_,"%RATIO%",String(_loc5_.ratioNewMythical));
            _loc9_ = dataM.replaceStringInText(_loc9_,"%COLOR6%","<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>");
         }
         tooltip.showToolTip("regularText",_loc9_,-1,-1);
      }
      
      private function packageMouseOut(param1:Number, param2:uint) : void
      {
         tooltip.hideToolTip();
      }
      
      public function boostsHaveBeenModified() : void
      {
         if(dataM.isTutorialActive() == false)
         {
            this.refreshScreen();
            screensM.screenConfirmation.displayQuestionOrNotification("boostsHaveBeenModified",-1,-1);
         }
      }
      
      public function backClicked() : void
      {
         this.removeMe();
         screensM.screenMissionWorldMap.screenBuyAnotherItemBoxClosed();
      }
      
      public function removeMe() : void
      {
         if(this.packagesTileList != null)
         {
            this.packagesTileList.removeMe();
            this.packagesTileList = null;
         }
         screensM.removeScreen("screenBuyAnotherItemBox");
      }
   }
}

