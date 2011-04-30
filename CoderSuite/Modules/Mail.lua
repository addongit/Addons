-- Data: 20.01.2011
-- Sobre: Tudo relacionado a caixa de email será realizado aqui.


--------------------------------------
-- FUNÇÃO - Encaminhar EMAIL
--------------------------------------
local function Mail_FF()	
	local sub = "FF: ";	local body = "\n\nAtt: "..UnitName("player");
	if OpenMailBodyText:GetText() then
		sub = sub..string.sub(OpenMailBodyText:GetText(), 0, 30)
		body = OpenMailBodyText:GetText().."\n\nAtt: "..UnitName("player")
	end
	
	MailFrameTab_OnClick(MailFrame, 2);
	SendMailNameEditBox:SetText(""); -- Limpa o destinatario
	SendMailNameEditBox:SetFocus(); -- Foco no campo do destinatario
	SendMailSubjectEditBox:SetText(sub); -- Pega um pedaço do corpo do texto a ser encaminhado e bota no assunto, pqp eu sou foda! ahushasu
	SendMailBodyEditBox:SetText(body);	-- Insere uma assinatura no final do email do tipo: Att NomeDoChar
end

--------------------------------------
-- FUNÇÃO - Copiar EMAIL
--------------------------------------
local function Mail_Copy()
	local body = ""
	
	if OpenMailBodyText:GetText() then		
		body = OpenMailBodyText:GetText()
	end
	
	MailFrameTab_OnClick(MailFrame, 2);
	SendMailNameEditBox:SetText((UnitName("player"))); -- Nome do destinario = seu mesmo para nao enviar por engano
	SendMailSubjectEditBox:SetText("Ctrl+C to copy"); -- Texto instrutivo no assunto	
	SendMailBodyEditBox:SetText(body); -- Corpo do email a ser copiado
	SendMailBodyEditBox:HighlightText(); -- Seleciona todo o texto
	SendMailBodyEditBox:SetFocus(); -- Focus no texto
end


---------------------------------------
-- TELA - Cria os botões
---------------------------------------
function CoderSuite:CreateButtonsEmail()
	-- Forward
	local _ffbutton = CreateFrame("Button", "OpenMailFFButton", OpenMailFrame, "UIPanelButtonTemplate")

	_ffbutton:SetText("Forward")
	_ffbutton:SetWidth(82)
	_ffbutton:SetHeight(22)
	_ffbutton:SetPoint("RIGHT","OpenMailCloseButton","LEFT",0,2)
	_ffbutton:SetScript("OnClick",Mail_FF)
	
	-- Copy
	local _copybutton = CreateFrame("Button", "OpenMailCopyButton", OpenMailFrame, "UIPanelButtonTemplate")
	_copybutton:SetText("Copy")
	_copybutton:SetWidth(82)
	_copybutton:SetHeight(22)
	_copybutton:SetPoint("RIGHT","OpenMailReplyButton","LEFT",0,0)
	_copybutton:SetScript("OnClick",Mail_Copy)
	
	if _ffbutton or _copybutton then 
		CoderSuite:UnregisterEvent("MAIL_SHOW");
	end
end


