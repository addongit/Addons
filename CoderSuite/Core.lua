_v = "0.08"
-- [Cores para texto] --
_tAzul = "\124cFF1874CD"
_tPreto = "\124cFF000000"
_tVerde = "\124cFF006400"
_tVermelho = "\124cFFFF0000"
_tCinzaEscuro = "\124cFF1A1A1A"
_tCinzaClaro = "\124cFF999999"
_tMarrom = "\124cFF8B4513"
_tLaranja = "\124cFFFF7F24"
_tBranco = "\124cFFFFFFFF"


-- Criando meu addon como Objeto!
CoderSuite = LibStub("AceAddon-3.0"):NewAddon("CoderSuite", "AceConsole-3.0", "AceEvent-3.0")

function CoderSuite:OnInitialize()
    -- Preciso ver como registrar todos os eventos de uma vez, senão vira palhaçada!
	
	-- Modules\Mail
	CoderSuite:RegisterEvent("MAIL_SHOW", "CreateButtonsEmail")	
	
	-- Modules\Slash
	CoderSuite:RegisterEvent("PLAYER_LOGIN", "RegisterSlash")

	--CoderSuit:RegisterEvent("","")
	
end

function CoderSuite:OnEnable()
    -- Called when the addon is enabled
    CoderSuite:Print(ChatFrame1, "CoderSuite ".._v.." loaded with success !!")
end

function CoderSuite:OnDisable()
    -- Called when the addon is disabled
end	

