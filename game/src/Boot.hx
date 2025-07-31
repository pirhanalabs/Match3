/**
	1. dwarf
	2. elf
	3. ranger
	4. rogue
	5. bandit
	6. knight
	7. shield
	8. monk
	9. priest
	10. war cleric
	11. war cleric
	12. templar
	13. schema monk
	14. barbarian
	15. winter barbarian
	16. female winter barbarian
	17. swordsman
	18. fencer
	19. female wizard
	20. male wizard
	21. druid
	22. sage
	23. dwarf mage
	24. warlock
	25. thresher
	26. scythe
	27. pitchfork
	28. baker
	29. blacksmith
	30. scholar
	31. peasant
	32. elderly woman
	33. elderly man

	1. orc
	2. orc wizard
	3. goblin
	4. orc blademaster
	5. orc warchief
	6. goblin archer
	7. goblin mage
	8. goblin brute
	9. ettin
	10. two headed ettin
	11. troll
	12. small slime
	13. big slime
	14. slimebody
	15. merged slimebody
	16. faceless monk
	17. unholy cardinal
	18. skeleton
	19. skeleton archer
	20. lich
	21. death knight
	22. zombie
	23. ghoul
	24. banshee
	25. reaper
	26. wraith
	27. cultist
	28. hag
	29. giant centipede
	30. lampreymancer
	31. giant earthworm
	32. manticore
	33. giant ant
	34. lycanthrope
	37. giant bat
	38. lesser giant ant
	39. giant spider
	40. lesser giant spider
	41. warg
	42. giant rat
	43. dryad
	44. wendigo
	45. rock golem
	46. centaur
	47. naga
	48. forest spirit
	49. satyr
	50. minotaur
	51. harpy
	52. gorgon
	53. kobold (reptile)
	54. drake
	55. dragon
	56. cockatrice
	57. basilisk
	58. small kobold (canine)
	59. kobold (canine)
	60. small myconid
	61. large myconid
	62. archangel
	63. devil
	64. small writhing mass
	65. large writhing mass
	66. writhing humanoid
**/

import core.heaps.filters.VHSShader;
import resources.FontResources;
import utils.Inputs;

class Boot extends engine.Application
{
	public static function main()
	{
		hxd.Res.initEmbed(); // should probably done elsewhere?
		// new Boot(640, 360);
		new Boot(480, 270);
	}

	var shader:VHSShader;
	var screenBackground:h2d.Bitmap;

	override function init()
	{
		super.init();
	}

	override function ready()
	{
		super.ready();

		// this.engine.backgroundColor = 0xffffff;

		// cursor.setCursor(new h2d.Bitmap(hxd.Res.sprites.cursor_regular.toTile()));
		// cursor.enable(true);
		// cursor.setCursor(new h2d.Object());

		FontResources.Init();
		Inputs.Init(inputs);

		// pushScreen(new screens.BattleScreen());
		// pushScreen(new screens.DungeonMapScreen());
		// pushScreen(new screens.RPGScreen());
		// pushScreen(new screens.TestScreen());
		// pushScreen(new screens.TestScreen());

		screenBackground = new h2d.Bitmap(h2d.Tile.fromColor(0x000000, 1, 1, 1));
		screenBackground.scaleX = this.vw;
		screenBackground.scaleY = this.vh;
		backgroundLayer.addChild(screenBackground);

		// vhs shader

		shader = new VHSShader();
		shader.chromatic_abberation = 0.001;
		shader.brightness = 1.0;
		shader.pixelate = false;
		shader.discolor = false;
		shader.grille_opacity = 0.0;
		shader.noise_opacity = 0.1;
		shader.scanline_opacity = 0.2;
		shader.warp = 0.15; // 0.25;
		shader.vignette_opacity = 1;
		shader.vignette_intensity = 0.18;
		shader.resolution_h = this.vh;
		shader.resolution_w = this.vw;
		screenShaderLayer.filter = shader;
		// extra call for shader
		resizeShader();

		// pushScreen(new screens.BattleScreen());
		// pushScreen(new screens.DungeonMapScreen());
		// pushScreen(new screens.RPGScreen());
		// pushScreen(new screens.TestScreen());
		// pushScreen(new example.ExampleScreen());
		pushScreen(new match3.screens.GameScreen());
	}

	private function resizeShader()
	{
		if (shader == null)
			return;

		// shader.resolutionAreaX = this.vw * this.vs / window.width;
		// shader.resolutionAreaY = this.vh * this.vs / window.height;
		// shader.resolutionOffsetX = this.ox / window.width;
		// shader.resolutionOffsetY = this.oy / window.height;
	}

	override function onResize()
	{
		super.onResize();
		resizeShader();
	}
}
