class UIMPShell_SquadLoadoutList_RankedGameNew extends UIMPShell_SquadLoadoutList_RankedGame;

function UpdateSquadListItems()
{
	local UIMechaListItem kListItem;
	local XComGameState kSquadLodoutState;
	local int pointTotal;
	local XComGameStateContext_SquadSelect kSquadLoadoutContext;
	local XComGameState_Unit kLoadoutUnit;

	local string strDisabledReason;

	SquadList.ClearItems();

	UIListItemString(SquadList.CreateItem(class'UIListItemString')).InitListItem(m_strCreateNewLoadout);

	foreach m_kMPShellManager.m_arrSquadLoadouts(kSquadLodoutState)
	{
		kSquadLoadoutContext = XComGameStateContext_SquadSelect(kSquadLodoutState.GetContext());
		`assert(kSquadLoadoutContext != none);
		`log(self $ "::" $ GetFuncName() @ `ShowVar(kSquadLoadoutContext.strLoadoutName) @ `ShowVar(kSquadLoadoutContext.iLoadoutId),, 'uixcom_mp');
		
		kListItem = UIMechaListItem(SquadList.CreateItem(class'UIMechaListItem'));

		pointTotal = 0;
		foreach kSquadLodoutState.IterateByClassType(class'XComGameState_Unit', kLoadoutUnit)
		{
			pointTotal += kLoadoutUnit.GetUnitPointValue();
		}

		kListItem.InitListItem();
		if( `ISCONTROLLERACTIVE )
		{
			kListItem.SetWidgetType(EUILineItemType_Description);
			kListItem.UpdateDataDescription(kSquadLoadoutContext.strLoadoutName @ "-" @ pointTotal @ m_strPointTotalPostfix);
		}
		else
		{
			kListItem.SetWidgetType(EUILineItemType_Checkbox);
			kListItem.UpdateDataCheckbox(kSquadLoadoutContext.strLoadoutName @ "-" @ pointTotal @ m_strPointTotalPostfix, "", false, OnCheckboxClicked);
		}

		kListItem.metadataObject = kSquadLodoutState;
		kListItem.metadataInt = pointTotal;

		if(pointTotal <= 0)
		{
			kListItem.SetBad(true);
		}
		else if(m_kMPShellManager.OnlineGame_GetMaxSquadCost() > 0)
		{
			kListItem.SetBad(pointTotal > m_kMPShellManager.OnlineGame_GetMaxSquadCost() || (pointTotal == 0 && (m_kMPShellManager.OnlineGame_GetIsRanked() || m_kMPShellManager.OnlineGame_GetAutomatch())));
		}
		
		// Валидация отряда
		if (!class'MPSquadValidator'.static.ValidateSquad(kSquadLodoutState, strDisabledReason))
		{
			kListItem.SetDisabled(true);
			kListItem.Desc.SetHTMLText(kListItem.Desc.htmlText @ strDisabledReason);			
		}
		
		kListItem.Show();
	}

	SelectFirstLoadout();
}

simulated function bool CanJoinGame()
{
	local string strDummyString;

	// Валидация отряда
	if (m_kSquadLoadout != none)
	{
		if (!class'MPSquadValidator'.static.ValidateSquad(m_kSquadLoadout, strDummyString))
		{
			return false;
		}
	}

	return super.CanJoinGame();
}
