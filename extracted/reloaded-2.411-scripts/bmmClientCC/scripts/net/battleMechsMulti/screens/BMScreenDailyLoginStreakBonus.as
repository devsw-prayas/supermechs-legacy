package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1016")]
   public class BMScreenDailyLoginStreakBonus extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcItemsHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtDescription:TextField;
      
      public var mcGlowPointer1:MovieClip;
      
      public var mcGlowPointer2:MovieClip;
      
      public var mcGlowPointer3:MovieClip;
      
      public var mcGlowPointer4:MovieClip;
      
      public var mcMouseHitArea:Sprite;
      
      public var mcFinger:Sprite;
      
      private var _fingerAnimationHandler:Boolean = false;
      
      private var _fingerAnimationCounter:uint;
      
      private var _firstRefresh:Boolean = true;
      
      private var _items:Array = new Array();
      
      public function BMScreenDailyLoginStreakBonus()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("dailyLoginStreakBonus");
      }
      
      public function refreshScreen() : void
      {
         var _loc2_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:MovieClip = null;
         var _loc6_:BMItem = null;
         var _loc7_:String = null;
         if(this._firstRefresh)
         {
            if(dataM.dailyLoginStreakBonusMythical)
            {
               this.txtTitle.y += 10;
               this.txtDescription.visible = false;
            }
            this.languageUpdate();
            if(dataM.runAsMobile == false)
            {
               this.mcMouseHitArea.addEventListener(MouseEvent.CLICK,this.mouseHitAreaClicked);
            }
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this.removeAllItems();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(dataM.dailyLoginStreakBonus.dailyLoginStreak >= dataM.dailyLoginStreakData.length)
         {
            dataM.dailyLoginStreakBonus.dailyLoginStreak = dataM.dailyLoginStreakData.length - 1;
         }
         else if(dataM.dailyLoginStreakBonus.dailyLoginStreak < 0)
         {
            dataM.dailyLoginStreakBonus.dailyLoginStreak = 0;
         }
         _loc1_.randomItemsFromLevelUp = new Array();
         if(dataM.dailyLoginStreakBonus.randomItemsFromLevelUp != null)
         {
            for each(_loc4_ in dataM.dailyLoginStreakBonus.randomItemsFromLevelUp)
            {
               _loc1_.randomItemsFromLevelUp.push(_loc4_.itemID);
            }
         }
         var _loc3_:uint = 0;
         while(_loc3_ < dataM.dailyLoginStreakData.length)
         {
            _loc2_ = dataM.dailyLoginStreakData[_loc3_];
            _loc6_ = new BMItem();
            switch(_loc2_.type)
            {
               case "crate":
                  _loc5_ = new mcDailyLoginStreakBonusItem1();
                  if(_loc3_ < dataM.dailyLoginStreakBonus.dailyLoginStreak)
                  {
                     _loc5_.gotoAndStop(4);
                  }
                  else
                  {
                     _loc5_.gotoAndStop(_loc2_.amount);
                  }
                  if(_loc3_ < 8)
                  {
                     _loc6_.x = 45 + _loc3_ * 90 + _loc5_.width / 2;
                     _loc6_.y = 107 + _loc5_.height / 2;
                  }
                  else
                  {
                     _loc6_.x = 45 + (_loc3_ - 8) * 90 + _loc5_.width / 2;
                     _loc6_.y = 212 + _loc5_.height / 2;
                  }
                  break;
               case "itemBox":
                  switch(_loc2_.packageID)
                  {
                     case 13:
                        _loc5_ = new mcDailyLoginStreakBonusItem3();
                        if(_loc3_ < dataM.dailyLoginStreakBonus.dailyLoginStreak)
                        {
                           _loc5_.gotoAndStop(2);
                        }
                        else
                        {
                           _loc5_.gotoAndStop(1);
                        }
                        if(dataM.dailyLoginStreakBonusMythical)
                        {
                           _loc6_.x = 45 + (_loc3_ - 16) * 142 + _loc5_.width / 2;
                        }
                        else
                        {
                           _loc6_.x = 45 + (_loc3_ - 16) * 140 + _loc5_.width / 2;
                        }
                        _loc6_.y = 318 + _loc5_.height / 2;
                        break;
                     case 18:
                        _loc5_ = new mcDailyLoginStreakBonusItem4();
                        if(_loc3_ < dataM.dailyLoginStreakBonus.dailyLoginStreak)
                        {
                           _loc5_.gotoAndStop(2);
                        }
                        else
                        {
                           _loc5_.gotoAndStop(1);
                        }
                        _loc6_.x = 45 + (_loc3_ - 16) * 142 + _loc5_.width / 2 + 28;
                        _loc6_.y = 318 + _loc5_.height / 2;
                        break;
                     default:
                        _loc5_ = new mcDailyLoginStreakBonusItem2();
                        if(dataM.dailyLoginStreakBonusMythical)
                        {
                           _loc6_.x = 45 + (_loc3_ - 16) * 142 + _loc5_.width / 2;
                        }
                        else
                        {
                           _loc6_.x = 45 + (_loc3_ - 16) * 140 + _loc5_.width / 2;
                        }
                        _loc6_.y = 335 + _loc5_.height / 2;
                        if(_loc3_ < dataM.dailyLoginStreakBonus.dailyLoginStreak)
                        {
                           _loc5_.gotoAndStop(4);
                        }
                        else
                        {
                           switch(_loc2_.packageID)
                           {
                              case 9:
                                 _loc5_.gotoAndStop(1);
                                 break;
                              case 11:
                                 _loc5_.gotoAndStop(2);
                                 break;
                              case 12:
                                 _loc5_.gotoAndStop(3);
                           }
                        }
                  }
            }
            _loc7_ = getScreenText("dayX");
            _loc7_ = dataM.replaceStringInText(_loc7_,"%DAY%",String(_loc3_ + 1));
            TextUtils.updateTextFormat(_loc5_.txtDay,16);
            _loc5_.txtDay.text = _loc7_;
            _loc6_.initialize(_loc3_,0,0,_loc5_,0,0,false,null,dataM.runAsMobile);
            if(dataM.runAsMobile)
            {
               _loc6_.createAssetsBitmap([_loc5_.txtDay],[],_loc5_);
            }
            this.mcItemsHolder.addChild(_loc6_);
            this._items.push(_loc6_);
            _loc3_++;
         }
         this.removeGlowPointerAnimations();
         _loc2_ = dataM.dailyLoginStreakData[dataM.dailyLoginStreakBonus.dailyLoginStreak];
         if(_loc2_.type == "crate")
         {
            this.activatePointer(this.mcGlowPointer1);
         }
         else if(dataM.dailyLoginStreakBonusMythical)
         {
            if(dataM.dailyLoginStreakBonus.dailyLoginStreak == dataM.dailyLoginStreakData.length - 1)
            {
               this.activatePointer(this.mcGlowPointer4,180);
            }
            else if(dataM.dailyLoginStreakBonus.dailyLoginStreak == dataM.dailyLoginStreakData.length - 2)
            {
               this.activatePointer(this.mcGlowPointer3,180);
            }
            else
            {
               this.activatePointer(this.mcGlowPointer2,180);
            }
         }
         else if(dataM.dailyLoginStreakBonus.dailyLoginStreak == dataM.dailyLoginStreakData.length - 1)
         {
            this.activatePointer(this.mcGlowPointer3,180);
         }
         else
         {
            this.activatePointer(this.mcGlowPointer2,180);
         }
         if(_loc1_.level <= 10 || dataM.dailyLoginStreakBonus.dailyLoginStreak < 4)
         {
            this.mcFinger.visible = true;
            this._fingerAnimationHandler = true;
            this._fingerAnimationCounter = 0;
         }
         else
         {
            this.mcFinger.visible = false;
         }
      }
      
      private function languageUpdate() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.txtDescription,16);
         }
         this.txtTitle.text = getScreenText("title");
         var _loc1_:String = getScreenText("description");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%DAYS%",String(dataM.dailyLoginStreakData.length));
         _loc1_ = dataM.replaceStringInText(_loc1_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
         this.txtDescription.htmlText = TextUtils.getTextFont() + _loc1_;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("dailyLoginStreak_texts",[this.txtTitle,this.txtDescription],"",this);
         }
      }
      
      private function activatePointer(param1:MovieClip, param2:Number = 0) : void
      {
         param1.gotoAndStop("animOn");
         param1.x = this._items[dataM.dailyLoginStreakBonus.dailyLoginStreak].x;
         param1.y = this._items[dataM.dailyLoginStreakBonus.dailyLoginStreak].y;
         this.mcFinger.x = param1.x;
         this.mcFinger.y = param1.y;
         this.mcFinger.rotation = param2;
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this.fingerAnimationHandler();
         }
      }
      
      private function fingerAnimationHandler() : void
      {
         if(this._fingerAnimationHandler)
         {
            ++this._fingerAnimationCounter;
            if(this._fingerAnimationCounter <= 10)
            {
               if(this.mcFinger.rotation == 0)
               {
                  this.mcFinger.y += 11 - this._fingerAnimationCounter;
               }
               else
               {
                  this.mcFinger.y -= 11 - this._fingerAnimationCounter;
               }
            }
            else
            {
               if(this.mcFinger.rotation == 0)
               {
                  this.mcFinger.y -= this._fingerAnimationCounter - 10;
               }
               else
               {
                  this.mcFinger.y += this._fingerAnimationCounter - 10;
               }
               if(this._fingerAnimationCounter >= 20)
               {
                  this._fingerAnimationCounter = 0;
               }
            }
         }
      }
      
      private function removeFingerAnimation() : void
      {
         this._fingerAnimationHandler = false;
         this.mcFinger.visible = false;
      }
      
      private function mouseHitAreaClicked(param1:MouseEvent) : void
      {
         this.mouseHitAreaClickedSub();
      }
      
      public function mouseHitAreaClickedSub() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:Number = NaN;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc7_:Object = null;
         var _loc8_:Object = null;
         this.removeFingerAnimation();
         this.removeGlowPointerAnimations();
         var _loc1_:Object = dataM.dailyLoginStreakData[dataM.dailyLoginStreakBonus.dailyLoginStreak];
         switch(_loc1_.type)
         {
            case "crate":
               _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc4_ = 0;
               _loc2_ = 0;
               while(_loc2_ < dataM.dailyLoginStreakBonus.crates.length)
               {
                  _loc7_ = dataM.dailyLoginStreakBonus.crates[_loc2_];
                  switch(_loc7_.type)
                  {
                     case "gold":
                        _loc3_.gold -= _loc7_.amount;
                        break;
                     case "xp":
                        _loc4_ += _loc7_.amount;
                  }
                  _loc2_++;
               }
               if(_loc4_ > 0)
               {
                  _loc3_.XP -= _loc4_;
                  if(dataM.levelUpDB[_loc3_.level] > _loc3_.XP)
                  {
                     --_loc3_.level;
                  }
               }
               _loc3_.lastGoldFromLevelUp = dataM.dailyLoginStreakBonus.goldFromLevelUp;
               if(_loc3_.lastGoldFromLevelUp > 0)
               {
                  _loc3_.gold -= _loc3_.lastGoldFromLevelUp;
               }
               _loc3_.lastTokensFromLevelUp = dataM.dailyLoginStreakBonus.bonusTokensFromLevelUp;
               if(_loc3_.lastTokensFromLevelUp > 0)
               {
                  _loc3_.tokens -= _loc3_.lastTokensFromLevelUp;
               }
               screensM.addScreen("screenMissionCompleted");
               screensM.screenMissionCompleted.refreshScreen(dataM.dailyLoginStreakBonus.crates,"DailyLoginStreak");
               break;
            case "itemBox":
               _loc5_ = new Array();
               _loc2_ = 0;
               while(_loc2_ < dataM.dailyLoginStreakBonus.items.length)
               {
                  _loc8_ = dataM.dailyLoginStreakBonus.items[_loc2_];
                  _loc5_.push(_loc8_.itemID);
                  _loc2_++;
               }
               _loc6_ = 25;
               if(dataM.dailyLoginStreakBonus.items.length == 1)
               {
                  _loc6_ = 20;
               }
               screensM.addScreen("screenItemCards");
               screensM.screenItemCards.refreshScreen(_loc5_,_loc6_);
         }
      }
      
      private function removeAllItems() : void
      {
         var _loc1_:uint = 0;
         if(this._items != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._items.length)
            {
               this._items[_loc1_].removeMe();
               this._items[_loc1_] = null;
               _loc1_++;
            }
            this._items = new Array();
         }
      }
      
      private function removeGlowPointerAnimations() : void
      {
         this.mcGlowPointer1.gotoAndStop("animOff");
         this.mcGlowPointer2.gotoAndStop("animOff");
         this.mcGlowPointer3.gotoAndStop("animOff");
         this.mcGlowPointer4.gotoAndStop("animOff");
      }
      
      public function closeScreen() : void
      {
         this.removeMe();
         screensM.screenWelcomeBackground.welcomeBackHandlerSub();
      }
      
      public function removeMe() : void
      {
         dataM.dailyLoginStreakBonus = new Object();
         this.removeAllItems();
         this.removeFingerAnimation();
         this.removeGlowPointerAnimations();
         screensM.removeScreen("screenDailyLoginStreakBonus");
      }
   }
}

