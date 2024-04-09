#=
File Name: Julia-Rhodes.jl
Author: Riley Rhodes
Description:
Professor: Dr. Delugach 
Use Instructions: 
=#

#=
Class Name:
=#
holder = []
struct Athlete 
    name::String
    ID::String
end


#=
Class Name:
=#
struct Event
    name::String
    ID::String 
end
#=
Class Name:

=#
#function Hi()
    #print(open(io->read(io, String), "register.txt"))

    open("register.txt") do line
        while ! eof(line)
        lines = readline(line)
        if (lines == "")
            continue
        end
        foo = split(lines,limit = 2)
        #print("$foo\n")
        ID::String = foo[1]
        name::String  = foo[2]
        print("ID = $ID\n")
        print("Name = $name\n")
        item = Athlete(ID,name)
        print("$item\n")
        #holder + item
        
        end 
    end

    #print("Holder = $holder\n")
#end
#Hi()