class UITacticalHUD_EnemiesNew extends UITacticalHUD_Enemies;

var private XComGameState_Unit LocActiveUnit;

public function UpdateVisuals(int HistoryIndex)
{
	local XGUnit kActiveUnit;
	local XComGameState_BaseObject TargetedObject;
	local XComGameState_Unit EnemyUnit;
	local X2VisualizerInterface Visualizer;
	local XComGameStateHistory History;
	local StateObjectReference ActiveUnitRef;
	local int i;
	local bool DisabledIcon;

	// DATA: -----------------------------------------------------------
	History = `XCOMHISTORY;
	kActiveUnit = XComTacticalController(PC).GetActiveUnit();
	ActiveUnitRef.ObjectID = kActiveUnit.ObjectID;
	if( kActiveUnit == none ) return; 


	// VISUALS: -----------------------------------------------------------
	// Now that the array is tidy, we can set the visuals from it.
	
	SetVisibleEnemies( iNumVisibleEnemies ); //Do this before setting data 

	for(i = 0; i < m_arrTargets.Length; i++)
	{
		TargetedObject = History.GetGameStateForObjectID(m_arrTargets[i].ObjectID, , HistoryIndex);
		Visualizer = X2VisualizerInterface(TargetedObject.GetVisualizer());
		EnemyUnit = XComGameState_Unit(TargetedObject);
			
		SetIcon( i, Visualizer.GetMyHUDIcon() );
		SetFlanked(i, false);  // Flanking was leaking inappropriately! 

		if( m_arrCurrentlyAffectable.Find('ObjectID', TargetedObject.ObjectID) > -1 )
		{
			SetBGColor(i, GetUnitTeamColor(Visualizer));
			SetDisabled(i, false);
			DisabledIcon = false;
		}
		else
		{
			SetBGColor(i, eUIState_Disabled);
			SetDisabled(i, true);
			DisabledIcon = true;
		}
				
		if(m_arrSSEnemies.Find('ObjectID', TargetedObject.ObjectID) > -1)
			SetSquadSight(i, true);
		else
			SetSquadSight(i, false);

		if( EnemyUnit != none && EnemyUnit.IsFlanked(ActiveUnitRef, false, HistoryIndex) && !DisabledIcon )
			SetFlanked(i, true);
			
	}

	RefreshShine();

	Movie.Pres.m_kTooltipMgr.ForceUpdateByPartialPath( string(MCPath) );

	// force set selected index, since updating the visible enemies resets the state of the selected target
	if(CurrentTargetIndex != -1)
		SetTargettedEnemy(CurrentTargetIndex, true);
}

event OnActiveUnitChanged(XComGameState_Unit NewActiveUnit)
{
	LocActiveUnit = NewActiveUnit;
	
	super.OnActiveUnitChanged(NewActiveUnit);	
}

private function EUIState GetUnitTeamColor(X2VisualizerInterface Visualizer)
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
					if (LocActiveUnit.IsEnemyUnit(UnitState))
					{
						return eUIState_Bad;
					}
                    return eUIState_Normal;
                default:
                    break;
            }
        }
    }
    return Visualizer.GetMyHUDIconColor();
}