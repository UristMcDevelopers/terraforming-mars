## Main goals:
1. Android support
2. Multiplayer (p2p without proxy server for MVP)
3. Copy of existing turn based board game
    rules RU: https://www.igromaster.com/files/pokorenie_marsa_rules.pdf?srsltid=AfmBOooG-m-IGPmvPGQLPgGXZBD6PnStoXzNcE1SbzvFFd3umBcKTvEx
    rules ENG: https://cdn.1j1ju.com/medias/13/3f/fb-terraforming-mars-rule.pdf



## Game basic mechanics details: 
1. turn based
2. hex board
3. different currencies
4. players have hands
5. 3 types of card
6. score system
7. player tablet (currencies + players played cards) 


## Mechanics
1. Board
    1. temperature
    2. oxygen
    3. map
        1. hex
        2. each hex contains 2 sockets
            1. player marker
            2. tile (ocean, tree, town, special)
        3. some hex contains rewards
    4. terraform rating
    5. bounties

2. Player
    1. currencies
        1. gold + gold income
        2. steel + steel income
        3. titanium + titanium income
        4. plants + plants income
        5. energy + energy income
        6. heat + heat income
    2. played cards
        1. blue cards - have additional mechanics/triggers/actions
        2. green cards - battle cry + used for icon counts
        3. red cards - battle cry. not used after until score count
    3. other resources (animals, microbes, etc.) stored on played cards
    4. hand

3. Cards
    1. card specific mechanics

4. Turn mechanic:
    1. Round 
    2. turn - Each round can play 2 or fewer actions
    3. if skip turn with 0 played actions you're done with round
5. Score system

## next TODOs
- Disable buttons which should not be clickable while placing tile/choosing in popup menu (maybe crate screen_manager which nows what disable on certain event)
- add initial tests for logic
- maybe code clean up for TODOs in code
- move hex_grid_ui to druid