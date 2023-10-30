class MPSquadValidator extends Object abstract;

static final function bool ValidateSquad(const XComGameState CheckSquad)
{
	local XComGameState_Unit UnitState;
	local array<name> UnitTypes;
	
	foreach CheckSquad.IterateByClassType(class'XComGameState_Unit', UnitState)
	{
		if (!ValidateUnit(UnitState, CheckSquad))
			return false;
		
		UnitTypes.AddItem(UnitState.GetMyTemplateName());
	}
	
	// Сюда добавляй макс. число разрешенных юнитов определенного типа
	if (CountUnitsOfType(UnitTypes, 'Sectoid') > 3) return false;
	if (CountUnitsOfType(UnitTypes, 'Trooper') > 2) return false;
	if (CountUnitsOfType(UnitTypes, 'Gatekeeper') > 1) return false;
	
	return true;
}

static final function int CountUnitsOfType(const array<name> UnitTypes, const name CheckUnitType)
{
	local name UnitType;
	local int NumCount;
	
	foreach UnitTypes(UnitType)
	{
		if (UnitType == CheckUnitType)
		{
			NumCount++;
		}
	}
	return NumCount;
}

static final function bool ValidateUnit(const XComGameState_Unit UnitState, const XComGameState CheckGameState)
{
	local X2CharacterTemplate CharTemplate;
	
	CharTemplate = UnitState.GetMyTemplate();
	if (CharTemplate == none)
		return false;
	
	if (!IsValidUnitType(CharTemplate.DataName))
		return false;
	
	// У пришельцев и адвенты предметы не проверяем
	if (CharTemplate.bIsAlien || CharTemplate.bIsAdvent)
		return true;
		
	return AreUnitItemsValid(UnitState, CheckGameState);
}

static final function bool IsValidUnitType(const name UnitType)
{
	switch (UnitType)
	{
		// Сюда добавляй имена темплпатов юнитов разрешенных в МП
		case 'Sectoid':
		case 'AdvTrooper':
		case 'Soldier':
			return true;
		default:
			`LOG("Unit type not valid:" @ UnitType,, 'Fear_MP');
			return false;
	}
	// До сюда код дайти не должен, но мало ли
	return false;
}

static final function bool AreUnitItemsValid(const XComGameState_Unit UnitState, const XComGameState CheckGameState)
{
	local array<XComGameState_Item> InventoryItems;
	local XComGameState_Item		InventoryItem;
	
	// Проверяем только предметы в слоте для доп. снаряжения
	UnitState.GetAllItemsInSlot(eInvSlot_Utility, CheckGameState);
	foreach InventoryItems(InventoryItem)
	{
		switch (InventoryItem.GetMyTemplateName())
		{
			// Сюда добавляй имена темплатов разрешенных предметов
			case 'KevlarArmor':
			case 'AssaultRifle_CV':
			case 'FragGrenade':
				return true;
			default:
				`LOG("Item not valid:" @ InventoryItem.GetMyTemplateName(),, 'Fear_MP');
				return false;
		}
	}
	// Юниты без предметов по-умолчанию валидны
	return true;
}
