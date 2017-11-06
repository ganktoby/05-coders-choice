Name: Lijie Zhang          ID:   47495426

## Proposed Project
My project is a online blackjeck game. All rules will be almost the same as casino. Bascilly the user pick a table and than against the dealer on each table(website itself).
If some user is playing with dealer and you want to join, you will be in a queue and can not jion the game until the current game is done. Every user has the choice to keep play or leave the table.
One table is able to accept 3 user at most. If the table is full, other user can not join.
My mission will mainly to make it work, rather than to design the appearance of the game (UI). 

## Outline Structure

There is a top-level-supervisor(A), whose child are all supervisor(B) for each table. B's child will be the dealer, user. 


