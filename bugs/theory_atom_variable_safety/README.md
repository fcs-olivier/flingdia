**Title:** Safe theory-atom argument reported as unsafe

`&left/2` declares both arguments with `safety: safe`, but `P` is reported as unsafe in:

```
point(a;b).
&left(a,b).
first(P) :- &left(P,b).
```

I think the positive theory atom should make `P` safe.