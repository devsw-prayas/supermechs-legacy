package net.battleMechsMulti.mobiles
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.battleMechsMulti.utils.TextOriginState;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMMovieClip extends MovieClip
   {
      
      private var _textsOriginState:Dictionary;
      
      public function BMMovieClip()
      {
         super();
         this._textsOriginState = new Dictionary(true);
      }
      
      protected function updateTextColor(param1:TextField, param2:uint) : *
      {
         if(this.getTextOriginState(param1) != null)
         {
            this.getTextOriginState(param1).textFormat.color = param2;
         }
      }
      
      protected function updateTextAndFormat(param1:TextField, param2:String, param3:Number = -1, param4:Boolean = false, param5:Boolean = false, param6:String = "") : void
      {
         if(param4)
         {
            this._textsOriginState[param1] = null;
         }
         if(FeatureFlags.ENABLE_XX_TEXT_ADDON && param2 != "")
         {
            param2 = "XX" + param2;
         }
         if(param2 == "")
         {
            param2 = " ";
         }
         var _loc7_:Boolean = param2.indexOf("<") >= 0 && param2.indexOf(">") >= 0;
         var _loc8_:Boolean = param5 || _loc7_;
         if(_loc8_)
         {
            param1.htmlText = param2;
         }
         else
         {
            param1.text = param2;
         }
         var _loc9_:TextOriginState = null;
         if(param1 in this._textsOriginState)
         {
            _loc9_ = this._textsOriginState[param1];
         }
         var _loc10_:uint = 0;
         this._textsOriginState[param1] = TextUtils.updateTextFormatNew(param1,param3,_loc10_,param6,_loc9_,_loc8_);
      }
      
      protected function getTextOriginState(param1:TextField) : TextOriginState
      {
         return this._textsOriginState[param1];
      }
      
      protected function updateTextAndFormatUnlocalized(param1:TextField, param2:String) : *
      {
         param1.text = param2;
      }
   }
}

