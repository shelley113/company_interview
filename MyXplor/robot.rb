#!/usr/bin/ruby

class Robot

    attr_accessor :positionX
    attr_accessor :positionY
    attr_accessor :direction

    def display_information
        puts "#{@positionX},#{@positionY},#{@direction}"
    end

    def validation
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
        robotInformation = lines[0].delete("\n")
        initial = robotInformation[6,robotInformation.length].split(",")
        
        @positionX = initial[0].to_i
        @positionY = initial[1].to_i
        @direction = initial[2]

        for commond in lines do
            case commond.delete("\n")
            when "MOVE"
              validation
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

robot = Robot. new
robot.start("data.rb")

