package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2163")]
   public class BMScreenDailyLoginStreakBonus extends BMBaseScreen
   {
      
      private static const BONUS_FRAME_GOLD:String = "gold";
      
      private static const BONUS_FRAME_XP:String = "xp";
      
      private static const BONUS_FRAME_BATTLE_CREDITS:String = "battleCredits";
      
      private static const BONUS_FRAME_TOKENS:String = "tokens";
      
      private static const BONUS_FRAME_SILVER_BOX_X1:String = "silverBoxX1";
      
      private static const BONUS_FRAME_SILVER_BOX_X2:String = "silverBoxX2";
      
      private static const BONUS_FRAME_SILVER_BOX_X3:String = "silverBoxX3";
      
      private static const BONUS_FRAME_GOLD_BOX:String = "goldBox";
      
      private static const BONUS_FRAME_CRATE:String = "crate";
      
      private static const BONUS_FRAME_COLLECTED:String = "collected";
      
      public var mcButtonsHolder:Sprite;
      
      public var mcItemsHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtDescription:TextField;
      
      public var mcGlowPointer1:MovieClip;
      
      public var mcMouseHitArea:Sprite;
      
      public var mcFinger:Sprite;
      
      private var _fingerAnimationHandler:Boolean = false;
      
      private var _fingerAnimationCounter:uint;
      
      private var _firstRefresh:Boolean = true;
      
      private var _items:Array = new Array();
      
      private var _firstItemValue:uint;
      
      public function BMScreenDailyLoginStreakBonus()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("dailyLoginStreakBonus");
      }
      
      private function getBonusDataType(param1:BMRewardData) : *
      {
         if(param1.boxes.length > 0 || param1.hasItems)
         {
            return "itemBox";
         }
         return "crate";
      }
      
      private function getBonusMovieClip(param1:BMRewardData, param2:Boolean) : MovieClip
      {
         var _loc5_:uint = 0;
         var _loc3_:MovieClip = new mcDailyLoginStreakBonusItem1();
         var _loc4_:String = BONUS_FRAME_CRATE;
         if(param1.gold > 0)
         {
            _loc4_ = BONUS_FRAME_GOLD;
         }
         else if(param1.tokens > 0)
         {
            _loc4_ = BONUS_FRAME_TOKENS;
         }
         else if(param1.battleCredits > 0)
         {
            _loc4_ = BONUS_FRAME_BATTLE_CREDITS;
         }
         else if(param1.hasItems)
         {
            _loc4_ = BONUS_FRAME_CRATE;
         }
         else if(param1.boxes.length > 0)
         {
            _loc5_ = dataM.getGacheMachine(param1.boxes[0]).imageID;
            if(_loc5_ == 1)
            {
               switch(param1.boxes.length)
               {
                  case 1:
                     _loc4_ = BONUS_FRAME_SILVER_BOX_X1;
                     break;
                  case 2:
                     _loc4_ = BONUS_FRAME_SILVER_BOX_X2;
                     break;
                  case 3:
                  default:
                     _loc4_ = BONUS_FRAME_SILVER_BOX_X3;
               }
            }
            else if(_loc5_ == 2)
            {
               _loc4_ = BONUS_FRAME_GOLD_BOX;
            }
         }
         else if(param1.xp > 0)
         {
            _loc4_ = BONUS_FRAME_XP;
         }
         if(param2)
         {
            _loc4_ = BONUS_FRAME_COLLECTED;
         }
         _loc3_.gotoAndStop(_loc4_);
         return _loc3_;
      }
      
      public function refreshScreen() : void
      {
         var _loc3_:* = undefined;
         var _loc4_:uint = 0;
         var _loc5_:BMRewardData = null;
         var _loc6_:MovieClip = null;
         var _loc7_:BMItem = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         if(this._firstRefresh)
         {
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
         var _loc2_:Array = new Array();
         for(_loc3_ in dataM.dailyLoginStreakData)
         {
            _loc2_.push(uint(_loc3_));
         }
         _loc2_.sort(Array.NUMERIC);
         this._firstItemValue = uint(_loc2_[0]);
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = uint(_loc3_);
            _loc5_ = new BMRewardData(dataM.dailyLoginStreakData[_loc4_]);
            _loc7_ = new BMItem();
            _loc6_ = this.getBonusMovieClip(_loc5_,this._items.length < dataM.dailyLoginStreakBonus.dailyLoginStreak - 1);
            _loc8_ = (_loc4_ - 1) % 7;
            _loc9_ = (_loc4_ - 1) / 7;
            _loc7_.x = 55 + _loc8_ * 100 + _loc6_.width / 2;
            _loc7_.y = 107 + 115 * _loc9_ + _loc6_.height / 2;
            _loc10_ = getScreenText("dayX");
            _loc10_ = dataM.replaceStringInText(_loc10_,"%DAY%",String(_loc4_));
            TextUtils.updateTextFormat(_loc6_.txtDay,16);
            updateTextAndFormat(_loc6_.txtDay,_loc10_);
            _loc7_.initialize(_loc4_,0,0,_loc6_,0,0,false,null,dataM.runAsMobile);
            if(dataM.runAsMobile)
            {
               _loc7_.createAssetsBitmap([_loc6_.txtDay],[],_loc6_);
            }
            this.mcItemsHolder.addChild(_loc7_);
            this._items.push(_loc7_);
         }
         this.removeGlowPointerAnimations();
         this.activatePointer(this.mcGlowPointer1);
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
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         var _loc1_:String = getScreenText("description");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%DAYS%",String(dataM.dailyLoginStreakData.length));
         _loc1_ = dataM.replaceStringInText(_loc1_,"%COLOR%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>");
         updateTextAndFormat(this.txtDescription,_loc1_);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("dailyLoginStreak_texts",[this.txtTitle,this.txtDescription],"",this);
         }
      }
      
      private function activatePointer(param1:MovieClip, param2:Number = 0) : void
      {
         param1.gotoAndStop("animOn");
         param1.x = this._items[dataM.dailyLoginStreakBonus.dailyLoginStreak - this._firstItemValue].x - 7;
         param1.y = this._items[dataM.dailyLoginStreakBonus.dailyLoginStreak - this._firstItemValue].y - 5;
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
         if(this._fingerAnimationHandler == false)
         {
            return;
         }
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
            return;
         }
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
         this.removeFingerAnimation();
         this.removeGlowPointerAnimations();
         var _loc1_:BMRewardData = dataM.dailyLoginStreakBonus.reward;
         dataM.giveRewardPopup(_loc1_,"DailyLoginStreak",true);
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
      }
      
      public function closeScreen() : void
      {
         this.removeMe();
         screensM.screenWelcomeBackground.welcomeBackHandlerSub();
      }
      
      public function removeMe() : void
      {
         dataM.dailyLoginStreakBonus.reward = null;
         this.removeAllItems();
         this.removeFingerAnimation();
         this.removeGlowPointerAnimations();
         screensM.removeScreen(BMScreensManager.SCR_DAILY_LOGIN_STREAK_BONUS);
      }
   }
}

