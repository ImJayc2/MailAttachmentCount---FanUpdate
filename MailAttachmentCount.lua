-- -------------------------------------------------------------------------- --
-- MailAttachmentCount by kunda                                               --
-- -------------------------------------------------------------------------- --

local GVAR = {}
GVAR.OverlayBox = {}

for i=1, INBOXITEMS_TO_DISPLAY do
	local parent = _G["MailItem"..i.."Button"]
	GVAR.OverlayBox[i] = CreateFrame("Frame", nil, parent, BackdropTemplateMixin and "BackdropTemplate")
	GVAR.OverlayBox[i]:SetFrameStrata("HIGH")
	GVAR.OverlayBox[i]:SetPoint("TOPLEFT", parent)
	GVAR.OverlayBox[i]:SetWidth(37)
	GVAR.OverlayBox[i]:SetHeight(37)
	GVAR.OverlayBox[i].Txt = GVAR.OverlayBox[i]:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
	GVAR.OverlayBox[i].Txt:SetPoint("BOTTOMRIGHT", GVAR.OverlayBox[i], "BOTTOMRIGHT", -5, 2)
end

hooksecurefunc("InboxFrame_Update", function()
	for i=1, INBOXITEMS_TO_DISPLAY do
		local index = _G["MailItem"..i.."Button"].index
		if not index then return end
		local attachments = 0
		for j=1, ATTACHMENTS_MAX_RECEIVE do
			if GetInboxItem(index, j) then
				attachments = attachments + 1
			end
		end
		if attachments > 1 then
			GVAR.OverlayBox[i].Txt:SetText("#"..attachments)
			GVAR.OverlayBox[i]:Show()
		else
			GVAR.OverlayBox[i]:Hide()
		end
	end
end)