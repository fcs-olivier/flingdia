**Title:** Safe theory-atom argument reported as unsafe

`&left_pp/2` declares both arguments with `safety: safe`, but `P` is reported as unsafe in:

```
point(a;b).
&left_pp(a,b).
first(P) :- &left_pp(P,b).
```

I think the positive theory atom should make `P` safe.