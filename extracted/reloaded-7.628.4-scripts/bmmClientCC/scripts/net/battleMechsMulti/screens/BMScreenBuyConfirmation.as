package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2193")]
   public class BMScreenBuyConfirmation extends BMBaseScreen
   {
      
      public static var CURRENCY_TOKENS:uint = 1;
      
      public static var CURRENCY_GOLD:uint = 2;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcMechHolder:MovieClip;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnCancel:Sprite;
      
      public var mcSizer_btnBuy:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnBuy:BMButton;
      
      public var btnCancel:BMButton;
      
      public var mcTokens:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtCost:TextField;
      
      public var txtBuy:TextField;
      
      public var txtDescription:TextField;
      
      private var _currenyType:uint;
      
      private var _cost:uint;
      
      private var _buyFunction:Function;
      
      private var _cancelFunction:Function;
      
      private var _mechView:BMMechView;
      
      private var _timer:Timer;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenBuyConfirmation()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen(param1:uint, param2:uint, param3:String, param4:String, param5:String, param6:String, param7:Function, param8:Function = null, param9:BMMechView = null) : void
      {
         var _loc10_:Boolean = false;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer(BMScreensManager.SCR_BUY_CONFIRMATION,"btnBack","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BUY_CONFIRMATION,"btnCancel","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BUY_CONFIRMATION,"btnBuy","regular");
            _loc10_ = dataM.runAsMobile;
            _loc10_ = false;
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,this.backClicked,_loc10_);
            this.btnCancel.initialize(param6,"red",null,null,this.backClicked,_loc10_);
            this.btnBuy.initialize("","orange",null,null,this.buyClicked,_loc10_);
            this.txtBuy.mouseEnabled = false;
            this.txtCost.mouseEnabled = false;
            this.mcTokens.mouseEnabled = false;
            this.mcTokens.mouseChildren = false;
            addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
         }
         this._currenyType = param1;
         this._cost = param2;
         this._buyFunction = param7;
         this._cancelFunction = param8;
         this._mechView = param9;
         updateTextAndFormat(this.txtTitle,param3);
         updateTextAndFormat(this.txtDescription,param4);
         updateTextAndFormat(this.txtCost,TextUtils.getNumberWithComma(this._cost));
         updateTextAndFormat(this.txtBuy,param5);
         if(this._mechView != null)
         {
            this.mcMechHolder.addChild(this._mechView);
            this._mechView.y = -(this._mechView.mechSizer.height + this._mechView.mechSizer.y);
            this._timer = new Timer(33);
            this._timer.addEventListener(TimerEvent.TIMER,this.timerTrigger);
            this._timer.start();
         }
      }
      
      private function buyClicked() : void
      {
         if(this.getPlayerCurrency() < this._cost)
         {
            dataM.openBuyTokensPage(BMScreensManager.SCR_BUY_CONFIRMATION);
         }
         else
         {
            this._buyFunction();
            this.removeMe();
         }
      }
      
      private function backClicked() : void
      {
         if(this._cancelFunction != null)
         {
            this._cancelFunction();
         }
         this.removeMe();
      }
      
      private function timerTrigger(param1:TimerEvent) : void
      {
         if(this._mechView != null)
         {
            this._mechView.onEnterFrameTrigger();
            this.electricityEffectsHandler();
         }
      }
      
      private function electricityEffectsHandler() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc1_:Number = Math.ceil(Math.random() * 12);
         switch(_loc1_)
         {
            case 1:
            case 2:
               _loc2_ = 1;
               _loc3_ = 2;
               _loc4_ = 40;
               effectsM.createSparksMC(BMScreensManager.SCR_BUY_CONFIRMATION,"spark",this._mechView.x,this._mechView.y,_loc2_,_loc3_,_loc4_,"horizontal","blue",true);
               break;
            case 3:
               _loc5_ = Math.random() * 40 - 20 + this._mechView.x;
               _loc6_ = Math.random() * 40 - 20 + this._mechView.y;
               _loc7_ = "electricity" + Math.ceil(Math.random() * 3);
               effectsM.createElectricity(_loc7_,_loc5_,_loc6_,this.mcMechHolder);
         }
      }
      
      private function getPlayerCurrency() : uint
      {
         switch(this._currenyType)
         {
            case CURRENCY_GOLD:
               return dataM.myProfile.gold;
            case CURRENCY_TOKENS:
               return dataM.myProfile.tokens;
            default:
               return 0;
         }
      }
      
      private function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_BUY_CONFIRMATION);
      }
      
      private function removedFromStage(param1:Event) : void
      {
         if(this._timer != null)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.timerTrigger);
            this._timer = null;
         }
         if(this._mechView != null)
         {
            this._mechView.removeMe();
            this._mechView = null;
         }
      }
   }
}

