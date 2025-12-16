# 16514.dahlem center lx page essai tech notes
## issues
- jekyll builds with 4.4.1 on git pages & lapsi, ruby is 3.1 on git and with 3.4.1 local i get different renderings of layout which work local but not on pages
- local ruby is same like python dependent on the environment running

## status
### lapsi
- ruby in .ruby-version is 3.1, starts wt system ruby ruby 3.4.1
- system jekyll: 4.4.1 (same like git)
- `bundle exec jekyll build --incremental``
  - only warnings for sass color stuff, renders fine, _site dir view in safari, all layout like intended
- now try set ruby 3.4.1 in .ruby-version and see what happens on git
  - ruby version in workflow set to 3.1 : try with 3.4.1 so same as local
