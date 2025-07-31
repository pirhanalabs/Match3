{
  id:'match_cards_banana',
  atlas:'match_cardsheet',
  spriteid:1,
  rarity:ERarity.Common,
  tags:[ECardTag.Edible, ECardTag.Fruit],
  effect:function(ctx, card){
    ctx.increaseScore(2 * ctx.getZone(ECardZone.Play).filter(c->c.id == 'match_cards_banana').length);
  }
}