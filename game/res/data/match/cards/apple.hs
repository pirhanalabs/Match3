{
  id:'match_cards_apple',
  atlas:'match_cardsheet',
  spriteid:0,
  rarity:ERarity.Common,
  tags:[ECardTag.Fruit, ECardTag.Edible],
  effect:function(ctx, card){
    ctx.increaseScore(10);
  }
}