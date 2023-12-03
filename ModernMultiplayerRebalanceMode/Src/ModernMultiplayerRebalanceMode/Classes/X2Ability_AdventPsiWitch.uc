class X2Ability_AdventPsiWitch extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(Parry());

	return Templates;
}

static function X2AbilityTemplate Parry()
{
    local X2AbilityTemplate Template;
    local X2Effect_EtheralGhost Effect;

    `CREATE_X2ABILITY_TEMPLATE(Template, 'Parry');

    Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
        Template.bDisplayInUITacticalText = false;
        Template.bDisplayInUITooltip = false;
        Template.bDontDisplayInAbilitySummary = true;
        Template.bHideOnClassUnlock = true;

    Template.AbilityToHitCalc = default.DeadEye;
    Template.AbilityTargetStyle = default.SelfTarget;
    Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

    Effect = new class'X2Effect_EtheralGhost';
    Effect.BuildPersistentEffect(1, true);
    Template.AddTargetEffect(Effect);

        Template.Hostility = eHostility_Neutral;
    Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
    Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.bSkipFireAction = true;

    return Template;
}