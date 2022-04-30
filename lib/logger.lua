function Logger()
    return setmetatable({
        ticks=0,
        Type="logger"
    },{
        __index={
            log = function (self,txt)
                print("["..self.ticks.."] "..txt)
            end,
            tick = function(self)
                self.ticks = self.ticks + 1
            end
        }
    })
end