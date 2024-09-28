--[[
file library fully simulated in luau
no this wont work outside of roblox
no this wont 'save' your data 

ONCE YOU LEAVE THE ROBLOX GAME ALL DATA IS LOST I HOPE YOU KNOW 
]]

local filesystem = { -- we store data here
    root = {
        files = {},
        folders = {}
    }
}

function readfile(file_path) --read the file
    local file = filesystem.root.files[file_path]
    if file then
        return file
    end
    error("didnt find" .. file_path)
end

function listfiles(folder_path) --need to fix
    local list = {}
    for name in pairs(filesystem.root.files) do
        table.insert(list, name)
    end
    for name in pairs(filesystem.root.folders) do
        table.insert(list, name)
    end
    return list
end

function writefile(file_path, data) --writefile todo: add if file exists already
    filesystem.root.files[file_path] = data
end

function makefolder(folder_path) --create a folder
    if not filesystem.root.folders[folder_path] then
        filesystem.root.folders[folder_path] = {}
    end
end

function appendfile(file_path, data) -- apend to file
    local current_data = readfile(file_path)
    writefile(file_path, current_data .. data)
end

function isfile(file_path) -- broken needs fixing
    return filesystem.root.files[file_path] ~= nil
end

function isfolder(folder_path) -- kinda broken needs dixing
    return filesystem.root.folders[folder_path] ~= nil
end

function delfile(file_path)
    filesystem.root.files[file_path] = nil
end

function delfolder(folder_path)
    filesystem.root.folders[folder_path] = nil
end

function loadfile(file_path)
    local file = readfile(file_path)
    local chunk, err = loadstring(file) -- neseds loadstring; i suggest finding a luavm loadstring (fione rerubi luauinluau or whatever)
    return chunk, err
end

function dofile(file_path)
    local chunk, err = loadfile(file_path)
    if chunk then
        chunk()
    else
        error(err)
    end
end
