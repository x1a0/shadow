Shadow = CreateFrame("Frame")
Shadow.frames = {}
Shadow:RegisterEvent("ADDON_LOADED")
Shadow:RegisterEvent("PLAYER_LOGIN")
Shadow:RegisterEvent("UPDATE_BONUS_ACTIONBAR")

function Shadow:Debug(msg)
  DEFAULT_CHAT_FRAME:AddMessage("[Shadow] " .. msg)
end

function Shadow:OnEvent()
  if event == "ADDON_LOADED" and arg1 == "Shadow" then
    if Shadow_Opacity == nil then
      Shadow_Opacity = 1
    end

    DEFAULT_CHAT_FRAME:AddMessage("Shadow loaded!")

  elseif event == "PLAYER_LOGIN" then
    local w = GetScreenWidth()
    local h = GetScreenHeight()

    local overlay = CreateFrame("Frame", nil, UIParent)
    overlay:SetFrameStrata("Background")
    overlay:SetWidth(w)
    overlay:SetHeight(h)

    local bg = overlay:CreateTexture(nil, "BACKGROUND")
    bg:SetTexture("Interface\\AddOns\\Shadow\\media\\overlay.tga")
    bg:SetAllPoints(overlay)
    overlay.texture = bg

    overlay:SetPoint("TOPLEFT", 0, 0)
    overlay:SetAlpha(Shadow_Opacity)

    -- send to global
    Shadow.overlay = overlay
    Shadow.overlay:Hide()

  elseif event == "UPDATE_BONUS_ACTIONBAR" then
    local icon, name, active, castable = GetShapeshiftFormInfo(1)
    if (name == "Stealth" and active) then
      Shadow.overlay:Show()
    else
      Shadow.overlay:Hide()
    end
  end
end

Shadow:SetScript("OnEvent", Shadow.OnEvent)

SLASH_SHADOW1 = '/shadow'
function SlashCmdList.SHADOW(msg, editbox)
  Shadow_Opacity = tonumber(msg)
  Shadow.overlay:SetAlpha(Shadow_Opacity)
end
