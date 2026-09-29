package net.battleMechsMulti.screens.raid
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMScreenRaidClaimReward extends BMBaseScreen
   {
      
      public var txtTitle:TextField;
      
      public var txtGroup:TextField;
      
      public var txtRank:TextField;
      
      public var btnClaim:BMBasicButton;
      
      public var mcRays:Sprite;
      
      public function BMScreenRaidClaimReward()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("raid");
         this.initRewards();
         this.initButtons();
         this.initAnimations();
         this.initTexts();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private function initTexts() : void
      {
         var _loc5_:uint = 0;
         updateTextAndFormat(this.txtTitle,getScreenText("raidFinished"));
         var _loc1_:String = "";
         var _loc2_:Array = [3,10,50,100,500,1000];
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc5_ = uint(_loc2_[_loc3_]);
            if(dataM.raidData.lastRaidRank <= _loc5_)
            {
               _loc1_ = getScreenText("top") + "<BR>" + TextUtils.getNumberWithComma(_loc5_);
               break;
            }
            _loc3_++;
         }
         if(_loc1_ == "")
         {
            _loc1_ = getScreenText("tierCaps") + "<BR>" + dataM.raidData.lastRaidLevel;
         }
         updateTextAndFormat(this.txtGroup,_loc1_);
         var _loc4_:String = getScreenText("yourRank");
         _loc4_ = dataM.replaceStringInText(_loc4_,"%RANK%",TextUtils.getNumberWithComma(dataM.raidData.lastRaidRank));
         updateTextAndFormat(this.txtRank,_loc4_);
      }
      
      private function initAnimations() : void
      {
         TweenMax.to(this.mcRays,16,{
            "rotation":360,
            "ease":Linear.ease,
            "repeat":-1
         });
      }
      
      private function initButtons() : void
      {
         this.btnClaim.addEventListener(BMIntractable.HIT,this.onClaimClicked);
         this.btnClaim.text = getScreenText("claimReward");
      }
      
      private function onClaimClicked(param1:Event) : void
      {
         dataM.giveRewardPopup(dataM.raidData.lastRaidReward);
         remoteM.socketM.raid_claimReward();
         dataM.raidData.rewardClaimed();
         screensM.removeScreen(BMScreensManager.SCR_RAID_CLAIM_REWARD);
      }
      
      private function initRewards() : void
      {
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         TweenMax.killTweensOf(this.mcRays);
      }
   }
}

