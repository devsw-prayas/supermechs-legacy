package net.battleMechsMulti.screens.webView
{
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.media.StageWebView;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol369")]
   public class BMScreenWebView extends BMBaseScreen
   {
      
      public var btnClose:BMBasicButton;
      
      private var _stageWebView:StageWebView;
      
      public function BMScreenWebView()
      {
         super();
      }
      
      public static function isSupported() : Boolean
      {
         return true;
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         this.btnClose.addEventListener(BMIntractable.HIT,this.onCloseClick);
      }
      
      public function show(param1:String) : *
      {
         this.displayWebView(param1);
      }
      
      private function onCloseClick(param1:Event) : void
      {
         this.backClicked();
      }
      
      private function displayWebView(param1:String) : *
      {
         this.removeWebView();
         this._stageWebView = new StageWebView();
         this._stageWebView.stage = this.stage;
         this._stageWebView.viewPort = new Rectangle(9,72,783,stage.stageHeight - 72);
         this._stageWebView.loadURL(param1);
      }
      
      private function removeWebView() : *
      {
         if(this._stageWebView != null)
         {
            this._stageWebView.dispose();
            this._stageWebView = null;
         }
      }
      
      public function backClicked() : void
      {
         this.removeWebView();
         screensM.removeScreen("screenWebView");
      }
   }
}

