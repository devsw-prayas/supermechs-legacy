package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1625")]
   public class BMScreenAchievementUnlocked extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcSizer_achievement:Sprite;
      
      public var mcAchievement:MovieClip;
      
      public var mcRank:MovieClip;
      
      public var mcLightEffect:Sprite;
      
      public var mcGold:Sprite;
      
      public var mcTokens:Sprite;
      
      public var mcBattleCredits:Sprite;
      
      public var txtDescription:TextField;
      
      public var txtReward:TextField;
      
      private var _notificationType:String;
      
      private var _notificationID:Number;
      
      private var _closeScreenCountdown:Number;
      
      private var _lightEffectCountdown:Number;
      
      private var _lightEffectOriginXPos:Number;
      
      private var _newlyUnlockedAchievements:Array = new Array();
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenAchievementUnlocked()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function displayUnlockedAchievements(param1:String, param2:Array) : void
      {
         var _loc3_:Boolean = false;
         if(this._newlyUnlockedAchievements.length > 0)
         {
            _loc3_ = true;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < param2.length)
         {
            this._newlyUnlockedAchievements.push({
               "type":param1,
               "ID":param2[_loc4_]
            });
            _loc4_++;
         }
         if(_loc3_ == false)
         {
            this.tryToActivateAchievement();
         }
      }
      
      private function tryToActivateAchievement() : void
      {
         if(this._newlyUnlockedAchievements.length > 0)
         {
            screensM.addScreen("screenAchievementUnlocked");
            this.refreshScreen(this._newlyUnlockedAchievements[0].type,this._newlyUnlockedAchievements[0].ID);
         }
      }
      
      public function refreshScreen(param1:String, param2:Number) : void
      {
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("achievements");
            this._lightEffectOriginXPos = this.mcLightEffect.x;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this._notificationType = param1;
         this._notificationID = param2;
         this.mcBackground.gotoAndStop("open");
         this.txtDescription.htmlText = "";
         this.txtReward.text = "";
         this.createTextsBitmapForMobile();
         this.mcGold.visible = false;
         this.mcTokens.visible = false;
         this.mcBattleCredits.visible = false;
         if(this._newlyUnlockedAchievements.length > 1)
         {
            this._closeScreenCountdown = 125;
         }
         else
         {
            this._closeScreenCountdown = 175;
         }
         this._lightEffectCountdown = 0;
         this.mcLightEffect.x = this._lightEffectOriginXPos;
      }
      
      private function languageUpdate() : void
      {
         var _loc1_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc1_ = 16;
            switch(dataM.languageID)
            {
               case 3:
                  _loc1_ = 16;
            }
            TextUtils.updateTextFormat(this.txtDescription,_loc1_);
            TextUtils.updateTextFormat(this.txtReward,18);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            if(this._closeScreenCountdown > 0)
            {
               --this._closeScreenCountdown;
               if(this._closeScreenCountdown == 0)
               {
                  this.closeScreen();
               }
            }
            if(this._lightEffectCountdown > 0)
            {
               --this._lightEffectCountdown;
               this.mcLightEffect.x += 50;
            }
         }
      }
      
      private function createTextsBitmapForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("achievementUnlocked_texts",[this.txtDescription,this.txtReward],"",this);
         }
      }
      
      public function backgroundOpened() : void
      {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         switch(this._notificationType)
         {
            case "achievement":
               _loc1_ = dataM.achievementsDB[this._notificationID];
               _loc2_ = dataM.getAchievmentDescriptionText(_loc1_);
               this.txtDescription.htmlText = TextUtils.getTextFont() + getScreenText("achievementUnlocked") + "<BR>" + _loc2_;
               _loc3_ = "achievement_" + _loc1_.type;
         }
         var _loc4_:Number = Number(_loc1_.requirement);
         if(_loc1_.type == "highestLadderProgress")
         {
            _loc4_ = dataM.getLadderRankByProgress(_loc1_.requirement);
         }
         if(_loc1_.goldBonus > 0)
         {
            this.mcGold.visible = true;
            this.txtReward.text = "+" + dataM.getNumberWithComma(_loc1_.goldBonus);
         }
         else if(_loc1_.tokensBonus > 0)
         {
            this.mcTokens.visible = true;
            this.txtReward.text = "+" + dataM.getNumberWithComma(_loc1_.tokensBonus);
         }
         else if(_loc1_.battleCreditsBonus > 0)
         {
            this.mcBattleCredits.visible = true;
            this.txtReward.text = "+" + dataM.getNumberWithComma(_loc1_.battleCreditsBonus);
         }
         this.mcAchievement = externalAssetsM.getAsset("general",_loc3_);
         this.mcAchievement.width = this.mcSizer_achievement.width;
         this.mcAchievement.height = this.mcSizer_achievement.height;
         this.mcAchievement.x = this.mcSizer_achievement.x;
         this.mcAchievement.y = this.mcSizer_achievement.y;
         this.mcIconsHolder.addChild(this.mcAchievement);
         switch(this._notificationType)
         {
            case "campaignMission":
               if(this.mcRank != null)
               {
                  this.mcRank.visible = false;
               }
               break;
            case "achievement":
               if(this.mcRank == null)
               {
                  this.mcRank = externalAssetsM.getAsset("general","achievementRank");
                  this.mcRank.width = this.mcSizer_achievement.width;
                  this.mcRank.height = this.mcSizer_achievement.height;
                  this.mcRank.x = this.mcSizer_achievement.x;
                  this.mcRank.y = this.mcSizer_achievement.y;
                  this.mcIconsHolder.addChild(this.mcRank);
               }
               this.mcRank.gotoAndStop("rank" + _loc1_.level);
               this.mcRank.visible = true;
         }
         this._lightEffectCountdown = 12;
         this.createTextsBitmapForMobile();
      }
      
      public function backgroundClosed() : void
      {
         this._newlyUnlockedAchievements.splice(0,1);
         if(this._newlyUnlockedAchievements.length > 0)
         {
            this.tryToActivateAchievement();
         }
         else
         {
            screensM.removeScreen("screenAchievementUnlocked");
         }
      }
      
      private function closeScreen() : void
      {
         this.txtDescription.htmlText = "";
         this.txtReward.text = "";
         this.createTextsBitmapForMobile();
         this.mcGold.visible = false;
         this.mcTokens.visible = false;
         this.mcBattleCredits.visible = false;
         this.mcBackground.gotoAndStop("close");
         if(this.mcAchievement != null)
         {
            if(this.mcAchievement.parent != null)
            {
               this.mcAchievement.parent.removeChild(this.mcAchievement);
            }
            this.mcAchievement = null;
         }
         if(this.mcRank != null)
         {
            this.mcRank.visible = false;
         }
      }
   }
}

