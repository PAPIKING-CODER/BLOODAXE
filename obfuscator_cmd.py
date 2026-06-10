import discord
from discord.ext import commands
import aiohttp
import asyncio

TOKEN = "MTUxNDE4MjExNDU1ODQ3NjMxOA.GSrjNd.djUQHpupPra4lampHDL20FF0j6HjWOwvtz_4IM"  # <--- REEMPLAZA ESTO

bot = commands.Bot(command_prefix="!")

@bot.event
async def on_ready():
    print(f"✅ Bot conectado como {bot.user.name}")

@bot.command(name="ofuscar")
async def obfuscate(ctx, *, codigo: str = None):
    """Ofusca un script Lua sin ejecutarlo.
    Uso: !ofuscar print('Hola mundo')"""
    if codigo is None:
        await ctx.send("❌ Uso correcto: `!ofuscar <código_lua>`")
        return

    # Envía mensaje de "procesando"
    msg = await ctx.send("⏳ Ofuscando, espera...")

    try:
        async with aiohttp.ClientSession() as session:
            # API pública de Bill's Lua Obfuscator (funciona sin clave)
            url = "https://lua-obfuscator-sable.vercel.app/api/obfuscate"
            payload = {"code": codigo, "level": "advanced"}  # level: basic, advanced
            async with session.post(url, json=payload) as resp:
                if resp.status == 200:
                    data = await resp.json()
                    ofuscado = data.get("obfuscated", "Error: no se pudo ofuscar")
                    # Si el resultado es muy largo, se envía como archivo
                    if len(ofuscado) > 1900:
                        archivo = discord.File(
                            filename="ofuscado.lua",
                            fp=bytes(ofuscado, "utf-8")
                        )
                        await msg.edit(content="✅ Código ofuscado (archivo adjunto):", file=archivo)
                    else:
                        await msg.edit(content=f"```lua\n{ofuscado}\n```")
                else:
                    await msg.edit(content=f"❌ Error {resp.status}: {await resp.text()}")
    except Exception as e:
        await msg.edit(content=f"⚠️ Error inesperado: {str(e)}")

bot.run(TOKEN)
