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

function OnSpawnComplete(const out EffectAppliedData ApplyEffectParameters, StateObjectReference NewUnitRef, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
local XComGameState_Unit SpectralUnit;

    SpectralUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(NewUnitRef.ObjectID));
    
    `LOG("Spawned zombie:" @ SpectralUnit.GetFullName() @ SpectralUnit.ObjectID,, 'IRITEST');

    if (SpectralUnit == none)
    {
        `RedScreen("X2Effect_SpectralArmyUnit: Spectral Zombie is missing: " $SpectralUnit.ObjectID);
        return;
    }

    SpectralUnit.ActionPoints.Length = 0;
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