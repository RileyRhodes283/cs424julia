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
holderAthletes = []
holderEvents = []
holderTags = []
mutable struct Athlete 
    name::String
    ID::String
    EventList::String
end


#=
Class Name:
=#
mutable struct Event
    name::String
    ID::String 
    AthleteList::String
end
#=
Class Name:

=#
open("register.txt") do line
    counter = 1
    while ! eof(line)
        lines = readline(line)
        if (lines == "")
            counter = counter + 1
            continue
        end
        foo = split(lines,limit = 2)
        ID::String = foo[1]
        name::String  = foo[2]
        if (counter == 1)
            item = Athlete(name, ID, "")
            push!(holderAthletes,item)
        end
        if (counter == 2)
            item = Event(name,ID, "")
            push!(holderEvents,item)
        end
        if (counter == 3)
            push!(holderTags,lines)
        end
        
    end 
end
for x in range(start = 1, stop = length(holderTags), step = 1)
    if x > length(holderTags)
        break;
    end
    found = false 
    foo = split(holderTags[x],limit = 2)
    for y in range(start = 1, stop = length(holderAthletes), step = 1)
        if foo[1] == holderAthletes[y].ID
            found = true
            break;
        else
            found = false
        end
    end
    if found == false 
        what = holderTags[x]
        print("GOODBYE $what\n")
        splice!(holderTags,x)
        print("______ $holderTags\n")
        continue;
    end
    for y in range(start = 1, stop = length(holderEvents), step = 1)
        if foo[2] == holderEvents[y].ID
            found = true
            break;
        else
            found  = false
        end
    end
    if found == false 
        splice!(holderTags,x)
        continue;
    end
end

for x in range(start = 1, stop = length(holderTags), step = 1)
    foo = split(holderTags[x],limit = 2)
    for c in range(start = 1, stop = length(holderAthletes), step = 1)
        if foo[1] == holderAthletes[c].ID
            for b in range(start = 1, stop = length(holderEvents), step = 1)
                if foo[2] == holderEvents[b].ID
                holderAthletes[c].EventList = holderAthletes[c].EventList * holderEvents[b].name * ","
                end
            end
        end
    end
    for c in range(start = 1, stop = length(holderEvents), step = 1)
        if foo[2] == holderEvents[c].ID
            for b in range(start = 1, stop = length(holderAthletes), step = 1)
                if foo[1] == holderAthletes[b].ID
                    holderEvents[c].AthleteList = holderEvents[c].AthleteList * holderAthletes[b].name * ","
            
                end
            end
        end
    end
end

for x in range(start = 1,stop = length(holderAthletes),step = 1)
    y = holderAthletes[x]
    print("Athletes $y\n")
end
for x in range(start = 1,stop = length(holderEvents),step = 1)
    y = holderEvents[x]
    print("Events $y\n")
end