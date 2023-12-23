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
        
        if (UnitState.IsSoldier())
        {
            UnitTypes.AddItem(UnitState.GetSoldierClassTemplateName());
        }
        else
        {
            UnitTypes.AddItem(UnitState.GetMyTemplateName());
        }
    }
	
	// Сюда добавляй макс. число разрешенных юнитов определенного типа
	if (!CountUnitsOfType(UnitTypes, 'AdvTrooperMP', 6, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'AdvCaptainMP', 6, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'AdvStunLancerMP', 6, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'AdvPurifierMP', 6, strDisabledReason)) return false;	
	if (!CountUnitsOfType(UnitTypes, 'FeralMEC_MP', 6, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'AdvMedic_MP', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'AdvShieldBearerMP', 3, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'AdvMEC_MP', 2, strDisabledReason)) return false;	
	if (!CountUnitsOfType(UnitTypes, 'AdvPriestMP', 6, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'AdvMEC_M2_MP', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'AdvGeneralMP', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'AdvPsiWitchMP', 1, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'AdvDroneMP', 2, strDisabledReason)) return false;

	if (!CountUnitsOfType(UnitTypes, 'TheLostDasherMP', 6, strDisabledReason)) return false;

	if (!CountUnitsOfType(UnitTypes, 'SectoidMP', 3, strDisabledReason)) return false;

	if (!CountUnitsOfType(UnitTypes, 'FacelessMP', 6, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'SectoidMP', 3, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'ChryssalidMP', 6, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'ViperMP', 6, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'MutonMP', 3, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'BerserkerMP', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'ViperNeonateMP', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'CyberusMP', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'SpectreMP', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'Centurioin', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'ArchonMP', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'SectoidM2_MP', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'AndromedonMP', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'ViperKingMP', 1, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'MutonElite_MP', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'BerserkerQueenMP', 1, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'ArchonKingMP', 1, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'GatekeeperMP', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'SectopodMP', 1, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'ChosenAssassinMP', 1, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'ChosenWarlockMP', 1, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'ChosenSniperMP', 1, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'AHWElder', 1, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'PhantomRanger', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'BlademasterRanger', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'SniperSharpshooter', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'MP_Grenadier', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'HeavyGunnerGrenadier', 1, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'DemoExpertGrenadier', 1, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'BattlefieldMedicSpecialis', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'CombatHackerSpecialist', 1, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'PsiOperative ', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'Reaper', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'Skirmisher', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'Templar', 2, strDisabledReason)) return false;
	if (!CountUnitsOfType(UnitTypes, 'SparkSoldierMP', 2, strDisabledReason)) return false;

	
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
	`LOG("Item not valid:" @ UnitState.GetMyTemplate(),, 'Fear_MP');
	if (CharTemplate.bIsAlien || CharTemplate.bIsAdvent)
	return true;
	return AreUnitItemsValid(UnitState, CheckGameState, strDisabledReason);
}

static final function bool IsValidUnitType(const name UnitType)
{
	switch (UnitType)
	{
		// Сюда добавляй имена темплпатов юнитов разрешенных в МП
		case 'AdvTrooperMP':
		case 'AdvCaptainMP':
		case 'AdvStunLancerMP':
		case 'AdvPurifierMP':
		case 'FeralMEC_MP':
		case 'AdvMedicMP':
		case 'AdvShieldBearerMP':
		case 'AdvMEC_MP':
		case 'AdvPriestMP':
		case 'AdvMEC_M2_MP':
		case 'AdvGeneralMP':
		case 'AdvDroneMP':
		case 'AdvPsiWitch_MP':
		case 'TheLostDasherMP':

		case 'FacelessMP':
		case 'SectoidMP':
		case 'ViperMP':
		case 'ChryssalidMP':
		case 'MutonMP':
		case 'BerserkerMP':
		case 'ViperNeonateMP':
		case 'CyberusMP':
		case 'SectoidM2_MP':
		case 'Centurion':
		case 'SpectreMP':
		case 'ArchonMP':
		case 'MutonElite_MP':
		case 'AndromedonMP':
		case 'ViperKingMP':
		case 'BerserkerQueenMP':
		case 'GatekeeperMP':
		case 'ArchonKingMP':
		case 'SectopodMP':
		case 'ChosenAssassinMP':
		case 'ChosenSniperMP':
		case 'ChosenWarlockMP':
		case 'AHWElder':

		case 'TemplarSoldier':
		case 'SkirmisherSoldier':
		case 'ReaperSoldier':
		case 'SparkSoldierMP':
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
	InventoryItems = UnitState.GetAllItemsInSlot(eInvSlot_Utility, CheckGameState);
	foreach InventoryItems(InventoryItem)
	{
		ItemTemplate = InventoryItem.GetMyTemplate();
		if (ItemTemplate == none)
		{
			strDisabledReason = default.strMissingItemTemplate @ InventoryItem.GetMyTemplateName();
			`LOG("Item not valid:" @ InventoryItem.GetMyTemplateName(),, 'Fear_MP');
			return false;
		}

		switch (InventoryItem.GetMyTemplateName())
		{
			// Сюда добавляй имена темплатов разрешенных предметов
			case 'AlienGrenade':
			case 'FragGrenade':
			case 'EMPGrenad':
			case 'MindShield':
			case 'APRounds':
			case 'TracerRounds':

			case 'Hellweave':
			case 'StasisVest':
			case 'HazmatVest':
			case 'NanoMedikit':
			case 'TalonRounds':
			case 'XPad':
			case 'Medikit':

			`LOG("Item  valid:" @ InventoryItem.GetMyTemplateName(),, 'Fear_MP');
				break;
			default:
				`LOG("Item not valid:" @ InventoryItem.GetMyTemplateName(),, 'Fear_MP');
				strDisabledReason = default.strItemNotAllowedInMP @ ItemTemplate.GetItemFriendlyNameNoStats();
				return false;
		}
	}
	// Юниты без предметов по-умолчанию валидны
	return true;
}
