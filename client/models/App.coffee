#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @newGame()

  newGame: =>
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get("playerHand").on "newGame", =>
      @newGame()
    @get("playerHand").on "stand", =>
      @get("dealerHand").models[0].flip()
      @dealerPlay()
      if @get("dealerHand").scores()[0]>21
        alert("dealer busted his nuts")
        @newGame()
      else
        @compare()
    @get("playerHand").on "busted", =>
      alert("you busted")
      @newGame()
  compare: ->
    # if a 1 exists, check 1<21 and if true set score 0->score1
    dhand = @get("dealerHand").scores()
    phand = @get("playerHand").scores()
    if dhand[1]? and dhand[1]<=21
      dhand[0] = dhand[1]
    if phand[1]? and phand[1]<=21
      phand[0] = phand[1]

    if dhand[0] == phand[0]
      alert("you pushed")
      @newGame()
    else if dhand[0] < phand[0]
      alert("you win")
      @newGame()
    else
      alert("you lose")
      @newGame()


  dealerPlay: ->
    dealerObj = @get("dealerHand")
    if dealerObj.scores()[1]? and dealerObj.scores()[1]<18
      dealerObj.hit()
      if dealerObj.scores()[1] < 18
        @dealerPlay()
      else if dealerObj.scores()[0] <18
        @dealerPlay()

    else if dealerObj.scores()[0] < 18 and not dealerObj.scores()[1]?
      dealerObj.hit()
      if dealerObj.scores()[0] < 18
        @dealerPlay()


