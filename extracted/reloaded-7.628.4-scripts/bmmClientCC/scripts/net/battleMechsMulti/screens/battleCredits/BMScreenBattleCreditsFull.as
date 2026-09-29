package net.battleMechsMulti.screens.battleCredits
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3473")]
   public class BMScreenBattleCreditsFull extends BMBaseScreen
   {
      
      public var txtTitle:TextField;
      
      public var txtBattleCreditsFull:TextField;
      
      public var mcRays:Sprite;
      
      public var closeBtn:BMBasicButton;
      
      public function BMScreenBattleCreditsFull()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         TweenMax.to(this.mcRays,15,{
            "rotation":360,
            "ease":Linear.easeNone,
            "repeat":-1
         });
         this.closeBtn.addEventListener(BMIntractable.HIT,this.onCloseButtonHit);
         updateTextAndFormat(this.txtTitle,getSpecificText("fillBattleCredits_title_refillBattleCredits"));
         updateTextAndFormat(this.txtBattleCreditsFull,getSpecificText("fillBattleCredits_maxFuel"));
         ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtBattleCreditsFull,this);
      }
      
      private function onCloseButtonHit(param1:Event) : void
      {
         screensM.removeScreen("screenBattleCreditsFull");
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         TweenMax.killTweensOf(this.mcRays);
      }
   }
}

