local module = ShaguTweaks:register({
  title = "Reduced Actionbar Size Plus",
  description = "Reduces the actionbar size by removing several items such as the bag panel and microbar",
  expansions = { ["vanilla"] = true, ["tbc"] = nil },
  categpry = nil,
  enabled = nil,
})

module.enable = function(self)
  -- general function to hide textures and frames
  local addonpath = "Interface\\AddOns\\ShaguTweaks"
  local function hide(frame, texture)
    if not frame then return end

    if texture and texture == 1 and frame.SetTexture then
      frame:SetTexture("")
    elseif texture and texture == 2 and frame.SetNormalTexture then
      frame:SetNormalTexture("")
    else
      frame:ClearAllPoints()
      frame.Show = function() return end
      frame:Hide()
    end
  end

  -- frames that shall be hidden
  
  local frames = {
    -- actionbar paging
    MainMenuBarPageNumber, ActionBarUpButton, ActionBarDownButton,
    -- xp and reputation bar
    MainMenuXPBarTexture2, MainMenuXPBarTexture3,
   ReputationWatchBarTexture2, ReputationWatchBarTexture3,
    -- actionbar backgrounds
    MainMenuBarTexture2, MainMenuBarTexture3,
    MainMenuMaxLevelBar2, MainMenuMaxLevelBar3,
    -- micro button panel
    CharacterMicroButton, SpellbookMicroButton, TalentMicroButton,
    QuestLogMicroButton, MainMenuMicroButton, SocialsMicroButton,
    WorldMapMicroButton, MainMenuBarPerformanceBarFrame, HelpMicroButton,
    -- bag panel
    CharacterBag3Slot, CharacterBag2Slot, CharacterBag1Slot,
    CharacterBag0Slot, MainMenuBarBackpackButton, KeyRingButton,
    -- shapeshift backgrounds
    ShapeshiftBarLeft, ShapeshiftBarMiddle, ShapeshiftBarRight,
  }

  -- textures that shall be set empty
  local textures = {
    ReputationWatchBarTexture2, ReputationWatchBarTexture3,
    ReputationXPBarTexture2, ReputationXPBarTexture3,
    SlidingActionBarTexture0, SlidingActionBarTexture1,
  }

  -- button textures that shall be set empty
  local normtextures = {
    ShapeshiftButton1, ShapeshiftButton2,
    ShapeshiftButton3, ShapeshiftButton4,
    ShapeshiftButton5, ShapeshiftButton6,
  }

  -- elements that shall be resized to 511px
  local resizes = {
    MainMenuBar, MainMenuExpBar, MainMenuBarMaxLevelBar,
    ReputationWatchBar, ReputationWatchStatusBar,
  }

  -- hide frames
  for id, frame in pairs(frames) do hide(frame) end
  
  --hide error frames
 
 UIErrorsFrame:Hide();

  -- clear textures
  for id, frame in pairs(textures) do hide(frame, 1) end
  for id, frame in pairs(normtextures) do hide(frame, 2) end

  -- resize actionbar
  for id, frame in pairs(resizes) do frame:SetWidth(511) end

  -- experience bar
  MainMenuXPBarTexture0:SetPoint("LEFT", MainMenuExpBar, "LEFT")
  MainMenuXPBarTexture1:SetPoint("RIGHT", MainMenuExpBar, "RIGHT")

  -- reputation bar
  ReputationWatchBar:SetPoint("BOTTOM", MainMenuExpBar, "TOP", 0, 0)
  ReputationWatchBarTexture0:SetPoint("LEFT", ReputationWatchBar, "LEFT")
  ReputationWatchBarTexture1:SetPoint("RIGHT", ReputationWatchBar, "RIGHT")

  -- move menubar texture background
  BonusActionBarFrame:Show()
  MainMenuBarTexture0:Hide()
  MainMenuBarTexture1:Hide()
  MainMenuMaxLevelBar0:SetPoint("LEFT", MainMenuBarArtFrame, "LEFT")
  MainMenuBarTexture0:SetPoint("LEFT", MainMenuBarArtFrame, "LEFT")
  MainMenuBarTexture1:SetPoint("RIGHT", MainMenuBarArtFrame, "RIGHT")

  -- move gryphon textures
  --MainMenuBarLeftEndCap:SetTexture("Interface\\Addons\\ShaguTweaks\\img\\uiactionbar2x.blp")
  MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBarArtFrame, "LEFT", 30, 0)
  MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBarArtFrame, "RIGHT", -30, 0)

  -- move MultiBarBottomRight ontop of MultiBarBottomLeft
  MultiBarBottomRight:ClearAllPoints()
  MultiBarBottomRight:SetPoint("BOTTOM", MultiBarBottomLeft, "TOP", 0, 5)
  MultiBarBottomLeft:SetFrameStrata("LOW")

  -- reload custom frame positions after original frame manage runs
  local hookUIParent_ManageFramePositions = UIParent_ManageFramePositions
  UIParent_ManageFramePositions = function(a1, a2, a3)
    -- run original function
    hookUIParent_ManageFramePositions(a1, a2, a3)

    -- move bars above xp bar if xp or reputation is tracked
	MainMenuBarLeftEndCap:ClearAllPoints()
	MainMenuBarRightEndCap:ClearAllPoints()
    MainMenuBar:ClearAllPoints()
   if MainMenuExpBar:IsVisible() or ReputationWatchBar:IsVisible() then
	local anchor = GetWatchedFactionInfo() and ReputationWatchBar or MainMenuExpBar
	
	MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 28)
	MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBarArtFrame, "LEFT", 26, 10)
	MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBarArtFrame, "RIGHT", -26, 10)
    else
      MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 13)
	MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBarArtFrame, "LEFT", 26, 25)
	MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBarArtFrame, "RIGHT", -26, 25)
	MainMenuBarMaxLevelBar:SetAlpha(0)
    end


	
	
	MainMenuExpBar:ClearAllPoints()
	MainMenuExpBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 13)
	--ActionButton1:ClearAllPoints()
	--ActionButton1:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 18)
	PetActionBarFrame:Hide()

	--MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 28)
	MultiBarBottomLeft:ClearAllPoints()
	MultiBarBottomLeft:SetPoint("BOTTOM", MainMenuBar, "TOP", 3, -5)
	ReputationWatchStatusBar:ClearAllPoints()
	ReputationWatchStatusBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 13)
	
	BonusActionBarFrame:SetAlpha(0)
	BonusActionButton1:SetAlpha(1)
	BonusActionButton2:SetAlpha(1)
	BonusActionButton3:SetAlpha(1)
	BonusActionButton4:SetAlpha(1)
	BonusActionButton5:SetAlpha(1)
	BonusActionButton6:SetAlpha(1)
	BonusActionButton7:SetAlpha(1)
	BonusActionButton8:SetAlpha(1)
	BonusActionButton9:SetAlpha(1)
	BonusActionButton10:SetAlpha(1)
	BonusActionButton11:SetAlpha(1)
	BonusActionButton12:SetAlpha(1)
	-- MainMenuBarLeftEndCap:ClearAllPoints()
	-- MainMenuBarRightEndCap:ClearAllPoints()
	-- MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBarArtFrame, "LEFT", 30, 20)
	-- MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBarArtFrame, "RIGHT", -30, 20)
	
	
    -- move pet actionbar above other actionbars
    PetActionBarFrame:ClearAllPoints()
    local anchor = MainMenuBarArtFrame
    anchor = MultiBarBottomLeft:IsVisible() and MultiBarBottomLeft or anchor
    anchor = MultiBarBottomRight:IsVisible() and MultiBarBottomRight or anchor
    PetActionBarFrame:SetPoint("BOTTOM", anchor, "TOP", 0, 3)

    -- ShapeshiftBarFrame
    ShapeshiftBarFrame:ClearAllPoints()
    local offset = 0
    local anchor = ActionButton1
    anchor = MultiBarBottomLeft:IsVisible() and MultiBarBottomLeft or anchor
    anchor = MultiBarBottomRight:IsVisible() and MultiBarBottomRight or anchor

    offset = anchor == ActionButton1 and ( MainMenuExpBar:IsVisible() or ReputationWatchBar:IsVisible() ) and 6 or 0
    offset = anchor == ActionButton1 and offset + 6 or offset
    ShapeshiftBarFrame:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 8, 2 + offset)

	--Buffs
	BuffButton0:ClearAllPoints()
    local offset = 0
    local anchor = ActionButton1
    anchor = MultiBarBottomLeft:IsVisible() and MultiBarBottomLeft or anchor
    anchor = MultiBarBottomRight:IsVisible() and MultiBarBottomRight or anchor
	local pet_offset = PetActionBarFrame:IsVisible() and 40 or 0
    offset = anchor == ActionButton1 and ( MainMenuExpBar:IsVisible() or ReputationWatchBar:IsVisible() ) and 6 or 0
    offset = anchor == ActionButton1 and offset + 6 or offset
    BuffButton0:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 453, 4 + pet_offset)
	
	-- add button border
    local _G = ShaguTweaks.GetGlobalEnv()
    local actionBars = {'Action' , 'BonusAction'}
    local f = CreateFrame("Frame", nil, UIParent)
    for k, v in pairs(actionBars) do
        for i = 1, NUM_ACTIONBAR_BUTTONS  do
          local button = _G[v..'Button'..i]
          button.bg = f:CreateTexture()
          button.bg:SetWidth(64)
          button.bg:SetHeight(64)
          button.bg:SetPoint("CENTER", button, "CENTER",0 , 0)  
          button.bg:SetTexture("Interface\\Buttons\\UI-Quickslot2")
          button.bg:SetVertexColor(1, 1, 1, 1)
		  button.bg:SetAlpha(0)
        end
    end
	
	-- add button background
    local _G = ShaguTweaks.GetGlobalEnv()
    local actionBars = {'Action' , 'BonusAction'}
    local f = CreateFrame("Frame", nil, UIParent)
    for k, v in pairs(actionBars) do
        for i = 1, NUM_ACTIONBAR_BUTTONS  do
          local button = _G[v..'Button'..i]
          button.bg = f:CreateTexture()
          button.bg:SetWidth(62)
          button.bg:SetHeight(62)
          button.bg:SetPoint("CENTER", button, "CENTER",11 , -11)  
		  button.bg:SetTexture("Interface\\Addons\\ShaguTweaks-more-mods\\img\\UI-Slot-background")
          button.bg:SetVertexColor(1, 1, 1, 0.35)
		  button.bg:SetAlpha(0)
        end
    end
	

    -- move castbar ontop of other bars
    local anchor = MainMenuBarArtFrame
    anchor = MultiBarBottomLeft:IsVisible() and MultiBarBottomLeft or anchor
    anchor = MultiBarBottomRight:IsVisible() and MultiBarBottomRight or anchor
    local pet_offset = PetActionBarFrame:IsVisible() and 40 or 0
    CastingBarFrame:SetPoint("BOTTOM", anchor, "TOP", 0, 50 + pet_offset)
  end
end
