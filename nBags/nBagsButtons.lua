
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

--- BAG FRAME 1 --

for c1 = 1, 16 do
   _G["ContainerFrame1Item"..c1]:SetNormalTexture("") -- Backpack only have 16 slot.
end

for c1i = 1, 16 do
   CreateBorder(_G["ContainerFrame1Item"..c1i], 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
end

--- BAG FRAME 2 --

for c2 = 1, 36 do
   _G["ContainerFrame2Item"..c2]:SetNormalTexture("") -- well, the biggest bag, that exist have 36 slot.
end

for c2i = 1, 36 do
   CreateBorder(_G["ContainerFrame2Item"..c2i], 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
end

--- BAG FRAME 3 --

for c3 = 1, 36 do
   _G["ContainerFrame3Item"..c3]:SetNormalTexture("")
end

for c3i = 1, 36 do
   CreateBorder(_G["ContainerFrame3Item"..c3i], 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
end

--- BAG FRAME 4 --

for c4 = 1, 36 do
   _G["ContainerFrame4Item"..c4]:SetNormalTexture("")
end

for c4i = 1, 36 do
   CreateBorder(_G["ContainerFrame4Item"..c4i], 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
end

--- BAG FRAME 5 --

for c5 = 1, 36 do
   _G["ContainerFrame5Item"..c5]:SetNormalTexture("")
end

for c5i = 1, 36 do
   CreateBorder(_G["ContainerFrame5Item"..c5i], 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
end

--- BAG FRAME 6 (BankSlot)  --

for c6 = 1, 36 do
   _G["ContainerFrame6Item"..c6]:SetNormalTexture("")
end

for c6i = 1, 36 do
   CreateBorder(_G["ContainerFrame6Item"..c6i], 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
end

-- BAG FRAME 7 (BankSlot) --

for c7 = 1, 36 do
   _G["ContainerFrame7Item"..c7]:SetNormalTexture("")
end

for c7i = 1, 36 do
   CreateBorder(_G["ContainerFrame7Item"..c7i], 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
end

-- -- BAG FRAME 8 (BankSlot) -- 

for c8 = 1, 36 do
   _G["ContainerFrame8Item"..c8]:SetNormalTexture("")
end

for c8i = 1, 36 do
   CreateBorder(_G["ContainerFrame8Item"..c8i], 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
end

-- -- BAG FRAME 9 (BankSlot) -- 

for c9 = 1, 36 do
   _G["ContainerFrame9Item"..c9]:SetNormalTexture("")
end

for c9i = 1, 36 do
   CreateBorder(_G["ContainerFrame9Item"..c9i], 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
end

-- -- BAG FRAME 10 (BankSlot) -- 

for c10 = 1, 36 do
   _G["ContainerFrame10Item"..c10]:SetNormalTexture("")
end

for c10i = 1, 36 do
   CreateBorder(_G["ContainerFrame10Item"..c10i], 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
end

-- -- BAG FRAME 11 (BankSlot) -- 

for c11 = 1, 36 do
   _G["ContainerFrame11Item"..c11]:SetNormalTexture("")
end

for c11i = 1, 36 do
   CreateBorder(_G["ContainerFrame11Item"..c11i], 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
end

-- -- BAG FRAME 12 (BankSlot) -- 

for c12 = 1, 36 do
   _G["ContainerFrame12Item"..c12]:SetNormalTexture("")
end

for c12i = 1, 36 do
   CreateBorder(_G["ContainerFrame12Item"..c12i], 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
end

--- BIG BANK FRAME

for b = 1, 28 do
   _G["BankFrameItem"..b]:SetNormalTexture("")
end

for bi = 1, 28 do
   CreateBorder(_G["BankFrameItem"..bi], 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
end

-- BIG BANK FRAME BACKPACKS

for bk = 1, 7 do
   _G["BankFrameBag"..bk]:SetNormalTexture("")
end

for bki = 1, 7 do
   CreateBorder(_G["BankFrameBag"..bki], 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
end