package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMShopManager;
   import net.battleMechsMulti.managers.externalImages.BMExternalImage;
   import net.battleMechsMulti.managers.externalImages.BMExternalImagesManager;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.mobiles.BMClanFlag;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMNewsData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1082")]
   public class BMScreenNews extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSpecialSalesHolder:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcFingerWheeling:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnNext:Sprite;
      
      public var mcSizer_btnPrevious:Sprite;
      
      public var mcSizer_tileList:Sprite;
      
      public var mcSizer_externalImage:Sprite;
      
      public var mcSizer_btnBack2:Sprite;
      
      public var mcSpecialSaleHitArea:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtNews:TextField;
      
      public var txtDate:TextField;
      
      public var txtNewItems:TextField;
      
      public var btnBack:BMButton;
      
      public var btnNext:BMButton_pictureE;
      
      public var btnPrevious:BMButton_pictureE;
      
      public var btnBack2:BMButton_pictureE;
      
      public var mcItemsTileListFrame:MovieClip;
      
      public var mcWeeklyWins:MovieClip;
      
      public var mcSandClock:MovieClip;
      
      public var mcBlackFriday:Sprite;
      
      public var mcCyberMonday:Sprite;
      
      public var mcChristmas1:Sprite;
      
      public var mcChristmas2:Sprite;
      
      public var mcPreHolidayPowerKits:Sprite;
      
      public var mcChineseNewYear:Sprite;
      
      public var itemsTileList:BMTileList;
      
      public var mcNew:Sprite;
      
      public var rewardsTileListItems:Array = new Array();
      
      private var _currentNewsID:Number;
      
      private var _currentNewsNumber:Number;
      
      private var _itemIDs:Array = new Array();
      
      private var _tileListOriginXPos:Number;
      
      private var _tileListFrameOriginXPos:Number;
      
      private var _currentNewsType:String;
      
      private var _fingerWheeling:BMFingerWheeling;
      
      private var _externalImage:BMExternalImage;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenNews()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("news");
      }
      
      public function refreshScreen() : void
      {
         var _loc2_:String = null;
         var _loc3_:Date = null;
         var _loc4_:BMNewsData = null;
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         var _loc7_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenNews","btnBack","regular");
            screensM.createButtonFromSizer("screenNews","btnNext","pictureE");
            screensM.createButtonFromSizer("screenNews","btnPrevious","pictureE");
            screensM.createButtonFromSizer("screenNews","btnBack2","pictureE");
            _loc5_ = this.backClicked;
            _loc6_ = this.nextClicked;
            _loc7_ = this.previousClicked;
            if(dataM.runAsMobile)
            {
               _loc5_ = null;
               _loc6_ = null;
               _loc7_ = null;
            }
            this.btnBack.initialize(getScreenText("close"),"blue",null,null,_loc5_,dataM.runAsMobile);
            this.btnNext.initialize("","",externalAssetsM.getAsset("general","interface_forward"),null,_loc6_,dataM.runAsMobile);
            this.btnPrevious.initialize("","",externalAssetsM.getAsset("general","interface_backward"),null,_loc7_,dataM.runAsMobile);
            this.btnBack2.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnNext.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnPrevious.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack2.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this._currentNewsNumber = 1;
            this._tileListOriginXPos = this.mcSizer_tileList.x;
            this._tileListFrameOriginXPos = this.mcItemsTileListFrame.x;
            this.languageUpdate();
            this.mcSizer_tileList.mouseEnabled = false;
            this.mcSizer_tileList.mouseChildren = false;
            if(dataM.runAsMobile)
            {
               this._fingerWheeling = new BMFingerWheeling();
               this._fingerWheeling.initialize("news",this.itemsTileList,this.mcFingerWheeling,null,this.mobileItemMouseDown,true);
               addChild(this._fingerWheeling);
            }
            else
            {
               this.mcFingerWheeling.parent.removeChild(this.mcFingerWheeling);
               this.mcFingerWheeling = null;
            }
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         var _loc1_:Number = 0;
         for each(_loc4_ in dataM.newsDB)
         {
            if(_loc3_ == null)
            {
               _loc2_ = _loc4_.postDateString;
               _loc3_ = _loc4_.postDate;
               _loc1_ = _loc4_.newsID;
            }
            else if(_loc3_ < _loc4_.postDate)
            {
               _loc2_ = _loc4_.postDateString;
               _loc3_ = _loc4_.postDate;
               _loc1_ = _loc4_.newsID;
            }
            else if(_loc2_ == _loc4_.postDateString)
            {
               if(_loc1_ < _loc4_.newsID)
               {
                  _loc2_ = _loc4_.postDateString;
                  _loc3_ = _loc4_.postDate;
                  _loc1_ = _loc4_.newsID;
               }
            }
         }
         this._currentNewsNumber = 1;
         this._currentNewsID = _loc1_;
         this.mcSpecialSaleHitArea.buttonMode = true;
         this.mcSpecialSaleHitArea.useHandCursor = true;
         this.refreshNews();
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = 33;
         switch(dataM.languageID)
         {
            case 5:
               _loc2_ = 28;
         }
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtDate,14);
            TextUtils.updateTextFormat(this.txtNewItems,28);
            TextUtils.updateTextFormat(this.txtNews,14);
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.mcWeeklyWins.txtClan1,20);
            TextUtils.updateTextFormat(this.mcWeeklyWins.txtClan2,20);
            TextUtils.updateTextFormat(this.mcWeeklyWins.txtClan3,20);
            TextUtils.updateTextFormat(this.mcWeeklyWins.txtPlayer1,20);
            TextUtils.updateTextFormat(this.mcWeeklyWins.txtPlayer2,20);
            TextUtils.updateTextFormat(this.mcWeeklyWins.txtPlayer3,20);
            TextUtils.updateTextFormat(this.mcWeeklyWins.txtGold1,20);
            TextUtils.updateTextFormat(this.mcWeeklyWins.txtGold2,20);
            TextUtils.updateTextFormat(this.mcWeeklyWins.txtGold3,20);
            TextUtils.updateTextFormat(this.mcWeeklyWins.txtTitle_clans,20);
            TextUtils.updateTextFormat(this.mcWeeklyWins.txtTitle_players,20);
            TextUtils.updateTextFormat(this.mcWeeklyWins.txtRewards,20);
            TextUtils.updateTextFormat(this.btnBack.txtButtonName,_loc2_);
            param1 = true;
         }
         if(param1)
         {
            this.btnBack.changeFontSize(_loc2_);
            this.btnBack.setButtonName(getScreenText("close"));
         }
         this.txtTitle.text = getScreenText("title");
         this.mcWeeklyWins.txtTitle_clans.text = getScreenText("weeklyClansTitle");
         this.mcWeeklyWins.txtTitle_players.text = getScreenText("weeklyPlayersTitle");
         this.mcWeeklyWins.txtRewards.text = getScreenText("weeklyRewards");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("news_title",[this.txtTitle],"",this);
            screensM.createMultipleTextsBitmap("weeklyWins_titles",[this.mcWeeklyWins.txtTitle_clans,this.mcWeeklyWins.txtTitle_players,this.mcWeeklyWins.txtRewards],"",this.mcWeeklyWins);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
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
      
      private function refreshNews() : void
      {
         var _loc1_:uint = 0;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:String = null;
         var _loc19_:BMItemData = null;
         var _loc20_:String = null;
         var _loc21_:uint = 0;
         var _loc22_:Boolean = false;
         var _loc23_:Boolean = false;
         var _loc24_:Boolean = false;
         var _loc25_:String = null;
         var _loc26_:uint = 0;
         var _loc27_:uint = 0;
         var _loc28_:MovieClip = null;
         var _loc29_:String = null;
         var _loc30_:Array = null;
         var _loc31_:uint = 0;
         var _loc32_:BMItemData = null;
         var _loc33_:MovieClip = null;
         var _loc34_:BMItem = null;
         var _loc35_:BMTileListItem = null;
         var _loc36_:Sprite = null;
         var _loc37_:Array = null;
         this.removeClanFlagsAndRewards();
         this.removeExternalImage();
         if(this.mcBlackFriday.parent != null)
         {
            this.mcBlackFriday.parent.removeChild(this.mcBlackFriday);
         }
         if(this.mcCyberMonday.parent != null)
         {
            this.mcCyberMonday.parent.removeChild(this.mcCyberMonday);
         }
         if(this.mcChristmas1.parent != null)
         {
            this.mcChristmas1.parent.removeChild(this.mcChristmas1);
         }
         if(this.mcChristmas2.parent != null)
         {
            this.mcChristmas2.parent.removeChild(this.mcChristmas2);
         }
         if(this.mcPreHolidayPowerKits.parent != null)
         {
            this.mcPreHolidayPowerKits.parent.removeChild(this.mcPreHolidayPowerKits);
         }
         if(this.mcChineseNewYear.parent != null)
         {
            this.mcChineseNewYear.parent.removeChild(this.mcChineseNewYear);
         }
         if(dataM.runAsMobile == false)
         {
            this.mcSpecialSaleHitArea.removeEventListener(MouseEvent.CLICK,this.specialSaleClicked);
         }
         if(this.mcSpecialSaleHitArea.parent != null)
         {
            this.mcSpecialSaleHitArea.parent.removeChild(this.mcSpecialSaleHitArea);
         }
         this.mcSandClock.gotoAndStop("animOff");
         var _loc2_:BMNewsData = dataM.newsDB[this._currentNewsID];
         this._itemIDs = new Array();
         var _loc3_:String = _loc2_.content;
         this._currentNewsType = "regular";
         switch(_loc2_.category)
         {
            case 1:
               this._currentNewsType = "specialSale";
               break;
            default:
               if(_loc3_.substr(0,8) == "[WEEKLY]")
               {
                  this._currentNewsType = "weeklyWins";
               }
               else if(_loc3_.substr(0,8) == "[BLACKF]")
               {
                  this._currentNewsType = "blackFriday";
               }
               else if(_loc3_.substr(0,8) == "[CYBERM]")
               {
                  this._currentNewsType = "cyberMonday";
               }
               else if(_loc3_.substr(0,9) == "[PREHOL1]")
               {
                  this._currentNewsType = "preHolidayPowerKits";
               }
               else if(_loc3_.substr(0,7) == "[XMAS1]")
               {
                  this._currentNewsType = "christmas1";
               }
               else if(_loc3_.substr(0,7) == "[XMAS2]")
               {
                  this._currentNewsType = "christmas2";
               }
               else if(_loc3_.substr(0,9) == "[CHINESE]")
               {
                  this._currentNewsType = "chineseNewYear";
               }
         }
         var _loc4_:String = _loc2_.postDateString.substr(8,2);
         var _loc5_:String = _loc2_.postDateString.substr(5,2);
         var _loc6_:String = _loc2_.postDateString.substr(0,4);
         if(_loc4_.substr(0,1) == "0")
         {
            _loc4_ = _loc4_.substr(1,1);
         }
         if(_loc5_.substr(0,1) == "0")
         {
            _loc5_ = _loc5_.substr(1,1);
         }
         this.mcWeeklyWins.visible = false;
         if(dataM.runAsMobile)
         {
            this.mcFingerWheeling.visible = false;
         }
         switch(this._currentNewsType)
         {
            case "regular":
               if(_loc3_.substr(0,7) == "[ITEMS]")
               {
                  if(dataM.runAsMobile)
                  {
                     this.mcFingerWheeling.visible = true;
                  }
                  _loc16_ = 0;
                  _loc17_ = 7;
                  _loc1_ = 7;
                  while(_loc1_ < _loc3_.length)
                  {
                     _loc20_ = _loc3_.substr(_loc1_,1);
                     if(_loc20_ == "," || _loc20_ == "[")
                     {
                        this._itemIDs.push(int(_loc3_.substr(_loc17_,_loc1_ - _loc17_)));
                        _loc17_ = _loc1_ + 1;
                     }
                     if(_loc3_.substr(_loc1_,8) == "[/ITEMS]")
                     {
                        _loc16_ = _loc1_ + 8;
                        _loc1_ = uint(_loc3_.length);
                     }
                     _loc1_++;
                  }
                  if(_loc16_ > 0)
                  {
                     _loc3_ = _loc3_.substr(_loc16_,_loc3_.length - _loc16_);
                  }
                  _loc19_ = dataM.itemsDB[this._itemIDs[0]];
                  if(_loc19_.specialStatus == 4)
                  {
                     if(this._itemIDs.length == 1)
                     {
                        _loc18_ = getScreenText("newMythicalReleased");
                     }
                     else
                     {
                        _loc18_ = getScreenText("newMythicalsReleased");
                     }
                     _loc18_ = dataM.replaceStringInText(_loc18_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>");
                  }
                  else if(_loc19_.specialStatus == 5)
                  {
                     _loc18_ = "A NEW <FONT COLOR=\'#" + dataM.COLOR_PERK + "\'>PERK</FONT> HAS BEEN RELEASED!";
                  }
                  else
                  {
                     if(this._itemIDs.length == 1)
                     {
                        _loc18_ = getScreenText("newLegendaryReleased");
                     }
                     else
                     {
                        _loc18_ = getScreenText("newLegendariesReleased");
                     }
                     _loc18_ = dataM.replaceStringInText(_loc18_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
                  }
                  this.txtNewItems.htmlText = TextUtils.getTextFont() + _loc18_;
                  switch(this._itemIDs.length)
                  {
                     case 1:
                        this.mcSizer_tileList.x = this._tileListOriginXPos;
                        this.mcItemsTileListFrame.x = this._tileListFrameOriginXPos;
                        this.mcItemsTileListFrame.gotoAndStop(1);
                        break;
                     case 2:
                        this.mcSizer_tileList.x = this._tileListOriginXPos - 70;
                        this.mcItemsTileListFrame.x = this._tileListFrameOriginXPos - 70;
                        this.mcItemsTileListFrame.gotoAndStop(2);
                        break;
                     default:
                        this.mcSizer_tileList.x = this._tileListOriginXPos - 140;
                        this.mcItemsTileListFrame.x = this._tileListFrameOriginXPos - 140;
                        this.mcItemsTileListFrame.gotoAndStop(3);
                  }
               }
               else
               {
                  this.txtNewItems.text = "";
               }
               if(this._itemIDs.length == 0)
               {
                  _loc21_ = 0;
                  switch(dataM.languageID)
                  {
                     case 3:
                     case 6:
                        _loc21_ = 17;
                  }
                  this.txtNews.htmlText = TextUtils.getTextFont(_loc21_) + _loc2_.title + "<BR>" + _loc3_;
               }
               else
               {
                  this.txtNews.htmlText = "";
               }
               TsLogger.log("txtNews.htmlText:" + this.txtNews.htmlText);
               this.txtDate.text = _loc4_ + " / " + _loc5_ + " / " + _loc6_;
               this.removeTileList();
               this.addTileList();
               break;
            case "specialSale":
               this.txtDate.text = "";
               this.txtNews.text = "";
               this.txtNewItems.text = "";
               this.removeTileList();
               this.mcSandClock.gotoAndStop("animOn");
               this._externalImage = BMExternalImagesManager.gi().createExternalImage(_loc2_.imageUrl,this.mcSizer_externalImage.width,this.mcSizer_externalImage.height,this.removeSandClock);
               this._externalImage.x = this.mcSizer_externalImage.x;
               this._externalImage.y = this.mcSizer_externalImage.y;
               this.mcIconsHolder.addChild(this._externalImage);
               this.addSpecialSalesHitArea();
               break;
            case "blackFriday":
            case "cyberMonday":
            case "christmas1":
            case "christmas2":
            case "chineseNewYear":
            case "preHolidayPowerKits":
               switch(this._currentNewsType)
               {
                  case "blackFriday":
                     if(this.mcBlackFriday.parent == null)
                     {
                        this.mcSpecialSalesHolder.addChild(this.mcBlackFriday);
                     }
                     break;
                  case "cyberMonday":
                     if(this.mcCyberMonday.parent == null)
                     {
                        this.mcSpecialSalesHolder.addChild(this.mcCyberMonday);
                     }
                     break;
                  case "christmas1":
                     if(this.mcChristmas1.parent == null)
                     {
                        this.mcSpecialSalesHolder.addChild(this.mcChristmas1);
                     }
                     break;
                  case "christmas2":
                     if(this.mcChristmas2.parent == null)
                     {
                        this.mcSpecialSalesHolder.addChild(this.mcChristmas2);
                     }
                     break;
                  case "preHolidayPowerKits":
                     if(this.mcPreHolidayPowerKits.parent == null)
                     {
                        this.mcSpecialSalesHolder.addChild(this.mcPreHolidayPowerKits);
                     }
                     break;
                  case "chineseNewYear":
                     if(this.mcChineseNewYear.parent == null)
                     {
                        this.mcSpecialSalesHolder.addChild(this.mcChineseNewYear);
                     }
               }
               this.addSpecialSalesHitArea();
               this.txtNews.htmlText = "";
               this.txtDate.text = "";
               this.txtNewItems.text = "";
               this.removeTileList();
               break;
            case "weeklyWins":
               _loc8_ = new Array();
               _loc9_ = new Array();
               _loc10_ = new Array();
               _loc11_ = "";
               _loc12_ = "";
               _loc1_ = 8;
               while(_loc1_ < _loc3_.length)
               {
                  _loc22_ = true;
                  if(_loc3_.substr(_loc1_,1) == "[" || _loc1_ == _loc3_.length - 1)
                  {
                     _loc23_ = false;
                     _loc24_ = false;
                     if(_loc1_ == _loc3_.length - 1)
                     {
                        _loc23_ = true;
                        _loc24_ = true;
                        _loc12_ += _loc3_.substr(_loc1_,1);
                     }
                     else
                     {
                        switch(_loc3_.substr(_loc1_,7))
                        {
                           case "[CNAME]":
                           case "[CFLAG]":
                           case "[ITEMS]":
                           case "[PNAME]":
                           case "[PGOLD]":
                              _loc23_ = true;
                        }
                     }
                     if(_loc23_)
                     {
                        if(_loc11_ != "")
                        {
                           switch(_loc11_)
                           {
                              case "CNAME":
                                 _loc8_.push({
                                    "name":_loc12_,
                                    "flag":""
                                 });
                                 break;
                              case "CFLAG":
                                 _loc8_[_loc8_.length - 1].flag = _loc12_;
                                 break;
                              case "ITEMS":
                                 _loc25_ = "";
                                 _loc26_ = 0;
                                 while(_loc26_ < _loc12_.length)
                                 {
                                    if(_loc26_ == _loc12_.length - 1)
                                    {
                                       _loc25_ += _loc12_.substr(_loc26_,1);
                                       _loc10_.push(int(_loc25_));
                                    }
                                    else if(_loc12_.substr(_loc26_,1) == ",")
                                    {
                                       _loc10_.push(int(_loc25_));
                                       _loc25_ = "";
                                    }
                                    else
                                    {
                                       _loc25_ += _loc12_.substr(_loc26_,1);
                                    }
                                    _loc26_++;
                                 }
                                 break;
                              case "PNAME":
                                 _loc9_.push({
                                    "name":_loc12_,
                                    "gold":""
                                 });
                                 break;
                              case "PGOLD":
                                 _loc9_[_loc9_.length - 1].gold = dataM.getNumberWithComma(int(_loc12_));
                           }
                        }
                        _loc22_ = false;
                        if(_loc24_ == false)
                        {
                           _loc11_ = _loc3_.substr(_loc1_ + 1,5);
                           _loc1_ += 6;
                           _loc12_ = "";
                        }
                     }
                  }
                  if(_loc22_)
                  {
                     _loc12_ += _loc3_.substr(_loc1_,1);
                  }
                  _loc1_++;
               }
               this.mcWeeklyWins.visible = true;
               _loc13_ = "";
               _loc14_ = "";
               _loc15_ = "";
               if(_loc8_[0] != null)
               {
                  _loc13_ = _loc8_[0].name;
               }
               if(_loc8_[1] != null)
               {
                  _loc14_ = _loc8_[1].name;
               }
               if(_loc8_[2] != null)
               {
                  _loc15_ = _loc8_[2].name;
               }
               this.mcWeeklyWins.txtClan1.text = dataM.getCensoredString(_loc13_);
               this.mcWeeklyWins.txtClan2.text = dataM.getCensoredString(_loc14_);
               this.mcWeeklyWins.txtClan3.text = dataM.getCensoredString(_loc15_);
               _loc27_ = 1;
               while(_loc27_ <= 3)
               {
                  this.mcWeeklyWins["mcClanFlag" + _loc27_] = new BMClanFlag();
                  _loc28_ = externalAssetsM.getAsset("general","clanFlag",this.mcWeeklyWins.mcSizer_flag1.width,this.mcWeeklyWins.mcSizer_flag1.height,false,false);
                  _loc28_.x = this.mcWeeklyWins["mcSizer_flag" + _loc27_].x;
                  _loc28_.y = this.mcWeeklyWins["mcSizer_flag" + _loc27_].y;
                  this.mcWeeklyWins["mcClanFlag" + _loc27_].initialize(_loc28_,dataM.runAsMobile);
                  _loc29_ = "";
                  if(_loc8_[_loc27_ - 1] != null)
                  {
                     _loc29_ = _loc8_[_loc27_ - 1].flag;
                  }
                  _loc30_ = dataM.getClanFlagData(_loc29_);
                  this.mcWeeklyWins["mcClanFlag" + _loc27_].updateFlag(_loc30_);
                  this.mcWeeklyWins.addChild(_loc28_);
                  _loc27_++;
               }
               _loc1_ = 1;
               while(_loc1_ <= 3)
               {
                  if(_loc9_[_loc1_ - 1] != null)
                  {
                     this.mcWeeklyWins["txtPlayer" + _loc1_].text = _loc1_ + ") " + dataM.getCensoredString(_loc9_[_loc1_ - 1].name);
                     this.mcWeeklyWins["txtGold" + _loc1_].text = _loc9_[_loc1_ - 1].gold;
                  }
                  else
                  {
                     this.mcWeeklyWins["txtPlayer" + _loc1_].text = "";
                     this.mcWeeklyWins["txtGold" + _loc1_].text = "";
                  }
                  _loc1_++;
               }
               this.mcWeeklyWins.txtDate.text = _loc4_ + " / " + _loc5_ + " / " + _loc6_;
               if(_loc10_.length > 0)
               {
                  _loc1_ = 0;
                  while(_loc1_ < _loc10_.length)
                  {
                     _loc31_ = uint(_loc10_[_loc1_]);
                     _loc32_ = dataM.itemsDB[_loc31_];
                     _loc33_ = externalAssetsM.getAsset(dataM.itemTypeSourceDB[_loc32_.type],_loc32_.grp,0,0,false,true);
                     _loc34_ = new BMItem();
                     _loc35_ = new BMTileListItem();
                     _loc36_ = this.mcWeeklyWins["mcSizer_item" + (_loc1_ + 1)];
                     _loc34_.initialize(_loc31_,_loc36_.width,_loc36_.height,_loc33_,0,0,false,null,dataM.runAsMobile);
                     _loc35_.initialize(_loc36_.width,_loc36_.height,_loc34_,"","","",4,null,null,null,this.itemMouseOver,this.itemMouseOut,dataM.runAsMobile);
                     _loc35_.x = _loc36_.x;
                     _loc35_.y = _loc36_.y;
                     this.mcWeeklyWins.addChild(_loc35_);
                     this.rewardsTileListItems.push(_loc35_);
                     _loc1_++;
                  }
               }
               this.txtNews.htmlText = "";
               this.txtDate.text = "";
               this.txtNewItems.text = "";
               this.removeTileList();
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("news_news",[this.txtDate,this.txtNewItems],"",this);
            _loc37_ = [this.mcWeeklyWins.txtClan1,this.mcWeeklyWins.txtClan2,this.mcWeeklyWins.txtClan3,this.mcWeeklyWins.txtPlayer1,this.mcWeeklyWins.txtPlayer2,this.mcWeeklyWins.txtPlayer3,this.mcWeeklyWins.txtGold1,this.mcWeeklyWins.txtGold2,this.mcWeeklyWins.txtGold3];
            screensM.createMultipleTextsBitmap("news_weeklyWins",_loc37_,"",this.mcWeeklyWins);
         }
         this.refreshButtons();
         var _loc7_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc7_.lastNewsID < this._currentNewsID)
         {
            _loc7_.lastNewsID = this._currentNewsID;
            remoteM.lobby_setLastNewsID(this._currentNewsID);
         }
         this.mcNew.visible = false;
         if(_loc7_.lastNewsIDBeforeLogin > 0)
         {
            if(this._currentNewsID > _loc7_.lastNewsIDBeforeLogin > 0)
            {
               this.mcNew.visible = true;
            }
         }
      }
      
      private function removeSandClock() : void
      {
         this.mcSandClock.gotoAndStop("animOff");
      }
      
      private function removeExternalImage() : void
      {
         if(this._externalImage != null)
         {
            if(this._externalImage.parent != null)
            {
               this._externalImage.parent.removeChild(this._externalImage);
            }
            this._externalImage = null;
         }
      }
      
      private function addSpecialSalesHitArea() : void
      {
         if(dataM.runAsMobile == false)
         {
            this.mcSpecialSaleHitArea.addEventListener(MouseEvent.CLICK,this.specialSaleClicked);
         }
         if(this.mcSpecialSaleHitArea.parent == null)
         {
            this.mcSpecialSalesHolder.addChild(this.mcSpecialSaleHitArea);
         }
      }
      
      private function refreshButtons() : void
      {
         var _loc2_:BMNewsData = null;
         var _loc1_:Number = 0;
         for each(_loc2_ in dataM.newsDB)
         {
            _loc1_++;
         }
         if(this._currentNewsNumber > 1)
         {
            this.btnNext.visible = true;
         }
         else
         {
            this.btnNext.visible = false;
         }
         if(this._currentNewsNumber < _loc1_)
         {
            this.btnPrevious.visible = true;
         }
         else
         {
            this.btnPrevious.visible = false;
         }
      }
      
      private function removeTileList() : void
      {
         if(this.itemsTileList != null)
         {
            this.itemsTileList.removeMe();
            this.itemsTileList = null;
         }
         this.mcItemsTileListFrame.visible = false;
      }
      
      private function addTileList() : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Function = null;
         var _loc8_:Function = null;
         var _loc9_:BMTileListItem = null;
         var _loc10_:Boolean = false;
         var _loc1_:Array = new Array();
         var _loc2_:Number = 1;
         var _loc3_:Number = 3;
         var _loc4_:Number = dataM.SHOP_REGULAR_TILE_LIST_ITEM_SIZE * 2;
         if(dataM.runAsMobile)
         {
            _loc4_ = dataM.SHOP_REGULAR_TILE_LIST_ITEM_SIZE_MOBILE * 2;
            _loc2_ = 1;
            _loc3_ = 3;
            this._fingerWheeling.resetTileList(null);
         }
         var _loc5_:uint = 0;
         while(_loc5_ < this._itemIDs.length)
         {
            _loc6_ = Number(this._itemIDs[_loc5_]);
            if(dataM.itemsDB[_loc6_] != null)
            {
               _loc7_ = this.itemMouseOver;
               _loc8_ = this.itemMouseOut;
               if(dataM.runAsMobile)
               {
                  _loc7_ = null;
                  _loc8_ = null;
               }
               _loc9_ = dataM.createShopTileListItem_basedOnItemID(_loc6_,"news",null,null,null,_loc7_,_loc8_,true);
               _loc9_.width = dataM.NEWS_TILE_LIST_ITEM_SIZE;
               _loc9_.height = dataM.NEWS_TILE_LIST_ITEM_SIZE;
               _loc1_.push(_loc9_);
            }
            _loc5_++;
         }
         if(_loc1_.length > 0)
         {
            this.itemsTileList = new BMTileList();
            _loc10_ = false;
            if(dataM.runAsMobile)
            {
            }
            this.itemsTileList.initialize(screensM.stagePointer,_loc1_,_loc2_,_loc3_,_loc4_,_loc4_,null,false,null,null,null,false,0,0.5,true,_loc10_,dataM.runAsMobile);
            this.itemsTileList.x = this.mcSizer_tileList.x;
            this.itemsTileList.y = this.mcSizer_tileList.y;
            this.mcButtonsHolder.addChild(this.itemsTileList);
            this.mcItemsTileListFrame.visible = true;
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.resetTileList(this.itemsTileList);
               this._fingerWheeling.addMouseListeners();
            }
         }
         else
         {
            this.mcItemsTileListFrame.visible = false;
         }
      }
      
      private function itemMouseOver(param1:Number, param2:Number) : void
      {
         tooltip.showToolTip("newsItem","",param2,-1);
      }
      
      private function itemMouseOut(param1:Number, param2:Number) : void
      {
         tooltip.hideToolTip();
      }
      
      private function mobileItemMouseDown(param1:uint, param2:Number) : void
      {
         tooltip.showToolTip("newsItem","",param2);
         tooltip.allowRepositionForMobile = true;
      }
      
      public function nextClicked() : void
      {
         var _loc4_:Date = null;
         var _loc1_:BMNewsData = dataM.newsDB[this._currentNewsID];
         var _loc2_:Date = _loc1_.postDate;
         var _loc3_:Number = 0;
         for each(_loc1_ in dataM.newsDB)
         {
            if(_loc1_.postDate > _loc2_)
            {
               if(_loc4_ != null)
               {
                  if(_loc1_.postDate < _loc4_)
                  {
                     _loc4_ = _loc1_.postDate;
                     _loc3_ = _loc1_.newsID;
                  }
               }
               else
               {
                  _loc4_ = _loc1_.postDate;
                  _loc3_ = _loc1_.newsID;
               }
            }
         }
         this._currentNewsID = _loc3_;
         --this._currentNewsNumber;
         this.refreshNews();
      }
      
      public function previousClicked() : void
      {
         var _loc4_:Date = null;
         var _loc1_:BMNewsData = dataM.newsDB[this._currentNewsID];
         var _loc2_:Date = _loc1_.postDate;
         var _loc3_:Number = 0;
         for each(_loc1_ in dataM.newsDB)
         {
            if(_loc1_.postDate < _loc2_)
            {
               if(_loc4_ != null)
               {
                  if(_loc1_.postDate > _loc4_)
                  {
                     _loc4_ = _loc1_.postDate;
                     _loc3_ = _loc1_.newsID;
                  }
               }
               else
               {
                  _loc4_ = _loc1_.postDate;
                  _loc3_ = _loc1_.newsID;
               }
            }
         }
         this._currentNewsID = _loc3_;
         ++this._currentNewsNumber;
         this.refreshNews();
      }
      
      private function removeClanFlagsAndRewards() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMTileListItem = null;
         _loc1_ = 1;
         while(_loc1_ <= 3)
         {
            if(this.mcWeeklyWins["mcClanFlag" + _loc1_] != null)
            {
               this.mcWeeklyWins["mcClanFlag" + _loc1_].removeMe();
               this.mcWeeklyWins["mcClanFlag" + _loc1_] = null;
            }
            _loc1_++;
         }
         if(this.rewardsTileListItems != null)
         {
            if(this.rewardsTileListItems.length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < this.rewardsTileListItems.length)
               {
                  _loc2_ = this.rewardsTileListItems[_loc1_];
                  _loc2_.removeMe();
                  _loc1_++;
               }
               this.rewardsTileListItems = new Array();
            }
         }
      }
      
      private function specialSaleClicked(param1:MouseEvent) : void
      {
         this.specialSaleClickedSub();
      }
      
      public function specialSaleClickedSub() : void
      {
         var _loc1_:BMNewsData = dataM.newsDB[this._currentNewsID];
         var _loc2_:String = "News_" + this._currentNewsType;
         switch(this._currentNewsType)
         {
            case "specialSale":
               if(BMSalesManager.gi().isSaleActive(dataM.currentTime))
               {
                  switch(_loc1_.clickTarget)
                  {
                     case 0:
                        break;
                     case 1:
                        BMShopManager.gi().showSpecialBoxses(_loc2_,_loc1_.clickTargetItemID);
                        break;
                     case 2:
                        BMShopManager.gi().showPowerKits(_loc2_);
                        break;
                     case 3:
                        BMShopManager.gi().showSpecialOffers(_loc2_);
                  }
               }
               break;
            case "blackFriday":
            case "cyberMonday":
            case "christmas1":
            case "christmas2":
            case "chineseNewYear":
               BMShopManager.gi().showSpecialBoxses(_loc2_);
               break;
            case "preHolidayPowerKits":
               BMShopManager.gi().showPowerKits(_loc2_);
         }
      }
      
      public function backClicked() : void
      {
         screensM.screenNewMenu.mainMenu();
      }
      
      public function removeMe() : void
      {
         if(this._currentNewsID > 1)
         {
            this.mcSandClock.gotoAndStop("animOff");
            this.removeTileList();
            screensM.removeScreen("screenNews");
            if(this.itemsTileList != null)
            {
               if(dataM.runAsMobile)
               {
                  this._fingerWheeling.removeMouseListeners();
               }
               this.itemsTileList.removeMe();
               this.itemsTileList = null;
            }
            this.removeClanFlagsAndRewards();
            if(dataM.runAsMobile == false)
            {
               this.mcSpecialSaleHitArea.removeEventListener(MouseEvent.CLICK,this.specialSaleClicked);
            }
         }
      }
   }
}

