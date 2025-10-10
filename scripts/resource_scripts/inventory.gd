class_name Inventory extends Resource


@export var item_slots : Dictionary[Item, int]


func add_item(item : Item, amount : int):
	if amount <= 0: return
	
	if item_slots.has(item):
		item_slots[item] += amount
	else:
		item_slots[item] = amount

func remove_item(item : Item, amount : int):
	if not has_item(item): return
	
	item_slots[item] -= amount
	if item_slots[item] == 0:
		item_slots.erase(item)

func has_item(item : Item, amount : int = 0) -> bool:
	if amount < 0: return false
	if not item_slots.has(item): return false
	if amount > item_slots[item]: return false

	return true
