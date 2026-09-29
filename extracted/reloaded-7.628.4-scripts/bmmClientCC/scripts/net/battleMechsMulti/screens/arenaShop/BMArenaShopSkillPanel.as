package net.battleMechsMulti.screens.arenaShop
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   
   public class BMArenaShopSkillPanel extends BMMovieClip
   {
      
      public var mcIconSizer:Sprite;
      
      public var txtSkillLevel:TextField;
      
      public var txtBonus:TextField;
      
      public var levelsBar:BMBar;
      
      public var mcSelected:Sprite;
      
      public var mcHitArea:Sprite;
      
      public var mcIconHolder:Sprite;
      
      private var _skillID:uint;
      
      private var _onClick:Function;
      
      private var _icon:Sprite;
      
      public function BMArenaShopSkillPanel()
      {
         super();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function initialize(param1:uint, param2:Function = null, param3:Sprite = null, param4:String = "", param5:Number = 0, param6:uint = 0, param7:Boolean = false) : void
      {
         this._skillID = param1;
         if(param2 != null)
         {
            this.addClickFunction(param2);
         }
         if(param3 != null)
         {
            this.addLocalIcon(param3);
         }
         else if(param4 != "")
         {
            this.addExternalIcon(param4);
         }
         if(param6 > 0)
         {
            this.setLevels(param5,param6);
         }
         this.selected = param7;
      }
      
      public function addClickFunction(param1:Function) : void
      {
         this._onClick = param1;
         this.mcHitArea.addEventListener(MouseEvent.CLICK,this.hitAreaClicked);
      }
      
      public function addExternalIcon(param1:String) : void
      {
         var _loc2_:int = this.mcIconSizer.width;
         this._icon = BMExternalAssetsManager.getInstance().getAsset("general",param1,_loc2_,_loc2_);
         this._icon.x = this.mcIconSizer.x;
         this._icon.y = this.mcIconSizer.y;
         this.mcIconHolder.addChild(this._icon);
      }
      
      public function addLocalIcon(param1:Sprite) : void
      {
         var _loc2_:int = this.mcIconSizer.width;
         this._icon = param1;
         this._icon.width = _loc2_;
         this._icon.height = _loc2_;
         this._icon.x = this.mcIconSizer.x;
         this._icon.y = this.mcIconSizer.y;
         this.mcIconHolder.addChild(this._icon);
      }
      
      public function setLevels(param1:Number, param2:uint) : void
      {
         this.levelsBar.initialize();
         if(param1 == param2)
         {
            updateTextAndFormat(this.txtSkillLevel,BMLanguageManager.getInstance().getText("arenaShop_max"));
            this.levelsBar.setFill(1);
            return;
         }
         var _loc3_:Number = param1 / param2;
         updateTextAndFormat(this.txtSkillLevel,param1 + " / " + param2);
         this.levelsBar.setFill(_loc3_);
      }
      
      public function setBonusText(param1:Number, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc8_:String = null;
         var _loc6_:String = "00FF00";
         if(param1 == 0)
         {
            _loc6_ = "999999";
         }
         else if(param3)
         {
            _loc6_ = "FFCC00";
         }
         var _loc7_:String = "+";
         if(param4)
         {
            _loc7_ = "-";
         }
         if(param5)
         {
            if(param1 == 0)
            {
               _loc8_ = "<FONT COLOR=\'#999999\'>0";
            }
            else
            {
               _loc8_ = "<FONT COLOR=\'#999999\'>1 / <FONT COLOR=\'#" + _loc6_ + "\'>" + param1;
            }
         }
         else
         {
            _loc8_ = "<FONT COLOR=\'#" + _loc6_ + "\'>" + _loc7_ + param1;
            if(param2 == false)
            {
               _loc8_ += "%";
            }
         }
         updateTextAndFormat(this.txtBonus,_loc8_);
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(param1)
         {
            this.mcSelected.visible = true;
         }
         else
         {
            this.mcSelected.visible = false;
         }
      }
      
      public function get selected() : Boolean
      {
         return this.mcSelected.visible;
      }
      
      private function hitAreaClicked(param1:MouseEvent) : void
      {
         this._onClick(this._skillID);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.mcHitArea.removeEventListener(MouseEvent.CLICK,this.hitAreaClicked);
         if(this._icon == null)
         {
            return;
         }
         this._icon.parent.removeChild(this._icon);
         this._icon = null;
      }
   }
}

