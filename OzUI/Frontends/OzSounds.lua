if (not OzUIConfig.OzSounds.enabled) then
	return
end

OzSounds = {}

function OzSounds:Init()
	self.containers = {}
	self.defaultSound = "Interface\\AddOns\\DXE\\Sounds\\NeoBeep.mp3"
end

function OzSounds:Hide(containerName,id)
	self.containers[containerName].sounds[id] = expire
end

function OzSounds:Create(containerName,id,resource,iconName,stacks,duration,expire,arg)
	if (not self.containers[containerName]) then
		self.containers[containerName] = {sounds = {}}
	end
	if (not self.containers[containerName].sounds[id]) then
		-- first time
		if (arg) then
			PlaySoundFile(arg)
		else
			PlaySoundFile(self.defaultSound)
		end
		self.containers[containerName].sounds[id] = expire
	elseif math.abs(self.containers[containerName].sounds[id] - expire) > 1 then
		-- replay sound
		self.containers[containerName].sounds[id] = expire
		if (arg) then
			PlaySoundFile(arg)
		else
			PlaySoundFile(self.defaultSound)
		end
	end
end

OzSounds:Init()


