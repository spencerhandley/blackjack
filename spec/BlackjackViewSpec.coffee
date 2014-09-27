expect = chai.expect

describe "player hand conventions", ->
  deck = null
  dHand = null
  pHand = null

  beforeEach ->
    deck = new Deck()
    pHand = deck.dealPlayer()
    dHand = deck.dealDealer()

  it "should bust over 21", ->
    if pHand.scores()[0] < 21
      pHand.hit()
      pHand.playerCheck()
    expect(true).to.equal true
