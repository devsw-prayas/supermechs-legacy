package net.battleMechsMulti.screens.clan
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.missionDifficulty.MissionReward;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMScreenClanBossClaimReward extends BMBaseScreen
   {
      
      public var txtTitle:TextField;
      
      public var mcClanCoins:MissionReward;
      
      public var mcGold:MissionReward;
      
      public var btnClaim:BMBasicButton;
      
      public var mcRays:Sprite;
      
      public var mcClanWarBoxes:MovieClip;
      
      public var mcBackground:MovieClip;
      
      private var _callback:Function;
      
      public function BMScreenClanBossClaimReward()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         this.btnClaim.addEventListener(BMIntractable.HIT,this.onClaimClicked);
         this.btnClaim.text = getSpecificText("raid_claimReward");
         TweenMax.to(this.mcRays,15,{
            "rotation":360,
            "ease":Linear.easeNone,
            "repeat":-1
         });
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function showReward(param1:String, param2:uint, param3:uint, param4:uint, param5:Function) : void
      {
         updateTextAndFormat(this.txtTitle,param1);
         if(param4 > 0)
         {
            this.mcClanCoins.x += 55;
            this.mcGold.x += 55;
            this.mcBackground.gotoAndStop("withBox");
            this.mcClanWarBoxes.gotoAndStop("box" + param4);
         }
         else
         {
            this.mcClanWarBoxes.visible = false;
         }
         this.mcClanCoins.text = String(param2);
         this.mcClanCoins.setIcon(new localIcon_clanCoinsCentered());
         this.mcClanCoins.pushRightAccordingToContent();
         if(param3 == 0)
         {
            this.mcGold.visible = false;
         }
         else
         {
            this.mcGold.text = TextUtils.getNumberWithComma(param3);
            this.mcGold.setIcon(new localIcon_gold());
            this.mcGold.pushRightAccordingToContent();
            this.mcClanCoins.y -= 18;
         }
         this._callback = param5;
      }
      
      private function onClaimClicked(param1:Event) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CLAN_BOSS_CLAIM_REWARD);
         this._callback();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         TweenMax.killTweensOf(this.mcRays);
      }
   }
}

