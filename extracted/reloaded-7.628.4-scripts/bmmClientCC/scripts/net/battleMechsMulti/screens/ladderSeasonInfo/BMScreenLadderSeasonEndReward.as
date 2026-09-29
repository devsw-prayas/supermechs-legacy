package net.battleMechsMulti.screens.ladderSeasonInfo
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2716")]
   public class BMScreenLadderSeasonEndReward extends BMBaseScreen
   {
      
      public var txtTitle:TextField;
      
      public var txtDesc:TextField;
      
      public var mcBoxHolder:Sprite;
      
      public var mcBoxReflectionHolder:Sprite;
      
      public var btnClaim:BMBasicButton;
      
      private var _ladderSeasonEndRewards:Array;
      
      private var _gachaMachineIDs:Array;
      
      private var _rewardSlot:uint;
      
      private var mcBox:MovieClip;
      
      private var mcBoxReflection:MovieClip;
      
      public function BMScreenLadderSeasonEndReward()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("ladderSeasonRewards");
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         this.btnClaim.addEventListener(BMIntractable.HIT,this.claimClicked);
         this.btnClaim.text = getScreenText("claim");
      }
      
      public function showContent(param1:uint, param2:Array, param3:Array) : void
      {
         var _loc6_:BMRewardData = null;
         var _loc4_:String = getScreenText("desc");
         _loc4_ = dataM.replaceStringInText(_loc4_,"%RANK%",String(dataM.getLadderRankByProgress(param1)));
         updateTextAndFormat(this.txtDesc,_loc4_);
         this._ladderSeasonEndRewards = new Array();
         var _loc5_:uint = 0;
         while(_loc5_ < param2.length)
         {
            _loc6_ = new BMRewardData(param2[_loc5_]);
            this._ladderSeasonEndRewards.push(_loc6_);
            _loc5_++;
         }
         this._gachaMachineIDs = param3;
         this._rewardSlot = 0;
         this.displayGachaMachine();
      }
      
      private function displayGachaMachine() : void
      {
         this.removeBox();
         var _loc1_:uint = uint(this._gachaMachineIDs[this._rewardSlot]);
         var _loc2_:BMGachaMachineData = dataM.getGacheMachine(_loc1_);
         var _loc3_:Array = BMShopManager.gi().getBoxGrpForVisualID(_loc2_.imageID);
         this.mcBox = _loc3_[0];
         this.mcBoxReflection = _loc3_[1];
         this.mcBoxReflection.scaleY = -1;
         this.mcBoxReflectionHolder.addChild(this.mcBoxReflection);
         this.mcBoxHolder.addChild(this.mcBox);
         if(this._rewardSlot == 0)
         {
            this.addBoxAnimation();
         }
      }
      
      public function itemCardsScreenClosed() : void
      {
         this.addBoxAnimation();
      }
      
      private function addBoxAnimation() : void
      {
         TweenMax.fromTo(this.mcBox,0.3,{
            "scaleX":0.1,
            "scaleY":0.1
         },{
            "scaleX":0.8,
            "scaleY":0.8
         });
         TweenMax.fromTo(this.mcBoxReflection,0.3,{
            "scaleX":0.1,
            "scaleY":-0.1
         },{
            "scaleX":0.8,
            "scaleY":-0.8
         });
      }
      
      private function removeBox() : void
      {
         if(this.mcBox == null)
         {
            return;
         }
         TweenMax.killTweensOf(this.mcBox);
         TweenMax.killTweensOf(this.mcBoxReflection);
         this.mcBox.parent.removeChild(this.mcBox);
         this.mcBoxReflection.parent.removeChild(this.mcBoxReflection);
         this.mcBox = null;
         this.mcBoxReflection = null;
      }
      
      private function claimClicked(param1:Event) : void
      {
         var _loc2_:BMRewardData = new BMRewardData(this._ladderSeasonEndRewards[this._rewardSlot]);
         var _loc3_:uint = uint(this._gachaMachineIDs[this._rewardSlot]);
         ++this._rewardSlot;
         if(this._rewardSlot >= this._ladderSeasonEndRewards.length)
         {
            screensM.screenMultiPlayerLadder.ladderSeasonSubScreenClosed(name);
            this.removeMe();
         }
         else
         {
            this.displayGachaMachine();
         }
         dataM.handleGotRewardData(_loc2_,_loc3_);
      }
      
      public function removeMe() : void
      {
         this.removeBox();
         screensM.removeScreen(BMScreensManager.SCR_LADDER_SEASON_END_REWARD);
      }
   }
}

