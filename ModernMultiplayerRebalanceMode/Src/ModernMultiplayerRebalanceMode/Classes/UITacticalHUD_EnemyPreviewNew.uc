class UITacticalHUD_EnemyPreviewNew extends UITacticalHUD_EnemyPreview;

public function UpdateVisuals(int HistoryIndex)
{
	local XGUnit kActiveUnit;
	local XComGameState_BaseObject TargetedObject;
	local XComGameState_Unit EnemyUnit;
	local X2VisualizerInterface Visualizer;
	local XComGameStateHistory History;
	local int i;

	// DATA: -----------------------------------------------------------
	History = `XCOMHISTORY;
	kActiveUnit = XComTacticalController(PC).GetActiveUnit();
	if (kActiveUnit == none) return;


	// VISUALS: -----------------------------------------------------------
	// Now that the array is tidy, we can set the visuals from it.



	SetVisibleEnemies(iNumVisibleEnemies); //Do this before setting data 

	for (i = 0; i < m_arrTargets.Length; i++)
	{
		TargetedObject = History.GetGameStateForObjectID(m_arrTargets[i].ObjectID, , HistoryIndex);
		Visualizer = X2VisualizerInterface(TargetedObject.GetVisualizer());
		EnemyUnit = XComGameState_Unit(TargetedObject);

		SetIcon(i, Visualizer.GetMyHUDIcon());

		if (m_arrCurrentlyAffectable.Find('ObjectID', TargetedObject.ObjectID) > -1)
		{
			SetBGColor(i, GetUnitTeamColor(Visualizer));
			SetDisabled(i, false);
		}
		else
		{
			SetBGColor(i, eUIState_Disabled);
			SetDisabled(i, true);
		}

		if (m_arrSSEnemies.Find('ObjectID', TargetedObject.ObjectID) > -1)
			SetSquadSight(i, true);
		else
			SetSquadSight(i, false);

		if (EnemyUnit != none && FlankedTargets.Find('ObjectID', EnemyUnit.ObjectID) != INDEX_NONE)
			SetFlanked(i, true);
		else
			SetFlanked(i, false);  // Flanking was leaking inappropriately! 

	}

	RefreshShine();

	Movie.Pres.m_kTooltipMgr.ForceUpdateByPartialPath(string(MCPath));

	// force set selected index, since updating the visible enemies resets the state of the selected target
	//if (CurrentTargetIndex != -1)
	//	SetTargettedEnemy(CurrentTargetIndex, true);
}

static private function EUIState GetUnitTeamColor(X2VisualizerInterface Visualizer)
{
	   local XComGameState_Unit UnitState;
    local XGUnit VisualizedUnit;

    VisualizedUnit = XGUnit(Visualizer);
    if (VisualizedUnit != none)
    {
        UnitState = VisualizedUnit.GetVisualizedGameState();
        if (UnitState != none)
        {
            switch (UnitState.GetTeam())
            {
                case eTeam_One:
                case eTeam_Two:
                    return eUIState_Bad;
                default:
                    break;
            }
        }
    }
    return Visualizer.GetMyHUDIconColor();
}
