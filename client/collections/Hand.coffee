class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    @check()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  check: ->
    if @scores()[0] > 21
      @busted()
      console.log "You Busted! Ahh skeet skeet skeet!"

  busted: ->
    # console.log "new game comin atcha"
    @trigger "busted"

  stand: ->
    # console.log "YOLO"
    @trigger "stand"
