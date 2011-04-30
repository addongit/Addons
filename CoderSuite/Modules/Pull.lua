SLASH_pull1 = "/pull";
function SlashCmdList.pull(command)
	if tonumber(command) ~= nil then
		local f,c=CnD or CreateFrame("Frame","CnD");
		SendChatMessage("Pull in " .. command .. " sec", "RAID_WARNING");
		f.e, f.t = command-1;
		f.w = math.floor(command * 0.75);
		f:SetScript("OnUpdate",
			function(s,e) 
				f.e=f.e-e;
				c=ceil(f.e);
				if c~=f.t then 
					f.t=c;
					if f.t < 15 and f.t >= 0 and f.t == f.w then
						f.w = math.floor(c * 0.75);
						SendChatMessage(f.t > 0 and f.t or "PULL !!!", "RAID_WARNING");
					end;
					if f.t==0 then 
						f:Hide();
					end;
				end;
			end);
		f:Show();
	end;
end;


 