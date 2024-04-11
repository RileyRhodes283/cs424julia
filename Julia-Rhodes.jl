#=
File Name: Julia-Rhodes.jl
Author: Riley Rhodes
Description: This program is an athelete to event manager
that accepts file register.txt in same folder which holds three blocks 
each seperated by one space. Each block holds a significant piece of data: athletes, events, athletes to event tags, respectively. 
Professor: Dr. Delugach 
Use Instructions: Open file path in terminal and use julia Julia-Rhodes.jl to run 
Design: Two data types Athlete and Events which are used in the main execution of the program 
to hold data. 
=#

#=
Type Name: Athlete
Data: 3 Strings 
name -> is athletes name
ID -> is a string version of the number ID 
AthleteList -> string to hold events that the athletes are present 
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
Type Name: Event
Data: 3 Strings 
name -> is events name
ID -> is a string version of the number ID 
AthleteList -> string to hold athletes present at events 
=#
mutable struct Event
    name::String
    ID::String 
    AthleteList::String
end

open("register.txt") do line
    counter = 1 # set up counter also mirrored the 1 based indexs 
    while ! eof(line) # while file has lines to read, the code should read them
        lines = readline(line)
        if (lines == "") # if line is empty increment counter and skip this loop
            counter = counter + 1
            continue
        end
        foo = split(lines,limit = 2) # temp variable to hold split line
        ID::String = foo[1] # temp variable names to not get confused with what im declaring in my type 
        name::String  = foo[2]
        if (counter == 1)
            item = Athlete(name, ID, "")
            push!(holderAthletes,item) # if in first block its an athlete push to proper array 
        end
        if (counter == 2)
            item = Event(name,ID, "")
            push!(holderEvents,item) # if in second block its an event place in proper array
        end
        if (counter == 3) # if in third block push onto array holdertags
            push!(holderTags,lines)
        end
        
    end 
end
for x in range(start = 1, stop = length(holderTags), step = 1) #loop through tags to validate
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
        temp = holderTags[x]
        print("This is what wasn't found: $temp\n")
        splice!(holderTags,x)
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
        temp = holderTags[x]
        print("This is what wasn't found: $temp\n")
        splice!(holderTags,x)
        continue;
    end
end

for x in range(start = 1, stop = length(holderTags), step = 1)
    foo = split(holderTags[x],limit = 2) # temp variable that splits the tags for athletes to events 
    for c in range(start = 1, stop = length(holderAthletes), step = 1) # loop through athletes and tag events 
        if foo[1] == holderAthletes[c].ID
            for b in range(start = 1, stop = length(holderEvents), step = 1)
                if foo[2] == holderEvents[b].ID 
                holderAthletes[c].EventList = holderAthletes[c].EventList * holderEvents[b].name * ",  "
                end
            end
        end
    end
    for c in range(start = 1, stop = length(holderEvents), step = 1) # loop through events and tag athletes. 
        if foo[2] == holderEvents[c].ID
            for b in range(start = 1, stop = length(holderAthletes), step = 1)
                if foo[1] == holderAthletes[b].ID && b != length(holderAthletes)
                    holderEvents[c].AthleteList = holderEvents[c].AthleteList * holderAthletes[b].name * ",  "
                end
            end
        end
    end
end

for x in range(start = 1,stop = length(holderAthletes),step = 1) # print the arrays 
   # y = holderAthletes[x].EventList
    local name = holderAthletes[x].name
    local ID = holderAthletes[x].ID

    print("The Athletes name is $name\n")
    print("The Athletes ID is $ID\n")
    y = split(holderAthletes[x].EventList, ",  ")
    if holderAthletes[x].EventList == ""
        print("This Athlete is not present at any events\n\n\n\n")
        break
    end
    for item in y 
# loop over substrings and print out each individually end condition either "" or no substrings left
        if item == ""
            break
        end
        print("Events Name = $item\n")
    end
    print("\n\n\n")
end
for x in range(start = 1,stop = length(holderEvents),step = 1) # print the arrays
    local name = holderEvents[x].name
    local ID = holderEvents[x].ID

    print("The Events name is $name\n")
    print("The Events ID is $ID\n")
    y = split(holderEvents[x].AthleteList, ",  ")
    if holderEvents[x].AthleteList == ""
        print("No athletes present at event\n\n\n\n")
        break
    end
    for item in y 
# loop over substrings and print out each individually end condition either "" or no substrings left 
        if item == ""
            break
        end
        print("Athletes Present Name = $item\n")
        
    end
    print("\n\n\n")
end

#=
Lessons Learned: 
This was a little bit easier than the ruby program due to already finding a solution to the problem. 
1st) Julia is a 1 based incrementing langugage which through me off looping through arrays.
2nd) The long hassle to use range and other features where 
I actually had to set each feild manaually i.e. range(start = someething, stop = something, step = something). 

Overall, I am impressed with julia due to the simplicity of the langauge. Compared to ruby this is easier to read
the english and transverse it to code. Take for example the for loop in julia compared to array.each do |foo|
to loop over something in ruby. 
=#

