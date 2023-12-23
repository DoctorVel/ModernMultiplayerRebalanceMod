class X2Effect_KineticPlatingNew extends X2Effect_KineticPlating;

function RegisterForEvents(XComGameState_Effect EffectGameState)
{
    local X2EventManager EventMan;
    local Object EffectObj;

    EventMan = `XEVENTMGR;
    EffectObj = EffectGameState;
    EventMan.RegisterForEvent(EffectObj, 'AbilityActivated', KineticPlatingListener, ELD_OnStateSubmitted,, ,, EffectObj);
}

static private function EventListenerReturn KineticPlatingListener(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameStateContext_Ability AbilityContext;
	local X2AbilityTemplate AbilityTemplate;
	local XComGameState NewGameState;
	local XComGameState_Unit UnitState;
	local X2Effect_KineticPlating PlatingEffect;
	local XComGameState_Effect EffectState;

	AbilityContext = XComGameStateContext_Ability(GameState.GetContext());
	if (AbilityContext != none && AbilityContext.InterruptionStatus != eInterruptionStatus_Interrupt && AbilityContext.IsResultContextMiss())
	{
		AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate(AbilityContext.InputContext.AbilityTemplateName);
		
		if (AbilityTemplate == none || X2AbilityToHitCalc_StatCheck_UnitVsUnit(AbilityTemplate.AbilityToHitCalc) != none)
		{
			`LOG("Ability blocked:" @ AbilityTemplate.DataName @ AbilityTemplate.LocFriendlyName,, 'KineticPlating');
			return ELR_NoInterrupt;
		}
		else
		{
			`LOG("Ability allowed:" @ AbilityTemplate.DataName @ AbilityTemplate.LocFriendlyName,, 'KineticPlating');
		}
			
		EffectState = XComGameState_Effect(CallbackData);
		if (EffectState == none)
			return ELR_NoInterrupt;
		
		if (AbilityContext.InputContext.PrimaryTarget == EffectState.ApplyEffectParameters.TargetStateObjectRef && AbilityTemplate.Hostility == eHostility_Offensive)
		{
			PlatingEffect = X2Effect_KineticPlating(EffectState.GetX2Effect());
			UnitState = XComGameState_Unit(GameState.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
			if (UnitState != none)
			{
				NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Kinetic Plating Shields");
				UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(UnitState.Class, UnitState.ObjectID));
				UnitState.ModifyCurrentStat(eStat_ShieldHP, PlatingEffect.ShieldPerMiss);
				NewGameState.ModifyStateObject(class'XComGameState_Ability', EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID);
				XComGameStateContext_ChangeContainer(NewGameState.GetContext()).BuildVisualizationFn = EffectState.TriggerAbilityFlyoverVisualizationFn;
				`GAMERULES.SubmitGameState(NewGameState);
			}
		}
	}

	return ELR_NoInterrupt;
}