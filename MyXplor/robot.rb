#!/usr/bin/ruby

class Robot

    attr_accessor :positionX
    attr_accessor :positionY
    attr_accessor :direction

    def display_information
        puts "#{@positionX},#{@positionY},#{@direction}"
    end

    def validation
        if @positionX != nil && @positionY != nil
            return true
        else
            return false
        end

    end

    def operation
        case @direction
        when "NORTH"
            if @positionY != 4
                @positionY = @positionY + 1
            end
        when "SOUTH"
            if @positionY != 0
                @positionY = @positionY - 1
            end  
        when "EAST"
            if @positionX != 4
                @positionX = @positionX + 1
            end
        when "WEST"
            if @positionX != 0
                @positionX = @positionX - 1
            end    
        end
    end

    def turnLeft
        case @direction
        when "NORTH"
            @direction = "WEST"
        when "SOUTH"
            @direction = "EAST" 
        when "EAST"
            @direction = "NORTH"
        when "WEST"
            @direction = "SOUTH"   
        end
    end

    def turnRight
        case @direction
        when "NORTH"
            @direction = "EAST"
        when "SOUTH"
            @direction = "WEST" 
        when "EAST"
            @direction = "SOUTH"
        when "WEST"
            @direction = "NORTH"   
        end
    end

    def start(fileName)
        lines = File.readlines(fileName)
        for commond in lines do
            if commond[0,5] == "PLACE"
                if commond[6,7].to_i >= 0 && commond[6,7].to_i <= 4 && commond[8,9].to_i >=0 && commond[8,9].to_i <= 4
                    @positionX = commond[6,7].to_i
                    @positionY = commond[8,9].to_i
                    @direction = commond[10,commond.length].delete("\n")
                end
            else
                if validation 
                    case commond.delete("\n")
                    when "MOVE"
                         operation
                    when "LEFT"
                         turnLeft
                    when "RIGHT"
                         turnRight
                    when "REPORT"
                         display_information
                    else
                         "Ignore"
                    end
                end
            end
        end

    end
    
end

robot = Robot. new
robot.start("data.rb")

