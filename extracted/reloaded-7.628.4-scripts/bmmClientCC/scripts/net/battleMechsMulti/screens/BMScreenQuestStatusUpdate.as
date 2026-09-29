package net.battleMechsMulti.screens
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMQuestStatusUpdateData;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1759")]
   public class BMScreenQuestStatusUpdate extends BMBaseScreen
   {
      
      private static const BACKGROUND_FRAME_PROGRESS:String = "progress";
      
      private static const BACKGROUND_FRAME_COMPLETED:String = "completed";
      
      private static const BACKGROUND_FRAME_KIN:String = "kin";
      
      private static const MESSAGE_DURATION_FOR_SINGLE_MESSAGE:uint = 175;
      
      private static const MESSAGE_DURATION_FOR_MULTIPLE_MESSAGES:uint = 125;
      
      private static const SCREEN_ORIGIN_Y_POS:Number = -120;
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcLightEffect:Sprite;
      
      public var txtQuestCompleted:TextField;
      
      public var txtQuestProgressUpdateDesc:TextField;
      
      public var txtQuestProgressUpdateValue:TextField;
      
      public var mcProgressBar:BMBar;
      
      private var _currentQuestStatusDisplayCountdown:Number;
      
      private var _lightEffectCountdown:Number;
      
      private var _lightEffectOriginXPos:Number;
      
      private var _pendingQuestStatuses:Array = new Array();
      
      private var _descriptionOriginYPos:Number;
      
      private var _closingScreen:Boolean = false;
      
      private var _progressDisplay_progressBeforeUpdate:uint;
      
      private var _progressDisplay_progressAfterUpdate:uint;
      
      private var _progressDisplay_progressMax:uint;
      
      private var _progressDisplay_currentAnimationProgress:uint;
      
      public function BMScreenQuestStatusUpdate()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         this._descriptionOriginYPos = this.txtQuestCompleted.y;
         addEventListener(MouseEvent.CLICK,this.onClicked);
         setLanguageManagerScreenName("achievements");
         this._lightEffectOriginXPos = this.mcLightEffect.x;
         this.languageUpdate();
         this._lightEffectCountdown = 0;
         this.mcLightEffect.x = this._lightEffectOriginXPos;
         TweenMax.fromTo(this,0.3,{"y":SCREEN_ORIGIN_Y_POS},{"y":0});
         this.mcProgressBar.initialize("blue");
         this.mcProgressBar.setFillSpeed(BMBar.FILL_SPEED_SLOW);
         this.mcProgressBar.setFillType(BMBar.FILL_TYPE_LINEAR);
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
            TextUtils.updateTextFormat(this.txtQuestCompleted,_loc1_);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent == null)
         {
            return;
         }
         if(this._currentQuestStatusDisplayCountdown > 0)
         {
            --this._currentQuestStatusDisplayCountdown;
            if(this._currentQuestStatusDisplayCountdown == 0)
            {
               this.displayingQuestStatusCompleted();
            }
         }
         if(this._lightEffectCountdown > 0)
         {
            --this._lightEffectCountdown;
            this.mcLightEffect.x += 50;
         }
      }
      
      private function onClicked(param1:MouseEvent) : void
      {
         this._currentQuestStatusDisplayCountdown = 1;
      }
      
      public function showQuestStatus(param1:BMQuestStatusUpdateData) : void
      {
         if(this._closingScreen)
         {
            this._closingScreen = false;
            TweenMax.killTweensOf(this);
            TweenMax.to(this,0.2,{"y":0});
         }
         this._pendingQuestStatuses.push(param1);
         if(this._pendingQuestStatuses.length == 1)
         {
            this.tryToDisplayNextQuestStatus();
         }
      }
      
      private function tryToDisplayNextQuestStatus() : void
      {
         if(this._pendingQuestStatuses.length > 0)
         {
            this.displayCurrentQuestStatusUpdate();
            if(this._pendingQuestStatuses.length > 1)
            {
               this._currentQuestStatusDisplayCountdown = MESSAGE_DURATION_FOR_MULTIPLE_MESSAGES;
            }
            else
            {
               this._currentQuestStatusDisplayCountdown = MESSAGE_DURATION_FOR_SINGLE_MESSAGE;
            }
         }
         else
         {
            this.closeScreen();
         }
      }
      
      public function displayCurrentQuestStatusUpdate() : void
      {
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         var _loc1_:BMQuestStatusUpdateData = this._pendingQuestStatuses[0];
         if(_loc1_.isCompleted)
         {
            this.mcBackground.gotoAndStop(BACKGROUND_FRAME_COMPLETED);
            if(_loc1_.isKin)
            {
               this.mcBackground.gotoAndStop(BACKGROUND_FRAME_KIN);
            }
            this.mcProgressBar.visible = false;
            this.txtQuestProgressUpdateDesc.text = "";
            this.txtQuestProgressUpdateValue.text = "";
            _loc2_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + _loc1_.title + "</FONT><BR>" + _loc1_.body;
            updateTextAndFormat(this.txtQuestCompleted,_loc2_);
            this.txtQuestCompleted.y = this._descriptionOriginYPos;
            if(this.txtQuestCompleted.numLines == 2)
            {
               this.txtQuestCompleted.y += 11;
            }
            this.mcProgressBar.setFillChangedCallback(null);
         }
         else
         {
            this.mcBackground.gotoAndStop(BACKGROUND_FRAME_PROGRESS);
            this.txtQuestCompleted.text = "";
            updateTextAndFormat(this.txtQuestProgressUpdateDesc,_loc1_.body);
            this._progressDisplay_progressBeforeUpdate = _loc1_.lastProgress;
            this._progressDisplay_progressAfterUpdate = _loc1_.currentProgress;
            this._progressDisplay_progressMax = _loc1_.progressRequired;
            this._progressDisplay_currentAnimationProgress = this._progressDisplay_progressBeforeUpdate;
            this.updateProgressValueText();
            _loc3_ = this._progressDisplay_progressBeforeUpdate / this._progressDisplay_progressMax;
            this.mcProgressBar.setFill(_loc3_);
            _loc3_ = this._progressDisplay_progressAfterUpdate / this._progressDisplay_progressMax;
            this.mcProgressBar.setFill(_loc3_,true,20);
            this.mcProgressBar.visible = true;
            this.txtQuestProgressUpdateDesc.y = this._descriptionOriginYPos;
            if(this.txtQuestProgressUpdateDesc.numLines == 1)
            {
               this.txtQuestProgressUpdateDesc.y += 11;
            }
            this.mcProgressBar.setFillChangedCallback(this.progressBarFillChanged);
         }
         this._lightEffectCountdown = 12;
      }
      
      private function updateProgressValueText() : void
      {
         var _loc1_:String = TextUtils.getNumberWithComma(this._progressDisplay_currentAnimationProgress) + " / " + TextUtils.getNumberWithComma(this._progressDisplay_progressMax);
         updateTextAndFormat(this.txtQuestProgressUpdateValue,_loc1_);
      }
      
      private function progressBarFillChanged(param1:Number) : void
      {
         var _loc2_:uint = Math.ceil(param1 * this._progressDisplay_progressMax);
         if(_loc2_ > this._progressDisplay_progressAfterUpdate)
         {
            _loc2_ = this._progressDisplay_progressAfterUpdate;
         }
         if(this._progressDisplay_currentAnimationProgress == _loc2_)
         {
            return;
         }
         this._progressDisplay_currentAnimationProgress = _loc2_;
         this.updateProgressValueText();
      }
      
      private function displayingQuestStatusCompleted() : void
      {
         this._pendingQuestStatuses.splice(0,1);
         if(this._pendingQuestStatuses.length > 0)
         {
            this.tryToDisplayNextQuestStatus();
         }
         else
         {
            this.closeScreen();
         }
      }
      
      private function closeScreen() : void
      {
         TweenMax.to(this,0.3,{
            "y":SCREEN_ORIGIN_Y_POS,
            "onComplete":this.removeMe
         });
         this._closingScreen = true;
      }
      
      private function removeMe() : void
      {
         TweenMax.killTweensOf(this);
         screensM.removeScreen(BMScreensManager.SCR_QUEST_STATUS_UPDATE);
      }
   }
}

