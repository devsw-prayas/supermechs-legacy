package net.battleMechsMulti.screens.battleCredits
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol838")]
   public class BMBattleCreditsBar extends BMBaseClass
   {
      
      public var txtAmount:TextField;
      
      public var mcPlusSizer:Sprite;
      
      private var plusBtn:BMButton_plus2;
      
      public function BMBattleCreditsBar()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         generateSingletonClassesPointers("");
         this.plusBtn = new BMButton_plus2();
         this.plusBtn.x = this.mcPlusSizer.x;
         this.plusBtn.y = this.mcPlusSizer.y;
         this.plusBtn.width = this.mcPlusSizer.width;
         this.plusBtn.height = this.mcPlusSizer.height;
         addChild(this.plusBtn);
         this.plusBtn.initialize("","",null,[],this.onGetBattleCreditsClicked,false);
         dataM.battleCreditsManager.addBattleCreditsChangeCallback(this.battleCreditsChanged);
         this.refresh();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function refresh() : void
      {
         this.txtAmount.text = TextUtils.getNumberWithComma(dataM.myProfile.battleCredits) + " / " + TextUtils.getNumberWithComma(dataM.battleCreditsManager.battleCreditsMax);
      }
      
      private function onGetBattleCreditsClicked() : void
      {
         if(dataM.myProfile.battleCredits < dataM.battleCreditsManager.battleCreditsMax)
         {
            screensM.addScreen("screenFillBattleCredits");
            screensM.screenFillBattleCredits.setPosition(BMScreenFillBattleCredits.POSITION_CENTER_SCREEN);
         }
         else
         {
            screensM.addScreen("screenBattleCreditsFull");
         }
      }
      
      private function battleCreditsChanged(param1:uint) : void
      {
         this.txtAmount.text = TextUtils.getNumberWithComma(dataM.myProfile.battleCredits) + "/" + TextUtils.getNumberWithComma(dataM.battleCreditsManager.battleCreditsMax);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         dataM.battleCreditsManager.removeBattleCreditsChangeCallback(this.battleCreditsChanged);
      }
   }
}

