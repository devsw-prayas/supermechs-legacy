package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMCompletedQuestData;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1887")]
   public class BMScreenAchievementUnlocked extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcQuestIcon:MovieClip;
      
      public var mcLightEffect:Sprite;
      
      public var txtDescription:TextField;
      
      private var _closeScreenCountdown:Number;
      
      private var _lightEffectCountdown:Number;
      
      private var _lightEffectOriginXPos:Number;
      
      private var _newlyCompletedQuests:Array = new Array();
      
      private var _descriptionOriginYPos:Number;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenAchievementUnlocked()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         this._descriptionOriginYPos = this.txtDescription.y;
         addEventListener(MouseEvent.CLICK,this.onClicked);
      }
      
      private function onClicked(param1:MouseEvent) : void
      {
         this._closeScreenCountdown = 1;
      }
      
      public function displayCompletedQuest(param1:BMCompletedQuestData) : void
      {
         var _loc2_:Boolean = false;
         if(this._newlyCompletedQuests.length > 0)
         {
            _loc2_ = true;
         }
         this._newlyCompletedQuests.push(param1);
         if(_loc2_ == false)
         {
            this.tryToActivateCompletedQuest();
         }
      }
      
      private function tryToActivateCompletedQuest() : void
      {
         if(this._newlyCompletedQuests.length > 0)
         {
            screensM.addScreen("screenAchievementUnlocked");
            this.refreshScreen();
         }
      }
      
      public function refreshScreen() : void
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
         this.mcBackground.gotoAndStop("open");
         this.txtDescription.htmlText = "";
         this.createTextsBitmapForMobile();
         if(this._newlyCompletedQuests.length > 1)
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
            _loc1_ = 18;
            switch(dataM.languageID)
            {
               case 3:
                  _loc1_ = 18;
            }
            TextUtils.updateTextFormat(this.txtDescription,_loc1_);
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
            screensM.createMultipleTextsBitmap("achievementUnlocked_texts",[this.txtDescription],"",this);
         }
      }
      
      public function backgroundOpened() : void
      {
         var _loc1_:BMCompletedQuestData = this._newlyCompletedQuests[0];
         this.txtDescription.htmlText = "<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>" + _loc1_.title + "</FONT><BR>" + _loc1_.body;
         this.txtDescription.y = this._descriptionOriginYPos;
         if(this.txtDescription.numLines == 2)
         {
            this.txtDescription.y += 11;
         }
         this._lightEffectCountdown = 12;
         this.createTextsBitmapForMobile();
      }
      
      public function backgroundClosed() : void
      {
         this._newlyCompletedQuests.splice(0,1);
         if(this._newlyCompletedQuests.length > 0)
         {
            this.tryToActivateCompletedQuest();
         }
         else
         {
            screensM.removeScreen("screenAchievementUnlocked");
         }
      }
      
      private function closeScreen() : void
      {
         this.txtDescription.htmlText = "";
         this.createTextsBitmapForMobile();
         this.mcBackground.gotoAndStop("close");
      }
   }
}

