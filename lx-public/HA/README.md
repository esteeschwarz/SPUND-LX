# 16453.draft.ha
----
## dahlem center for linguistics site

- CMS backend based on github workflow
- why:
    - FU CMS used (wordpress + single sign on) forces users to use wordpress UI or worst case deliver finalised content which authenticated users then post to database > this prevents many users to continually work on posts or post content actively
    - github offers several static (=no DB needed) approaches to allow unlimited users to create content based on simple .csv tables or .md or plain texts which then are rendered to html frontend which is dependent on framework more or less customizable
- caveats:
    - public data storage
    - anyone with access can edit anything / admins have to keep track of organisation users
 