class X2EventListener_KineticPlating extends X2EventListener;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(KineticPlating());

	return Templates;
}

static protected function X2EventListenerTemplate KineticPlating()
{
	local X2EventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'X2TraitTemplate', Template, 'Fear_KineticPlating_Listener');

	Template.AddEvent('AbilityActivated', OnAbilityActivated_Fear_KineticPlating_Listener);

	return Template;
}

static protected function EventListenerReturn OnAbilityActivated_Fear_KineticPlating_Listener(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	local XComGameStateContext_Ability AbilityContext;
	local X2AbilityTemplate AbilityTemplate;
	local XComGameState NewGameState;
	local XComGameState_Unit UnitState;
	local X2Effect_KineticPlating PlatingEffect;
	local XComGameState_Effect EffectState;
	
	

	AbilityContext = XComGameStateContext_Ability(GameState.GetContext());
	
	`LOG("Running for ability:" @ AbilityContext.InputContext.AbilityTemplateName @ "not interrupt:" @ AbilityContext.InterruptionStatus != eInterruptionStatus_Interrupt @ "is miss:" @ AbilityContext.IsResultContextMiss(),, 'KineticPlating');
	
	if (AbilityContext != none && AbilityContext.InterruptionStatus != eInterruptionStatus_Interrupt && AbilityContext.IsResultContextMiss())
	{
		AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate(AbilityContext.InputContext.AbilityTemplateName);
		
		`LOG("Have ability template:" @ AbilityTemplate != none,, 'KineticPlating');
		
		if (AbilityTemplate == none || X2AbilityToHitCalc_StatCheck_UnitVsUnit(AbilityTemplate.AbilityToHitCalc) != none)
		{
			`LOG("Ability blocked:" @ AbilityTemplate.DataName @ AbilityTemplate.LocFriendlyName,, 'KineticPlating');
			return ELR_NoInterrupt;
		}
		else
		{
			`LOG("Ability allowed:" @ AbilityTemplate.DataName @ AbilityTemplate.LocFriendlyName,, 'KineticPlating');
		}

		UnitState = XComGameState_Unit(GameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
		if (UnitState == none)
			return ELR_NoInterrupt;
		
		`LOG("Have unit state:" @ UnitState.GetMyTemplateName(),, 'KineticPlating');
		
		if (!UnitState.IsFriendlyToLocalPlayer())
		{
			`LOG("Unit not friendly to local player",, 'KineticPlating');
			return ELR_NoInterrupt;
		}
		
		EffectState = UnitState.GetUnitAffectedByEffectState('ChosenKineticPlating');
		if (EffectState == none)
		{
			`LOG("No effect state on unit",, 'KineticPlating');
			return ELR_NoInterrupt;
		}
		
		PlatingEffect = X2Effect_KineticPlating(EffectState.GetX2Effect());
		if (PlatingEffect == none)
		{
			`LOG("No effect template",, 'KineticPlating');
			return ELR_NoInterrupt;
		}

		if (AbilityTemplate.Hostility == eHostility_Offensive)
		{
			`LOG("Activating kinetic plating",, 'KineticPlating');
			
			NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Kinetic Plating Shields");
			UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(UnitState.Class, UnitState.ObjectID));
			UnitState.ModifyCurrentStat(eStat_ShieldHP, PlatingEffect.ShieldPerMiss);
			NewGameState.ModifyStateObject(class'XComGameState_Ability', EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID);
			XComGameStateContext_ChangeContainer(NewGameState.GetContext()).BuildVisualizationFn = EffectState.TriggerAbilityFlyoverVisualizationFn;
			`GAMERULES.SubmitGameState(NewGameState);			
		}
	}
	`LOG("Reached EOL",, 'KineticPlating');
	return ELR_NoInterrupt;
}