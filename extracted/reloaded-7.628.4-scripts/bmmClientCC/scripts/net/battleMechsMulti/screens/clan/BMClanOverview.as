package net.battleMechsMulti.screens.clan
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.mobiles.BMClanFlag;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   
   public class BMClanOverview extends BMMovieClip
   {
      
      public var mcSizer_flag:Sprite;
      
      public var mcSizer_rank:Sprite;
      
      public var txtClanName:TextField;
      
      public var txtLeaderName:TextField;
      
      public var txtTitle:TextField;
      
      private var mcClanFlag:BMClanFlag;
      
      private var mcRank:Sprite;
      
      public function BMClanOverview()
      {
         super();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function initialize(param1:String, param2:String, param3:String, param4:uint, param5:String = "") : void
      {
         updateTextAndFormat(this.txtClanName,param1);
         var _loc6_:String = BMLanguageManager.getInstance().getText("rankingList_clanLeader");
         _loc6_ = this.dataM.replaceStringInText(_loc6_,"%NAME%",param2);
         if(this.txtLeaderName != null)
         {
            updateTextAndFormat(this.txtLeaderName,_loc6_);
         }
         if(this.txtTitle != null)
         {
            updateTextAndFormat(this.txtTitle,param5);
         }
         this.displayRank(param4);
         this.removeClanFlag();
         this.createFlag(param3);
      }
      
      private function removeClanFlag() : void
      {
         if(this.mcClanFlag != null)
         {
            this.mcClanFlag.removeMe();
            this.mcClanFlag = null;
         }
      }
      
      private function createFlag(param1:String) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:Array = this.dataM.getClanFlagData(param1);
         if(_loc2_.length > 0)
         {
            this.mcClanFlag = new BMClanFlag();
            _loc3_ = this.externalAssetsM.getAsset("general","clanFlag",this.mcSizer_flag.width,this.mcSizer_flag.height,false,false);
            _loc3_.x = this.mcSizer_flag.x;
            _loc3_.y = this.mcSizer_flag.y;
            this.mcClanFlag.initialize(_loc3_,this.dataM.runAsMobile);
            this.mcClanFlag.updateFlag(_loc2_);
            addChild(_loc3_);
         }
      }
      
      private function displayRank(param1:uint) : void
      {
         if(this.mcSizer_rank == null)
         {
            return;
         }
         var _loc2_:uint = this.dataM.getLadderRankByProgress(param1);
         var _loc3_:uint = this.dataM.getLadderRankIconNumber(_loc2_);
         this.mcRank = this.externalAssetsM.getAsset("general","Grp_rank" + _loc3_,this.mcSizer_rank.width,this.mcSizer_rank.height,false,false);
         this.mcRank.x = this.mcSizer_rank.x;
         this.mcRank.y = this.mcSizer_rank.y;
         addChild(this.mcRank);
      }
      
      private function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
      
      private function get externalAssetsM() : BMExternalAssetsManager
      {
         return BMExternalAssetsManager.getInstance();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.removeClanFlag();
      }
   }
}

