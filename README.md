# AHK-PoE-Trade-Macro
Cycles through players with a trade message

standard hotkeys
alt + j = setup trade or stop current trade spam
alt + k = start trade spam
alt  + a = pause trade spam
alt + l = setup ignore list


console command:

players_list = '';
players_list_array = [];
$('.whisper-btn').parent().find('.character-name').each(function(index, ele){
    player_name = $(ele).text().substring(5);
    if(!players_list_array.includes(player_name)){
        players_list_array.push(player_name);
        players_list = players_list + (players_list.length ? ' ':'') + player_name;
    }
});

console.log(players_list);


