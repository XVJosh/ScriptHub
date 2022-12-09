local RS = game:GetService("ReplicatedStorage")
local Player = game:GetService("Players").LocalPlayer

local Plot = workspace.Plots[Player.Name]
local Blocks = Plot.Blocks

local function merge(name)
    local HRP = Player.Character.PrimaryPart

    local block1 = Blocks[name]
    block1.Name = name .. " - 1"
    local block2 = Blocks[name]
    block2.Name = name .. " - 2"

    HRP.CFrame = block1.CFrame
    wait(0.15)
    local args = {[1] = block1}
    RS.Functions.TakeBlock:FireServer(unpack(args))

    wait(0.15)

    HRP.CFrame = block2.CFrame
end

spawn(
    function()
        while wait() do
            for _, child in pairs(Blocks:GetChildren()) do
                child.Name = child.Front.Number.Text
            end

            local BlocksTable = {}
            for _, child in pairs(Blocks:GetChildren()) do
                if table.find(BlocksTable, child.Name) then
                    merge(child.Name)
                    break
                end
                table.insert(BlocksTable, child.Name)
            end
        end
    end
)