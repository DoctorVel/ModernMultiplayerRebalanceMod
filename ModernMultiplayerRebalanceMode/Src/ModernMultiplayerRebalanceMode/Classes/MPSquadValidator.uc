class MPSquadValidator extends Object abstract;

var private localized string strUnitMissingCharTemplate;
var private localized string strUnitNotAllowedInMP;
var private localized string strMissingItemTemplate;
var private localized string strItemNotAllowedInMP;
var private localized string strTooManyUnitsOfSameType;

static final function bool ValidateSquad(const XComGameState CheckSquad, out string strDisabledReason)
{
	local XComGameState_Unit UnitState;
	local array<name> UnitTypes;
	
	foreach CheckSquad.IterateByClassType(class'XComGameState_Unit', UnitState)
	{
		if (!ValidateUnit(UnitState, CheckSquad, strDisabledReason))
		{
			return false;
		}
		
		UnitTypes.AddItem(UnitState.GetMyTemplateName());
	}
	
	// Сюда добавляй макс. число разрешенных юнитов определенного типа
	if (!CountUnitsOfType(UnitTypes, 'SectoidMP', 1, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'Trooper', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'Gatekeeper', 1, strDisabledReason)) return false;
	
	return true;
}

static final function bool CountUnitsOfType(const array<name> UnitTypes, const name CheckUnitType, const int iNumNaxUnits, out string strDisabledReason)
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
	if (NumCount > iNumNaxUnits)
	{
		strDisabledReason = Repl(default.strTooManyUnitsOfSameType, "%MaxAllowed%", string(iNumNaxUnits));
		strDisabledReason = Repl(strDisabledReason, "%NumUnits%", string(NumCount));
		return false;
	}
	return true;
}

static final function bool ValidateUnit(const XComGameState_Unit UnitState, const XComGameState CheckGameState, out string strDisabledReason)
{
	local X2CharacterTemplate CharTemplate;
	
	CharTemplate = UnitState.GetMyTemplate();
	if (CharTemplate == none)
	{
		strDisabledReason = UnitState.GetFullName() @ default.strUnitMissingCharTemplate;
		return false;
	}
	
	if (!IsValidUnitType(CharTemplate.DataName))
	{
		strDisabledReason = UnitState.GetFullName() @ default.strUnitNotAllowedInMP;
		return false;
	}
	
	// У пришельцев и адвенты предметы не проверяем
	if (CharTemplate.bIsAlien || CharTemplate.bIsAdvent)
		return true;
		
	return AreUnitItemsValid(UnitState, CheckGameState, strDisabledReason);
}

static final function bool IsValidUnitType(const name UnitType)
{
	switch (UnitType)
	{
		// Сюда добавляй имена темплпатов юнитов разрешенных в МП
		case 'SectoidMP':
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

static final function bool AreUnitItemsValid(const XComGameState_Unit UnitState, const XComGameState CheckGameState, out string strDisabledReason)
{
	local array<XComGameState_Item> InventoryItems;
	local XComGameState_Item		InventoryItem;
	local X2ItemTemplate			ItemTemplate;
	
	// Проверяем только предметы в слоте для доп. снаряжения
	UnitState.GetAllItemsInSlot(eInvSlot_Utility, CheckGameState);
	foreach InventoryItems(InventoryItem)
	{
		ItemTemplate = InventoryItem.GetMyTemplate();
		if (ItemTemplate == none)
		{
			strDisabledReason = default.strMissingItemTemplate @ InventoryItem.GetMyTemplateName();
			return false;
		}

		switch (InventoryItem.GetMyTemplateName())
		{
			// Сюда добавляй имена темплатов разрешенных предметов
			case 'EMPGrenade':
				return true;
			default:
				`LOG("Item not valid:" @ InventoryItem.GetMyTemplateName(),, 'Fear_MP');
				strDisabledReason = default.strItemNotAllowedInMP @ ItemTemplate.GetItemFriendlyNameNoStats();
				return false;
		}
	}
	// Юниты без предметов по-умолчанию валидны
	return true;
}
