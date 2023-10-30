//From Deployable Turrets mod for WotC
class X2Effect_SpawnTurretScaled_XCom extends X2Effect_SpawnUnit;

function vector GetSpawnLocation(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState)
{
	local Vector DropPosition;

	DropPosition = ApplyEffectParameters.AbilityInputContext.TargetLocations[0];

	if(ApplyEffectParameters.AbilityInputContext.TargetLocations.Length == 0)
	{
		`Redscreen("Attempting to create X2Effect_SpawnDeployableTurret without a target location! @dslonneger");
		return vect(0,0,0);
	}
	
	return DropPosition;
}

function ETeam GetTeam(const out EffectAppliedData ApplyEffectParameters)
{
	return GetSourceUnitsTeam(ApplyEffectParameters);
}
function AddSpawnVisualizationsToTracks_Parent(XComGameStateContext Context, XComGameState_Unit SpawnedUnit, out VisualizationActionMetadata SpawnedUnitTrack,
										XComGameState_Unit EffectTargetUnit, X2Action Parent)
{
	class'X2Action_ShowSpawnedUnit'.static.AddToVisualizationTree(SpawnedUnitTrack, Context, false, Parent);
}


defaultproperties
{
	UnitToSpawnName="AdvTurretMP"
    bKnockbackAffectsSpawnLocation=false
}