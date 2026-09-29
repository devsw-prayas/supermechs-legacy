package net.battleMechsMulti.screens.multiplayerLadder
{
   import flash.events.Event;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.popups.BMScreenYesNoPopup;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2202")]
   public class BMScreen1V1To2V2TransitionWarning extends BMScreenYesNoPopup
   {
      
      public var btnClose:BMBasicButton;
      
      public function BMScreen1V1To2V2TransitionWarning()
      {
         super();
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         var _loc2_:BMScreensManager = BMScreensManager.getInstance();
         var _loc3_:BMLanguageManager = BMLanguageManager.getInstance();
         var _loc4_:uint = uint(_loc1_.get1v1to2v2TransitionRank());
         var _loc5_:String = _loc3_.getText("multiplayerLadder_transitionWarning");
         _loc5_ = _loc1_.replaceStringInText(_loc5_,"%RANK%",String(_loc4_));
         var _loc6_:String = _loc3_.getText("multiplayerLadder_noPrizes");
         var _loc7_:String = _loc3_.getText("multiplayerLadder_buildSecondMech");
         var _loc8_:String = _loc3_.getText("mainMenu_workshop");
         var _loc9_:String = _loc3_.getText("multiplayerLadder_play1V1");
         var _loc10_:Function = _loc2_.screenMultiPlayerLadder.transitionWarningGoToHanger;
         var _loc11_:Function = _loc2_.screenMultiPlayerLadder.transitionWarningPlay1V1;
         if(this.canPlay1v1WithoutReward == false)
         {
            _loc6_ = "";
            _loc9_ = "";
            _loc11_ = null;
            btnNo.visible = false;
            btnYes.x = (btnYes.x + btnNo.x) / 2;
            txtDesc2.x = (txtDesc1.x + txtDesc2.x) / 2;
         }
         displayYesNoPopup(_loc5_,_loc6_,_loc7_,_loc10_,_loc11_,_loc8_,_loc9_);
         this.btnClose.addEventListener(BMIntractable.HIT,this.onCloseClicked);
      }
      
      private function get canPlay1v1WithoutReward() : Boolean
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         var _loc2_:uint = uint(_loc1_.get1v1to2v2TransitionRank());
         var _loc3_:uint = _loc1_.getLadderRankByProgress(_loc1_.myProfile.ladderProgress);
         return _loc2_ == _loc3_;
      }
      
      private function onCloseClicked(param1:Event) : void
      {
         var _loc2_:BMScreensManager = BMScreensManager.getInstance();
         _loc2_.removeScreen(BMScreensManager.SCR_1V1_TO_2V2_TRANSITION_WARNING);
      }
   }
}

