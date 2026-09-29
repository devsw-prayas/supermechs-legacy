package net.battleMechsMulti.screens.beta
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3052")]
   public class BMScreenBetaOptIn extends BMBaseScreen
   {
      
      public var txtTitle:TextField;
      
      public var txtDesc:TextField;
      
      public var descMouseHitArea:Sprite;
      
      public var btnExit:BMBasicButton;
      
      public var btnContinue:BMBasicButton;
      
      public var txtPlaceHolder:MovieClip;
      
      public function BMScreenBetaOptIn()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         this.txtDesc.htmlText = "You have been chosen to participate in the Super Mechs closed beta as a New Player.<BR>If you prefer to return playing your regular account please <FONT COLOR=\'#00CCFF\'>press here</FONT> or the special button in the main screen at any time.";
         ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this.txtPlaceHolder);
         ImageUtils.swapTextFieldWithBitMap(this.txtDesc,this.txtPlaceHolder);
         this.descMouseHitArea.addEventListener(MouseEvent.CLICK,this.onDescClick);
         this.btnExit.addEventListener(BMIntractable.HIT,this.onExitClick);
         this.btnContinue.addEventListener(BMIntractable.HIT,this.onContinueClick);
      }
      
      private function onContinueClick(param1:Event) : void
      {
         remoteM.socketM.betaOptIn();
         screensM.removeScreen(BMScreensManager.SCR_BETA_OPT_IN);
      }
      
      private function onExitClick(param1:Event) : void
      {
         dataM.goToDownloadOldClintPage();
      }
      
      private function onDescClick(param1:MouseEvent) : void
      {
         dataM.goToDownloadOldClintPage();
      }
   }
}

