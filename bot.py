import discord
from discord.ext import commands
import requests
import config
from flask import Flask, request, jsonify
import threading

intents = discord.Intents.default()
intents.message_content = True
bot = commands.Bot(command_prefix='/', intents=intents)

app = Flask(__name__)

@app.route('/webhook', methods=['POST'])
def webhook():
    data = request.json
    action = data.get('action')
    if action == 'connect':
        # Örnek işlem: Bağlantı başarılı
        return jsonify({"message": "Connected!"}), 200
    else:
        return jsonify({"message": "Failed to Connect"}), 400

def run_app():
    app.run(host='0.0.0.0', port=5000)

@bot.event
async def on_ready():
    print(f'Logged in as {bot.user}')

@bot.command()
async def connect(ctx):
    try:
        response = requests.post('http://localhost:5000/webhook', json={"action": "connect"})
        if response.status_code == 200:
            await ctx.send('Connected!')
        else:
            await ctx.send('Failed to Connect')
    except Exception as e:
        await ctx.send('Failed to Connect')
        print(e)

@bot.command()
async def kanal(ctx):
    servers = [guild.name for guild in bot.guilds]
    await ctx.send(f'Joined servers: {", ".join(servers)}')

@bot.command()
async def grup(ctx, action: str, group_id: int = None):
    if action == 'list':
        groups = ['Group1', 'Group2']
        await ctx.send(f'Available groups: {", ".join(groups)}')
    elif action == 'enter':
        if group_id:
            await ctx.send(f'Entered group {group_id}')
        else:
            await ctx.send('Please provide a group ID.')

@bot.command()
async def kanal_list(ctx, group_id: int):
    channels = ['Channel1', 'Channel2']
    await ctx.send(f'Channels in group {group_id}: {", ".join(channels)}')

@bot.command()
async def photo(ctx, photo_id: str):
    photo_url = f'https://www.roblox.com/asset/?id={photo_id}'
    embed = discord.Embed(title="Roblox Photo")
    embed.set_image(url=photo_url)
    await ctx.send(embed=embed)

if __name__ == '__main__':
    threading.Thread(target=run_app).start()
    bot.run(config.DISCORD_TOKEN)
