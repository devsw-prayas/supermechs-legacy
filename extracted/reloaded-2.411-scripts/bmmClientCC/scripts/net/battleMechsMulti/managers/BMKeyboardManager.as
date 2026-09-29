package net.battleMechsMulti.managers
{
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   
   public class BMKeyboardManager extends MovieClip
   {
      
      private static var _instance:BMKeyboardManager;
      
      private static var _allowInstantiation:Boolean;
      
      private var _stagePointer:*;
      
      private var _outputFunction:Function;
      
      private var _keyLeft:Boolean;
      
      private var _keyRight:Boolean;
      
      private var _keyUp:Boolean;
      
      private var _keyDown:Boolean;
      
      private var _keyEnter:Boolean;
      
      private var _key1:Boolean;
      
      private var _key2:Boolean;
      
      private var _key3:Boolean;
      
      private var _key4:Boolean;
      
      private var _key5:Boolean;
      
      private var _key6:Boolean;
      
      private var _key7:Boolean;
      
      private var _key8:Boolean;
      
      private var _key9:Boolean;
      
      private var _key10:Boolean;
      
      private var __up:Number;
      
      private var __down:Number;
      
      private var __left:Number;
      
      private var __right:Number;
      
      private var __enter:Number;
      
      private var __key1A:Number;
      
      private var __key1B:Number;
      
      private var __key2A:Number;
      
      private var __key2B:Number;
      
      private var __key3A:Number;
      
      private var __key3B:Number;
      
      private var __key4A:Number;
      
      private var __key4B:Number;
      
      private var __key5A:Number;
      
      private var __key5B:Number;
      
      private var __key6A:Number;
      
      private var __key6B:Number;
      
      private var __key7A:Number;
      
      private var __key7B:Number;
      
      private var __key8A:Number;
      
      private var __key8B:Number;
      
      private var __key9A:Number;
      
      private var __key9B:Number;
      
      private var __key10A:Number;
      
      private var __key10B:Number;
      
      private var _last9Chars:String;
      
      private var _keyboardData:Object;
      
      private var _activator:String;
      
      public function BMKeyboardManager()
      {
         super();
         if(!_allowInstantiation)
         {
            throw new Error("Error: Instantiation failed: Use BMKeyboardManager.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : BMKeyboardManager
      {
         if(_instance == null)
         {
            _allowInstantiation = true;
            _instance = new BMKeyboardManager();
            _allowInstantiation = false;
         }
         return _instance;
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMKeyboardManager initialized");
         this._activator = "";
         this.setControls();
         this.resetControlParameters();
      }
      
      public function setStagePointer(param1:Stage) : void
      {
         this._stagePointer = param1;
      }
      
      public function setKeyboardOutputFunction(param1:Function, param2:String) : void
      {
         this._outputFunction = param1;
      }
      
      public function removeKeyboardOutputFunction(param1:String) : void
      {
         this._outputFunction = null;
      }
      
      public function activateMe(param1:String) : void
      {
         this.resetControlParameters();
         if(this._activator != param1)
         {
            this._activator = param1;
            this._stagePointer.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDown);
            this._stagePointer.addEventListener(KeyboardEvent.KEY_UP,this.keyUp);
         }
      }
      
      public function deactivateMe() : void
      {
         this._stagePointer.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDown);
         this._stagePointer.removeEventListener(KeyboardEvent.KEY_UP,this.keyUp);
         this._activator = "";
      }
      
      private function setControls() : void
      {
         this.__up = 38;
         this.__down = 40;
         this.__left = 37;
         this.__right = 39;
         this.__enter = 13;
         this.__key1A = 49;
         this.__key1B = 97;
         this.__key2A = 50;
         this.__key2B = 98;
         this.__key3A = 51;
         this.__key3B = 99;
         this.__key4A = 52;
         this.__key4B = 100;
         this.__key5A = 53;
         this.__key5B = 101;
         this.__key6A = 54;
         this.__key6B = 102;
         this.__key7A = 55;
         this.__key7B = 103;
         this.__key8A = 56;
         this.__key8B = 104;
         this.__key9A = 57;
         this.__key9B = 105;
         this.__key10A = 48;
         this.__key10B = 96;
      }
      
      private function resetControlParameters() : void
      {
         this._keyLeft = false;
         this._keyRight = false;
         this._keyUp = false;
         this._keyDown = false;
         this._keyEnter = false;
         this._key1 = false;
         this._key2 = false;
         this._key3 = false;
         this._key4 = false;
         this._key5 = false;
         this._key6 = false;
         this._key7 = false;
         this._key8 = false;
         this._key9 = false;
         this._key10 = false;
         this._keyboardData = new Object();
         this._keyboardData.xAxis = "none";
         this._keyboardData.yAxis = "none";
         this._keyboardData.enter = false;
         this._keyboardData.debuggerActivated = false;
      }
      
      private function keyDown(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case this.__left:
               this._keyLeft = true;
               break;
            case this.__right:
               this._keyRight = true;
               break;
            case this.__up:
               this._keyUp = true;
               break;
            case this.__down:
               this._keyDown = true;
               break;
            case this.__enter:
               this._keyEnter = true;
               break;
            case this.__key1A:
            case this.__key1B:
               this._key1 = true;
               break;
            case this.__key2A:
            case this.__key2B:
               this._key2 = true;
               break;
            case this.__key3A:
            case this.__key3B:
               this._key3 = true;
               break;
            case this.__key4A:
            case this.__key4B:
               this._key4 = true;
               break;
            case this.__key5A:
            case this.__key5B:
               this._key5 = true;
               break;
            case this.__key6A:
            case this.__key6B:
               this._key6 = true;
               break;
            case this.__key7A:
            case this.__key7B:
               this._key7 = true;
               break;
            case this.__key8A:
            case this.__key8B:
               this._key8 = true;
               break;
            case this.__key9A:
            case this.__key9B:
               this._key9 = true;
               break;
            case this.__key10A:
            case this.__key10B:
               this._key10 = true;
         }
         this._last9Chars += String.fromCharCode(param1.charCode);
         if(this._last9Chars.length > 9)
         {
            this._last9Chars = this._last9Chars.substr(this._last9Chars.length - 9,9);
         }
         this._keyboardData.debuggerActivated = false;
         if(this._last9Chars == "liran1234")
         {
            this._keyboardData.debuggerActivated = true;
         }
         this.activateKeyboard();
      }
      
      private function keyUp(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case this.__left:
               this._keyLeft = false;
               break;
            case this.__right:
               this._keyRight = false;
               break;
            case this.__up:
               this._keyUp = false;
               break;
            case this.__down:
               this._keyDown = false;
               break;
            case this.__enter:
               this._keyEnter = false;
               break;
            case this.__key1A:
            case this.__key1B:
               this._key1 = false;
               break;
            case this.__key2A:
            case this.__key2B:
               this._key2 = false;
               break;
            case this.__key3A:
            case this.__key3B:
               this._key3 = false;
               break;
            case this.__key4A:
            case this.__key4B:
               this._key4 = false;
               break;
            case this.__key5A:
            case this.__key5B:
               this._key5 = false;
               break;
            case this.__key6A:
            case this.__key6B:
               this._key6 = false;
               break;
            case this.__key7A:
            case this.__key7B:
               this._key7 = false;
               break;
            case this.__key8A:
            case this.__key8B:
               this._key8 = false;
               break;
            case this.__key9A:
            case this.__key9B:
               this._key9 = false;
               break;
            case this.__key10A:
            case this.__key10B:
               this._key10 = false;
         }
         this.activateKeyboard();
      }
      
      private function activateKeyboard() : void
      {
         this._keyboardData.xAxis = "none";
         if(this._keyLeft)
         {
            this._keyboardData.xAxis = "left";
         }
         else if(this._keyRight)
         {
            this._keyboardData.xAxis = "right";
         }
         this._keyboardData.yAxis = "none";
         if(this._keyUp)
         {
            this._keyboardData.yAxis = "up";
         }
         else if(this._keyDown)
         {
            this._keyboardData.yAxis = "down";
         }
         this._keyboardData.enter = false;
         if(this._keyEnter)
         {
            this._keyboardData.enter = true;
         }
         this._keyboardData.numberKey = -1;
         var _loc1_:uint = 1;
         while(_loc1_ <= 10)
         {
            if(this["_key" + _loc1_])
            {
               this._keyboardData.numberKey = _loc1_;
               _loc1_ = 10;
            }
            _loc1_++;
         }
         if(this._outputFunction != null)
         {
            this._outputFunction(this._keyboardData);
         }
      }
   }
}

