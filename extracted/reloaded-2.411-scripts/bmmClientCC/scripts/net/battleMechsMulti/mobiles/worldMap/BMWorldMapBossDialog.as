package net.battleMechsMulti.mobiles.worldMap
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMMechView;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol412")]
   public class BMWorldMapBossDialog extends MovieClip
   {
      
      public var txtDialog:TextField;
      
      public var mcMechHolder:Sprite;
      
      private var mechView:BMMechView;
      
      private var _textOriginYPos:Number;
      
      public function BMWorldMapBossDialog()
      {
         super();
         this._textOriginYPos = this.txtDialog.y;
      }
      
      public function showMech(param1:BMMechView, param2:Number = 0, param3:Number = 0) : void
      {
         this.mechView = param1;
         this.mechView.activateBreathing();
         if(this.mechView.scaleX > 0)
         {
            this.mechView.scaleX *= -1;
         }
         this.mechView.x = param2;
         this.mechView.y = this.mechView.mechSizer.y * -1 - param3;
         this.mcMechHolder.addChild(this.mechView);
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this.mechView != null)
         {
            this.mechView.onEnterFrameTrigger();
         }
      }
      
      public function showDialog(param1:String) : void
      {
         this.txtDialog.htmlText = param1;
         if(this.txtDialog.numLines == 1)
         {
            this.txtDialog.y = this._textOriginYPos + 18;
         }
         else
         {
            this.txtDialog.y = this._textOriginYPos;
         }
      }
      
      public function removeMe() : void
      {
         if(this.mechView != null)
         {
            this.mechView.removeMe();
            this.mechView = null;
         }
      }
   }
}

