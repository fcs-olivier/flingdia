%*
metasp solve flingo --meta-config config.yaml \
                    --project=show \
                    --warn=no-atom-undefined \
                    instances/STATIC/zebra_puzzle.lp  0 \
                    -c display_time=10  
*%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Zebra Puzzle instance %%%%%%%%%%%%%%%%%%%%%%%%%%%
% There are three houses painted in different colors: blue, red, and green. 
% 1. TEA is drunk in the RED house.
% 2. The CUBAN drinks MILK.
% 3. The SWISS man lives in the first house on the left.
% 4. The GREEK lives in a house to the right of the CUBAN’s house. 
% 5. BEER is drunk in a house to the right of the FOX’s owner.
% 6. The DOG’s owner lives to the left of the house where the GREEK lives. 
% 7. The ZEBRA’s owner lives in the BLUE house.

% Question: What nationality is the zebra’s owner?

%%%%%%%%%%%%%%%%%%%%%%%%%%  Sorts  %%%%%%%%%%%%%%%%%%%%%%%%%

beverage(tea;milk;beer). 
pet(fox;dog;zebra).
person(cuban;greek;swiss). 
house(blue;green;red). 

item(X):- beverage(X).
item(X):- pet(X).
item(X):- person(X).

% Geometric typing
point(P):- item(P).
rect(R):- house(R).


%%%%%%%%%%%%%%%  Commonsense Knowledge  %%%%%%%%%%%%%%%%%%%%

% Houses lie on the ground
line(ground).
&eq(ystart(ground),0). &eq(yend(ground),0).
&eq(xstart(ground),0). &eq(xend(ground),10).
&on(House, ground):- house(House).

% Houses are apart from each other
:- &overlap(House1,House2), house(House1), house(House2). 

% Every item is contained in a house
:- item(Item), not &in(Item,H): house(H).

% A house only contains one person who owns one pet and drinks one beverage
isA(Beverage, beverage):- beverage(Beverage).
isA(Pet, pet):- pet(Pet).
isA(Person, person):- person(Person).

:- house(House),
   &in(Item1,House), 
   &in(Item2,House), 
   Item1 != Item2,
   isA(Item1, Sort1), 
   isA(Item2, Sort2), 
   Sort1 = Sort2.

% For visualization purposes: points must have distinct positions
:- &samePlace(P1,P2), point(P1), point(P2).


%%%%%%%%%%%%%%%%%%%%%%%  Clues  %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%1. TEA is drunk in the RED house. 
&in(tea, red). 

%2. The CUBAN drinks MILK.
&in(milk, House):- house(House), &in(cuban, House).
 
%3. The SWISS man lives in the first house on the left. 
&in(swiss, House):- house(House), &leftmost(House).

%4. The GREEK lives in a house to the right of the CUBAN’s house. 
&right(House1, House2):- house(House1), house(House2),
                            &in(greek, House1), 
                            &in(cuban, House2).  

%5. BEER is drunk in a house to the right of the FOX’s owner. 
&right(House1, House2):- house(House1), house(House2),
                            &in(beer, House1), 
                            &in(fox, House2).  

%6. The DOG’s owner lives to the left of the house where the GREEK lives. 
&left(House1, House2):- house(House1), house(House2),
                           &in(dog, House1), 
                           &in(greek, House2).

%7. The ZEBRA’s owner lives in the BLUE house. 
&in(zebra, blue).

% The owner is the person located in the same house as the zebra.
zebra_owner(Person) :- person(Person), house(House),
                       &in(Person, House), 
                       &in(zebra, House).







