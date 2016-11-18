ws = new WebSocket("ws://localhost:9292/ws")

fastEdit =  (e) => {
    id = $(e.currentTarget).parent().parent().attr("data-id")
    form = $('<form class="form-inline" method="POST" action="/edit"></form>')
        .append('<input type="hidden" name="action" value="edit">')
        .append('<input type="hidden" name="id" value="'+id+'">')
        .append($('<div class="form-group input-group"></div>')
            .append(input = $('<input class="form-control" name="word" type="text" placeholder="слово">'))
            .append($('<span class="input-group-btn"></span>')
                .append('<button class="btn btn-success" type="submit">Добавить</button>')))
        .insertAfter(e.currentTarget)
    form.submit((e) => {
        form = $(e.currentTarget)
        id = form.find('input[name="id"]').val()
        word = form.find('input[name="word"]').val()
        console.log(id, word)
        $.ajax({
            url: form.attr("action"),
            method: "POST",
            data: {
                id: id,
                word: word,
                action: "edit"
            }
        }).done(function() {
            form.remove()
        })
        return false
    })
    input.focus()
}

ws.onmessage = (e) => {
    e = JSON.parse(e.data)
    if (e.action == "create") $('<article data-id="'+e.sentence.id+'"></article>')
        .append($('<blockquote></blockquote>')
            .append('<a class="lead">'+e.sentence.text+'</a>')
            .append($('<footer></footer>')
                .append('<a rel="author">@'+e.user.name+'</a>'))
            .append('<a class="btn btn-default" href="/edit/'+e.sentence.id+'">Добавить слово</a>'))
        .prependTo($("section"))
    else if (e.action == "edit") {
        ed = $('article[data-id="'+e.sentence.id+'"]')
        ed.find("blockquote").children().remove()
        ed.find("blockquote")
            .append($('<a class="lead">'+e.sentence.text+'</a>')
                .click(fastEdit))
            .append('<footer><a rel="author">@'+e.user.name+'</a></footer>')
            .append('<a class="btn btn-default" href="/edit/'+e.sentence.id+'">Добавить слово</a>')
    }
}

document.body.onload = () => {
    $("a.lead").click(fastEdit)
}
