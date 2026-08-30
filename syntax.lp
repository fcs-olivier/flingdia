#type st {
  expressions: {
    &true/0;
    &not/1: { type: st, safety: unsafe; };
    &initial/0;
    &next/1: {type: st, safety: safe;};
    &prev/1: {type: st, safety: safe;};
    &eventually/1: {type: st, safety: safe;};
    &always/1: {type: st, safety: safe;};
    &until/2: {type: st, safety: safe; type: st, safety: safe;};
  };
  subtypes: { atom; spatial; };
  macros:   { &final: &not(&next(&true)); };
  occurrence: any;
}.

#type spatial {
  expressions: {
    % Axioms
    &partial/0;
    &not_inertia/0;

    % Numerical atoms
    &eq/2: {type: atom, safety: safe; type: symbol, safety: safe;};

    % Actions
    &move/1: {type: atom, safety: safe;};
    &move_right/1: {type: atom, safety: safe;};
    &move_left/1: {type: atom, safety: safe;};
    &move_up/1: {type: atom, safety: safe;};
    &move_down/1: {type: atom, safety: safe;};
    &move_up_right/1: {type: atom, safety: safe;};
    &move_up_left/1: {type: atom, safety: safe;};
    &move_down_right/1: {type: atom, safety: safe;};
    &move_down_left/1: {type: atom, safety: safe;};
    &grows/1: {type: atom, safety: safe;};

    % Spatial relations (sort-overloaded; signatures are checked internally)
    &horizontal/1: {type: atom, safety: safe;};
    &vertical/1:   {type: atom, safety: safe;};
    &diagonal/1:   {type: atom, safety: safe;};
    &rightmost/1:  {type: atom, safety: safe;};
    &leftmost/1:   {type: atom, safety: safe;};
    &empty/1:      {type: atom, safety: safe;};

    &startsAt/2:       {type: atom, safety: safe; type: atom, safety: safe;};
    &endsAt/2:         {type: atom, safety: safe; type: atom, safety: safe;};
    &on/2:             {type: atom, safety: safe; type: atom, safety: safe;};
    &left/2:           {type: atom, safety: safe; type: atom, safety: safe;};
    &right/2:          {type: atom, safety: safe; type: atom, safety: safe;};
    &alignedY/2:       {type: atom, safety: safe; type: atom, safety: safe;};
    &alignedYEq/2:     {type: atom, safety: safe; type: atom, safety: safe;};
    &samePlace/2:      {type: atom, safety: safe; type: atom, safety: safe;};
    &far/2:            {type: atom, safety: safe; type: atom, safety: safe;};
    &in/2:             {type: atom, safety: safe; type: atom, safety: safe;};
    &inEq/2:           {type: atom, safety: safe; type: atom, safety: safe;};
    &out/2:            {type: atom, safety: safe; type: atom, safety: safe;};
    &touches/2:        {type: atom, safety: safe; type: atom, safety: safe;};
    &above/2:          {type: atom, safety: safe; type: atom, safety: safe;};
    &below/2:          {type: atom, safety: safe; type: atom, safety: safe;};
    &overlap/2:        {type: atom, safety: safe; type: atom, safety: safe;};
    &ntpp/2:           {type: atom, safety: safe; type: atom, safety: safe;};
    &disconnected/2:   {type: atom, safety: safe; type: atom, safety: safe;};
    &discrete/2:       {type: atom, safety: safe; type: atom, safety: safe;};
    &equal/2:          {type: atom, safety: safe; type: atom, safety: safe;};
    &partialOverlap/2: {type: atom, safety: safe; type: atom, safety: safe;};
    &properPart/2:     {type: atom, safety: safe; type: atom, safety: safe;};
    &extConnected/2:   {type: atom, safety: safe; type: atom, safety: safe;};

    &fromTo/3: {type: atom, safety: safe; type: atom, safety: safe; type: atom, safety: safe;};
  };
  subtypes: { };
  macros:   { };
  occurrence: any;
}.
