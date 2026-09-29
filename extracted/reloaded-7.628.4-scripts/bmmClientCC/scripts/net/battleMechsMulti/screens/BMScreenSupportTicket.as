package net.battleMechsMulti.screens
{
   import com.distriqt.extension.application.Application;
   import com.distriqt.extension.application.Device;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.globalization.DateTimeFormatter;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.text.TextField;
   import mx.utils.Base64Encoder;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.session.BMPlatformUtils;
   import net.battleMechsMulti.session.LoginServices;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol477")]
   public class BMScreenSupportTicket extends BMBaseScreen
   {
      
      public var mcButtonsHolder:MovieClip;
      
      public var mcSizer_btnBack:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtName:TextField;
      
      public var txtInputName:TextField;
      
      public var txtEmail:TextField;
      
      public var txtInputEmail:TextField;
      
      public var txtComment:TextField;
      
      public var txtInputComment:TextField;
      
      public var btnSend:BMBasicButton;
      
      public var btnBack:BMButton_pictureE;
      
      private var _subject:String;
      
      public function BMScreenSupportTicket()
      {
         super();
         this.__setTab_txtInputEmail_BMScreenSupportTicket_input_0();
         this.__setTab_txtInputComment_BMScreenSupportTicket_input_0();
         this.__setTab_txtInputName_BMScreenSupportTicket_input_0();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("supportTicket");
         this.initButtons();
         this.initTexts();
         this.txtInputName.text = this.getUserName();
         this.txtInputEmail.text = dataM.userEmail;
         if(screensM.isScreenOpened(BMScreensManager.SCR_LOST_CONNECTION))
         {
            screensM.screenLostConnection.visible = false;
         }
      }
      
      private function getUserName() : String
      {
         if(dataM.isGeneratedUser())
         {
            return getScreenText("guest");
         }
         if(dataM.perUserSharedObject.data.lastLoginUsername != null)
         {
            return dataM.perUserSharedObject.data.lastLoginUsername;
         }
         if(dataM.isConnectedToService(LoginServices.SUPERMECHS))
         {
            return dataM.sessionManager.userData.username;
         }
         if(dataM.hasPlayerProfile)
         {
            return dataM.myProfile.playerName;
         }
         return getScreenText("guest");
      }
      
      private function initTexts() : void
      {
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         updateTextAndFormat(this.txtName,getScreenText("name"));
         updateTextAndFormat(this.txtEmail,getScreenText("email"));
         updateTextAndFormat(this.txtComment,getScreenText("comment"));
         ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtName,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtEmail,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtComment,this);
      }
      
      private function initButtons() : void
      {
         screensM.createButtonFromSizer(BMScreensManager.SCR_SUPPORT_TICKET,"btnBack","pictureE");
         this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,this.backClicked,false);
         this.btnSend.text = getScreenText("submit");
         this.btnSend.addEventListener(BMIntractable.HIT,this.onSendClick);
      }
      
      public function setSubject(param1:String) : *
      {
         this._subject = param1;
      }
      
      private function onSendClick(param1:Event) : void
      {
         if(!this.isValidEmail(this.txtInputEmail.text))
         {
            this.txtEmail.textColor = 16724736;
            ImageUtils.swapTextFieldWithBitMap(this.txtEmail,this);
            return;
         }
         var _loc2_:String = this.txtInputComment.text + "\n\n\n\n\n\n\n\n" + this.getBodyAddedData();
         this.sendSupportTicket(this.txtInputName.text,this.txtInputEmail.text,this._subject,_loc2_);
      }
      
      private function getBodyAddedData() : String
      {
         var encoder:Base64Encoder;
         var days:int = 0;
         var statusValue:int = 0;
         var dtf:DateTimeFormatter = null;
         var date:Date = null;
         var deviceData:String = "";
         var getDeviceDetails:Function = function():String
         {
            var _loc1_:Device = Application.service.device;
            return JSON.stringify({
               "device":_loc1_.device,
               "brand":_loc1_.brand,
               "model":_loc1_.model,
               "product":_loc1_.product,
               "yearClass":_loc1_.yearClass,
               "manufacturer":_loc1_.manufacturer,
               "name":_loc1_.name
            });
         };
         deviceData = getDeviceDetails();
         var body:String = "[ Data for support - do not modify ]\n";
         body += "User ID:" + dataM.userID + "\n";
         body += "Username:" + dataM.userName + "\n";
         body += "Platform:" + BMPlatformUtils.sourcePlatform + " \n";
         body += "Device Data:" + deviceData + " \n";
         body += "Version:" + externalAssetsM.getVersionNumber() + " \n";
         body += "Accounts:" + dataM.getConnectedServices().join(",") + " \n";
         if(dataM.hasPlayerProfile)
         {
            body += "User Since:" + dataM.myProfile.dRegistration + "+\n";
            days = 0;
            if(dataM.myProfile.firstSessionDate > 0)
            {
               days = int((dataM.currentTime - dataM.myProfile.firstSessionDate) / 86400);
            }
            body += "Days:" + days + "+\n";
            body += "Rank:" + dataM.getLadderRankByProgress(dataM.myProfile.ladderProgress) + "\n";
            body += "Level:" + dataM.myProfile.level + " \n";
            body += "Clan Name:" + dataM.myProfile.clanName + " \n";
            body += "Clan Leader:" + dataM.myProfile.isClanLeader + " \n";
            if(dataM.myProfile.timeToFirstPayment > 0)
            {
               dtf = new DateTimeFormatter("en-US");
               dtf.setDateTimePattern("dd-MM-yyyy \'at\' hh:mm:ssa");
               date = new Date();
               date.setTime(dataM.myProfile.timeToFirstPayment * 1000);
               body += "Flag:" + dtf.format(date) + " \n";
            }
            else
            {
               body += "Flag:0 \n";
            }
            statusValue = 0;
            if(dataM.estimatedDollarsSpent() > 0)
            {
               statusValue = 1;
            }
            if(dataM.estimatedDollarsSpent() > 100)
            {
               statusValue = 2;
            }
            if(dataM.estimatedDollarsSpent() > 1000)
            {
               statusValue = 3;
            }
            body += "Status:" + statusValue + " \n";
         }
         encoder = new Base64Encoder();
         encoder.encodeUTFBytes(TsLogger.getLog());
         body += encoder.toString();
         return body;
      }
      
      private function isValidEmail(param1:String) : Boolean
      {
         var _loc2_:RegExp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/i;
         return _loc2_.test(param1);
      }
      
      private function sendSupportTicket(param1:String, param2:String, param3:String, param4:String) : *
      {
         var _loc5_:Object = {"ticket":{
            "requester":{
               "name":param1,
               "email":param2
            },
            "subject":param3,
            "comment":{"body":param4}
         }};
         var _loc6_:URLRequest = new URLRequest("http://supermechs.com/api/zendesk_proxy.php");
         _loc6_.method = URLRequestMethod.POST;
         _loc6_.data = JSON.stringify(_loc5_);
         var _loc7_:URLLoader = new URLLoader();
         _loc7_.addEventListener(Event.COMPLETE,this.onSupportSent);
         _loc7_.addEventListener(IOErrorEvent.IO_ERROR,this.onIoError);
         _loc7_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         _loc7_.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.httpStatusHandler);
         _loc7_.load(_loc6_);
         screensM.screenConfirmation.displayCustomLoading(getScreenText("sendingMessage"));
      }
      
      private function httpStatusHandler(param1:HTTPStatusEvent) : void
      {
         TsLogger.log("BMScreenSupportTicket:httpStatusHandler: " + param1);
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         TsLogger.log("BMScreenSupportTicket:onSecurityError " + param1.text);
         this.handleErrorSendingTicket();
      }
      
      private function onIoError(param1:IOErrorEvent) : void
      {
         TsLogger.log("BMScreenSupportTicket:onIoError " + param1.text);
         this.handleErrorSendingTicket();
      }
      
      private function handleErrorSendingTicket() : *
      {
         screensM.screenConfirmation.displayCustomMessage("Could not send the support request.\nPlease try again later");
      }
      
      private function onSupportSent(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         trace("BMScreenSupportTicket:onSupportSent");
         this.backClicked();
         screensM.screenConfirmation.displayCustomMessage(getScreenText("messageSent"));
      }
      
      public function backClicked() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_LOST_CONNECTION))
         {
            screensM.screenLostConnection.visible = true;
         }
         screensM.removeScreen(BMScreensManager.SCR_SUPPORT_TICKET);
      }
      
      internal function __setTab_txtInputEmail_BMScreenSupportTicket_input_0() : *
      {
         this.txtInputEmail.tabIndex = 2;
      }
      
      internal function __setTab_txtInputComment_BMScreenSupportTicket_input_0() : *
      {
         this.txtInputComment.tabIndex = 3;
      }
      
      internal function __setTab_txtInputName_BMScreenSupportTicket_input_0() : *
      {
         this.txtInputName.tabIndex = 1;
      }
   }
}

