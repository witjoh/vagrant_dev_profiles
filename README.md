The profiles module.

All profile are stored in this hige module.

application specific profiles should reside in there own
direcory as :

<modulepath>/profiles/manifests/<applicationdir>/some.pp

Those profiles could be assembled in a <application>.pp file at

<modulepath>/profiles/manifests/<application.pp>

for simple applications this file could then simply be included in 
the corrsponding role.

More complex applications will have multiple profiles inculded in 
there corresponding role.
