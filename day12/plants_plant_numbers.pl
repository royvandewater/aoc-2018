:- module(plants_plant_numbers, [plants_plant_numbers/2]).

plants_plant_numbers(Plants, PlantNumbers) :-
  dict_pairs(Plants, plants, Pairs),
  pairs_keys(Pairs, PlantNumberAtoms),
  maplist(atom_number, PlantNumberAtoms, PlantNumbers).
