var script = document.createElement('script');
script.src = 'https://code.jquery.com/jquery-3.4.1.min.js';
script.type = 'text/javascript';
document.getElementsByTagName('head')[0].appendChild(script);

players_list = '';
$('.whisper-btn').parent().find('.character-name').each(function(index, ele){
    players_list = players_list + (players_list.length ? ' ':'') + $(ele).text().substring(5);
});

console.log(players_list);