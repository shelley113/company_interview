#!/usr/bin/ruby

# Accept commond from file
class Input

    def initialize()
        @validation = Validation.new
        @robot = Robot.new
        @operation = Operation.new(@robot)
    end

    def startToMove(fileName)
        lines = File.readlines(fileName)
        for commond in lines do
            commonds = commond.split(" ")

            if commonds[0] == "PLACE"
                robotInformation = commonds[1].split(",")
                if robotInformation[0].to_i >= 0 && robotInformation[0].to_i <= 4 && robotInformation[1].to_i >=0 && robotInformation[1].to_i <= 4
                    @robot.positionX = robotInformation[0].to_i
                    @robot.positionY = robotInformation[1].to_i
                    @robot.direction = robotInformation[2]
                end
            else
                if @validation.checkValid(@robot.positionX,@robot.positionY) 
                    case commond.delete("\n")
                    when "MOVE"
                         @operation.operation
                    when "LEFT"
                         @operation.turnLeft
                    when "RIGHT"
                        @operation.turnRight
                    when "REPORT"
                         @robot.display_information
                    else
                         #Ignore
                    end
                end
            end
        end

    end
end

# check if the robot position is valid
class Validation
    def checkValid(x,y)
        if x != nil && y != nil
            return true
        else
            return false
        end

    end
end

# robot movement
class Operation

    def initialize(robot)
        @robot = robot
    end

    def operation
        case @robot.direction
        when "NORTH"
            if @robot.positionY != 4
                @robot.positionY = @robot.positionY + 1
            end
        when "SOUTH"
            if @robot.positionY != 0
                @robot.positionY = @robot.positionY - 1
            end  
        when "EAST"
            if @robot.positionX != 4
                @robot.positionX = @robot.positionX + 1
            end
        when "WEST"
            if @robot.positionX != 0
                @robot.positionX = @robot.positionX - 1
            end    
        end
    end

    def turnLeft
        case @robot.direction
        when "NORTH"
            @robot.direction = "WEST"
        when "SOUTH"
            @robot.direction = "EAST" 
        when "EAST"
            @robot.direction = "NORTH"
        when "WEST"
            @robot.direction = "SOUTH"   
        end
    end

    def turnRight
        case @robot.direction
        when "NORTH"
            @robot.direction = "EAST"
        when "SOUTH"
            @robot.direction = "WEST" 
        when "EAST"
            @robot.direction = "SOUTH"
        when "WEST"
            @robot.direction = "NORTH"   
        end
    end
end

# robot information
class Robot

    attr_accessor :positionX
    attr_accessor :positionY
    attr_accessor :direction

    def display_information
        puts "#{@positionX},#{@positionY},#{@direction}"
    end
    
end


input = Input.new()
input.startToMove("data.rb")

