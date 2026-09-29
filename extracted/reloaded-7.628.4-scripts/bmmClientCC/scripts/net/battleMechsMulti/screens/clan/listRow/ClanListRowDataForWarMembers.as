package net.battleMechsMulti.screens.clan.listRow
{
   public class ClanListRowDataForWarMembers extends ClanListRowData
   {
      
      public var mechs:uint;
      
      public function ClanListRowDataForWarMembers(param1:String, param2:uint, param3:uint)
      {
         super();
         name = param1;
         rankIconNumber = param2;
         this.mechs = param3;
      }
   }
}

