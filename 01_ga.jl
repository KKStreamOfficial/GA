# GA steps
# Step 1: Initialize:  Create a population of N elements, each with randomly generated DNA
# Step 2: Selection : Evaluate the fitness of each element of the population and build the mating pool
# Step 3: Reproduction  (Repeat N times):
#  a: Pick two parents with probability according to relative fitness
#  b: Crossover - create a "child" by combining the DNA of these two parents
#  c: Mutation  - mutate the child's DNA based on a given probability
#  d: Add the new child to a new population
# Step 4: Replace the old population with the new population and return to Step 2.

# We will study the famous monkey problem.
# If a monkey randomly typing on a typewriter for infinity amount of time, can be reproduce
# all of the books from Shakespeare.

# Variables:
target="To be, or not be that is the question:"
muationRate=0.01
totalPopulation =1500

# we need an ABC. (the keys, which can the monkey press)
abc="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz, :"
#the length of the ABC is:
lengthABC=endof(abc)

#####
#DNA#
#####

# First: Need a DNA object
# mutable structure allows us to create a custom type, where the variable type can be change.
# it isn't relevant in our first example, but can be very handy in another applications.
mutable struct DNA
    genes
    fit::Float64
end

function createDNA(n)
 temp=""
 for i=1:n
     temp=temp*abc[rand(1:lengthABC)]
 end # for loop
 dna=DNA(temp,0)
 return dna
end #function CreateDNA

function calcFitness(target,gen)
    score=0
    for i=1:endof(gen)
        if gen[i]==target[i]
            score=score+1
        end #if statement
    end #for loop
    fitness=float(score)/float(endof(target))
    return fitness
end # function calcFitness

function crossover(parent1,parent2)
    # the child's DNA came from the parents.
    temp=""
    midpoint=rand(1:endof(target))
    for i=1:endof(parent1)
        if i<midpoint
            temp=temp*parent1[i]
        else
            temp=temp*parent2[i]
        end # if statement
    end # for loop
    child=DNA(temp,0)
  return child
end # function crossover

function mutation(ddd,muationRate)
    temp=""
    for i=1:endof(ddd.genes)
        if float(rand(1)[1])<float(muationRate)
            # println(typeof(gen[i]))
            temp=temp*abc[rand(1:lengthABC)]
        else
            temp=temp*ddd.genes[i]
        end #if statement
    end #for loop
    mutated=DNA(temp,0)
    return mutated
end # function mutation



############
#Population#
############

#create the list of the population
best_fit=0
population=DNA[]
population_count=1
exit_number=0
mating_pool=DNA[] #the "fotune wheel" better fitness, better chance
#populate the population :)
for i=1:totalPopulation
    temp=createDNA(endof(target))
    push!(population,temp)
end # for loop

#don't need
# for i=1:totalPopulation
    # population[i].fit=calcFitness(target,population[i].genes)
# end

out=true
while out
# calculate the fitness of the population
for i=1:totalPopulation
    population[i].fit=calcFitness(target,population[i].genes)
    if population[i].fit>best_fit
        best_fit=population[i].fit
        println(best_fit)
        println(population[i].genes)
        println("population: ",population_count)
    end
    if population[i].fit == 1.0
        exit_number=i
        out=false
    end
end
# create the mating pool: better fittness, better chance
for i=1:totalPopulation
    nnn=Int(round(population[i].fit*100))
    if nnn>0
    for j=1:nnn
        push!(mating_pool,population[i])
    end
end
end
# Now create a new generation
lengthMatingPool=endof(mating_pool)
for i=1:totalPopulation
    #pick a random numbers for parrents
    a=rand(1:lengthMatingPool)
    b=rand(1:lengthMatingPool)
    #pick the parrents
    p1=mating_pool[a]
    p2=mating_pool[b]
    c1=crossover(p1.genes,p2.genes)
    c_mut=mutation(c1,muationRate)
    population[i]=c_mut
end

population_count=population_count+1
# empty the mating pool
mating_pool=DNA[]
# println(population_count)
end #while loop
