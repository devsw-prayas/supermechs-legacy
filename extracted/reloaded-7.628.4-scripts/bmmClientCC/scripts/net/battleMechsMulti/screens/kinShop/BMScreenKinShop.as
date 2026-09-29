package net.battleMechsMulti.screens.kinShop
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMScreenKinShop extends BMBaseScreen
   {
      
      public var btnClose:BMBasicButton;
      
      public var txtMyKin:TextField;
      
      public var txtStoreTitle:TextField;
      
      public var txtInfoTitle:TextField;
      
      public var mcTimer:BMTimer;
      
      public var mcTabs:MovieClip;
      
      public var mcHitAreaShop:Sprite;
      
      public var mcHitAreaInfo:Sprite;
      
      public var mcInfo:MovieClip;
      
      private var _currentTab:String;
      
      public var TAB_SHOP:String = "shop";
      
      public var TAB_INFO:String = "info";
      
      public function BMScreenKinShop()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("kin");
         updateTextAndFormat(this.txtStoreTitle,getScreenText("storeTitle"));
         updateTextAndFormat(this.txtInfoTitle,getScreenText("infoTitle"));
         this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
         this.mcTimer.initialize(dataM.questsManager.getDailyQuestsSecLeft,this.onTimeEnd);
         this.mcInfo.btnBackupWallet.addEventListener(BMIntractable.HIT,this.backupWalletClicked);
         this.mcInfo.btnRestoreWallet.addEventListener(BMIntractable.HIT,this.restoreWalletClicked);
         this.mcInfo.btnBackupWallet.text = getScreenText("backupWallet");
         this.mcInfo.btnRestoreWallet.text = getScreenText("restoreWallet");
         this.mcInfo.btnBackupWallet.visible = dataM.kinM.isBackupAndRestoreSupported;
         this.mcInfo.btnRestoreWallet.visible = dataM.kinM.isBackupAndRestoreSupported;
         this.mcInfo.mcHitArea.addEventListener(MouseEvent.CLICK,this.moreInfoClicked);
         this.mcHitAreaShop.addEventListener(MouseEvent.CLICK,this.shopClicked);
         this.mcHitAreaInfo.addEventListener(MouseEvent.CLICK,this.infoClicked);
         updateTextAndFormat(this.mcInfo.txtWhatIsKin,getScreenText("whatIsKin"));
         var _loc1_:String = getScreenText("kinDesc");
         var _loc2_:String = getScreenText("moreInfo");
         _loc2_ = dataM.replaceStringInText(_loc2_,"%CLICKHERE%","<FONT COLOR=\'#00CCFF\'>" + getScreenText("clickHere") + "</FONT>");
         _loc1_ = _loc1_ + "<BR>" + _loc2_;
         updateTextAndFormat(this.mcInfo.txtKinDesc,_loc1_);
         updateTextAndFormat(this.mcInfo.txtHowToEarn,getScreenText("howToEarn"));
         updateTextAndFormat(this.mcInfo.txtEarnDesc,getScreenText("earnDesc"));
         updateTextAndFormat(this.mcInfo.txtKin,getScreenText("kin"));
         sub(BMPubSub.MESSAGE_KIN_ACCOUNT_BALANCE_UPDATED,this.handleKinAccountBalanceUpdated);
      }
      
      private function onTimeEnd() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         TweenMax.delayedCall(2,this.restartTimer);
      }
      
      private function restartTimer() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(this._currentTab == this.TAB_SHOP)
         {
            BMShopManager.gi().showClanShop("",true);
         }
         this.mcTimer.visible = false;
      }
      
      public function refreshScreen(param1:String) : void
      {
         this.changeToTab(param1);
         this.refreshKin();
      }
      
      public function refreshKin() : void
      {
         this.mcInfo.txtMyKin.text = TextUtils.getNumberWithComma(dataM.kinM.kin);
         this.txtMyKin.text = TextUtils.getNumberWithComma(dataM.kinM.kin);
      }
      
      private function backupWalletClicked(param1:Event) : void
      {
         dataM.kinM.backupAccount();
      }
      
      private function restoreWalletClicked(param1:Event) : void
      {
         dataM.kinM.restoreAccount();
      }
      
      private function moreInfoClicked(param1:MouseEvent) : void
      {
         dataM.openURL("https://help.kik.com/hc/en-us/articles/360013193493-What-is-Kin-","_blank");
      }
      
      private function shopClicked(param1:MouseEvent) : void
      {
         this.changeToTab(this.TAB_SHOP);
      }
      
      private function infoClicked(param1:MouseEvent) : void
      {
         this.changeToTab(this.TAB_INFO);
      }
      
      private function changeToTab(param1:String) : void
      {
         if(this._currentTab == param1)
         {
            return;
         }
         this._currentTab = param1;
         if(this._currentTab == this.TAB_SHOP)
         {
            this.mcTabs.gotoAndStop(1);
            this.mcTimer.visible = true;
            this.mcInfo.visible = false;
            BMShopManager.gi().showClanShop("",true);
         }
         else
         {
            this.mcTabs.gotoAndStop(2);
            this.mcTimer.visible = false;
            this.mcInfo.visible = true;
            BMShopManager.gi().close();
         }
      }
      
      private function closeClicked(param1:Event) : void
      {
         this.removeMe();
      }
      
      private function handleKinAccountBalanceUpdated(param1:String, param2:Object) : void
      {
         this.refreshKin();
      }
      
      public function removeMe() : void
      {
         this.mcHitAreaShop.removeEventListener(MouseEvent.CLICK,this.shopClicked);
         this.mcHitAreaInfo.removeEventListener(MouseEvent.CLICK,this.infoClicked);
         this.mcInfo.mcHitArea.removeEventListener(MouseEvent.CLICK,this.moreInfoClicked);
         screensM.removeScreen(BMScreensManager.SCR_KIN_SHOP);
         BMShopManager.gi().close();
      }
   }
}

