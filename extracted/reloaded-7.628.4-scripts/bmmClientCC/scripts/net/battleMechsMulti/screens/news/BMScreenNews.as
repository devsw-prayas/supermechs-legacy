package net.battleMechsMulti.screens.news
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.externalImages.BMExternalImage;
   import net.battleMechsMulti.managers.externalImages.BMExternalImagesManager;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.managers.specialOffers.BMSpecialOffersManager;
   import net.battleMechsMulti.mobiles.BMClanFlag;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2227")]
   public class BMScreenNews extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcExternalImageHolder:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnNext:Sprite;
      
      public var mcSizer_btnPrevious:Sprite;
      
      public var mcSizer_externalImage:Sprite;
      
      public var mcSizer_btnBack2:Sprite;
      
      public var mcMouseHitArea:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtNews:TextField;
      
      public var txtDate:TextField;
      
      public var btnBack:BMButton;
      
      public var btnNext:BMButton_pictureE;
      
      public var btnPrevious:BMButton_pictureE;
      
      public var btnBack2:BMButton_pictureE;
      
      public var mcWeeklyWins:MovieClip;
      
      public var mcSandClock:MovieClip;
      
      public var mcNew:Sprite;
      
      public var rewardsTileListItems:Array = new Array();
      
      private var _currentNewsType:uint;
      
      private var _currentNewsSlot:Number;
      
      private var _itemIDs:Array = new Array();
      
      private var _currentNewsSubType:uint;
      
      private var _externalImage:BMExternalImage;
      
      private var _stickyNewsItems:Array;
      
      private var _regularNewsItems:Array;
      
      private var _closeMeOnNextFrame:Boolean = false;
      
      private var _closeMeFrameCounter:uint = 0;
      
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
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer(BMScreensManager.SCR_NEWS,"btnBack","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_NEWS,"btnNext","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_NEWS,"btnPrevious","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_NEWS,"btnBack2","pictureE");
            _loc3_ = this.backClicked;
            _loc4_ = this.nextClicked;
            _loc5_ = this.previousClicked;
            if(dataM.runAsMobile)
            {
               _loc3_ = null;
               _loc4_ = null;
               _loc5_ = null;
            }
            this.btnBack.initialize(getScreenText("close"),"blue",null,null,_loc3_,dataM.runAsMobile);
            this.btnNext.initialize("","",externalAssetsM.getAsset("general","interface_forward"),null,_loc4_,dataM.runAsMobile);
            this.btnPrevious.initialize("","",externalAssetsM.getAsset("general","interface_backward"),null,_loc5_,dataM.runAsMobile);
            this.btnBack2.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnNext.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnPrevious.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack2.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this.mcMouseHitArea.buttonMode = true;
         this.mcMouseHitArea.useHandCursor = true;
         var _loc1_:Boolean = dataM.newsHandler.newsDisplayedThisSession;
         var _loc2_:Array = dataM.newsHandler.getNews(_loc1_);
         this._stickyNewsItems = _loc2_[0];
         this._regularNewsItems = _loc2_[1];
         this._currentNewsSlot = 0;
         if(this._stickyNewsItems.length > 0)
         {
            this._currentNewsType = BMNewsHandler.NEWS_TYPE_STICKY;
         }
         else
         {
            this._currentNewsType = BMNewsHandler.NEWS_TYPE_REGULAR;
         }
         this.addMouseHitArea();
         this.refreshNews();
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         updateTextAndFormat(this.btnBack.txtButtonName,getScreenText("close"));
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         updateTextAndFormat(this.mcWeeklyWins.txtTitle_clans,getScreenText("weeklyClansTitle"));
         updateTextAndFormat(this.mcWeeklyWins.txtTitle_players,getScreenText("weeklyPlayersTitle"));
         updateTextAndFormat(this.mcWeeklyWins.txtRewards,getScreenText("weeklyRewards"));
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("news_title",[this.txtTitle],"",this);
            screensM.createMultipleTextsBitmap("weeklyWins_titles",[this.mcWeeklyWins.txtTitle_clans,this.mcWeeklyWins.txtTitle_players,this.mcWeeklyWins.txtRewards],"",this.mcWeeklyWins);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent == null)
         {
            return;
         }
         if(this._closeMeOnNextFrame)
         {
            if(this._closeMeFrameCounter < 40)
            {
               ++this._closeMeFrameCounter;
            }
            else
            {
               this.backClicked();
               this._closeMeOnNextFrame = false;
            }
         }
      }
      
      private function refreshNews() : void
      {
         var _loc5_:uint = 0;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc17_:Boolean = false;
         var _loc18_:String = null;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:MovieClip = null;
         var _loc22_:String = null;
         var _loc23_:Array = null;
         var _loc24_:String = null;
         var _loc25_:String = null;
         var _loc26_:uint = 0;
         var _loc27_:BMItemData = null;
         var _loc28_:MovieClip = null;
         var _loc29_:BMItem = null;
         var _loc30_:BMTileListItem = null;
         var _loc31_:Sprite = null;
         var _loc32_:Array = null;
         this.removeClanFlagsAndRewards();
         this.removeExternalImage();
         this.mcSandClock.gotoAndStop("animOff");
         var _loc1_:BMNewsItemData = this.getCurrentNewsItem();
         if(_loc1_ == null)
         {
            this._closeMeOnNextFrame = true;
            this._closeMeFrameCounter = 0;
            visible = false;
            return;
         }
         this._itemIDs = new Array();
         var _loc2_:String = _loc1_.newsText;
         this._currentNewsSubType = BMNewsHandler.NEWS_SUB_TYPE_REGULAR;
         switch(_loc1_.category)
         {
            case 1:
               this._currentNewsSubType = BMNewsHandler.NEWS_SUB_TYPE_SPECIAL_SALE;
               break;
            case 2:
               this._currentNewsSubType = BMNewsHandler.NEWS_SUB_TYPE_WEB_VIEW;
               break;
            default:
               if(_loc2_.substr(0,8) == "[WEEKLY]")
               {
                  this._currentNewsSubType = BMNewsHandler.NEWS_SUB_TYPE_SEASON_RESULTS;
               }
         }
         var _loc3_:Date = new Date();
         _loc3_.setTime(int(_loc1_.startDate) * 1000);
         var _loc4_:String = _loc3_.day + " / " + _loc3_.month + " / " + _loc3_.fullYear;
         this.mcWeeklyWins.visible = false;
         var _loc6_:Boolean = false;
         switch(this._currentNewsSubType)
         {
            case BMNewsHandler.NEWS_SUB_TYPE_REGULAR:
               if(_loc1_.imageUrl != "")
               {
                  _loc6_ = true;
               }
               else
               {
                  if(this._itemIDs.length == 0)
                  {
                     updateTextAndFormat(this.txtNews,_loc1_.newsTitle + "<BR>" + _loc2_);
                  }
                  else
                  {
                     this.txtNews.htmlText = "";
                  }
                  this.txtDate.text = _loc4_;
               }
               break;
            case BMNewsHandler.NEWS_SUB_TYPE_WEB_VIEW:
            case BMNewsHandler.NEWS_SUB_TYPE_SPECIAL_SALE:
               _loc6_ = true;
               break;
            case BMNewsHandler.NEWS_SUB_TYPE_SEASON_RESULTS:
               _loc7_ = new Array();
               _loc8_ = new Array();
               _loc9_ = new Array();
               _loc10_ = "";
               _loc11_ = "";
               _loc5_ = 8;
               while(_loc5_ < _loc2_.length)
               {
                  _loc15_ = true;
                  if(_loc2_.substr(_loc5_,1) == "[" || _loc5_ == _loc2_.length - 1)
                  {
                     _loc16_ = false;
                     _loc17_ = false;
                     if(_loc5_ == _loc2_.length - 1)
                     {
                        _loc16_ = true;
                        _loc17_ = true;
                        _loc11_ += _loc2_.substr(_loc5_,1);
                     }
                     else
                     {
                        switch(_loc2_.substr(_loc5_,7))
                        {
                           case "[CNAME]":
                           case "[CFLAG]":
                           case "[ITEMS]":
                           case "[PNAME]":
                           case "[PGOLD]":
                              _loc16_ = true;
                        }
                     }
                     if(_loc16_)
                     {
                        if(_loc10_ != "")
                        {
                           switch(_loc10_)
                           {
                              case "CNAME":
                                 _loc7_.push({
                                    "name":_loc11_,
                                    "flag":""
                                 });
                                 break;
                              case "CFLAG":
                                 _loc7_[_loc7_.length - 1].flag = _loc11_;
                                 break;
                              case "ITEMS":
                                 _loc18_ = "";
                                 _loc19_ = 0;
                                 while(_loc19_ < _loc11_.length)
                                 {
                                    if(_loc19_ == _loc11_.length - 1)
                                    {
                                       _loc18_ += _loc11_.substr(_loc19_,1);
                                       _loc9_.push(int(_loc18_));
                                    }
                                    else if(_loc11_.substr(_loc19_,1) == ",")
                                    {
                                       _loc9_.push(int(_loc18_));
                                       _loc18_ = "";
                                    }
                                    else
                                    {
                                       _loc18_ += _loc11_.substr(_loc19_,1);
                                    }
                                    _loc19_++;
                                 }
                                 break;
                              case "PNAME":
                                 _loc8_.push({
                                    "name":_loc11_,
                                    "gold":""
                                 });
                                 break;
                              case "PGOLD":
                                 _loc8_[_loc8_.length - 1].gold = TextUtils.getNumberWithComma(int(_loc11_));
                           }
                        }
                        _loc15_ = false;
                        if(_loc17_ == false)
                        {
                           _loc10_ = _loc2_.substr(_loc5_ + 1,5);
                           _loc5_ += 6;
                           _loc11_ = "";
                        }
                     }
                  }
                  if(_loc15_)
                  {
                     _loc11_ += _loc2_.substr(_loc5_,1);
                  }
                  _loc5_++;
               }
               this.mcWeeklyWins.visible = true;
               _loc12_ = "";
               _loc13_ = "";
               _loc14_ = "";
               if(_loc7_[0] != null)
               {
                  _loc12_ = _loc7_[0].name;
               }
               if(_loc7_[1] != null)
               {
                  _loc13_ = _loc7_[1].name;
               }
               if(_loc7_[2] != null)
               {
                  _loc14_ = _loc7_[2].name;
               }
               updateTextAndFormat(this.mcWeeklyWins.txtClan1,dataM.getCensoredString(_loc12_));
               updateTextAndFormat(this.mcWeeklyWins.txtClan2,dataM.getCensoredString(_loc13_));
               updateTextAndFormat(this.mcWeeklyWins.txtClan3,dataM.getCensoredString(_loc14_));
               _loc20_ = 1;
               while(_loc20_ <= 3)
               {
                  this.mcWeeklyWins["mcClanFlag" + _loc20_] = new BMClanFlag();
                  _loc21_ = externalAssetsM.getAsset("general","clanFlag",this.mcWeeklyWins.mcSizer_flag1.width,this.mcWeeklyWins.mcSizer_flag1.height,false,false);
                  _loc21_.x = this.mcWeeklyWins["mcSizer_flag" + _loc20_].x;
                  _loc21_.y = this.mcWeeklyWins["mcSizer_flag" + _loc20_].y;
                  this.mcWeeklyWins["mcClanFlag" + _loc20_].initialize(_loc21_,dataM.runAsMobile);
                  _loc22_ = "";
                  if(_loc7_[_loc20_ - 1] != null)
                  {
                     _loc22_ = _loc7_[_loc20_ - 1].flag;
                  }
                  _loc23_ = dataM.getClanFlagData(_loc22_);
                  this.mcWeeklyWins["mcClanFlag" + _loc20_].updateFlag(_loc23_);
                  this.mcWeeklyWins.addChild(_loc21_);
                  _loc20_++;
               }
               _loc5_ = 1;
               while(_loc5_ <= 3)
               {
                  if(_loc8_[_loc5_ - 1] != null)
                  {
                     _loc24_ = _loc5_ + ") " + dataM.getCensoredString(_loc8_[_loc5_ - 1].name);
                     updateTextAndFormat(this.mcWeeklyWins["txtPlayer" + _loc5_],_loc24_);
                     _loc25_ = _loc8_[_loc5_ - 1].gold;
                     updateTextAndFormat(this.mcWeeklyWins["txtGold" + _loc5_],_loc25_);
                  }
                  else
                  {
                     this.mcWeeklyWins["txtPlayer" + _loc5_].text = "";
                     this.mcWeeklyWins["txtGold" + _loc5_].text = "";
                  }
                  _loc5_++;
               }
               this.mcWeeklyWins.txtDate.text = _loc4_;
               if(_loc9_.length > 0)
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc9_.length)
                  {
                     _loc26_ = uint(_loc9_[_loc5_]);
                     _loc27_ = dataM.itemsDB[_loc26_];
                     _loc28_ = externalAssetsM.getAsset(dataM.itemTypeSourceDB[_loc27_.type],_loc27_.grp,0,0,false,true);
                     _loc29_ = new BMItem();
                     _loc30_ = new BMTileListItem();
                     _loc31_ = this.mcWeeklyWins["mcSizer_item" + (_loc5_ + 1)];
                     _loc29_.initialize(_loc26_,_loc31_.width,_loc31_.height,_loc28_,0,0,false,null,dataM.runAsMobile);
                     _loc30_.initialize(_loc31_.width,_loc31_.height,_loc29_,"","","",4,null,null,null,null,null,dataM.runAsMobile);
                     _loc30_.x = _loc31_.x;
                     _loc30_.y = _loc31_.y;
                     this.mcWeeklyWins.addChild(_loc30_);
                     this.rewardsTileListItems.push(_loc30_);
                     _loc5_++;
                  }
               }
               this.txtNews.htmlText = "";
               this.txtDate.text = "";
         }
         if(_loc6_)
         {
            this.txtDate.text = "";
            this.txtNews.text = "";
            this.mcSandClock.gotoAndStop("animOn");
            this._externalImage = BMExternalImagesManager.gi().createExternalImage(_loc1_.imageUrl,this.mcSizer_externalImage.width,this.mcSizer_externalImage.height,this.removeSandClock);
            this._externalImage.x = this.mcSizer_externalImage.x;
            this._externalImage.y = this.mcSizer_externalImage.y;
            this.mcIconsHolder.addChild(this._externalImage);
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("news_news",[this.txtDate],"",this);
            _loc32_ = [this.mcWeeklyWins.txtClan1,this.mcWeeklyWins.txtClan2,this.mcWeeklyWins.txtClan3,this.mcWeeklyWins.txtPlayer1,this.mcWeeklyWins.txtPlayer2,this.mcWeeklyWins.txtPlayer3,this.mcWeeklyWins.txtGold1,this.mcWeeklyWins.txtGold2,this.mcWeeklyWins.txtGold3];
            screensM.createMultipleTextsBitmap("news_weeklyWins",_loc32_,"",this.mcWeeklyWins);
         }
         this.refreshButtons();
         this.mcNew.visible = false;
         if(this._currentNewsSlot >= 0)
         {
            if(dataM.newsHandler.isNewsItemNew(this._currentNewsSlot))
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
      
      private function addMouseHitArea() : void
      {
         if(dataM.runAsMobile == false)
         {
            this.mcMouseHitArea.addEventListener(MouseEvent.CLICK,this.mouseHitAreaClicked);
         }
         if(this.mcMouseHitArea.parent == null)
         {
            this.mcExternalImageHolder.addChild(this.mcMouseHitArea);
         }
      }
      
      private function refreshButtons() : void
      {
         if(this._currentNewsType == BMNewsHandler.NEWS_TYPE_STICKY)
         {
            this.btnNext.visible = false;
            this.btnPrevious.visible = false;
            this.btnBack2.visible = true;
            return;
         }
         if(this._currentNewsSlot > 0)
         {
            this.btnNext.visible = true;
         }
         else
         {
            this.btnNext.visible = false;
         }
         if(this._currentNewsSlot < this._regularNewsItems.length - 1)
         {
            this.btnPrevious.visible = true;
         }
         else
         {
            this.btnPrevious.visible = false;
         }
      }
      
      public function nextClicked() : void
      {
         --this._currentNewsSlot;
         this.refreshNews();
      }
      
      public function previousClicked() : void
      {
         this._currentNewsSlot += 1;
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
      
      private function mouseHitAreaClicked(param1:MouseEvent) : void
      {
         this.mouseHitAreaClickedSub();
      }
      
      public function mouseHitAreaClickedSub() : void
      {
         var _loc1_:BMNewsItemData = this.getCurrentNewsItem();
         if(_loc1_.newsPageLink != "")
         {
            if(dataM.runAsMobile)
            {
               screensM.openWebView(_loc1_.newsPageLink);
            }
            else
            {
               dataM.openURL(_loc1_.newsPageLink,"_blank");
            }
            return;
         }
         var _loc2_:String = "News_" + this._currentNewsSubType;
         switch(this._currentNewsSubType)
         {
            case BMNewsHandler.NEWS_SUB_TYPE_WEB_VIEW:
               if(_loc1_.newsTitle != "")
               {
                  screensM.openWebView(_loc1_.newsTitle);
               }
               break;
            case BMNewsHandler.NEWS_SUB_TYPE_SPECIAL_SALE:
               if(BMSalesManager.gi().isSaleActive(dataM.currentTime))
               {
                  BMSpecialOffersManager.gi().doAction(_loc2_,_loc1_.clickTarget,_loc1_.clickTargetItemID);
               }
               break;
            case BMNewsHandler.NEWS_SUB_TYPE_REGULAR:
               if(_loc1_.clickTarget > 0)
               {
                  BMSpecialOffersManager.gi().doAction(_loc2_,_loc1_.clickTarget,_loc1_.clickTargetItemID);
               }
         }
      }
      
      private function getCurrentNewsItem() : BMNewsItemData
      {
         switch(this._currentNewsType)
         {
            case BMNewsHandler.NEWS_TYPE_STICKY:
               return this._stickyNewsItems[this._currentNewsSlot];
            case BMNewsHandler.NEWS_TYPE_REGULAR:
               return this._regularNewsItems[this._currentNewsSlot];
            default:
               return null;
         }
      }
      
      public function backClicked(param1:Boolean = false) : void
      {
         if(param1 == false)
         {
            if(this._currentNewsType == BMNewsHandler.NEWS_TYPE_STICKY)
            {
               if(this._currentNewsSlot < this._stickyNewsItems.length - 1)
               {
                  ++this._currentNewsSlot;
                  this.refreshNews();
                  return;
               }
               if(this._regularNewsItems.length > 0)
               {
                  this._currentNewsSlot = 0;
                  this._currentNewsType = BMNewsHandler.NEWS_TYPE_REGULAR;
                  this.refreshNews();
                  return;
               }
            }
         }
         this.removeMe();
         if(param1 == false && screensM.screenTransitionsManager.prevScreen == BMScreensManager.SCR_EXTRA_OPTIONS)
         {
            screensM.screenTransitionsManager.extraOptions();
         }
         else
         {
            screensM.screenTransitionsManager.mainMenu();
         }
      }
      
      public function removeMe() : void
      {
         dataM.newsHandler.newsDisplayed();
         this.mcSandClock.gotoAndStop("animOff");
         this.removeClanFlagsAndRewards();
         if(dataM.runAsMobile == false)
         {
            this.mcMouseHitArea.removeEventListener(MouseEvent.CLICK,this.mouseHitAreaClicked);
         }
         screensM.removeScreen(BMScreensManager.SCR_NEWS);
      }
   }
}

