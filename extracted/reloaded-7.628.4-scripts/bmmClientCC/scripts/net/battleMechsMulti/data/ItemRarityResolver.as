package net.battleMechsMulti.data
{
   import net.battleMechsMulti.managers.BMLanguageManager;
   
   public class ItemRarityResolver
   {
      
      public static const RARITY_COMMON:Number = 0;
      
      public static const RARITY_RARE:Number = 1;
      
      public static const RARITY_EPIC:Number = 2;
      
      public static const RARITY_LEGENDARY:Number = 3;
      
      public static const RARITY_MYTHICAL:Number = 4;
      
      public static const RARITY_ASCENDED:Number = 10;
      
      public static const RARITY_PERK:Number = 5;
      
      public static const COLOR_COMMON_ITEM:String = "c0c0c0";
      
      public static const COLOR_RARE_ITEM:String = "0099FF";
      
      public static const COLOR_RARE_ITEM_UINT:uint = 39423;
      
      public static const COLOR_EPIC_ITEM:String = "9C3399";
      
      public static const COLOR_EPIC_ITEM_UINT:uint = 10236825;
      
      public static const COLOR_LEGENDARY_ITEM:String = "FF9900";
      
      public static const COLOR_LEGENDARY_ITEM_UINT:uint = 16750848;
      
      public static const COLOR_MYTHICAL_ITEM:String = "FF6633";
      
      public static const COLOR_MYTHICAL_ITEM_UINT:uint = 16737843;
      
      public static const COLOR_MYTHICAL_ITEM_DARK:String = "3A0B00";
      
      public static const COLOR_ASCENDED_ITEM:String = "FFFFFF";
      
      public static const COLOR_ASCENDED_ITEM_UINT:uint = 16777215;
      
      public static const COLOR_ASCENDED_ITEM_DARK:String = "FFFFFF";
      
      public static const COLOR_PERK:String = "FFFF33";
      
      public function ItemRarityResolver()
      {
         super();
      }
      
      public static function nextRarity(param1:uint) : uint
      {
         if(param1 == RARITY_COMMON)
         {
            return RARITY_RARE;
         }
         if(param1 == RARITY_RARE)
         {
            return RARITY_EPIC;
         }
         if(param1 == RARITY_EPIC)
         {
            return RARITY_LEGENDARY;
         }
         if(param1 == RARITY_LEGENDARY)
         {
            return RARITY_MYTHICAL;
         }
         if(param1 == RARITY_MYTHICAL)
         {
            return RARITY_ASCENDED;
         }
         throw new Error("Error: cannot find next rarity for " + param1);
      }
      
      public static function previousRarity(param1:uint) : uint
      {
         if(param1 == RARITY_RARE)
         {
            return RARITY_COMMON;
         }
         if(param1 == RARITY_EPIC)
         {
            return RARITY_RARE;
         }
         if(param1 == RARITY_LEGENDARY)
         {
            return RARITY_EPIC;
         }
         if(param1 == RARITY_MYTHICAL)
         {
            return RARITY_LEGENDARY;
         }
         if(param1 == RARITY_ASCENDED)
         {
            return RARITY_MYTHICAL;
         }
         throw new Error("Error: cannot find previous rarity for " + param1);
      }
      
      public static function getItemTierColor(param1:int) : String
      {
         switch(param1)
         {
            case RARITY_COMMON:
               return COLOR_COMMON_ITEM;
            case RARITY_RARE:
               return COLOR_RARE_ITEM;
            case RARITY_EPIC:
               return COLOR_EPIC_ITEM;
            case RARITY_LEGENDARY:
               return COLOR_LEGENDARY_ITEM;
            case RARITY_MYTHICAL:
               return COLOR_MYTHICAL_ITEM;
            case RARITY_ASCENDED:
               return COLOR_ASCENDED_ITEM;
            case RARITY_PERK:
               return COLOR_PERK;
            default:
               throw new Error("Error: cannot find color for rarity " + param1);
         }
      }
      
      public static function getItemTierName(param1:uint) : String
      {
         var _loc2_:BMLanguageManager = BMLanguageManager.getInstance();
         switch(param1)
         {
            case RARITY_COMMON:
               return _loc2_.getText("general_common");
            case RARITY_RARE:
               return _loc2_.getText("general_rare");
            case RARITY_EPIC:
               return _loc2_.getText("general_epic");
            case RARITY_LEGENDARY:
               return _loc2_.getText("general_legendary");
            case RARITY_MYTHICAL:
               return _loc2_.getText("general_mythical");
            case RARITY_ASCENDED:
               return _loc2_.getText("general_ascended");
            case RARITY_PERK:
               return _loc2_.getText("general_perk");
            default:
               throw new Error("Error: cannot find name for rarity " + param1);
         }
      }
   }
}

