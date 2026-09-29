package net.battleMechsMulti.screens.languages
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.buttons.BMLanguageButton;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.FeatureFlags;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1777")]
   public class BMScreenLanguageSelection extends BMBaseScreen
   {
      
      private static const NUM_OF_BUTTONS:uint = 14;
      
      public var mcButtonMarker:Sprite;
      
      public var mcButtonSizer:Sprite;
      
      public var btnLang1:BMLanguageButton;
      
      public var btnLang2:BMLanguageButton;
      
      public var btnLang3:BMLanguageButton;
      
      public var btnLang4:BMLanguageButton;
      
      public var btnLang5:BMLanguageButton;
      
      public var btnLang6:BMLanguageButton;
      
      public var btnLang7:BMLanguageButton;
      
      public var btnLang8:BMLanguageButton;
      
      public var btnLang9:BMLanguageButton;
      
      public var btnLang10:BMLanguageButton;
      
      public var btnLang11:BMLanguageButton;
      
      public var btnLang12:BMLanguageButton;
      
      public var btnLang13:BMLanguageButton;
      
      public var btnLang14:BMLanguageButton;
      
      public var mcBackground:Sprite;
      
      private var _returnFunction:Function;
      
      private var _allLanguages:Array;
      
      public function BMScreenLanguageSelection()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen(param1:Function = null) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:BMLanguageButton = null;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:Sprite = null;
         this._returnFunction = param1;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(BMLanguageManager.ALL_LANGUAGES);
         _loc2_.position = 0;
         this._allLanguages = _loc2_.readObject();
         _loc2_.clear();
         if(FeatureFlags.ENABLE_TT_LANGUAGE || dataM.clientRunningLocally)
         {
         }
         _loc3_ = 1;
         while(_loc3_ <= this._allLanguages.length)
         {
            _loc4_ = this["btnLang" + _loc3_];
            _loc6_ = uint(this._allLanguages[_loc3_ - 1]);
            _loc7_ = languageM.getFlagIconNameByLanguageID(_loc6_);
            _loc8_ = dataM.getLocalGraphicIcon(_loc7_);
            _loc4_.addFlagImage(_loc8_);
            _loc4_.addEventListener(BMIntractable.HIT,this.languageButtonClicked);
            _loc4_.languageID = _loc6_;
            _loc3_++;
         }
         _loc3_ = this.getCurrentLanguageButtonNumber();
         _loc4_ = this["btnLang" + _loc3_];
         this.mcButtonMarker.x = _loc4_.x;
         this.mcButtonMarker.y = _loc4_.y;
         if(NUM_OF_BUTTONS > this._allLanguages.length)
         {
            _loc3_ = this._allLanguages.length + 1;
            while(_loc3_ <= NUM_OF_BUTTONS)
            {
               _loc4_ = this["btnLang" + _loc3_];
               _loc4_.visible = false;
               _loc3_++;
            }
         }
         var _loc5_:uint = 10;
         this.mcBackground.width = _loc5_ * 2 + this.btnLang1.width * 2 + this.btnLang2.x - (this.btnLang1.x + this.btnLang1.width);
         _loc4_ = this["btnLang" + this._allLanguages.length];
         this.mcBackground.height = _loc4_.y + _loc4_.height + _loc5_;
      }
      
      private function getCurrentLanguageButtonNumber() : uint
      {
         return this._allLanguages.indexOf(dataM.languageID) + 1;
      }
      
      private function languageButtonClicked(param1:Event) : void
      {
         var _loc2_:BMLanguageButton = param1["target"];
         var _loc3_:uint = _loc2_.languageID;
         this.languageClicked(_loc3_);
      }
      
      public function languageClicked(param1:uint) : void
      {
         languageM.offerUserToSwitchToDetectedLanguage = false;
         dataM.setLanguageID(param1);
         if(this._returnFunction != null)
         {
            this._returnFunction();
         }
         screensM.removeScreen(BMScreensManager.SCR_LANGUAGE_SELECTION);
      }
   }
}

