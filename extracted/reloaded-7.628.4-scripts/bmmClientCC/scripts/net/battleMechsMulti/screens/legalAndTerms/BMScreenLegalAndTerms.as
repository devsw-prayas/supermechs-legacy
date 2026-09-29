package net.battleMechsMulti.screens.legalAndTerms
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3011")]
   public class BMScreenLegalAndTerms extends BMBaseScreen
   {
      
      public var txtDesc1:TextField;
      
      public var txtDesc2:TextField;
      
      public var txtTitle:TextField;
      
      public var desc1MouseHitArea:Sprite;
      
      public var desc2MouseHitArea:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public function BMScreenLegalAndTerms()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("legalAndTerms");
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         screensM.createButtonFromSizer("screenLegalAndTerms","btnBack","pictureE");
         this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,this.backClicked,false);
         var _loc1_:String = getScreenText("tacticsoftTOS");
         var _loc2_:String = getScreenText("fontLisence");
         updateTextAndFormat(this.txtDesc1,_loc1_);
         updateTextAndFormat(this.txtDesc2,_loc2_);
         this.desc1MouseHitArea.buttonMode = true;
         this.desc1MouseHitArea.useHandCursor = true;
         this.desc2MouseHitArea.buttonMode = true;
         this.desc2MouseHitArea.useHandCursor = true;
         this.desc1MouseHitArea.addEventListener(MouseEvent.CLICK,this.desc1Click);
         this.desc2MouseHitArea.addEventListener(MouseEvent.CLICK,this.desc2Click);
      }
      
      private function desc1Click(param1:MouseEvent) : void
      {
         dataM.openURL("http://www.battledawn.com/index.php?p=tos","_blank");
      }
      
      private function desc2Click(param1:MouseEvent) : void
      {
         dataM.openURL("http://www.apache.org/licenses/LICENSE-2.0","_blank");
      }
      
      private function backClicked() : void
      {
         screensM.removeScreen("screenLegalAndTerms");
         this.desc1MouseHitArea.removeEventListener(MouseEvent.CLICK,this.desc1Click);
         this.desc2MouseHitArea.removeEventListener(MouseEvent.CLICK,this.desc2Click);
      }
   }
}

