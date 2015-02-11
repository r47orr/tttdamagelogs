if SERVER then
	Damagelog:EventHook("TTTBodyFound")
else
	Damagelog:AddFilter("Show Found Bodies", DAMAGELOG_FILTER_BOOL, true)
	Damagelog:AddColor("TTTBodyFound", Color(127,0,255))
end

local event = {}

event.Type = "BODY"

function event:TTTBodyFound(ply, deadply, rag)
	print( (IsValid(deadply) and deadply:Nick() or CORPSE.GetPlayerNick(rag, "<Disconnected Player>")) )
	self.CallEvent({
		[1] = (IsValid(ply) and ply:Nick() or "<Disconnected Player>"),
		[2] = (IsValid(ply) and ply:GetRole() or "disconnected"),
		[3] = (IsValid(ply) and ply:SteamID() or "<Disconnected Player>"),
		[4] = (IsValid(deadply) and deadply:Nick() or CORPSE.GetPlayerNick(rag, "<Disconnected Player>")),
		[5] = (IsValid(deadply) and deadply:GetRole() or "disconnected"),
		[6] = (IsValid(deadply) and deadply:SteamID() or "<Disconnected Player>")
	})
end

function event:ToString(v)
	return string.format("%s [%s] identified the body of %s [%s].", v[1], Damagelog:StrRole(v[2]), v[4], Damagelog:StrRole(v[5]))
end

function event:IsAllowed(tbl)
	return Damagelog.filter_settings["Show Found Bodies"]
end

function event:Highlight(line, tbl, text)
	if table.HasValue(Damagelog.Highlighted, tbl[1]) or table.HasValue(Damagelog.Highlighted, tbl[4]) then
		return true
	end
	return false
end

function event:GetColor(tbl)
	return Damagelog:GetColor("TTTBodyFound")
end

function event:RightClick(line, tbl, text)
	line:ShowTooLong(true)
	line:ShowCopy(true, { tbl[1], tbl[3] })
end

Damagelog:AddEvent(event)