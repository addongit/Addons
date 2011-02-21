--[[

    CreateBorder(self, borderSize, 1, 1, 1, uL1, uL2, uR1, uR2, bL1, bL2, bR1, bR2)

	bR2 - DOWN
	bL2 - DOWN
	uL1 - <-- 
	bl1 - <--
	uR1 - -->
	bR1 - -->
    uL2 - UPP
	uR2 - UPP

--]]

-- Normal Bags --

for o = 1, 5 do

	ContainerFrame = 'ContainerFrame'..o
	
	_G[ContainerFrame..'CloseButton']:Hide()
	_G[ContainerFrame..'PortraitButton']:Hide()
	

	for p = 1, 5 do
		select(p, _G[ContainerFrame]:GetRegions()):SetAlpha(0)
    end
end

_G["BackpackTokenFrame"]:GetRegions():SetAlpha(0) -- Thanks Sniffles

-- BagFrame 1 --

local ContainerFrame1bg = CreateFrame('Frame', nil, _G['ContainerFrame1'])
ContainerFrame1bg:SetPoint('TOPLEFT', 8, -9)
ContainerFrame1bg:SetPoint('BOTTOMRIGHT', -4, 3)
ContainerFrame1bg:SetBackdrop({
	bgFile = [[Interface\Buttons\WHITE8x8]],
	insets = {top = 29, left = 1, bottom = 1, right = 1}, 
})
ContainerFrame1bg:SetBackdropColor(0, 0, 0, .8)
	
CreateBorder(ContainerFrame1bg, 12, 1, 1, 1, 1, -29, 1, -29, 1, 1, 1, 1)

-- BagFrame 2 --

local ContainerFrame2bg = CreateFrame('Frame', nil, _G['ContainerFrame2'])
ContainerFrame2bg:SetPoint('TOPLEFT', 8, -4)
ContainerFrame2bg:SetPoint('BOTTOMRIGHT', -4, 3)

ContainerFrame2bg:SetBackdrop({
	bgFile = [[Interface\Buttons\WHITE8x8]],
	insets = {top = 16, left = 1, bottom = 1, right = 1}, 
})
ContainerFrame2bg:SetBackdropColor(0, 0, 0, .8)
	
CreateBorder(ContainerFrame2bg, 12, 1, 1, 1, 1, -15, 1, -15, 1, 2, 1, 2)

-- BagFrame 3 --

local ContainerFrame3bg = CreateFrame('Frame', nil, _G['ContainerFrame3'])
ContainerFrame3bg:SetPoint('TOPLEFT', 8, -4)
ContainerFrame3bg:SetPoint('BOTTOMRIGHT', -4, 3)

ContainerFrame3bg:SetBackdrop({
	bgFile = [[Interface\Buttons\WHITE8x8]],
	insets = {top = 17, left = 1, bottom = -1, right = 1}, 
})
ContainerFrame3bg:SetBackdropColor(0, 0, 0, .8)
	
CreateBorder(ContainerFrame3bg, 12, 1, 1, 1, 1, -16, 1, -16, 1, 2, 1, 2)

-- BagFrame 4 --

local ContainerFrame4bg = CreateFrame('Frame', nil, _G['ContainerFrame4'])
ContainerFrame4bg:SetPoint('TOPLEFT', 8, -4)
ContainerFrame4bg:SetPoint('BOTTOMRIGHT', -4, 3)

ContainerFrame4bg:SetBackdrop({
	bgFile = [[Interface\Buttons\WHITE8x8]],
	insets = {top = 17, left = 1, bottom = -1, right = 1}, 
})
ContainerFrame4bg:SetBackdropColor(0, 0, 0, .8)
	
CreateBorder(ContainerFrame4bg, 12, 1, 1, 1, 1, -16, 1, -16, 1, 3, 1, 3)

-- BagFrame 5 --

local ContainerFrame5bg = CreateFrame('Frame', nil, _G['ContainerFrame5'])
ContainerFrame5bg:SetPoint('TOPLEFT', 8, -4)
ContainerFrame5bg:SetPoint('BOTTOMRIGHT', -4, 3)

ContainerFrame5bg:SetBackdrop({
	bgFile = [[Interface\Buttons\WHITE8x8]],
	insets = {top = 17, left = 1, bottom = 1, right = 1}, 
})
ContainerFrame5bg:SetBackdropColor(0, 0, 0, .8)
	
CreateBorder(ContainerFrame5bg, 12, 1, 1, 1, 1, -16, 1, -16, 1, 2, 1, 2)

-- Bank Frames --

for u = 1, 12 do

	BankContainerFrame = 'ContainerFrame'..u
	
	_G[BankContainerFrame..'CloseButton']:Hide()
	_G[BankContainerFrame..'PortraitButton']:Hide()

	for d = 1, 7 do
		select(d, _G[BankContainerFrame]:GetRegions()):SetAlpha(0)
    end
end

-- BankFrame 6

local BankContainerFrame6bg = CreateFrame('Frame', nil, _G['ContainerFrame6'])
BankContainerFrame6bg:SetPoint('TOPLEFT', 8, -4)
BankContainerFrame6bg:SetPoint('BOTTOMRIGHT', -4, 3)

BankContainerFrame6bg:SetBackdrop({
	bgFile = [[Interface\Buttons\WHITE8x8]],
	insets = {top = 17, left = -1, bottom = 1, right = 1}, 
})
BankContainerFrame6bg:SetBackdropColor(0, 0, 0, .7)
	
