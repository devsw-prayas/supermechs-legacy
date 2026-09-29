package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMSpecialOffersManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol291")]
   public class BMScreenMissionWorldMapInterface extends BMBaseScreen
   {
      
      public var mcButtonsHolder:MovieClip;
      
      public var mcSpecialOffersLocation:Sprite;
      
      public var mcSizer_btnGoToHighestMission:Sprite;
      
      public var mcSizer_btnBattleType:Sprite;
      
      public var mcTooltip_hard:Sprite;
      
      public var mcTooltip_insane:Sprite;
      
      public var mcKeyHard:Sprite;
      
      public var mcKeyInsane:Sprite;
      
      public var btnBattleType:BMButton;
      
      public var btnGoToHighestMission:BMButton_pictureE;
      
      public var txtHard:TextField;
      
      public var txtInsane:TextField;
      
      public var txtGameStyle:TextField;
      
      private var _keyHardOriginXPos:Number;
      
      private var _keyHardOriginYPos:Number;
      
      private var _keyInsaneOriginXPos:Number;
      
      private var _keyInsaneOriginYPos:Number;
      
      private var _keyAnimationHandlerActive:Boolean;
      
      private var _keyAnimationFrameCounter:uint;
      
      private var _keyAnimationDifficulty:uint;
      
      private var _keyAnimationStatus:String;
      
      private var _keyAnimationTargetXPos:Number;
      
      private var _keyAnimationTargetYPos:Number;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenMissionWorldMapInterface()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenMissionWorldMapInterface","btnGoToHighestMission","pictureE");
            _loc1_ = screensM.screenMissionWorldMap.goToHighestMission;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
            }
            this.btnGoToHighestMission.initialize("","",new mcGoToHighestMission(),null,_loc1_,dataM.runAsMobile);
            this.btnGoToHighestMission.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this._keyHardOriginXPos = this.mcKeyHard.x;
            this._keyHardOriginYPos = this.mcKeyHard.y;
            this._keyInsaneOriginXPos = this.mcKeyInsane.x;
            this._keyInsaneOriginYPos = this.mcKeyInsane.y;
            if(!dataM.runAsMobile)
            {
               this.btnGoToHighestMission.buttonCore.addMouseOverListerner(this.goToHighestMissionMouseOver);
               this.btnGoToHighestMission.buttonCore.addMouseOutListerner(this.goToHighestMissionMouseOut);
               this.mcTooltip_hard.addEventListener(MouseEvent.MOUSE_OVER,this.hardTooltipMouseOver);
               this.mcTooltip_hard.addEventListener(MouseEvent.MOUSE_OUT,this.generalTooltipMouseOut);
               this.mcTooltip_insane.addEventListener(MouseEvent.MOUSE_OVER,this.insaneTooltipMouseOver);
               this.mcTooltip_insane.addEventListener(MouseEvent.MOUSE_OUT,this.generalTooltipMouseOut);
            }
            this.txtGameStyle.text = "Game style";
            this._firstRefresh = false;
         }
         this.resetAnimationKeys();
         this.refreshSpecialOffers();
         this.refreshBattleTypeButton();
         this.refreshHardAndInsaneKeys();
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this.keyAnimationHandler();
         }
      }
      
      private function refreshBattleTypeButton() : void
      {
      }
      
      public function battleTypeClicked() : void
      {
         ++dataM.campaignBattleType;
         if(dataM.campaignBattleType > 3)
         {
            dataM.campaignBattleType = 1;
         }
         this.refreshBattleTypeButton();
      }
      
      public function resetAnimationKeys() : void
      {
         this._keyAnimationHandlerActive = false;
         this.mcKeyHard.x = this._keyHardOriginXPos;
         this.mcKeyHard.y = this._keyHardOriginYPos;
         this.mcKeyHard.scaleX = 1;
         this.mcKeyHard.scaleY = 1;
         this.mcKeyHard.visible = false;
         this.mcKeyInsane.x = this._keyInsaneOriginXPos;
         this.mcKeyInsane.y = this._keyInsaneOriginYPos;
         this.mcKeyInsane.scaleX = 1;
         this.mcKeyInsane.scaleY = 1;
         this.mcKeyInsane.visible = false;
      }
      
      public function activateKeyAnimation(param1:uint, param2:uint) : void
      {
         this._keyAnimationHandlerActive = true;
         this._keyAnimationFrameCounter = 0;
         this._keyAnimationDifficulty = param1;
         if(this._keyAnimationDifficulty == 2)
         {
            this.refreshHardAndInsaneKeys(true);
         }
         else
         {
            this.refreshHardAndInsaneKeys(false,true);
         }
         this._keyAnimationStatus = "up";
         var _loc3_:BMWorldMapLocationData = dataM.missionsDB[param2];
         this._keyAnimationTargetXPos = _loc3_.xPos + screensM.screenMissionWorldMap.mcMapContentHolder.x + screensM.screenMissionWorldMap.mcMapHolder.x;
         this._keyAnimationTargetYPos = _loc3_.yPos + screensM.screenMissionWorldMap.mcMapContentHolder.y + screensM.screenMissionWorldMap.mcMapHolder.y;
      }
      
      private function keyAnimationHandler() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._keyAnimationHandlerActive)
         {
            ++this._keyAnimationFrameCounter;
            if(this._keyAnimationDifficulty == 2)
            {
               _loc1_ = this.mcKeyHard;
            }
            else
            {
               _loc1_ = this.mcKeyInsane;
            }
            switch(this._keyAnimationStatus)
            {
               case "up":
                  if(this._keyAnimationFrameCounter == 1)
                  {
                     _loc1_.visible = true;
                  }
                  if(this._keyAnimationFrameCounter <= 10)
                  {
                     _loc1_.scaleX += 0.2;
                     _loc1_.scaleY += 0.2;
                  }
                  _loc2_ = 240 - _loc1_.y;
                  _loc1_.y += _loc2_ * 0.15;
                  if(Math.abs(_loc2_) < 1)
                  {
                     _loc1_.y = 240;
                     this._keyAnimationStatus = "wait";
                     this._keyAnimationFrameCounter = 0;
                  }
                  break;
               case "wait":
                  if(this._keyAnimationFrameCounter >= 10)
                  {
                     this._keyAnimationStatus = "down";
                     this._keyAnimationFrameCounter = 0;
                  }
                  break;
               case "down":
                  _loc3_ = this._keyAnimationTargetXPos - _loc1_.x;
                  _loc2_ = this._keyAnimationTargetYPos - _loc1_.y;
                  _loc1_.x += _loc3_ * 0.3;
                  _loc1_.y += _loc2_ * 0.3;
                  if(Math.abs(_loc3_) < 1 && Math.abs(_loc2_) < 1)
                  {
                     _loc1_.x = this._keyAnimationTargetXPos;
                     _loc1_.y = this._keyAnimationTargetYPos;
                     this._keyAnimationStatus = "shrink";
                  }
                  break;
               case "shrink":
                  _loc1_.scaleX -= 0.25;
                  _loc1_.scaleY -= 0.25;
                  if(_loc1_.scaleX <= 0.25)
                  {
                     _loc1_.visible = false;
                     this._keyAnimationStatus = "done";
                  }
                  break;
               case "done":
                  this._keyAnimationHandlerActive = false;
                  screensM.screenMissionWorldMap.enterMission();
            }
         }
      }
      
      public function refreshHardAndInsaneKeys(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         if(param1)
         {
            _loc4_--;
         }
         if(param2)
         {
            _loc5_--;
         }
         this.txtHard.text = String(_loc4_);
         this.txtInsane.text = String(_loc5_);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("missionWorlMapInterface",[this.txtHard,this.txtInsane],"",this);
         }
      }
      
      public function refreshSpecialOffers() : void
      {
         dataM.starterPack_goBackToScreen = "singlePlayer";
         BMSpecialOffersManager.gi().showBigBanner(this.mcSpecialOffersLocation,0.82);
      }
      
      public function goToHighestMissionMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("missionWorldMap_goToNextMission"));
      }
      
      public function goToHighestMissionMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      private function hardTooltipMouseOver(param1:MouseEvent) : void
      {
         this.hardTooltipMouseOverSub();
      }
      
      public function hardTooltipMouseOverSub() : void
      {
         var _loc1_:String = getSpecificText("missionWorldMap_hardKeys");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_HARD + "\'>");
         tooltip.showToolTip("regularText",_loc1_);
      }
      
      private function insaneTooltipMouseOver(param1:MouseEvent) : void
      {
         this.insaneTooltipMouseOverSub();
      }
      
      public function insaneTooltipMouseOverSub() : void
      {
         var _loc1_:String = getSpecificText("missionWorldMap_insaneKeys");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_INSANE + "\'>");
         tooltip.showToolTip("regularText",_loc1_);
      }
      
      public function generalTooltipMouseOut(param1:MouseEvent) : void
      {
         tooltip.hideToolTip();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen("screenMissionWorldMapInterface");
      }
   }
}

