port = 42069
ids = [
    "-1",
    "-2"
]




import asyncio
from websockets.server import serve

async def echo(websocket):
    try:
        deviceId = await websocket.recv()
        if deviceId in ids:
            await websocket.send("valid")
            print("\033[93mdevice "+deviceId+" decrypted")
        else:
            await websocket.send("invalid")
            print("\033[0mdevice "+deviceId+" pinged")
        return

    except Exception as e:
        print("\033[31m"+str(e))
        return




#█▀▄▀█ ▄▀█ █ █▄░█   █░░ █▀█ █▀█ █▀█
#█░▀░█ █▀█ █ █░▀█   █▄▄ █▄█ █▄█ █▀▀
    
async def main():
    print("\033c\033[3J\033[95m----popcornVirus server 1.0.0----")
    async with serve(echo, "", port, compression=None):
        await asyncio.Future()

asyncio.run(main())