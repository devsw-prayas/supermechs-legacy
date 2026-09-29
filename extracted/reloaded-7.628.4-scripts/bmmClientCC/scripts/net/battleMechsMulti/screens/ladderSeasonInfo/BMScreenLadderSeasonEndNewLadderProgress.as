package net.battleMechsMulti.screens.ladderSeasonInfo
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2720")]
   public class BMScreenLadderSeasonEndNewLadderProgress extends BMBaseScreen
   {
      
      public var txtTitle:TextField;
      
      public var txtStarsColected:TextField;
      
      public var txtRank:TextField;
      
      public var mcSizer_rank:Sprite;
      
      public var mcStarsBackground:MovieClip;
      
      public var btnContinue:BMBasicButton;
      
      public var mcRankStarsHolder:Sprite;
      
      public var mcRays:Sprite;
      
      public function BMScreenLadderSeasonEndNewLadderProgress()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("ladderSeasonNewLadderProgress");
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
         this.btnContinue.addEventListener(BMIntractable.HIT,this.continueClicked);
         this.btnContinue.text = getScreenText("continue");
      }
      
      public function showNewSeasonStartingLadderProgress(param1:uint) : void
      {
         var _loc2_:String = getScreenText("starsCollected");
         var _loc3_:uint = uint(dataM.totalStarsPerLadderProgressList[param1]);
         _loc2_ = dataM.replaceStringInText(_loc2_,"%STARS%",String(_loc3_));
         updateTextAndFormat(this.txtStarsColected,_loc2_);
         var _loc4_:BMLadderRankDisplayer = new BMLadderRankDisplayer();
         _loc4_.setLadderRank(param1,this.mcRankStarsHolder,this,this.mcSizer_rank,this.txtRank,this.mcStarsBackground);
         TweenMax.to(this.mcRays,16,{
            "rotation":360,
            "ease":Linear.ease,
            "repeat":-1
         });
      }
      
      private function continueClicked(param1:Event) : void
      {
         screensM.screenMultiPlayerLadder.ladderSeasonSubScreenClosed(name);
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_LADDER_SEASON_END_NEW_LADDER_PROGRESS);
      }
      
      private function removedFromStage(param1:Event) : void
      {
         TweenMax.killTweensOf(this.mcRays);
      }
   }
}

