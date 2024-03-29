package;


enum Item{
	WATER;
	WOOD;
	MUD;
	STONE;
	GLASS;
	ALCOHOL;
	RAG;
	COAL;
	GUNPOWDER;
//Craftable
	WOOD_WALL;
	STONE_WALL;
	WOOD_BARRICADE;
}

class Inventory {

	public var items:Map<Item,Int>;
	public var recipes:Map<Item,Array<Item>>;

	public function new(){
		items = [
			Item.WATER=>0,
			Item.WOOD=>0,
			Item.MUD=>0,
			Item.STONE=>0,
			Item.GLASS=>0,
			Item.ALCOHOL=>0,
			Item.RAG=>0,
			Item.COAL=>0,
			Item.GUNPOWDER=>0,
			//Craftables
			Item.WOOD_WALL=>0,
			Item.STONE_WALL=>0,
			Item.WOOD_BARRICADE=>0,
    	];

    	recipes = [
	    	Item.WOOD_WALL => [Item.WOOD,Item.WOOD],
	    	Item.STONE_WALL => [Item.MUD,Item.MUD,Item.MUD,Item.MUD,Item.STONE,Item.STONE,Item.STONE,Item.STONE],
	    	Item.WOOD_BARRICADE => [Item.WOOD,Item.WOOD, Item.WOOD]
    	];

	}

	public function addItem(item:Item){
		items[item] += 1;
	}

	public function removeItem(item:Item){
		items[item] -= 1;
	}

	public function getQuantity(it:Item):Int{
		return items[it];
	}

	public function createItem(recipe:Item){
		if(!canCreate(recipe)) return;
		removeItemsFromRecipe(recipe);
		items[recipe] += 1;
	}

	public function canCreate(recipe:Item):Bool{
		var temp = new Map<Item, Int>();
		for(i in items.keys()){
			temp.set(i, items[i]);
		}

		for(key in recipes[recipe]){
			temp[key] -= 1;
			if(temp[key] == -1) return false;
		}

		return true;
	}

	public function removeItemsFromRecipe(recipe:Item){
		for(key in recipes[recipe]){
			items[key] -= 1;
		}
	}
}