CreateBorder(BankContainerFrame6bg, 12, 1, 1, 1, 1, -16, 1, -16, 1, 2, 1, 2)

-- BankFrame 7

local BankContainerFrame7bg = CreateFrame('Frame', nil, _G['ContainerFrame7'])
BankContainerFrame7bg:SetPoint('TOPLEFT', 8, -4)
BankContainerFrame7bg:SetPoint('BOTTOMRIGHT', -4, 3)

BankContainerFrame7bg:SetBackdrop({
	bgFile = [[Interface\Buttons\WHITE8x8]],
	insets = {top = 17, left = -1, bottom = 1, right = 1}, 
})
BankContainerFrame7bg:SetBackdropColor(0, 0, 0, .7)
	
CreateBorder(BankContainerFrame7bg, 12, 1, 1, 1, 1, -16, 1, -16, 1, 2, 1, 2)

-- BankFrame 8

local BankContainerFrame8bg = CreateFrame('Frame', nil, _G['ContainerFrame8'])
BankContainerFrame8bg:SetPoint('TOPLEFT', 8, -4)
BankContainerFrame8bg:SetPoint('BOTTOMRIGHT', -4, 3)

BankContainerFrame8bg:SetBackdrop({
	bgFile = [[Interface\Buttons\WHITE8x8]],
	insets = {top = 17, left = -1, bottom = 1, right = 1}, 
})
BankContainerFrame8bg:SetBackdropColor(0, 0, 0, .7)
	
CreateBorder(BankContainerFrame8bg, 12, 1, 1, 1, 1, -16, 1, -16, 1, 2, 1, 2)

-- BankFrame 9

local BankContainerFrame9bg = CreateFrame('Frame', nil, _G['ContainerFrame9'])
BankContainerFrame9bg:SetPoint('TOPLEFT', 8, -4)
BankContainerFrame9bg:SetPoint('BOTTOMRIGHT', -4, 3)

BankContainerFrame9bg:SetBackdrop({
	bgFile = [[Interface\Buttons\WHITE8x8]],
	insets = {top = 17, left = -1, bottom = 1, right = 1}, 
})
BankContainerFrame9bg:SetBackdropColor(0, 0, 0, .7)
	
CreateBorder(BankContainerFrame9bg, 12, 1, 1, 1, 1, -16, 1, -16, 1, 2, 1, 2)

-- BankFrame 10

local BankContainerFrame10bg = CreateFrame('Frame', nil, _G['ContainerFrame10'])
BankContainerFrame10bg:SetPoint('TOPLEFT', 8, -4)
BankContainerFrame10bg:SetPoint('BOTTOMRIGHT', -4, 3)

BankContainerFrame10bg:SetBackdrop({
	bgFile = [[Interface\Buttons\WHITE8x8]],
	insets = {top = 17, left = -1, bottom = 1, right = 1}, 
})
BankContainerFrame10bg:SetBackdropColor(0, 0, 0, .7)
	
CreateBorder(BankContainerFrame10bg, 12, 1, 1, 1, 1, -16, 1, -16, 1, 2, 1, 2)

-- BankFrame 11

local BankContainerFrame11bg = CreateFrame('Frame', nil, _G['ContainerFrame11'])
BankContainerFrame11bg:SetPoint('TOPLEFT', 8, -4)
BankContainerFrame11bg:SetPoint('BOTTOMRIGHT', -4, 3)

BankContainerFrame11bg:SetBackdrop({
	bgFile = [[Interface\Buttons\WHITE8x8]],
	insets = {top = 17, left = -1, bottom = 1, right = 1}, 
})
BankContainerFrame11bg:SetBackdropColor(0, 0, 0, .7)
	
CreateBorder(BankContainerFrame11bg, 12, 1, 1, 1, 1, -16, 1, -16, 1, 2, 1, 2)

-- BankFrame 12 --

local BankContainerFrame12bg = CreateFrame('Frame', nil, _G['ContainerFrame12'])
BankContainerFrame12bg:SetPoint('TOPLEFT', 8, -4)
BankContainerFrame12bg:SetPoint('BOTTOMRIGHT', -4, 3)

BankContainerFrame12bg:SetBackdrop({
	bgFile = [[Interface\Buttons\WHITE8x8]],
	insets = {top = 17, left = -1, bottom = 1, right = 1}, 
})
BankContainerFrame12bg:SetBackdropColor(0, 0, 0, .7)
	
CreateBorder(BankContainerFrame12bg, 12, 1, 1, 1, 1, -16, 1, -16, 1, 2, 1, 2)

-- Big BankFrame --

_G['BankCloseButton']:Hide()
	
local BankFramebg = CreateFrame('Frame', nil, _G['BankFrame'])
BankFramebg:SetPoint('TOPLEFT', 8, -4)
BankFramebg:SetPoint('BOTTOMRIGHT', -4, 3)

BankFramebg:SetBackdrop({
	bgFile = [[Interface\Buttons\WHITE8x8]],
	insets = {top = 35, left = 16, bottom = 75, right = 16}, 
})
BankFramebg:SetBackdropColor(0, 0, 0, .7)
	
CreateBorder(BankFramebg, 12, 1, 1, 1, -15, -30, -15, -30, -15, -75, -15, -75)

for f = 1, 5 do
	select(f, _G['BankFrame']:GetRegions()):SetAlpha(0) 
end