


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
    &inertia/0;
    &df/0;

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

    % Relations
    % line_
    &horizontal_l/1: {type: atom, safety: safe;};
    &vertical_l/1:   {type: atom, safety: safe;};

    % point_
    &rightmost_p/1:  {type: atom, safety: safe;};
    &leftmost_p/1:   {type: atom, safety: safe;};

    % point_point
    &left_pp/2:      {type: atom, safety: safe; type: atom, safety: safe;};
    &right_pp/2:     {type: atom, safety: safe; type: atom, safety: safe;}; 
    &alignedY_pp/2:  {type: atom, safety: safe; type: atom, safety: safe;};
    &samePlace_pp/2: {type: atom, safety: safe; type: atom, safety: safe;};

    &far_pp/2:      {type: atom, safety: safe; type: atom, safety: safe;};

    % % point_rect
    &left_pr/2:      {type: atom, safety: safe; type: atom, safety: safe;};
    &right_pr/2:     {type: atom, safety: safe; type: atom, safety: safe;};
    &alignedY_pr/2:  {type: atom, safety: safe; type: atom, safety: safe;};
    &in_pr/2:        {type: atom, safety: safe; type: atom, safety: safe;};
    &inEq_pr/2:      {type: atom, safety: safe; type: atom, safety: safe;};

    % % rect_point
    &touches_rp/2:   {type: atom, safety: safe; type: atom, safety: safe;};

    % % rect_
    &rightmost_r/1:  {type: atom, safety: safe;};
    &leftmost_r/1:   {type: atom, safety: safe;};
    &horizontal_r/1: {type: atom, safety: safe;};
    &vertical_r/1:   {type: atom, safety: safe;};
    
    % % rect_line
    &on_rl/2:        {type: atom, safety: safe; type: atom, safety: safe;};

    % % rect_rect POS
    &left_rr/2:           {type: atom, safety: safe; type: atom, safety: safe;};
    &right_rr/2:          {type: atom, safety: safe; type: atom, safety: safe;};
    &above_rr/2:          {type: atom, safety: safe; type: atom, safety: safe;};
    &below_rr/2:          {type: atom, safety: safe; type: atom, safety: safe;};
    &on_rr/2:             {type: atom, safety: safe; type: atom, safety: safe;};

    % % rect_rect TOPO
    &overlap_rr/2:        {type: atom, safety: safe; type: atom, safety: safe;};
    &ntpp_rr/2:           {type: atom, safety: safe; type: atom, safety: safe;};
    &disconnected_rr/2:   {type: atom, safety: safe; type: atom, safety: safe;};
    &discrete_rr/2:       {type: atom, safety: safe; type: atom, safety: safe;};
    &equal_rr/2:          {type: atom, safety: safe; type: atom, safety: safe;};
    &partialOverlap_rr/2: {type: atom, safety: safe; type: atom, safety: safe;};
    &properPart_rr/2:     {type: atom, safety: safe; type: atom, safety: safe;};
    &extConnected_rr/2:   {type: atom, safety: safe; type: atom, safety: safe;};

    %&far_rr/2:           {type: atom, safety: safe; type: atom, safety: safe;};

  };
  subtypes: { };
  macros:   { };
  occurrence: any;
}.
