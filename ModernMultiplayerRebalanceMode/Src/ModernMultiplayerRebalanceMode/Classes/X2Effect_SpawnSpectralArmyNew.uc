class X2Effect_SpawnSpectralArmyNew extends X2Effect_SpawnSpectralArmy;

function OnSpawnComplete(const out EffectAppliedData ApplyEffectParameters, StateObjectReference NewUnitRef, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit SpectralUnit;
	
	super.OnSpawnComplete(ApplyEffectParameters, NewUnitRef, NewGameState, NewEffectState);

	SpectralUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(NewUnitRef.ObjectID));

	if (SpectralUnit == none)
	{
		`RedScreen("X2Effect_SpectralArmyUnit: Spectral Unit is missing: " $SpectralUnit.ObjectID);
		return;
	}

	SpectralUnit.ActionPoints.Length = 0;
	SpectralUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.MoveActionPoint);
}

simulated function AddX2ActionsForVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, name EffectApplyResult)
{
	local XComGameStateHistory History;
	local XComGameStateVisualizationMgr VisualizationMgr;
	local X2Action_Fire_SpectralArmy FireAction;
	local array<XComGameState_Unit> SpectralUnits;
	local VisualizationActionMetadata EmptyTrack, NewUnitActionMetadata;
	local int j;
	local XComGameState_Unit SpawnedUnit;
	local X2Action_PlayAnimation AnimAction;
	local X2Action_WaitForAbilityEffect WaitAction;
	local X2Action_ShowSpawnedUnit ShowUnitAction;

	History = `XCOMHISTORY;
	VisualizationMgr = `XCOMVISUALIZATIONMGR;

	// Find the X2Action_Fire_SpectralArmy
	FireAction = X2Action_Fire_SpectralArmy(VisualizationMgr.GetNodeOfType(VisualizationMgr.BuildVisTree, class'X2Action_Fire_SpectralArmy'));

	FindNewlySpawnedUnits(VisualizeGameState, SpectralUnits);

	for (j = 0; j < SpectralUnits.Length; ++j)
	{
		NewUnitActionMetadata = EmptyTrack;
		NewUnitActionMetadata.StateObject_OldState = SpectralUnits[j];
		NewUnitActionMetadata.StateObject_NewState = NewUnitActionMetadata.StateObject_OldState;
		SpawnedUnit = XComGameState_Unit(NewUnitActionMetadata.StateObject_NewState);
		NewUnitActionMetadata.VisualizeActor = History.GetVisualizer(SpawnedUnit.ObjectID);

		WaitAction = X2Action_WaitForAbilityEffect(class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(NewUnitActionMetadata, VisualizeGameState.GetContext(), false, FireAction));
		
		ShowUnitAction = X2Action_ShowSpawnedUnit(class'X2Action_ShowSpawnedUnit'.static.AddToVisualizationTree(NewUnitActionMetadata, VisualizeGameState.GetContext(), false, WaitAction));
		ShowUnitAction.bPlayIdle = false;

		AnimAction = X2Action_PlayAnimation(class'X2Action_PlayAnimation'.static.AddToVisualizationTree(NewUnitActionMetadata, VisualizeGameState.GetContext(), false, ShowUnitAction));
		AnimAction.Params.AnimName = 'HL_SpectralArmy_Target';
		AnimAction.Params.BlendTime = 0.0f;
		AnimAction.bFinishAnimationWait = true;
	}
}

simulated function FindNewlySpawnedUnits(XComGameState VisualizeGameState, out array<XComGameState_Unit> SpawnedUnits)
{
    local XComGameStateHistory History;
    local XComGameState_Unit SpawnedUnit;
    local XComGameState_Unit ExistedPreviousFrame;

    History = `XCOMHISTORY;

    SpawnedUnits.Length = 0;

    foreach VisualizeGameState.IterateByClassType( class'XComGameState_Unit', SpawnedUnit )
    {
        if (SpawnedUnit.GetMyTemplateName() == UnitToSpawnName)
        {
            ExistedPreviousFrame = XComGameState_Unit(History.GetGameStateForObjectID(SpawnedUnit.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1));
            if (ExistedPreviousFrame == None)
            {
                `LOG("Zombie:" @ SpawnedUnit.ObjectID @ "did NOT exist in History",, 'IRITEST');
            }
            else
            {
                `LOG("Zombie:" @ SpawnedUnit.ObjectID @ "DID exist in History",, 'IRITEST');
            }
            SpawnedUnits.AddItem(SpawnedUnit);
        }
    }
}