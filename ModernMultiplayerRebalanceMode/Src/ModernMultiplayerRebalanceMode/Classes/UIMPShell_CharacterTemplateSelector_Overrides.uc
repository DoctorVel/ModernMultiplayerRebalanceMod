class UIMPShell_CharacterTemplateSelector_Overrides extends UIMPShell_CharacterTemplateSelector;

simulated function PopulateData() {

    local int i;
	local array<name> arrNames;
	local X2MPCharacterTemplate MPCharTemplate;
	local X2MPCharacterTemplateManager MPCharTemplateManager;
	local X2CharacterTemplate CharTemplate;
	local X2CharacterTemplateManager CharTemplateManager;
	local X2SoldierClassTemplateManager SoldierClassManager;
	local UIInventory_ListItem kListItem;
	local string strDisplayText;
	List.ItemPadding = 0;

	MPCharTemplateManager = class'X2MPCharacterTemplateManager'.static.GetMPCharacterTemplateManager();
	MPCharTemplateManager.GetTemplateNames(arrNames);
	CharTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
	SoldierClassManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();

	for (i = 0; i < arrNames.Length; ++i)
	{
		MPCharTemplate = MPCharTemplateManager.FindMPCharacterTemplate(arrNames[i]);
		if(MPCharTemplate == none)
			continue;

		if(i == 0)
			SelectCharacterTemplate(MPCharTemplate);

		strDisplayText = "";
		
		CharTemplate = CharTemplateManager.FindCharacterTemplate(MPCharTemplate.CharacterTemplateName);

		if(CharTemplate != none)
		{
			if(CharTemplate.DataName == 'Soldier' && MPCharTemplate.DataName != 'PsiOperative')
			{
				strDisplayText $= SoldierClassManager.FindSoldierClassTemplate(MPCharTemplate.SoldierClassTemplateName).DisplayName $ m_strSoldierClassDivider;
			}
			else if(CharTemplate.bIsAdvent)
			{
				strDisplayText $= m_strAdventPrefix;
			}
		}

		strDisplayText $= MPCharTemplate.DisplayName;
	
		kListItem = UIInventory_ListItem(List.CreateItem(class'UIInventory_ListItem'));
		kListItem.InitListItem(strDisplayText);
		kListItem.SetDisabled(MPCharTemplate.Cost > m_MaxPoints);
		kListItem.UpdateQuantity(MPCharTemplate.Cost);
		kListItem.SetConfirmButtonStyle(eUIConfirmButtonStyle_Default, class'UIMPShell_SquadUnitInfoItem'.default.m_strAddUnitText, 0, , AcceptUnit);
		kListItem.metadataObject = MPCharTemplate;
		
	if (MPCharTemplate.DataName == 'Sectoid' && GetNumCharsInSquad(MPCharTemplate.DataName) > 2)
     {
  kListItem.SetDisabled(true);
  }
  if (MPCharTemplate.DataName == 'AdvShieldbearer' && GetNumCharsInSquad(MPCharTemplate.DataName) > 2)
     {
  kListItem.SetDisabled(true);
  }
  if (MPCharTemplate.DataName == 'AdvMEC' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
  }
  if (MPCharTemplate.DataName == 'AdvMEC_M2_MP' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
  }
  if (MPCharTemplate.DataName == 'Muton' && GetNumCharsInSquad(MPCharTemplate.DataName) > 2)
     {
  kListItem.SetDisabled(true);
  }
  if (MPCharTemplate.DataName == 'AdvGeneralMP' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
  }
  if (MPCharTemplate.DataName == 'AdvPsiWitchMP' && GetNumCharsInSquad(MPCharTemplate.DataName) > 0)
     {
  kListItem.SetDisabled(true);
  }
  if (MPCharTemplate.DataName == 'Codex' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
  }
  if (MPCharTemplate.DataName == 'Berserker' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
  }
  if (MPCharTemplate.DataName == 'Archon' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
  }
  if (MPCharTemplate.DataName == 'Andromedon' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
  }
  if (MPCharTemplate.DataName == 'Sectopod' && GetNumCharsInSquad(MPCharTemplate.DataName) > 0)
     {
  kListItem.SetDisabled(true);
  }
  if (MPCharTemplate.DataName == 'Gatekeeper' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'Spectre' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'PhantomRanger' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'BlademasterRanger' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'SniperSharpshooter' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'GunslingerSharpshooter' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'HeavyGunnerGrenadier' && GetNumCharsInSquad(MPCharTemplate.DataName) > 0)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'DemoExpertGrenadier' && GetNumCharsInSquad(MPCharTemplate.DataName) > 0)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'BattlefieldMedicSpecialist' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'CombatHackerSpecialist' && GetNumCharsInSquad(MPCharTemplate.DataName) > 0)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'PsiOperative' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'Reaper' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'Skirmisher' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'Templar' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'ChosenAssassinMP'  && GetNumCharsInSquad(MPCharTemplate.DataName) > 0)
     {
  kListItem.SetDisabled(true);
     }
if (MPCharTemplate.DataName == 'ChosenWarlockMP' && GetNumCharsInSquad(MPCharTemplate.DataName) > 0)
     {
  kListItem.SetDisabled(true);
     }
  if (MPCharTemplate.DataName == 'ChosenSniperMP' && GetNumCharsInSquad(MPCharTemplate.DataName) > 0)
     {
  kListItem.SetDisabled(true);
     }
	  if (MPCharTemplate.DataName == 'ViperKingMP' && GetNumCharsInSquad(MPCharTemplate.DataName) > 0)
     {
  kListItem.SetDisabled(true);
     }
	  if (MPCharTemplate.DataName == 'ViperNeonateMP' && GetNumCharsInSquad(MPCharTemplate.DataName) > 1)
     {
  kListItem.SetDisabled(true);
     }
	 if (MPCharTemplate.DataName == 'ArchonKingMP' && GetNumCharsInSquad(MPCharTemplate.DataName) > 0)
     {
  kListItem.SetDisabled(true);
     }
}	 
}
private function int GetNumCharsInSquad(const name CheckName)
{
    local UIMPShell_SquadEditor SquadEditor;
    local XComGameState_Unit UnitState;
    local int NumChars;

    SquadEditor = UIMPShell_SquadEditor(`SCREENSTACK.GetFirstInstanceOf(class'UIMPShell_SquadEditor'));
    if (SquadEditor == none)
        return INDEX_NONE;

    foreach SquadEditor.m_kSquadLoadout.IterateByClassType(class'XComGameState_Unit', UnitState)
    {
        if (UnitState.GetMyTemplateName() == CheckName || UnitState.GetSoldierClassTemplateName() == CheckName)
        {
            NumChars++;
        }
    }
    return NumChars;
}	  