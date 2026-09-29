package net.battleMechsMulti.mobiles.autoplayAndGameSpeedPanel
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   
   public class BMAutoplayAndGameSpeedPanel extends MovieClip
   {
      
      public var btnAutopilotOn:BMBasicButton;
      
      public var btnAutopilotOff:BMBasicButton;
      
      public var btnX1Speed:BMBasicButton;
      
      public var btnX2Speed:BMBasicButton;
      
      public var mcUserAutopilotArrow:MovieClip;
      
      private var _actionAllowedResolver:Function;
      
      private var _onUserAutopilotOn:Function;
      
      private var _onUserAutopilotOff:Function;
      
      private var _onGameSpeedX1:Function;
      
      private var _onGameSpeedX2:Function;
      
      private var _inBattleScreen:Boolean;
      
      private var _userAutopilotArrowController:BMTutorialArrowController;
      
      public function BMAutoplayAndGameSpeedPanel()
      {
         super();
      }
      
      public function initialize(param1:Function = null, param2:Function = null, param3:Function = null, param4:Function = null, param5:Function = null, param6:Boolean = false) : void
      {
         this._actionAllowedResolver = param1;
         this._onUserAutopilotOn = param2;
         this._onUserAutopilotOff = param3;
         this._onGameSpeedX1 = param4;
         this._onGameSpeedX2 = param5;
         this._inBattleScreen = param6;
         this.initializeUserAutopilotArrow();
         this.initAutopilotButtons();
         this.initGameSpeedButtons();
      }
      
      private function initAutopilotButtons() : void
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(_loc1_.isAutopilotAllowed(this._inBattleScreen) == false)
         {
            this.btnAutopilotOff.visible = false;
            this.btnAutopilotOn.visible = false;
            return;
         }
         _loc1_.userAutopilot = _loc1_.lastUserAutopilotInCampaign;
         this.btnAutopilotOn.addEventListener(BMIntractable.HIT,this.autopilotOnClicked);
         this.btnAutopilotOff.addEventListener(BMIntractable.HIT,this.autopilotOffClicked);
         this.refreshAutopilotButtons();
      }
      
      private function get areActionsAllowed() : Boolean
      {
         if(this._actionAllowedResolver == null)
         {
            return true;
         }
         return this._actionAllowedResolver();
      }
      
      private function autopilotOnClicked(param1:Event) : void
      {
         if(this.areActionsAllowed == false)
         {
            return;
         }
         BMDataManager.getInstance().setUserAutopilotOn();
         this.refreshAutopilotButtons();
         if(this._onUserAutopilotOn != null)
         {
            this._onUserAutopilotOn();
         }
      }
      
      private function autopilotOffClicked(param1:Event) : void
      {
         if(this.areActionsAllowed == false)
         {
            return;
         }
         this.autopilotOffClickedSub();
      }
      
      private function autopilotOffClickedSub() : void
      {
         BMDataManager.getInstance().setUserAutopilotOff();
         this.refreshAutopilotButtons();
         if(this._onUserAutopilotOff != null)
         {
            this._onUserAutopilotOff();
         }
      }
      
      public function manuallyClickAutopilotOff() : void
      {
         this.autopilotOffClickedSub();
      }
      
      private function refreshAutopilotButtons() : void
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         this.btnAutopilotOn.visible = false;
         this.btnAutopilotOff.visible = false;
         if(_loc1_.isAutopilotAllowed(this._inBattleScreen) == false)
         {
            return;
         }
         if(_loc1_.userAutopilot)
         {
            this.btnAutopilotOn.visible = false;
            this.btnAutopilotOff.visible = true;
         }
         else
         {
            this.btnAutopilotOn.visible = true;
            this.btnAutopilotOff.visible = false;
         }
      }
      
      public function disableAutopilotButtons() : void
      {
         this.btnAutopilotOn.disableMe();
         this.btnAutopilotOff.disableMe();
      }
      
      private function initializeUserAutopilotArrow() : void
      {
         if(this._userAutopilotArrowController == null)
         {
            this._userAutopilotArrowController = new BMTutorialArrowController(this.mcUserAutopilotArrow);
         }
      }
      
      public function activateUserAutopilotArrow() : void
      {
         this.initializeUserAutopilotArrow();
         var _loc1_:Number = this.btnAutopilotOn.x + this.btnAutopilotOn.width / 2;
         var _loc2_:Number = this.btnAutopilotOn.y;
         var _loc3_:uint = 270;
         var _loc4_:uint = 0;
         var _loc5_:uint = 60;
         this._userAutopilotArrowController.activateTutorialArrowWithTimer(this,_loc1_,_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      private function initGameSpeedButtons() : void
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(_loc1_.isAutopilotAllowed(this._inBattleScreen) == false || _loc1_.shouldForceDoubleSpeed)
         {
            this.btnX1Speed.visible = false;
            this.btnX2Speed.visible = false;
            return;
         }
         _loc1_.generalSpeedRatio = _loc1_.lastGeneralSpeedRatioInCampaign;
         this.btnX1Speed.addEventListener(BMIntractable.HIT,this.gameX1SpeedClicked);
         this.btnX2Speed.addEventListener(BMIntractable.HIT,this.gameX2SpeedClicked);
         this.refreshGameSpeedButtons();
      }
      
      private function gameX1SpeedClicked(param1:Event) : void
      {
         BMDataManager.getInstance().setGeneralSpeedRatioAsDouble();
         this.refreshGameSpeedButtons();
         if(this._onGameSpeedX1 != null)
         {
            this._onGameSpeedX1();
         }
      }
      
      private function gameX2SpeedClicked(param1:Event) : void
      {
         BMDataManager.getInstance().setGeneralSpeedRatioAsNormal();
         this.refreshGameSpeedButtons();
         if(this._onGameSpeedX2 != null)
         {
            this._onGameSpeedX2();
         }
      }
      
      private function refreshGameSpeedButtons() : void
      {
         this.btnX1Speed.visible = false;
         this.btnX2Speed.visible = false;
         if(BMDataManager.getInstance().isAutopilotAllowed(this._inBattleScreen) == false)
         {
            return;
         }
         switch(BMDataManager.getInstance().generalSpeedRatio)
         {
            case BMDataManager.GENERAL_SPEED_RATIO_NORMAL:
               this.btnX1Speed.visible = true;
               break;
            case BMDataManager.GENERAL_SPEED_RATIO_DOUBLE:
               this.btnX2Speed.visible = true;
         }
      }
      
      public function disableGameSpeedButtons() : void
      {
         this.btnX1Speed.disableMe();
         this.btnX2Speed.disableMe();
      }
      
      public function hideMe() : void
      {
         visible = false;
      }
   }
}

