; Use this profile locally to fetch the main makefile.

core = "6.x"

; Uncomment the following line if you want to use vanilla core.
projects[] = drupal
;projects[pressflow][type] = "core"
;projects[pressflow][download][type] = "git"
;projects[pressflow][download][url] = git://github.com/bigmack83/pressflow-6.git


; Profile
projects[essential][type] = "profile"
projects[essential][download][type] = "git"
projects[essential][download][url] = "git@longlake.co.uk:essential"
