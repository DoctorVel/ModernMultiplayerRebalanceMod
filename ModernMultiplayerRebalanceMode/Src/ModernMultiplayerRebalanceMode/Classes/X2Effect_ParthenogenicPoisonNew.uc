class X2Effect_ParthenogenicPoisonNew extends X2Effect_ParthenogenicPoison;

function OnSpawnComplete(const out EffectAppliedData ApplyEffectParameters, StateObjectReference NewUnitRef, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
local XComGameState_Unit SpectralUnit;

	super.OnSpawnComplete(ApplyEffectParameters, NewUnitRef, NewGameState, NewEffectState);

    SpectralUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(NewUnitRef.ObjectID));
    
    `LOG("Spawned zombie:" @ SpectralUnit.GetFullName() @ SpectralUnit.ObjectID,, 'IRITEST');

    if (SpectralUnit == none)
    {
        `RedScreen("X2Effect_SpectralArmyUnit: Spectral Zombie is missing: " $SpectralUnit.ObjectID);
        return;
    }

    SpectralUnit.ActionPoints.Length = 0;
}