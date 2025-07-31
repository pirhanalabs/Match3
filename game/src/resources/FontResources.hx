package resources;

enum FontType
{
	Mystery8;
	Public8;
	Pirhana4;
	Celtictime16;
	Bitfantasy16;
	Alkhemikal16;
	Calamity16;
	Monogram13;
	CursedScript13;
	Healthbar7;
}

class FontResources
{
	static var fonts:Map<FontType, h2d.Font> = new Map();

	public static function Init()
	{
		fonts.set(Mystery8, hxd.Res.fonts.mysteryfont.mysteryfont_8.toFont());
		fonts.set(Public8, hxd.Res.fonts.publicpixel.publicpixel_8.toFont());
		fonts.set(Pirhana4, hxd.Res.fonts.pirhana4x4.pirhana4x4.toFont());
		fonts.set(Celtictime16, hxd.Res.fonts.celtictime.celtictime16.toFont());
		fonts.set(Bitfantasy16, hxd.Res.fonts.bitfantasy.bitfantasy16.toFont());
		fonts.set(Alkhemikal16, hxd.Res.fonts.alkhemikal.alkhemikal_16.toFont());
		fonts.set(Calamity16, hxd.Res.fonts.calamity.calamity_16.toFont());
		fonts.set(Monogram13, hxd.Res.fonts.monogram.monogram_extended13.toFont());
		fonts.set(CursedScript13, hxd.Res.fonts.cursedscript.cursedscript_13.toFont());
		fonts.set(Healthbar7, hxd.Res.fonts.healthbar.healthbar7.toFont());
	}

	public static inline function get(font:FontType)
	{
		return fonts[font];
	}
}
