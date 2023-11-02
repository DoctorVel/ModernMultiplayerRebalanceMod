class X2Effect_ParthenogenicPoisonNew extends X2Effect_ParthenogenicPoison;

function OnSpawnComplete(const out EffectAppliedData ApplyEffectParameters, StateObjectReference NewUnitRef, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit CocoonUnit;

	super.OnSpawnComplete(ApplyEffectParameters, NewUnitRef, NewGameState, NewEffectState);

    CocoonUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(NewUnitRef.ObjectID));
    
    `LOG("Spawned cocoon:" @ CocoonUnit.GetFullName() @ CocoonUnit.ObjectID,, 'Fear_MP');

    if (CocoonUnit == none)
    {
		`LOG("Spawned zombie:" @ CocoonUnit.GetFullName() @ CocoonUnit.ObjectID,, 'Fear_MP');
        return;
    }

    CocoonUnit.ActionPoints.Length = 0;
<<<<<<< HEAD
}
=======
}
>>>>>>> 81b7223d8401c0c65117057697faf766cfe8764b
