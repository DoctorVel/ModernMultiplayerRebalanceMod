class X2Ability_StoneSkin extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(CreateStoneSkin());
	Templates.AddItem(PurePassive('StoneSkinPassive', "img:///UILibrary_PerkIcons.UIPerk_ironskin", false, 'eAbilitySource_Perk', true));

	return Templates;
}

static function X2DataTemplate CreateStoneSkin()
{
	local X2AbilityTemplate Template;
	local X2Effect_ConditionalDamageModifier DamageEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'StoneSkin');

	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_ironskin";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDontDisplayInAbilitySummary = true;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);


	DamageEffect = new class'X2Effect_ConditionalDamageModifier';
	DamageEffect.bModifyIncomingDamage = true;
	DamageEffect.DamageBonus = -1;
	DamageEffect.BuildPersistentEffect(1, true);
	DamageEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), "img:///UILibrary_PerkIcons.UIPerk_ironskin", true);
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
    Template.bShowActivation = false;
    Template.bSkipFireAction = false;
	Template.AddTargetEffect(DamageEffect);

	Template.AdditionalAbilities.AddItem('StoneSkinPassive');
	return Template;
}